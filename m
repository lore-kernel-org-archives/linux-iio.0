Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:41487 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0D0XOJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2010 19:14:09 -0400
Message-ID: <4BD7706F.70003@cam.ac.uk>
Date: Wed, 28 Apr 2010 00:17:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Song, Barry" <Barry.Song@analog.com>
CC: linux-iio@vger.kernel.org, "Zhang, Sonic" <Sonic.Zhang@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: adis16300 to new abi
References: <4BD5F4A8.7020309@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/27/10 04:20, Song, Barry wrote:
> Drivers that passed debugging and testing on hardware can be pushed to mainline. By now, ADIS16300 and ADIS16400 drivers are on the list.
> But the problem is they are based on old abi, will you change codes to match new abi? If no, we can update codes after you merge the new abi into mainline.
> 

Hi Barry,

I've just taken a quick look at the adis16300 driver.  The following
patch is all that is needed to get it to build against the abi patch set.
(and touch wood it should still work, be it with an odd mix of abis)

There are other changes to meet the abi, but they can be done via 
incremental patches after this one.  They are all name changes (such as
addition of _raw to the inclination parameters) or additional parameters
that would be needed by a general userspace interpreter (my
drivers are missing some of these as well at the moment!).  Also there
are a couple of additions to make to the abi documentation.  All of these
could be sorted by a nice clean patch set after the driver patch itself.

Whilst we are here.  Under what circumstances does userspace want to reset
the device manually?  Unless there is a clear and common use for this, I'd
be inclined to move that particular attribute definition into individual
drivers.

How do you want to do the actual patch? I could apply the following as
a 'merge' fix to a clean patch from you, or I can put together a suitable
hybrid of the two (from you of course). Obviously this would need you
to take a quick glance and sign-off on it.

Thanks,

Jonathan
---
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 8f84175..94ea2d1 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -646,9 +646,9 @@ static struct attribute *adis16300_attributes[] = {
        &iio_const_attr_volt_supply_scale.dev_attr.attr,
        &iio_dev_attr_gyro_x.dev_attr.attr,
        &iio_const_attr_gyro_scale.dev_attr.attr,
-       &iio_dev_attr_accel_x.dev_attr.attr,
-       &iio_dev_attr_accel_y.dev_attr.attr,
-       &iio_dev_attr_accel_z.dev_attr.attr,
+       &iio_dev_attr_accel_x_raw.dev_attr.attr,
+       &iio_dev_attr_accel_y_raw.dev_attr.attr,
+       &iio_dev_attr_accel_z_raw.dev_attr.attr,
        &iio_const_attr_accel_scale.dev_attr.attr,
        &iio_dev_attr_incli_x.dev_attr.attr,
        &iio_dev_attr_incli_y.dev_attr.attr,
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 79298b3..76cf8a6 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -49,7 +49,7 @@ static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, IIO_SIGNED(12),
 static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12),
                     ADIS16300_YINCLI_OUT, NULL);
 
-static IIO_SCAN_EL_TIMESTAMP;
+static IIO_SCAN_EL_TIMESTAMP(9);
 
 static struct attribute *adis16300_scan_el_attrs[] = {
        &iio_scan_el_supply.dev_attr.attr,
@@ -224,7 +224,7 @@ error_iio_sw_rb_free:
 
 int adis16300_initialize_ring(struct iio_ring_buffer *ring)
 {
-       return iio_ring_buffer_register(ring);
+       return iio_ring_buffer_register(ring, 0);
 }
 
 void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
