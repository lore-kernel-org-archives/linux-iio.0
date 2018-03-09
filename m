Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:48754 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeCIJBk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Mar 2018 04:01:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 844F24380065
        for <linux-iio@vger.kernel.org>; Fri,  9 Mar 2018 10:01:39 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id A57704380064
        for <linux-iio@vger.kernel.org>; Fri,  9 Mar 2018 10:01:38 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 09 Mar 2018 10:01:38 +0100
From: Michael Nosthoff <committed@heine.so>
To: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: accel: Revert "iio: accel: st_accel: remove
 redundant pointer pdata"
Message-ID: <f489bdb12143112e091dcfdc9e6cb35b@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 585ed27d removed code which was unused due to a bug in
commit 7383d44b. To fix this bug the code is needed. Thus this
revert.

This reverts commit 585ed27d06151f98e39238298f43ee261314ae74.
Signed-off-by: Michael Nosthoff <committed@heine.so>
---
  drivers/iio/accel/st_accel_core.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c 
b/drivers/iio/accel/st_accel_core.c
index 6fe995c..460aa58 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -920,6 +920,8 @@ static const struct iio_trigger_ops 
st_accel_trigger_ops = {
  int st_accel_common_probe(struct iio_dev *indio_dev)
  {
  	struct st_sensor_data *adata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
  	int irq = adata->get_irq_data_ready(indio_dev);
  	int err;

@@ -946,6 +948,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
  					&adata->sensor_settings->fs.fs_avl[0];
  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;

+	if (!pdata)
+		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
+
  	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
  	if (err < 0)
  		goto st_accel_power_off;
-- 
2.7.4
