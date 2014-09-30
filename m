Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43274 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaI3MAT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Sep 2014 08:00:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so5394063pab.9
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2014 05:00:19 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v3 1/4] Documentation: devicetree: bindings: Document correct and deprecated vendor-prefix with device isl29028
Date: Tue, 30 Sep 2014 17:29:05 +0530
Message-Id: <1412078348-7646-2-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch documents the device isl29028 with its vendor-prefix. Undocumented deprecated vendor-prefix
found by checkpatch also documented for compatibility reasons.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 6af570e..d024613 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -57,6 +57,8 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
 isl,isl12057		Intersil ISL12057 I2C RTC Chip
+isil,isl29028           Deprecated name, use isl,isl29028 instead
+isl,isl29028            Intersil ISL29028 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-- 
1.9.1

