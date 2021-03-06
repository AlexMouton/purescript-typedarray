"use strict";

// module Data.DataView


exports.asDataView = function(b) {
  return new DataView(b);
}

exports.sliceImpl = function(just, nothing, s, l, b) {
  return s + l <= b.byteLength? just(new DataView(b, s, l)) : nothing;
}

exports.toArrayBuffer = function(v) {
  return v.buffer;
}

exports.byteOffset = function(v) {
  return v.byteOffset;
}

exports.byteLength = function(v) {
  return v.byteLength;
}

exports.getFloat32Unsafe = function(v,o,ile) {
    return v.getFloat32(o,ile);
}

exports.getUInt16Unsafe = function(v,o,ile) {
    return v.getUint16(o,ile);
}

exports.getUInt32Unsafe = function(v,o,ile) {
    return v.getUint32(o,ile);
}
