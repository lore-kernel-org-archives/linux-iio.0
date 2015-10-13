Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-112.synserver.de ([212.40.185.112]:1169 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753048AbbJMQTw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:19:52 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success
Date: Tue, 13 Oct 2015 18:15:37 +0200
Message-Id: <1444752938-4680-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

i2c_master_send() returns the number of bytes transferred on success while
the ad5064 driver expects that the write() callback returns 0 on success.
Fix that by translating any non negative return value of i2c_master_send()
to 0.

Fixes: commit 6a17a0768f77 ("iio:dac:ad5064: Add support for the ad5629r and ad5669r")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5064.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index c067e68..7e7ebf3 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -598,10 +598,16 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
 	unsigned int addr, unsigned int val)
 {
 	struct i2c_client *i2c = to_i2c_client(st->dev);
+	int ret;
 
 	st->data.i2c[0] = (cmd << 4) | addr;
 	put_unaligned_be16(val, &st->data.i2c[1]);
-	return i2c_master_send(i2c, st->data.i2c, 3);
+
+	ret = i2c_master_send(i2c, st->data.i2c, 3);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int ad5064_i2c_probe(struct i2c_client *i2c,
-- 
2.1.4

