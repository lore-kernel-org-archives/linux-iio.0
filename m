Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48077 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbcAFBN3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jan 2016 20:13:29 -0500
From: Yong Li <sdliyong@gmail.com>
To: sdliyong@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, akinobu.mita@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: mcp4725: set iio name property in sysfs
Date: Wed,  6 Jan 2016 09:09:43 +0800
Message-Id: <1452042583-10580-1-git-send-email-sdliyong@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Without this change, the name entity for mcp4725 is missing in
/sys/bus/iio/devices/iio\:device*/name

With this change, name is reported correctly

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/iio/dac/mcp4725.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index fb4b336..cca935c 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -346,6 +346,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	data->client = client;
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
 	indio_dev->info = &mcp4725_info;
 	indio_dev->channels = &mcp472x_channel[id->driver_data];
 	indio_dev->num_channels = 1;
-- 
2.1.4

