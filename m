Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:51042 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdHBX0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 19:26:15 -0400
Date: Thu, 3 Aug 2017 01:26:09 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iio: srf08: add buffered to device mode
Message-ID: <20170802232609.GA15406@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add INDIO_BUFFER_TRIGGERED and INDIO_BUFFER_SOFTWARE to device mode

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index a63c272c3b22..ea238ab1066c 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -437,7 +437,9 @@ static int srf08_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE
+				| INDIO_BUFFER_TRIGGERED
+				| INDIO_BUFFER_SOFTWARE;
 
 	/* srf02 is not using sensitivity nor max_range */
 	if (id->driver_data == SRF02)
-- 
2.1.4


-- 
