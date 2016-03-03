Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30852 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332AbcCCKnv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Mar 2016 05:43:51 -0500
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
Subject: [PATCH v2 1/5] iio:magnetometer:ak8975: fix uninitialized chipset
Date: Thu, 3 Mar 2016 11:44:03 +0100
Message-ID: <2a478132d071a144e6621832ac3badd2f636d61a.1457001111.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1457001111.git.gregor.boirie@parrot.com>
References: <cover.1457001111.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ak_def_array bounds are not properly checked in case of ACPI matching
failure. GCC warns with the following message at line 799:
‘chipset’ may be used uninitialized in this function.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 9c5c9ef..11059b2 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -774,8 +774,11 @@ static int ak8975_probe(struct i2c_client *client,
 	if (id) {
 		chipset = (enum asahi_compass_chipset)(id->driver_data);
 		name = id->name;
-	} else if (ACPI_HANDLE(&client->dev))
+	} else if (ACPI_HANDLE(&client->dev)) {
 		name = ak8975_match_acpi_device(&client->dev, &chipset);
+		if (!name)
+			return -ENODEV;
+	}
 	else
 		return -ENOSYS;
 
-- 
2.1.4

