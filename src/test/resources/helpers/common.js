/**
 * common.js — Shared utility functions for Karate tests
 *
 * Usage in a feature file:
 *   * def common = read('classpath:helpers/common.js')
 *   * def email = call common.randomEmail
 */

function randomEmail() {
  return 'user' + Math.floor(Math.random() * 999999) + '@karate.test';
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomString(length) {
  var chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  var result = '';
  for (var i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

function isoTimestamp() {
  return new Date().toISOString();
}

function truncate(str, maxLength) {
  if (str.length <= maxLength) return str;
  return str.substring(0, maxLength) + '...';
}
