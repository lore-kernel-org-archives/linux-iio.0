Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2A29ACC5;
	Sun, 16 Aug 2026 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849969; cv=none; b=OJygyOPZPv1QWjDsEJDqUlK79CRzasEy24HAChYMGbSjTSSMPcB8nkoOPE/Mlnf95u+2n/AWXCXsXgiABtTTqqFgjwYle6OuKhRszLtpkoCr/oVrjixNHQhLm1X5qHwuMd6X289mB3Fzj8DGHiXtdn6EUVrnYeDRDjxt+VWyBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849969; c=relaxed/simple;
	bh=Y1AK0IOErqM8P5qBQL6iY9ntDjcV9am22ycCOGnB5QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5dOQ1bIiYgDLvU+RbX39OnzOT1MscukBwtsgtlM/73uzbFlZn+Jays2Yv/AqNNLWDC0UW2ThPZtWSLRpIKkUISh69vLUWloFgVWr3u4LPC0/ocmp9LzfmGsJdHYEbzUkRclQ2CFaxsvqKxPl+u0E47J0JmKotCHBG1RbFAPvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuna9B/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuna9B/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F91F000E9;
	Sun, 16 Aug 2026 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786849967;
	bh=ma1I20qzr1MRZ2tl1fHwAM0YG5ggM9+YmEq6xaxBxRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yuna9B/rZRJrO/2LVBQBRJGairWwAqrcdLxF+rdACk1iE3lAcrcbgCFk4WTmbM1Ws
	 vn5pkVOMk56zrJK2/uEEBRkqZynRFRMzTf30HFpv4eXlAsuVYET/Szmw1v8/IdIbhQ
	 M7TNkAtCPdXYdhzbHwd9wkwMaBUdNzs8W1mvbiatiY0BC8pTUPIWTu/+xnTXQl1tbv
	 wCR1hXYFL33n/pN9ky+r/MOEDcTQn+c0CCuB33KvW1kRU/nGzw+K2U481dXqleekmk
	 n6dskaLXtXbn71kNFHKTe5MPMINyWKfSgJOD2yP5rpHowB7PryP+g6EAGSa7MPQX88
	 cdXefLBiqet7g==
Date: Sun, 16 Aug 2026 04:12:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Henrik Grimler" <henrik.grimler@axis.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 3/3] iio: accel: icm42370: Add FIFO buffer
 functionality
Message-ID: <20260816041243.08fcbb76@jic23-huawei>
In-Reply-To: <20260813-b4-inv_icm42370p-v2-3-11aedfdf76d3@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	<20260813-b4-inv_icm42370p-v2-3-11aedfdf76d3@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 14:26:12 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Add support for the hardware FIFO buffer to support high data rate
> capture. This includes necessary IIO buffer setup ops, watermark
> management and FIFO packet decoding. The accelerometer has 2.25kB FIFO
> size. The buffer can be handled via sysfs.
>=20
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
Hi Kanak,

I'm out of time for today so this is a little superficial.
I'll take a closer look at the buffer handling in v3.

Thanks,

Jonathan

> diff --git a/drivers/iio/accel/inv_icm42370_buffer.c b/drivers/iio/accel/=
inv_icm42370_buffer.c
> new file mode 100644
> index 0000000000000..c6a4d313c92c5
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_buffer.c
> @@ -0,0 +1,496 @@

> +
> +static int inv_icm42370_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/* Exit if there are several sensors using the FIFO. */
> +	if (data->fifo.on > 1) {
> +		data->fifo.on--;
> +		return 0;
> +	}
> +
> +	/* set FIFO in bypass mode */
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_FIFO_CONFIG1,
> +			   INV_ICM42370_FIFO_CONFIG_BYPASS);
> +	if (ret)
> +		return ret;
> +
> +	/* when FIFO is bypassed it gets disabled, so reduce the
> +	 * count
> +	 */
> +	data->fifo.on--;
> +
> +	/* flush FIFO data */
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH);
> +	if (ret)
> +		return ret;
> +
> +	/* disable FIFO threshold interrupt */
> +	ret =3D regmap_clear_bits(data->map, INV_ICM42370_REG_INT_SOURCE0,
> +				INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return regmap_clear_bits()

> +}
> +
> +static int inv_icm42370_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts =3D &data->ts;
> +	struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int sensor;
> +	unsigned int *watermark;
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	unsigned int sleep_temp =3D 0;
> +	unsigned int sleep_sensor =3D 0;
> +	unsigned int sleep;
> +	int ret;
> +
> +	if (indio_dev =3D=3D data->indio_accel) {
> +		sensor =3D INV_ICM42370_SENSOR_ACCEL;
> +		watermark =3D &data->fifo.watermark.accel;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&data->lock);

