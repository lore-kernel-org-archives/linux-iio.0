Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45946 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab3CXQ6k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2013 12:58:40 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] staging:iio:magnetometer:ak8975 drop unused eoc_irq
Date: Sun, 24 Mar 2013 16:58:27 +0000
Message-Id: <1364144310-32251-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1364144310-32251-1-git-send-email-jic23@kernel.org>
References: <1364144310-32251-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index b614da1..8726ea1 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -94,7 +94,6 @@ struct ak8975_data {
 	long			raw_to_gauss[3];
 	u8			reg_cache[AK8975_MAX_REGS];
 	int			eoc_gpio;
-	int			eoc_irq;
 };
 
 static const int ak8975_index_to_reg[] = {
@@ -452,7 +451,6 @@ static int ak8975_probe(struct i2c_client *client,
 
 	data->client = client;
 	mutex_init(&data->lock);
-	data->eoc_irq = client->irq;
 	data->eoc_gpio = eoc_gpio;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = ak8975_channels;
-- 
1.8.1.4

