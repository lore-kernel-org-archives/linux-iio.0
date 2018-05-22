Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeEVRd3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 13:33:29 -0400
Date: Tue, 22 May 2018 18:33:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: Martin Kelly <mkelly@xevo.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add comment about frequencies
Message-ID: <20180522183324.412667f2@archlinux>
In-Reply-To: <CY4PR1201MB0184CB717224AA426AF6E501C4940@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180521184154.29548-1-mkelly@xevo.com>
        <CY4PR1201MB0184CB717224AA426AF6E501C4940@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 12:55:23 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>=20
>=20
> From: Martin Kelly <mkelly@xevo.com>
> Sent: Monday, May 21, 2018 20:41
> To: linux-iio@vger.kernel.org
> Cc: Jean-Baptiste Maneyrol; Jonathan Cameron; Martin Kelly
> Subject: [PATCH] iio: imu: inv_mpu6050: add comment about frequencies
>=20
> Although the driver allows frequencies between 4 and 1000 Hz, only the
> frequencies advertised in the available frequencies file are backed
> properly by a low-pass filter to prevent aliasing, so it's best to use
> them. Since this is not obvious to the user, add a comment explaining
> what's going on.
>=20
> Signed-off-by: Martin Kelly <mkelly@xevo.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 43fba5f7532b..f9c0624505a2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -798,7 +798,14 @@ static const struct iio_chan_spec inv_mpu_channels[]=
 =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, II=
O_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
> =C2=A0};
>=20
> -/* constant IIO attribute */
> +/*
> + * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE a=
nd
> + * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by =
the
> + * low-pass filter. Specifically, each of these sampling rates are about=
 twice
> + * the bandwidth of a corresponding low-pass filter, which should elimin=
ate
> + * aliasing following the Nyquist principle. By picking a frequency diff=
erent
> + * from these, the user risks aliasing effects.
> + */
> =C2=A0static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
> =C2=A0static IIO_CONST_ATTR(in_anglvel_scale_available,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "0.000133090 0.000266181 0.000532362 0.001064724");
> --
> 2.11.0
>=20
>     --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

