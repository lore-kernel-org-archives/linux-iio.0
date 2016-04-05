Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay03.alfahosting-server.de ([109.237.142.239]:44149 "EHLO
	relay03.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751635AbcDENKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Apr 2016 09:10:03 -0400
Date: Tue, 5 Apr 2016 15:03:48 +0200
From: Richard Leitner <dev@g0hl1n.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Richard Leitner <dev@g0hl1n.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ak8975: fix maybe-uninitialized warning
Message-ID: <20160405150348.30fea0a9@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If i2c_device_id *id is NULL and acpi_match_device returns NULL too,
then chipset may be unitialized when accessing &ak_def_array[chipset] in
ak8975_probe. Therefore initialize chipset to AK_MAX_TYPE, which will
return an error when not changed.

This patch fixes the following maybe-uninitialized warning:

drivers/iio/magnetometer/ak8975.c: In function ‘ak8975_probe’:
drivers/iio/magnetometer/ak8975.c:788:14: warning: ‘chipset’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  data->def = &ak_def_array[chipset];

Signed-off-by: Richard Leitner <dev@g0hl1n.net>
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c
b/drivers/iio/magnetometer/ak8975.c index 9c5c9ef..82783dc 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -732,7 +732,7 @@ static int ak8975_probe(struct i2c_client *client,
 	int eoc_gpio;
 	int err;
 	const char *name = NULL;
-	enum asahi_compass_chipset chipset;
+	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
 
 	/* Grab and set up the supplied GPIO. */
 	if (client->dev.platform_data)
-- 
2.1.4

