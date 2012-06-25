Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/7] iio staging: fix generic_buffer print2byte()
Date: Mon, 25 Jun 2012 21:11:39 +0200
Message-Id: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

drop extra argument, move cast

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index bf55335..8d6e91c 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -72,8 +72,7 @@ void print2byte(int input, struct iio_channel_info *info)
 		val &= (1 << info->bits_used) - 1;
 		val = (int16_t)(val << (16 - info->bits_used)) >>
 			(16 - info->bits_used);
-		printf("%05f  ", val,
-		       (float)(val + info->offset)*info->scale);
+		printf("%05f  ", ((float)val + info->offset)*info->scale);
 	} else {
 		uint16_t val = input;
 		val &= (1 << info->bits_used) - 1;
-- 
1.7.9.5
