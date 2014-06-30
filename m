Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44960 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbaF3C6r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 22:58:47 -0400
From: Reyad Attiyat <reyad.attiyat@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH v4 0/4] Add support for rotation from north to the hid-sensor-magn-3d driver
Date: Sun, 29 Jun 2014 21:58:35 -0500
Message-Id: <1404097119-19922-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This version of patches tries to make smaller changes to the magn-3d driver. It
scans for usages present in the magn_3d_addresses array. It then allocates
memory for the IIO channel structs and value arrays that are used in the IIO subsystem.
It sets-up each IIO channel struct by copying the values from the static array of
IIO configurations. There is also an array used to store each channel IIO value
pointer for each HID usage attribute.



Reyad Attiyat (4):
  iio: Documentation: Add documentation for rotation from north sensor
    usage attributes
  iio: types: Added support for rotation from north usage attributes
  iio: hid-sensor-magn-3d: Scan for usage attributes before setting up
    iio channels
  iio: hid-sensor-magn-3d: Add support for rotation from north

 Documentation/ABI/testing/sysfs-bus-iio       |  82 +++++++++++++
 drivers/iio/industrialio-core.c               |   4 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 167 ++++++++++++++++++++------
 include/linux/iio/types.h                     |   4 +
 4 files changed, 220 insertions(+), 37 deletions(-)

-- 
1.9.3

