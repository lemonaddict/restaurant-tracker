'use strict';
module.exports = (sequelize, DataTypes) => {
  const Menus_Preorders = sequelize.define('Menus_Preorders', {
    preorder_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    reservation_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Reservations',
        key: 'reservation_id',
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
    },
    menu_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Menus',
        key: 'menu_id',
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  }, {
    tableName: 'Menus_Preorders',
    timestamps: true,
  });

  // Associations
  Menus_Preorders.associate = (models) => {
    Menus_Preorders.belongsTo(models.Reservations, {
      foreignKey: 'reservation_id',
      as: 'reservation',
      onDelete: 'CASCADE',
    });

    Menus_Preorders.belongsTo(models.Menus, {
      foreignKey: 'menu_id',
      as: 'menu',
      onDelete: 'CASCADE',
    });
  };

  return Menus_Preorders;
};
