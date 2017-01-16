Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59126
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751130AbdAPPvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 10:51:07 -0500
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Stefan Eichenberger <eichest@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Vaussard <florian.vaussard@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio: adc: max1363: Export OF device ID table as module aliases
Date: Mon, 16 Jan 2017 12:50:45 -0300
Message-Id: <1484581845-19457-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
References: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/adc/max1363.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 841a13c9b6ea..c6c12feb4a08 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1567,6 +1567,7 @@ static const struct of_device_id max1363_of_match[] = {
 	MAX1363_COMPATIBLE("maxim,max11647", max11647),
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, max1363_of_match);
 #endif
 
 static int max1363_probe(struct i2c_client *client,
-- 
2.7.4

