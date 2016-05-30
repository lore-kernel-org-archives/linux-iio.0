Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:52288 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbcE3OwU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2016 10:52:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: as3935: improve error reporting in as3935_event_work
Date: Mon, 30 May 2016 16:52:04 +0200
Message-Id: <1464619938-988956-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

gcc warns about a potentially uninitialized variable use
in as3935_event_work:

drivers/iio/proximity/as3935.c: In function ‘as3935_event_work’:
drivers/iio/proximity/as3935.c:231:6: error: ‘val’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

This case specifically happens when spi_w8r8() fails with a
negative return code. We check all other users of this function
except this one.

As the error is rather unlikely to happen after the device
has already been initialized, this just adds a dev_warn().
Another warning already existst in the same function, but is
missing a trailing '\n' character, so I'm fixing that too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/proximity/as3935.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f4d29d5dbd5f..b49e3ab5730a 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -224,10 +224,16 @@ static void as3935_event_work(struct work_struct *work)
 {
 	struct as3935_state *st;
 	int val;
+	int ret;
 
 	st = container_of(work, struct as3935_state, work.work);
 
-	as3935_read(st, AS3935_INT, &val);
+	ret = as3935_read(st, AS3935_INT, &val);
+	if (ret) {
+		dev_warn(&st->spi->dev, "read error\n");
+		return;
+	}
+
 	val &= AS3935_INT_MASK;
 
 	switch (val) {
@@ -235,7 +241,7 @@ static void as3935_event_work(struct work_struct *work)
 		iio_trigger_poll(st->trig);
 		break;
 	case AS3935_NOISE_INT:
-		dev_warn(&st->spi->dev, "noise level is too high");
+		dev_warn(&st->spi->dev, "noise level is too high\n");
 		break;
 	}
 }
-- 
2.7.0

