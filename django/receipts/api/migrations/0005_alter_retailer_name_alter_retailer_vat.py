# Generated by Django 4.0.4 on 2023-03-03 15:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_rename_id_retailer_vat'),
    ]

    operations = [
        migrations.AlterField(
            model_name='retailer',
            name='name',
            field=models.CharField(max_length=100, primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name='retailer',
            name='vat',
            field=models.CharField(max_length=100),
        ),
    ]