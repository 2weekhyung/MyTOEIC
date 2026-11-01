package com.mytoeic.config;
import org.junit.jupiter.api.Test;
import javax.sql.DataSource;
import java.sql.Connection;
import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.*;

class DatabaseSafetyTest {
 @Test void refusesExistingUnrelatedDatabaseBeforeMigration() throws Exception {
   var source=mock(DataSource.class);var connection=mock(Connection.class);when(source.getConnection()).thenReturn(connection);when(connection.getCatalog()).thenReturn("existing_service");
   assertThatThrownBy(()->DatabaseSafety.verify(source)).isInstanceOf(IllegalStateException.class).hasMessageContaining("전용 DB");
   verify(connection,never()).createStatement();verify(connection).close();
 }
 @Test void acceptsDedicatedCatalog() throws Exception {
   var source=mock(DataSource.class);var connection=mock(Connection.class);when(source.getConnection()).thenReturn(connection);when(connection.getCatalog()).thenReturn("mytoeic_restore_20261030");
   assertThatCode(()->DatabaseSafety.verify(source)).doesNotThrowAnyException();
 }
 @Test void migrationRequiresExplicitFlagAndSeparateAccount() {
   assertThatThrownBy(()->MigrationCommand.run(java.util.Map.of())).isInstanceOf(IllegalStateException.class).hasMessageContaining("DB_MIGRATE");
   assertThatThrownBy(()->MigrationCommand.run(java.util.Map.of("DB_MIGRATE","true","DB_USERNAME","shared","DB_MIGRATION_USERNAME","shared"))).isInstanceOf(IllegalStateException.class).hasMessageContaining("분리");
 }
}
