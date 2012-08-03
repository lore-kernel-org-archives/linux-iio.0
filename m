Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Juergen Beisert <jbe@pengutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Wolfgang Denk <wd@denx.de>
Subject: [PATCH 1/3] IIO: Add 4-byte unsigned reads into generic-buffer example
Date: Fri,  3 Aug 2012 17:28:39 +0200
Message-Id: <1344007721-11595-2-git-send-email-marex@denx.de>
In-Reply-To: <1344007721-11595-1-git-send-email-marex@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Add unsigned 32bit-wide reads into the generic-buffer.c

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Juergen Beisert <jbe@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/staging/iio/Documentation/generic_buffer.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 827e92d..40d0eca 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -104,6 +104,16 @@ void process_scan(char *data,
 			print2byte(*(uint16_t *)(data + channels[k].location),
 				   &channels[k]);
 			break;
+		case 4:
+			if (!channels[k].is_signed) {
+				uint32_t val = *(uint32_t *)
+					(data + channels[k].location);
+				printf("%05f ", ((float)val +
+						 channels[k].offset)*
+				       channels[k].scale);
+
+			}
+			break;
 		case 8:
 			if (channels[k].is_signed) {
 				int64_t val = *(int64_t *)
-- 
1.7.10.4
