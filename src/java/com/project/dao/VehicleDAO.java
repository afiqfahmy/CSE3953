package com.project.dao;

import com.project.model.Vehicle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    // 🔧 Helper method (cleaner code)
    private Vehicle map(ResultSet rs) throws SQLException {
        return new Vehicle(
                rs.getInt("id"),
                rs.getString("license_plate"),
                rs.getString("type"),
                rs.getInt("capacity"),
                rs.getString("status")
        );
    }

    // ✅ CHECK DUPLICATE LICENSE PLATE
    public boolean isPlateExists(String plate) {
        String sql = "SELECT id FROM vehicles WHERE license_plate = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, plate);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ CREATE VEHICLE
    public boolean addVehicle(Vehicle v) {

        // Prevent duplicate plate
        if (isPlateExists(v.getLicensePlate())) {
            return false;
        }

        String sql = "INSERT INTO vehicles (license_plate, type, capacity, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, v.getLicensePlate());
            ps.setString(2, v.getType());
            ps.setInt(3, v.getCapacity());
            ps.setString(4, v.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ GET ALL VEHICLES
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicles ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ FILTER BY STATUS
    public List<Vehicle> getVehiclesByStatus(String status) {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicles WHERE status = ? ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ SEARCH VEHICLES (plate OR type)
    public List<Vehicle> searchVehicles(String keyword) {
        List<Vehicle> list = new ArrayList<>();

        String sql = "SELECT * FROM vehicles "
                + "WHERE LOWER(license_plate) LIKE LOWER(?) "
                + "OR LOWER(type) LIKE LOWER(?) "
                + "ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            String search = "%" + keyword + "%";
            ps.setString(1, search);
            ps.setString(2, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ GET BY ID
    public Vehicle getVehicleById(int id) {
        String sql = "SELECT * FROM vehicles WHERE id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ✅ UPDATE VEHICLE
    public boolean updateVehicle(Vehicle v) {
        String sql = "UPDATE vehicles SET license_plate=?, type=?, capacity=?, status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, v.getLicensePlate());
            ps.setString(2, v.getType());
            ps.setInt(3, v.getCapacity());
            ps.setString(4, v.getStatus());
            ps.setInt(5, v.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ DELETE VEHICLE
    public boolean deleteVehicle(int id) {
        String sql = "DELETE FROM vehicles WHERE id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
