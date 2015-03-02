-----------------------------------------------------------------------------
--
-- Module      :  TypedArray
-- Copyright   :  Jürgen Nicklisch-Franken
-- License     :  Apache-2.0
--
-- Maintainer  :  jnf@arcor.de
-- Stability   :
-- Portability :
--
-- | Binding to Typed Arrays of Javascript (which are only useful for FFI interfaces)
-- | It makes sense to import this module qualified.
--
-----------------------------------------------------------------------------

module Data.TypedArray where

import Data.TypedArray.Types

import Data.Maybe

-- * conversion from and to typed arrays
foreign import asInt8Array
  """function asInt8Array(array)
    {var res = new Int8Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Int8

foreign import asUint8Array
  """function asUint8Array(array)
    {var res = new Uint8Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Uint8

foreign import asUint8ClampedArray
  """function asUint8ClampedArray(array)
    {var res = new Uint8ClampedArray (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Uint8ClampedArray

foreign import asInt16Array
  """function asInt16Array(array)
    {var res = new Int16Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Int16

foreign import asUint16Array
  """function asUint16Array(array)
    {var res = new Uint16Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Uint16

foreign import asInt32Array
  """function asInt32Array(array)
    {var res = new Int32Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Int32

foreign import asUint32Array
  """function asUint32Array(array)
    {var res = new Uint32Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Uint32

foreign import asFloat32Array
  """function asFloat32Array(array)
    {var res = new Float32Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Float32

foreign import asFloat64Array
  """function asFloat64Array(array)
    {var res = new Float64Array (array);
     return res;};"""
    :: [Number] -> ArrayBuffer Float64

foreign import asArray
  """function asArray(arrayBuffer)
    {var res = Array.prototype.slice.call(arrayBuffer);;
     return res;};"""
    :: forall a. ArrayBuffer a -> [Number]

foreign import length
  """function length(arrayBuffer)
    {return arrayBuffer.length;};"""
    :: forall a. ArrayBuffer a -> Number

foreign import byteLength
  """function byteLength(arrayBuffer)
    {return arrayBuffer.byteLength;};"""
    :: forall a. ArrayBuffer a -> Number

infixl 8 !!

foreign import insertAt
  "function insertAt (index) {\
  \  return function (a) {\
  \    return function (l) {\
  \      var l1 = l.slice();\
  \      l1.splice(index, 0, a);\
  \      return l1;\
  \    }; \
  \  };\
  \}":: forall a. Number -> a -> ArrayBuffer a -> ArrayBuffer a

(!!) :: forall a. ArrayBuffer a -> Number -> Maybe Number
(!!) xs n =
  if n < 0 || n >= (length xs) || isInt n
    then Nothing
    else Just (xs `unsafeIndex` n)
  where
  isInt n = n /= complement (complement n)

foreign import unsafeIndex
  "function unsafeIndex(xs) {\
  \  return function(n) {\
  \    return xs[n];\
  \  };\
  \}" :: forall a. ArrayBuffer a -> Number -> Number
