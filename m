Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28259 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbbFOPRY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Jun 2015 11:17:24 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Subject: [PATCH] tools: iio: Add single-byte case for generic_buffer
Date: Mon, 15 Jun 2015 18:17:49 +0300
Message-Id: <1434381469-4373-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensors export data in an 8-bit format.
Add a single-byte case for the generic_buffer tool so that
these sensors' buffer data can be visualized.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 tools/iio/generic_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index f805493..0d438e3 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -103,6 +103,14 @@ void process_scan(char *data,
 	for (k = 0; k < num_channels; k++)
 		switch (channels[k].bytes) {
 			/* only a few cases implemented so far */
+		case 1:
+			if (channels[k].is_signed) {
+				int8_t val = *(int8_t *)
+					(data + channels[k].location);
+				printf("%05f ",
+					((float)val) * channels[k].scale);
+			}
+			break;
 		case 2:
 			print2byte(*(uint16_t *)(data + channels[k].location),
 				   &channels[k]);
-- 
1.9.1

