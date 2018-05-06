Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeEFQ3x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 12:29:53 -0400
Date: Sun, 6 May 2018 17:29:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accell: mma8452: Reduce sleep time when data not
 ready
Message-ID: <20180506172949.0bf0f33c@archlinux>
In-Reply-To: <36898239-4047-b061-e6d7-7dd566a98976@electromag.com.au>
References: <e15558d1-ef9b-edbf-7fd8-e4d0e86e6b22@electromag.com.au>
        <36898239-4047-b061-e6d7-7dd566a98976@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 30 Apr 2018 17:50:06 +0800
Richard Tresidder <rtresidd@electromag.com.au> wrote:

> Hi
> Sorry realised I hadn't cc'd a maintainer so trying again
> First patch attempt.
> Currently the driver runs into problems when trying to acquire at sample
> rates higher than 50sps.
> This is due to the usage of msleep when data is not ready.
> This patch attempts to speed things up by utilising the usleep_range
> call to allow shorter sleep times.
>=20
> I've tested this using iio buffers and hr triggers up to 100sps on a
> mma8451 device.
> It should technically be ok up to the 800sps rate though.
>=20
> I seem to have snuck a couple of whitespace alignment fixes into this also
> Please let me know if I should remove separate them

Separate patches please.  It is possible we will want to backport
the reduction in sleep time to older kernels, where as we won't bother
with the white space stuff.

Also I think your email client has replaced all tabs with spaces
thus making the patch broken.  Please fix that up before sending
a v2.

The fundamental change seems sensible to me. Please cc
the original driver author on future versions (it's also
worth checking for anyone else who had made large changes
recently and adding them to the cc.)

Jonathan

