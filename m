Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44795 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932557AbeCIXqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 18:46:32 -0500
Date: Fri, 9 Mar 2018 20:46:25 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging:iio:ad2s1210: Remove old_data from ad2s1210_state
Message-ID: <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The variable old_data is a bool type, which only receives the value
'true' in the function ad2s1210_config_write and ad2s1210_config_read.
There is no other use for this variable. This patch removes old_data
from the ad2s1210_state and from all the function that use it.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 79cb56670fc2..ac13b99bd9cb 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -76,7 +76,6 @@ struct ad2s1210_state {
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
-	bool old_data;
 	u8 resolution;
 	enum ad2s1210_mode mode;
 	u8 rx[2] ____cacheline_aligned;
@@ -107,7 +106,6 @@ static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
 	ret = spi_write(st->sdev, st->tx, 1);
 	if (ret < 0)
 		return ret;
-	st->old_data = true;
 
 	return 0;
 }
@@ -129,7 +127,6 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
 	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret < 0)
 		return ret;
-	st->old_data = true;
 
 	return st->rx[1];
 }
-- 
2.16.2

