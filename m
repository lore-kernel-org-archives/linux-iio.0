Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36156 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753750AbdHKToU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2017 15:44:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so3144104wrb.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2017 12:44:19 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, gregor.boirie@parrot.com,
        denis.ciocca@st.com, lorenzo.bianconi@st.com
Subject: [PATCH 1/2] iio: pressure: st_pressure: fix drdy configuration for LPS22HB and LPS25H
Date: Fri, 11 Aug 2017 21:44:13 +0200
Message-Id: <20170811194414.20741-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170811194414.20741-1-lorenzo.bianconi@st.com>
References: <20170811194414.20741-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove int2 configuration parameter for LPS22HB and LPS25H since
these devices export just int1 as data-ready line

Fixes: 931878405b86 (iio:pressure: Add support for LPS25H pressure sensor)
Fixes: e039e2f5b4da (iio:st_pressure:initial lps22hb sensor support)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/pressure/st_pressure_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index aa61ec15c139..c84eea73b3ae 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -390,7 +390,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = 0x23,
 			.mask_int1 = 0x01,
-			.mask_int2 = 0x10,
+			.mask_int2 = 0x00,
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 			.addr_od = 0x22,
@@ -449,7 +449,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = 0x12,
 			.mask_int1 = 0x04,
-			.mask_int2 = 0x08,
+			.mask_int2 = 0x00,
 			.addr_ihl = 0x12,
 			.mask_ihl = 0x80,
 			.addr_od = 0x12,
-- 
2.14.0

