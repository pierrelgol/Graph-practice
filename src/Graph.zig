// ************************************************************************** //
//                                                                            //
//                                                        :::      ::::::::   //
//   Graph.zig                                          :+:      :+:    :+:   //
//                                                    +:+ +:+         +:+     //
//   By: pollivie <pollivie.student.42.fr>          +#+  +:+       +#+        //
//                                                +#+#+#+#+#+   +#+           //
//   Created: 2025/03/11 08:45:29 by pollivie          #+#    #+#             //
//   Updated: 2025/03/11 08:45:30 by pollivie         ###   ########.fr       //
//                                                                            //
// ************************************************************************** //

const std = @import("std");
const mem = std.mem;
const heap = std.heap;
const math = std.math;
const List = @import("SlotMap.zig").SlotMapUnmanaged;
const Set = std.AutoArrayHashMapUnmanaged;

// pub fn GraphUnmanaged(comptime T: type) type {
//     return struct {
//         pub const Self = @This();
//         pub const Error = error{} || mem.Allocator.Error;

//         nodes: List(Node) = .{},
//         edges: List(Edge) = .{},

//         pub fn deinit(self: *Self, allocator: mem.Allocator) void {
//             for (self.nodes.objects.items) |*n| {
//                 n.deinit(self, allocator) catch {};
//             }
//             self.nodes.deinit(allocator);
//             self.edges.deinit(allocator);
//         }

//         fn len(self: *const Self) usize {
//             return self.nodes.objects.items.len;
//         }

//         pub fn makeNode(self: *Self, allocator: mem.Allocator, item: T) Error!NodeIndex {
//             const result = try self.nodes.addOne(allocator);
//             result.ptr.* = Node.init(result.handle, item);
//             return result.handle;
//         }

//         pub fn removeNode(self: *Self, allocator: mem.Allocator, node: NodeIndex) Error!void {
//             var n = try self.nodes.remove(allocator, node);
//             n.deinit(self, allocator);
//         }

//         pub fn makeEdge(self: *Self, allocator: mem.Allocator, from: NodeIndex, to: NodeIndex, weight: f32) Error!EdgeIndex {
//             const result = try self.edges.addOne(allocator);
//             result.ptr.* = Edge.init(from, to, weight);
//             return result.handle;
//         }

//         pub fn removeEdge(self: *Self, allocator: mem.Allocator, edge: EdgeIndex) Error!void {
//             const e = try self.edges.remove(allocator, edge);
//             const f = self.getNode(e.from);
//             const t = self.getNode(e.to);

//             if (f) |node| {
//                 node.removeEdge(e.to);
//             }

//             if (t) |node| {
//                 node.removeEdge(e.from);
//             }
//         }

//         pub fn getNode(self: *Self, node: NodeIndex) ?*Node {
//             return self.nodes.get(node);
//         }

//         pub fn getEdge(self: *Self, edge: EdgeIndex) ?*Edge {
//             return self.edges.get(edge);
//         }

//         pub const Node = struct {
//             id: NodeIndex,
//             item: T,
//             edges: Set(NodeIndex, EdgeIndex),

//             pub fn init(id: NodeIndex, item: T) Node {
//                 return .{
//                     .id = id,
//                     .item = item,
//                     .edges = .empty,
//                 };
//             }

//             pub fn deinit(self: *Node, graph: *Self, allocator: mem.Allocator) Error!void {
//                 var it = self.edges.iterator();
//                 while (it.next()) |edge| {
//                     try graph.removeEdge(allocator, edge.value_ptr.*);
//                 }
//                 self.edges.deinit(allocator);
//             }

//             pub fn removeEdge(self: *Node, node: NodeIndex) void {
//                 _ = self.edges.swapRemove(node);
//             }

//             pub fn addEdge(self: *Node, allocator: mem.Allocator, node: NodeIndex, edge: EdgeIndex) Error!void {
//                 const result = try self.edges.getOrPut(allocator, node);
//                 if (!result.found_existing) {
//                     result.value_ptr.* = edge;
//                 }
//             }
//         };

//         pub const Edge = struct {
//             from: NodeIndex,
//             to: NodeIndex,
//             weight: f32,

//             pub fn init(from: NodeIndex, to: NodeIndex, weight: f32) Edge {
//                 return .{
//                     .to = to,
//                     .from = from,
//                     .weight = weight,
//                 };
//             }
//         };

//         pub const NodeIndex = usize;
//         pub const EdgeIndex = usize;
//     };
// }

// const testing = std.testing;

// test "simple" {
//     const alloc = testing.allocator;

//     var g = GraphUnmanaged(u32){};
//     defer g.deinit(alloc);

//     const n1 = try g.makeNode(alloc, 1);
//     const n2 = try g.makeNode(alloc, 2);
//     const n3 = try g.makeNode(alloc, 3);
//     const n4 = try g.makeNode(alloc, 4);

//     const e1 = try g.makeEdge(alloc, n1, n2, 1.0);
//     const e2 = try g.makeEdge(alloc, n2, n3, 1.0);
//     const e3 = try g.makeEdge(alloc, n3, n4, 1.0);

//     try g.getNode(n1).?.addEdge(alloc, n2, e1);
//     try g.getNode(n2).?.addEdge(alloc, n3, e2);
//     try g.getNode(n3).?.addEdge(alloc, n4, e3);
// }
