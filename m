Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59114
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751130AbdAPPvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 10:51:01 -0500
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 2/3] iio: potentiometer: mcp4531: Export OF device ID table as module aliases
Date: Mon, 16 Jan 2017 12:50:44 -0300
Message-Id: <1484581845-19457-2-git-send-email-javier@osg.samsung.com>
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

 drivers/iio/potentiometer/mcp4531.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 0d1bcf89ae17..314353d7ab59 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -284,6 +284,7 @@ static const struct of_device_id mcp4531_of_match[] = {
 	MCP4531_COMPATIBLE("microchip,mcp4662-104", MCP466x_104),
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mcp4531_of_match);
 #endif
 
 static int mcp4531_probe(struct i2c_client *client,
-- 
2.7.4

