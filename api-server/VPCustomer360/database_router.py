class DatabaseRouter:
    api_apps = {'fact_customer_apis', 'apis'}

    def db_for_read(self, model, **hints):
        if model._meta.app_label in self.api_apps:
            return 'redshift'
        return 'default'

    def db_for_write(self, model, **hints):
        return 'default'
    
    
    def allow_relation(self, model, **hints):
        return 'default'
    
    
    def allow_migrate(self, model, **hints):
        return 'default'
    