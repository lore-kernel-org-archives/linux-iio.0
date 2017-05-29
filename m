Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36901 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdE2PwN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/38] iio:frequency: drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:28 +0100
Message-Id: <20170529155154.22580-13-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/frequency/ad9523.c  | 1 -
 drivers/iio/frequency/adf4350.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 99eba524f6dd..ddb6a334ae68 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -738,7 +738,6 @@ static const struct iio_info ad9523_info = {
 	.write_raw = &ad9523_write_raw,
 	.debugfs_reg_access = &ad9523_reg_access,
 	.attrs = &ad9523_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9523_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index d2d824b446f5..6d768431d90e 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -374,7 +374,6 @@ static const struct iio_chan_spec adf4350_chan = {
 
 static const struct iio_info adf4350_info = {
 	.debugfs_reg_access = &adf4350_reg_access,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_OF
-- 
2.13.0

