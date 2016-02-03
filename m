Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:43745 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcBCObL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 09:31:11 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 1/4] iio: ad5755: add support for dt bindings
Date: Wed, 3 Feb 2016 15:31:01 +0100
Message-ID: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Still missing a way to provide default modes and settings
for the driver from dt, but I see this as a start.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v1:
- none

 drivers/iio/dac/ad5755.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bfb350a..e1b6e78 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -607,6 +607,16 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
+static const struct of_device_id ad5755_of_match[] = {
+	{ .compatible = "adi,ad5755" },
+	{ .compatible = "adi,ad5755-1" },
+	{ .compatible = "adi,ad5757" },
+	{ .compatible = "adi,ad5735" },
+	{ .compatible = "adi,ad5737" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5755_of_match);
+
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
-- 
2.7.0

