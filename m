Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50746 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755178AbcKJJ0b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:31 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 23/28] staging: iio: tsl2583: clarified comment about clearing interrupts
Date: Thu, 10 Nov 2016 04:25:59 -0500
Message-Id: <1478769964-7065-24-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The comment that describes the code that clears the interrupt bit was
vague and didn't provide much value. This patch adds more detail about
why that bit needs to be cleared.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index d3fe9f7..68b77b8 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -205,8 +205,9 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	}
 
 	/*
-	 * clear status, really interrupt status (interrupts are off), but
-	 * we use the bit anyway - don't forget 0x80 - this is a command
+	 * Clear the pending interrupt status bit on the chip to allow the next
+	 * integration cycle to start. This has to be done even though this
+	 * driver currently does not support interrupts.
 	 */
 	ret = i2c_smbus_write_byte(chip->client,
 				   (TSL2583_CMD_REG | TSL2583_CMD_SPL_FN |
-- 
2.7.4

