# Generated by Django 4.0.4 on 2023-03-03 16:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_alter_retailer_name_alter_retailer_vat'),
    ]

    operations = [
        migrations.AddField(
            model_name='receipt',
            name='retailer',
            field=models.ForeignKey(default='Tesco', on_delete=django.db.models.deletion.CASCADE, to='api.retailer'),
            preserve_default=False,
        ),
    ]