Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:44616 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdBLKzj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Feb 2017 05:55:39 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 1/2] staging: iio: isl29028: change sampling frequencies available to use decimals
Date: Sun, 12 Feb 2017 05:55:33 -0500
Message-Id: <20170212105534.5648-2-masneyb@onstation.org>
In-Reply-To: <20170212105534.5648-1-masneyb@onstation.org>
References: <20170212105534.5648-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sysfs attribute in_proximity_sampling_frequency_available currently
shows the values 1 3 5 10 13 20 83 100. These values are supposed to
correspond to the sleep values 800 400 200 100 75 50 12 0 (all in ms).
When passing in a sampling frequency of 3, it actually uses a sleep
time of 200ms instead of the expected 400ms value. This patch changes
the value shown by this sysfs attribute to use decimal numbers so
that the correct sampling frequency is shown to the user. Only the
integer portion is actually passed to isl29028_set_proxim_sampling(),
but that is ok since the correct sleep time will still be selected.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 5375e7a..c1d6540 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -472,7 +472,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
-				"1 3 5 10 13 20 83 100");
+				"1.25 2.5 5 10 13.3 20 83.3 100");
 static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
 
 #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
-- 
2.9.3

