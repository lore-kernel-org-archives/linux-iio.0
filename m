Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4DB82ABC.70304@iis.fraunhofer.de>
Date: Wed, 27 Apr 2011 16:39:56 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging: iio: hmc5843: Add missing attribute name
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
  drivers/staging/iio/magnetometer/hmc5843.c |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c 
b/drivers/staging/iio/magnetometer/hmc5843.c
index d0676e9..b015a38 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -481,6 +481,8 @@ static IIO_DEVICE_ATTR(magn_scale,
  			show_scale,
  			NULL , 0);
  +static IIO_CONST_ATTR_NAME("hmc5843");
+
  static struct attribute *hmc5843_attributes[] = {
  	&iio_dev_attr_meas_conf.dev_attr.attr,
  	&iio_dev_attr_operating_mode.dev_attr.attr,
@@ -491,6 +493,7 @@ static struct attribute *hmc5843_attributes[] = {
  	&iio_dev_attr_magn_y_raw.dev_attr.attr,
  	&iio_dev_attr_magn_z_raw.dev_attr.attr,
  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
  	NULL
  };
  -- 1.7.2.3