>=20
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7a2da7f..cede523 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -57,7 +57,7 @@
> =C2=A0#define MMA8452_FF_MT_THS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x17
> =C2=A0#define=C2=A0 MMA8452_FF_MT_THS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7f
> =C2=A0#define MMA8452_FF_MT_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x18
> -#define MMA8452_FF_MT_CHAN_SHIFT=C2=A0=C2=A0=C2=A0 3
> +#define MMA8452_FF_MT_CHAN_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 3
> =C2=A0#define MMA8452_TRANSIENT_CFG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1d
> =C2=A0#define=C2=A0 MMA8452_TRANSIENT_CFG_CHAN(chan)=C2=A0=C2=A0=C2=A0 BI=
T(chan + 1)
> =C2=A0#define=C2=A0 MMA8452_TRANSIENT_CFG_HPF_BYP=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(0)
> @@ -69,7 +69,7 @@
> =C2=A0#define MMA8452_TRANSIENT_THS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1f
> =C2=A0#define=C2=A0 MMA8452_TRANSIENT_THS_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 GENMASK(6, 0)
> =C2=A0#define MMA8452_TRANSIENT_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x20
> -#define MMA8452_TRANSIENT_CHAN_SHIFT 1
> +#define MMA8452_TRANSIENT_CHAN_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1
> =C2=A0#define MMA8452_CTRL_REG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x2a
> =C2=A0#define=C2=A0 MMA8452_CTRL_ACTIVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0)
> =C2=A0#define=C2=A0 MMA8452_CTRL_DR_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(5, 3)
> @@ -106,6 +106,7 @@ struct mma8452_data {
> =C2=A0=C2=A0=C2=A0=C2=A0 u8 ctrl_reg1;
> =C2=A0=C2=A0=C2=A0=C2=A0 u8 data_cfg;
> =C2=A0=C2=A0=C2=A0=C2=A0 const struct mma_chip_info *chip_info;
> +=C2=A0=C2=A0=C2=A0 int sleep_val;
> =C2=A0};
> =C2=A0
> =C2=A0 /**
> @@ -193,7 +194,10 @@ static int mma8452_drdy(struct mma8452_data *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((ret & MMA8452_STATU=
S_DRDY) =3D=3D MMA8452_STATUS_DRDY)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return 0;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(20);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->sleep_val <=3D 20)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uslee=
p_range(data->sleep_val * 250, data->sleep_val * 500);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mslee=
p(20);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&data->client->dev, "data not ready\n");
> @@ -544,10 +548,22 @@ static int mma8452_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> =C2=A0}
> =C2=A0
> +static int mma8452_calculate_sleep(struct mma8452_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 int ret, i =3D mma8452_get_odr_index(data);
> +=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0 if (mma8452_samp_freq[i][0] > 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1000 / mma8452_samp_f=
req[i][0];
> +=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1000;
> +
> +=C2=A0=C2=A0=C2=A0 return ret =3D=3D 0 ? 1 : ret;
> +}
> +
> =C2=A0static int mma8452_standby(struct mma8452_data *data)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 return i2c_smbus_write_byte_data(data->client, M=
MA8452_CTRL_REG1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 & ~MMA8452_CTRL_=
ACTIVE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 & ~MMA8452=
_CTRL_ACTIVE);
> =C2=A0}
> =C2=A0
> =C2=A0static int mma8452_active(struct mma8452_data *data)
> @@ -700,6 +716,8 @@ static int mma8452_write_raw(struct iio_dev *indio_de=
v,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 &=3D ~MM=
A8452_CTRL_DR_MASK;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 |=3D i <=
< MMA8452_CTRL_DR_SHIFT;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->sleep_val =3D mma8452_c=
alculate_sleep(data);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mma8452_change_c=
onfig(data, MMA8452_CTRL_REG1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da=
ta->ctrl_reg1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> @@ -738,7 +756,7 @@ static int mma8452_write_raw(struct iio_dev *indio_de=
v,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mma8452_change_c=
onfig(data, MMA8452_DATA_CFG,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da=
ta->data_cfg);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->da=
ta_cfg);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -761,8 +779,9 @@ static int mma8452_write_raw(struct iio_dev *indio_de=
v,
> =C2=A0}
> =C2=A0
> =C2=A0static int mma8452_get_event_regs(struct mma8452_data *data,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *c=
han, enum iio_event_direction dir,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct mma8452_event_re=
gs **ev_reg)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct mma8452_event_regs **ev_reg)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!chan)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> @@ -772,9 +791,9 @@ static int mma8452_get_event_regs(struct
> mma8452_data *data,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (dir) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_EV_DIR_RISING:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if ((data->chip_info->all_events
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & MMA8452_INT_TRANS) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (data->chip_info->enabled_events
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & MMA8452_INT_TRANS))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 & MMA8452_INT_TRANS) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (data->chip_info->enabled_events
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 & MMA8452_INT_TRANS))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *ev_reg =3D &trans_ev_regs;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *ev_reg =3D &ff_mt_ev_regs;
> @@ -791,11 +810,11 @@ static int mma8452_get_event_regs(struct
> mma8452_data *data,
> =C2=A0}
> =C2=A0
> =C2=A0static int mma8452_read_event_value(struct iio_dev *indio_dev,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_info info,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_info info,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 struct mma8452_data *data =3D iio_priv(indio_dev=
);
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, us, power_mode;
> @@ -854,11 +873,11 @@ static int mma8452_read_event_value(struct iio_dev
> *indio_dev,
> =C2=A0}
> =C2=A0
> =C2=A0static int mma8452_write_event_value(struct iio_dev *indio_dev,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enum iio_event_info info,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int val, int val2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec=
 *chan,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction d=
ir,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_info info,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 struct mma8452_data *data =3D iio_priv(indio_dev=
);
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, reg, steps;
> @@ -1528,6 +1547,7 @@ static int mma8452_probe(struct i2c_client *client,
> =C2=A0=C2=A0=C2=A0=C2=A0 case FXLS8471_DEVICE_ID:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D data->chi=
p_info->chip_id)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FALLTHRU */
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -1593,6 +1613,9 @@ static int mma8452_probe(struct i2c_client *client,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 =3D MMA8452_CTRL_ACTIVE |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0 data->sleep_val =3D mma8452_calculate_sleep(data);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(client, MMA845=
2_CTRL_REG1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

