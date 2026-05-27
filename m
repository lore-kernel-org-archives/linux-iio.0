Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB4296BCD
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898025; cv=none; b=RXgsXQe3rTNDVweRGL6YzU0Z3afBCjpyERgI9LwjqGFgOQaSJj8LL+tk72prIoQH2tifuNOqZi+uTOhCZ9cL3CB1AxMjSlEhH1WVBVwyshHHEBKHl0u0hl9ujnnmwank4sJt8w/tofdx4jmVWbl/9cSxmTYvXCKP7IXZBuzG89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898025; c=relaxed/simple;
	bh=FWbRiVisD9vp06iEzSmRg0ALKQFA1RmN5gfYjO4gjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H027yZNRiao+izgACG6VU35JAP2EMm0KUDtY+DZc2kKhFg/nPEQpD2CKNrbjg4csMFyAoyKoKfS+wywC04RacytY6MPkJT1J0dqfZ+bDOKfXhx9D0Q2vxd4EtrPNP8EGWygtt/I3W7jp5dchoGsHB0bD3UhFsZW1YsRauC3oV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCRGPRpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCRGPRpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C881F000E9;
	Wed, 27 May 2026 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898024;
	bh=h/PmrBpOltuGRQItvevqc4m4HN5vkamET4ylyxLgu9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eCRGPRpZCOSa5scur4XOZdrlPNsJJZbb05LJ3vorrg8/CMg1z+Pd56usbHm0J++70
	 v+PX5AKcjCG+60vHT8zThCQ8Y2Atzg+jFiaAox8WRnMDsEXUhiAq//rxJB+hab4fOq
	 DOzXJlF1dRVUw6y9LWWCVqdVZmr/quzAwu2D6wF3sdmgfyoL8q/vGVZr1PMIzhdLFm
	 Z8tsNaWEJtj3tDct0gbZhsiWgTgCX9odtqEpt3Bw/cVT/j3T3dtkvDnNXaVKuJTOlE
	 J5jaS+aHfDN6XupbZgyhLlBDtNTW+4NWW3t7peK+3t4F7eabmmxavdt4xUoAlcI8p4
	 EG8mJPCk6qRwg==
Date: Wed, 27 May 2026 17:06:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <20260527170656.4ef393bf@jic23-huawei>
In-Reply-To: <3219ec710db09eff8a0324b2f6ab3b78e883df9f.1779781224.git.azpijr@gmail.com>
References: <cover.1779781224.git.azpijr@gmail.com>
	<3219ec710db09eff8a0324b2f6ab3b78e883df9f.1779781224.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 09:55:46 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add IIO driver for Broadcom APDS9999 ambient light sensor.
> 
> The APDS9999 is a digital proximity and RGB sensor with ALS
> capability. The driver implements the ALS/Lux functionality
> using the green channel, which uses optical coating technology
> to approximate the human eye spectral response.
> 
> Raw IIO_INTENSITY channels are exposed for red, green, blue,
> and IR so userspace can compute its own weighted lux.
> Proximity (PS) support is not yet implemented.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Hi Jose,

A few really minor things inline.  Given how minor they are I've applied
this series to the testing branch of iio.git with the following tweaks:
(shout if you disagree with any of them!)

diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
index f2fbd743abe7..215f3e8087c9 100644
--- a/drivers/iio/light/apds9999.c
+++ b/drivers/iio/light/apds9999.c
@@ -52,17 +52,14 @@ static const int apds9999_gains[] = {
        [APDS9999_GAIN_18X] = 18,
 };
 
-enum apds9999_resolution {
-       APDS9999_RES_20BIT = 0,
-       APDS9999_RES_19BIT = 1,
-       APDS9999_RES_18BIT = 2,
-       APDS9999_RES_17BIT = 3,
-       APDS9999_RES_16BIT = 4,
-       APDS9999_RES_13BIT = 5,
-       APDS9999_RES_NUM
-};
-
-static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
+#define APDS9999_RES_20BIT             0
+#define APDS9999_RES_19BIT             1
+#define APDS9999_RES_18BIT             2
+#define APDS9999_RES_17BIT             3
+#define APDS9999_RES_16BIT             4
+#define APDS9999_RES_13BIT             5
+
+static const int apds9999_itimes_us[] = {
        [APDS9999_RES_20BIT] = 400 * USEC_PER_MSEC,
        [APDS9999_RES_19BIT] = 200 * USEC_PER_MSEC,
        [APDS9999_RES_18BIT] = 100 * USEC_PER_MSEC,
@@ -285,16 +282,14 @@ static int apds9999_probe(struct i2c_client *client)
 
        part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
        if (part_id < 0)
-               return dev_err_probe(dev, part_id,
-                                    "failed to read PART_ID\n");
+               return dev_err_probe(dev, part_id, "failed to read PART_ID\n");
        if (part_id != APDS9999_PART_ID)
                dev_info(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
                         part_id, APDS9999_PART_ID);
 
        ret = apds9999_init(data);
        if (ret)
-               return dev_err_probe(dev, ret,
-                                    "failed to initialize device\n");
+               return dev_err_probe(dev, ret, "failed to initialize device\n");
 
        indio_dev->name = "apds9999";
        indio_dev->info = &apds9999_info;
@@ -304,8 +299,7 @@ static int apds9999_probe(struct i2c_client *client)
 
        ret = devm_iio_device_register(dev, indio_dev);
        if (ret)
-               return dev_err_probe(dev, ret,
-                                    "failed to register IIO device\n");
+               return dev_err_probe(dev, ret, "failed to register IIO device\n");
 
        return 0;
 }

> diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> new file mode 100644
> index 000000000000..f2fbd743abe7
> --- /dev/null
> +++ b/drivers/iio/light/apds9999.c

> +
> +static const int apds9999_gains[] = {
> +	[APDS9999_GAIN_1X]  = 1,
> +	[APDS9999_GAIN_3X]  = 3,
> +	[APDS9999_GAIN_6X]  = 6,
> +	[APDS9999_GAIN_9X]  = 9,
> +	[APDS9999_GAIN_18X] = 18,
> +};
> +
> +enum apds9999_resolution {
> +	APDS9999_RES_20BIT = 0,
> +	APDS9999_RES_19BIT = 1,
> +	APDS9999_RES_18BIT = 2,
> +	APDS9999_RES_17BIT = 3,
> +	APDS9999_RES_16BIT = 4,
> +	APDS9999_RES_13BIT = 5,
> +	APDS9999_RES_NUM
> +};

Why is set of field values an enum whereas all the others
are defines?  I prefer defines if the type isn't used and they
reflect hardware filed values.

> +
> +static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
> +	[APDS9999_RES_20BIT] = 400 * USEC_PER_MSEC,
> +	[APDS9999_RES_19BIT] = 200 * USEC_PER_MSEC,
> +	[APDS9999_RES_18BIT] = 100 * USEC_PER_MSEC,
> +	[APDS9999_RES_17BIT] =  50 * USEC_PER_MSEC,
> +	[APDS9999_RES_16BIT] =  25 * USEC_PER_MSEC,
> +	[APDS9999_RES_13BIT] =   3125,
> +};
> +
> +#define APDS9999_RATE_25_MS		0
> +#define APDS9999_RATE_50_MS		1
> +#define APDS9999_RATE_100_MS		2
> +#define APDS9999_RATE_200_MS		3
> +#define APDS9999_RATE_500_MS		4
> +#define APDS9999_RATE_1000_MS		5
> +#define APDS9999_RATE_2000_MS		6

>
> +static int apds9999_read_channel(struct apds9999_data *data, u8 reg,
> +				 u32 *counts)
> +{
> +	struct i2c_client *client = data->client;
> +	u8 buf[3];
> +	int ret, tries;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
> +	 * plus margin.  Each try sleeps 20 ms.
> +	 */
> +	tries = max(2, (apds9999_itimes_us[data->als_res] * 2) / 20000);
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(client,
> +					       APDS9999_REG_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
> +			break;
> +		fsleep(20000);
> +	}
> +
> +	if (tries < 0)
> +		return -ETIMEDOUT;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	*counts = get_unaligned_le24(buf) & GENMASK(19, 0);
> +	return 0;
> +}
> +
> +static int apds9999_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9999_data *data = iio_priv(indio_dev);
> +	int gain, itime_us;
> +	u64 scale_nano;
> +	u32 counts;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = apds9999_read_channel(data, chan->address, &counts);

Not necessarily worth changing but I'll note you could have returned
the value if not an error
		ret = apds9999_read_channel(data, chan->address);
		if (ret < 0)
			return ret;

		*val = ret;
		return IIO_VAL_INT;

This is one of those design decisions where there isn't a right answer.

> +		if (ret)
> +			return ret;
> +		*val = (int)counts;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
> +		 *
> +		 * The constant 54 is derived from the datasheet table:
> +		 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
> +		 *   -> C = 0.180 * 3 * 100 = 54
> +		 *
> +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> +		 */
> +		gain = apds9999_gains[data->als_gain_idx];
> +		itime_us = apds9999_itimes_us[data->als_res];
> +
> +		/* scale_nano = 54 * 1e12 / (gain * itime_us) nano-lux/count */
> +		scale_nano = div_u64(54ULL * NSEC_PER_SEC * USEC_PER_MSEC, (u32)(gain * itime_us));
> +		*val = (int)(scale_nano / NSEC_PER_SEC);
> +		*val2 = (int)(scale_nano % NSEC_PER_SEC);
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = apds9999_itimes_us[data->als_res];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info apds9999_info = {
> +	.read_raw = apds9999_read_raw,
> +};
> +
> +/*
> + * The green channel uses optical coating to approximate the human eye
> + * spectral response.  IIO_INTENSITY channels provide raw ADC data for
> + * red, green, blue, and IR so userspace can compute weighted lux.
> + */
> +static const struct iio_chan_spec apds9999_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_GREEN_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_RED,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_RED_0,

More a note for the future than a 'now' thing. If you make scale writeable
then it will (I assume) affect these channels a well as the light. This is
based on assumption that write will be the control for the gain (with the
current integration time etc taken into account).  You might present
it for the non light channels as 1/(int_time * gain) as the the end result
of _raw * _scale for an IIO_INTENSITY value is not in any particular
scale - we just what the result to remain stable if the _scale is changed
and the actual incident light is the same - i.e. double _scale and _raw should
halve.

Anyhow that would be a new feature so no need to do it now.

 
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_GREEN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_GREEN_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BLUE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_BLUE_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_IR_0,
> +	},
> +};
> +
> +static int apds9999_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct apds9999_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, part_id;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
> +	if (part_id < 0)
> +		return dev_err_probe(dev, part_id,
> +				     "failed to read PART_ID\n");

Under 80 chars when on one line.

> +	if (part_id != APDS9999_PART_ID)
> +		dev_info(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
> +			 part_id, APDS9999_PART_ID);
> +
> +	ret = apds9999_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize device\n");
I make this under 80 chars on one line.

> +
> +	indio_dev->name = "apds9999";
> +	indio_dev->info = &apds9999_info;
> +	indio_dev->channels = apds9999_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(apds9999_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");

This one is 81 ish so I'll probably just make that a single line as well.






