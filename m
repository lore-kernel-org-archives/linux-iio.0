Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:13664
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751036AbeEVMzZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 08:55:25 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Martin Kelly <mkelly@xevo.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add comment about frequencies
Date: Tue, 22 May 2018 12:55:23 +0000
Message-ID: <CY4PR1201MB0184CB717224AA426AF6E501C4940@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180521184154.29548-1-mkelly@xevo.com>
In-Reply-To: <20180521184154.29548-1-mkelly@xevo.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>


From: Martin Kelly <mkelly@xevo.com>
Sent: Monday, May 21, 2018 20:41
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol; Jonathan Cameron; Martin Kelly
Subject: [PATCH] iio: imu: inv_mpu6050: add comment about frequencies

Although the driver allows frequencies between 4 and 1000 Hz, only the
frequencies advertised in the available frequencies file are backed
properly by a low-pass filter to prevent aliasing, so it's best to use
them. Since this is not obvious to the user, add a comment explaining
what's going on.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 ++++++++-
=A01 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 43fba5f7532b..f9c0624505a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -798,7 +798,14 @@ static const struct iio_chan_spec inv_mpu_channels[] =
=3D {
=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SC=
AN_ACCL_Z),
=A0};

-/* constant IIO attribute */
+/*
+ * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE and
+ * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by th=
e
+ * low-pass filter. Specifically, each of these sampling rates are about t=
wice
+ * the bandwidth of a corresponding low-pass filter, which should eliminat=
e
+ * aliasing following the Nyquist principle. By picking a frequency differ=
ent
+ * from these, the user risks aliasing effects.
+ */
=A0static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
=A0static IIO_CONST_ATTR(in_anglvel_scale_available,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "0.000133090 0.000266181 0=
.000532362 0.001064724");
--
2.11.0

    =
