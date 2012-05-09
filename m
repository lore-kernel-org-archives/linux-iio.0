Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52622 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2EIJ7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:59:53 -0400
Received: by lbbgm6 with SMTP id gm6so57531lbb.19
        for <linux-iio@vger.kernel.org>; Wed, 09 May 2012 02:59:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336515606-12364-2-git-send-email-pmeerw@pmeerw.net>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
	<1336515606-12364-2-git-send-email-pmeerw@pmeerw.net>
Date: Wed, 9 May 2012 15:29:52 +0530
Message-ID: <CAM=Q2csFuVULPim9gE8YnVLCDmJDFTuSFPWwrUmM29yR=LpCEQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: fix access to hmc5843 private data
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,
A minor observation your from and signoff are a little different was
it intended?

On Wed, May 9, 2012 at 3:49 AM, Peter Meerwald <pmeerw@pmeerw.net> wrot=
e:
> From: Peter Meerwald <p.meerwald@bct-electronic.com>
>
> i2c_get_clientdata(client) points to iio_dev, not hmc5843_data; fixes
> issue similar to 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72
>
Looks good to me ack.

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
> =A0drivers/staging/iio/magnetometer/hmc5843.c | =A0 14 +++++++++-----
> =A01 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/sta=
ging/iio/magnetometer/hmc5843.c
> index 3ec6518..9725cf8 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -250,7 +250,8 @@ static IIO_DEVICE_ATTR(operating_mode,
> =A0static s32 hmc5843_set_meas_conf(struct i2c_client *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0u8 meas_conf)
> =A0{
> - =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct hmc5843_data *data =3D iio_priv(indio_dev);
> =A0 =A0 =A0 =A0u8 reg_val;
> =A0 =A0 =A0 =A0reg_val =3D (meas_conf & MEAS_CONF_MASK) | =A0(data->r=
ate << RATE_OFFSET);
> =A0 =A0 =A0 =A0return i2c_smbus_write_byte_data(client, HMC5843_CONFI=
G_REG_A, reg_val);
> @@ -272,7 +273,7 @@ static ssize_t hmc5843_set_measurement_configurat=
ion(struct device *dev,
> =A0{
> =A0 =A0 =A0 =A0struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> =A0 =A0 =A0 =A0struct i2c_client *client =3D to_i2c_client(indio_dev-=
>dev.parent);
> - =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct hmc5843_data *data =3D iio_priv(indio_dev);
> =A0 =A0 =A0 =A0unsigned long meas_conf =3D 0;
> =A0 =A0 =A0 =A0int error =3D strict_strtoul(buf, 10, &meas_conf);
> =A0 =A0 =A0 =A0if (error)
> @@ -314,7 +315,8 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 =
10 20 50");
> =A0static s32 hmc5843_set_rate(struct i2c_client *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 rat=
e)
> =A0{
> - =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct hmc5843_data *data =3D iio_priv(indio_dev);
> =A0 =A0 =A0 =A0u8 reg_val;
>
> =A0 =A0 =A0 =A0reg_val =3D (data->meas_conf) | =A0(rate << RATE_OFFSE=
T);
> @@ -600,8 +602,10 @@ static int hmc5843_suspend(struct device *dev)
>
> =A0static int hmc5843_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(to_i2c=
_client(dev));
> - =A0 =A0 =A0 hmc5843_configure(to_i2c_client(dev), data->operating_m=
ode);
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct hmc5843_data *data =3D iio_priv(indio_dev);
> + =A0 =A0 =A0 hmc5843_configure(client, data->operating_mode);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
