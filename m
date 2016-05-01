Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50181 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcEAUha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 16:37:30 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 11/13] iio: health/afe440x: Match LED currents to stages
Date: Sun, 1 May 2016 15:37:01 -0500
Message-ID: <1462135023-14445-12-git-send-email-afd@ti.com>
In-Reply-To: <1462135023-14445-1-git-send-email-afd@ti.com>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The current channel number for the LEDs should match the stage
number that they are active during, fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 10 ++++------
 drivers/iio/health/afe4404.c | 15 ++++++---------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 610631b..059d521 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -126,8 +126,6 @@ enum afe4403_chan_id {
 	ALED1,
 	LED2_ALED2,
 	LED1_ALED1,
-	ILED1,
-	ILED2,
 };
 
 static const unsigned int afe4403_channel_values[] = {
@@ -140,8 +138,8 @@ static const unsigned int afe4403_channel_values[] = {
 };
 
 static const unsigned int afe4403_channel_leds[] = {
-	[ILED1] = F_ILED1,
-	[ILED2] = F_ILED2,
+	[LED2] = F_ILED2,
+	[LED1] = F_ILED1,
 };
 
 static const struct iio_chan_spec afe4403_channels[] = {
@@ -153,8 +151,8 @@ static const struct iio_chan_spec afe4403_channels[] = {
 	AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
 	AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
 	/* LED current */
-	AFE440X_CURRENT_CHAN(ILED1),
-	AFE440X_CURRENT_CHAN(ILED2),
+	AFE440X_CURRENT_CHAN(LED2),
+	AFE440X_CURRENT_CHAN(LED1),
 };
 
 static const struct afe440x_val_table afe4403_res_table[] = {
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 69116cd..aa8770b 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -128,9 +128,6 @@ enum afe4404_chan_id {
 	ALED1,
 	LED2_ALED2,
 	LED1_ALED1,
-	ILED1,
-	ILED2,
-	ILED3,
 };
 
 static const unsigned int afe4404_channel_values[] = {
@@ -143,9 +140,9 @@ static const unsigned int afe4404_channel_values[] = {
 };
 
 static const unsigned int afe4404_channel_leds[] = {
-	[ILED1] = F_ILED1,
-	[ILED2] = F_ILED2,
-	[ILED3] = F_ILED3,
+	[LED2] = F_ILED2,
+	[ALED2] = F_ILED3,
+	[LED1] = F_ILED1,
 };
 
 static const unsigned int afe4404_channel_offdacs[] = {
@@ -164,9 +161,9 @@ static const struct iio_chan_spec afe4404_channels[] = {
 	AFE440X_INTENSITY_CHAN(LED2_ALED2, 0),
 	AFE440X_INTENSITY_CHAN(LED1_ALED1, 0),
 	/* LED current */
-	AFE440X_CURRENT_CHAN(ILED1),
-	AFE440X_CURRENT_CHAN(ILED2),
-	AFE440X_CURRENT_CHAN(ILED3),
+	AFE440X_CURRENT_CHAN(LED2),
+	AFE440X_CURRENT_CHAN(ALED2),
+	AFE440X_CURRENT_CHAN(LED1),
 };
 
 static const struct afe440x_val_table afe4404_res_table[] = {
-- 
2.8.1

