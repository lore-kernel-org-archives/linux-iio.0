Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:57410 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbbH1WAT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:19 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 2/6] iio:dac:m62332: shutdown on remove
Date: Fri, 28 Aug 2015 23:59:54 +0200
Message-Id: <17d2da9c4c05f45dce7aa81362770f9bdeae0bed.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The regulator framework requests to balance regulator_enable() calls with
regulator_disable() calls. To meet this requirement, set channels to 0 on
remove, which implies a regulator_disable() call in case that channel was
enabled.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/dac/m62332.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index cffc0630ed32..c61720de8606 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -243,6 +243,8 @@ static int m62332_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_map_array_unregister(indio_dev);
+	m62332_set_value(indio_dev, 0, 0);
+	m62332_set_value(indio_dev, 0, 1);
 
 	return 0;
 }
-- 
2.4.6

