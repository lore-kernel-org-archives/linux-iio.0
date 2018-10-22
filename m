Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34958 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJWFAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 01:00:33 -0400
Date: Mon, 22 Oct 2018 17:40:25 -0300
From: Victor Colombo <victorcolombo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/2] staging: iio: ad5933: Remove unnecessary space on casting
Message-ID: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: No space is necessary after a cast

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a920f675b83..7a216ea90784 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -210,7 +210,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = (u64) freq * (u64) (1 << 27);
+	freqreg = (u64)freq * (u64)(1 << 27);
 	do_div(freqreg, st->mclk_hz / 4);
 
 	switch (reg) {
-- 
2.19.1
