# Generated by Django 5.1.4 on 2024-12-27 09:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('skillsharingbackend', '0002_alter_profile_id_alter_skills_id'),
    ]

    operations = [
        migrations.AddField(
            model_name='profile',
            name='name',
            field=models.CharField(default='', max_length=255),
        ),
    ]