Read the documentation in cleanup.h.  Functions with stuff from
that and gotos are a non starter.  This one isn't buggy but it
is fragile to later code movement.

> +
> +	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
> +
> +	ret =3D inv_icm42370_buffer_set_fifo_en(data, data->fifo.en & ~sensor);
> +	if (ret)
> +		goto out_unlock;
> +
> +	*watermark =3D 0;
> +	ret =3D inv_icm42370_buffer_update_watermark(data);
> +	if (ret)
> +		goto out_unlock;
> +
> +	conf.mode =3D INV_ICM42370_SENSOR_MODE_OFF;
> +	ret =3D inv_icm42370_set_accel_conf(data, &conf, &sleep_sensor);
> +	if (ret)
> +		goto out_unlock;
> +
> +out_unlock:
No lock, so reanme that.

> +	/* sleep maximum required time */
> +	sleep =3D max(sleep_sensor, sleep_temp);
> +	if (sleep)
> +		msleep(sleep);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}

> +int inv_icm42370_buffer_fifo_parse(struct inv_icm42370_data *data)
> +{
> +	struct inv_sensors_timestamp *ts;
> +	int ret;
> +
> +	if (data->fifo.nb.total =3D=3D 0)
> +		return 0;
> +
> +	/* handle accelerometer timestamp and FIFO data parsing */
> +	if (data->fifo.nb.accel > 0) {
> +		ts =3D &data->ts;
> +		inv_sensors_timestamp_interrupt(
> +			ts, data->fifo.watermark.eff_accel, data->timestamp);
Go long on line to format that more nicely

> +		ret =3D inv_icm42370_accel_parse_fifo(data->indio_accel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

> +int inv_icm42370_buffer_init(struct inv_icm42370_data *data)
> +{
> +	unsigned int val;
> +	u8 regval;
> +	int ret;
> +
> +	data->fifo.watermark.eff_accel =3D 1;
> +
> +	/* watermark should be set to a non-zero value before enabling interrup=
ts */
> +	data->fifo.watermark.accel =3D 1;
> +	ret =3D inv_icm42370_buffer_update_watermark(data);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Default FIFO configuration (bits 6 to 5)
> +	 * - FIFO count in bytes
> +	 * - FIFO count in big endian
> +	 */
> +	val =3D INV_ICM42370_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
> +	ret =3D regmap_update_bits(data->map, INV_ICM42370_REG_INTF_CONFIG0,
> +				 GENMASK(6, 5), val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Enable FIFO partial read interrupt.
> +	 * Disable all FIFO EN bits.
> +	 */
> +	ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
> +				     INV_ICM42370_REG_FIFO_CONFIG5, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval &=3D ~(GENMASK(6, 5) | GENMASK(3, 0));

Those need defines so we know what they are.

> +	regval |=3D INV_ICM42370_FIFO_CONFIG5_WM_GT_TH;
> +	regval |=3D INV_ICM42370_FIFO_CONFIG5_RESUME_PARTIAL_RD;
> +
> +	return inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +				       INV_ICM42370_REG_FIFO_CONFIG5, regval);
> +}

> diff --git a/drivers/iio/accel/inv_icm42370_buffer.h b/drivers/iio/accel/=
inv_icm42370_buffer.h
> new file mode 100644
> index 0000000000000..d43a4209a5640
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_buffer.h

...

> +
> +/**
> + * struct inv_icm42370_fifo - FIFO state variables
> + * @on:		reference counter for FIFO on.
> + * @en:		bits field of INV_ICM42370_SENSOR_* for FIFO EN bits.
> + * @period:	FIFO internal period.
> + * @watermark:	watermark configuration values for accel.
> + * @count:	number of bytes in the FIFO data buffer.
> + * @nb:		accel and total samples in the FIFO data buffer.
> + * @data:	FIFO data buffer aligned for DMA.
> + */
> +struct inv_icm42370_fifo {
> +	struct {
> +		size_t accel;
> +		size_t total;
> +	} nb;
> +	struct {
> +		unsigned int accel;
> +		unsigned int eff_accel;
> +	} watermark;
> +	unsigned int on;
> +	unsigned int en;
> +	size_t count;
> +	u32 period;
> +	u8 *data __aligned(IIO_DMA_MINALIGN);

What do you think that does?  It doesn't do anything useful

> +};

> diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/in=
v_icm42370_core.c
> index 6266362e83f6a..b1713a2f533c8 100644
> --- a/drivers/iio/accel/inv_icm42370_core.c
> +++ b/drivers/iio/accel/inv_icm42370_core.c
> @@ -20,10 +20,25 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
> =20
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> =20
>  #include "inv_icm42370.h"
> +#include "inv_icm42370_buffer.h"
> +
> +#define INV_ICM42370_SCAN_MASK_ACCEL_3AXIS				\
> +	(BIT(INV_ICM42370_ACCEL_SCAN_X) |				\
> +	BIT(INV_ICM42370_ACCEL_SCAN_Y) |				\
> +	BIT(INV_ICM42370_ACCEL_SCAN_Z))
> +
Align after (


> @@ -75,6 +92,18 @@ static const int inv_icm42370_accel_scale[] =3D {
>  	[2 * INV_ICM42370_ACCEL_FS_2G + 1] =3D 598550,
>  };
> =20
> +/*
> + * IIO buffer layout: must match channel scan types.
> + * Accel: 3 x s16 BE (6 bytes), Temp: 1 x s16 native (2 bytes) =3D 8 byt=
es data.
> + * Timestamp: s64 at 8-byte aligned offset.
> + */
> +struct inv_icm42370_accel_buffer {
> +	struct inv_icm42370_fifo_sensor_data accel;
> +	s16 temp;
> +
> +	s64 timestamp __aligned(8);

	aligned_s64 timestamp;

> +};



> @@ -1161,15 +1263,54 @@ static int inv_icm42370_accel_read_raw(struct iio=
_dev *indio_dev,
>  	}
>  }
> =20
> +static int inv_icm42370_accel_hwfifo_set_watermark(struct iio_dev *indio=
_dev,
> +						   unsigned int val)
> +{
> +	struct inv_icm42370_data *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->fifo.watermark.accel =3D val;
> +	ret =3D inv_icm42370_buffer_update_watermark(st);
> +
> +	return ret;

	return inv_icm...

> +}
> +
> +static int inv_icm42370_accel_hwfifo_flush(struct iio_dev *indio_dev,
> +					   unsigned int count)
> +{
> +	struct inv_icm42370_data *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (count =3D=3D 0)
> +		return 0;
> +
> +	mutex_lock(&st->lock);
=09
	guard(mutex)(&st->lock);

> +
> +	ret =3D inv_icm42370_buffer_hwfifo_flush(st, count);
> +	if (!ret)
> +		ret =3D st->fifo.nb.accel;
	if (ret)
		return ret;

	return st->fifo.nb.accel;

> +
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}

> =20
>  struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
>  					struct inv_icm42370_data *data)
>  {
> +	struct device *dev =3D regmap_get_device(data->map);
>  	struct inv_sensors_timestamp_chip ts_chip;
> +	int ret;
> =20
>  	data->scales =3D inv_icm42370_accel_scale;
>  	data->scales_len =3D ARRAY_SIZE(inv_icm42370_accel_scale);
> @@ -1187,13 +1328,64 @@ struct iio_dev *inv_icm42370_accel_init(struct ii=
o_dev *indio_dev,
> =20
>  	indio_dev->name =3D "inv_icm42370";
>  	indio_dev->info =3D &inv_icm42370_info;
> -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_ALL_BUFFER_MODES;

That's very unlikely as there are a bunch of those modes.
No driver should ever set ALL_BUFFER_MODES

>  	indio_dev->channels =3D inv_icm42370_accel_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42370_accel_channels);
> =20
> +	ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &inv_icm42370_buffer_ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return indio_dev;
>  }
> =20
> +int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts =3D &data->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const void *accel, *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	s64 ts_val;
> +	struct inv_icm42370_accel_buffer buffer =3D {};
{ }; preferred style in IIO (I picked randomly a few years ago!)

Reverse xmas tree.

> +
> +	for (i =3D 0, no =3D 0; i < data->fifo.count; i +=3D size, ++no) {
> +		size =3D inv_icm42370_fifo_decode_packet(&data->fifo.data[i],
> +				&accel, &temp, &timestamp, &odr);
> +		if (size <=3D 0)
> +			return size;
> +
> +		if (accel =3D=3D NULL || !inv_icm42370_fifo_is_data_valid(accel))
> +			continue;
> +
> +		if (odr & INV_ICM42370_SENSOR_ACCEL)
> +			inv_sensors_timestamp_apply_odr(ts, data->fifo.period,
> +							data->fifo.nb.total, no);
> +
> +		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
> +
> +		/*
> +		 * FIFO 8-bit temp has sensitivity ~2 LSB/=C2=B0C.
> +		 * Register 16-bit temp has sensitivity 128 LSB/=C2=B0C.
> +		 * Scale factor: 128 / 2 =3D 64.
> +		 * This lets the IIO scale (1000/128) and offset (3200) work
> +		 * correctly for both register reads and FIFO data.
> +		 */
> +		if (temp)
> +			buffer.temp =3D (s16)*temp * 64;
> +		else
> +			buffer.temp =3D (s16)INV_ICM42370_DATA_INVALID;

Why put anything at all in there if no temp?

> +
> +		ts_val =3D inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);

iio_push_to_buffers_with_ts() for new code.

> +	}
> +
> +	return 0;
> +}
