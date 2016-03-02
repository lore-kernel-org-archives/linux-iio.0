Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30858 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178AbcCBLJ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Mar 2016 06:09:56 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 2/6] iio:magnetometer:ak8975: remove unused field
Date: Wed, 2 Mar 2016 12:10:24 +0100
Message-ID: <250cf66b368fb7d28ea7b02bb3e79ae580577e1c.1456916271.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1456916271.git.gregor.boirie@parrot.com>
References: <cover.1456916271.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove unused struct ak8975_data attrs field.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 11059b2..896b13e3 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -361,7 +361,6 @@ static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
 struct ak8975_data {
 	struct i2c_client	*client;
 	const struct ak_def	*def;
-	struct attribute_group	attrs;
 	struct mutex		lock;
 	u8			asa[3];
 	long			raw_to_gauss[3];
-- 
2.1.4

