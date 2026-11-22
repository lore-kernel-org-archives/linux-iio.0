Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379469;
	b=sqmLwOiFacp/KkzIQi/61b7cg9ylb4vQXyXIqiQDtWQuPQBZfw0/Uga7LYDyG2RZBweX
	 vus+UNY/bVlfvXvpiChwQkUUtM0gALbt+F6ZtCiX9cWWPVUiQDYKMABuFVUe9hAQUXDJL
	 jC69NEFUIpvcd8P8d7TDalNT2/t4lcEtMACNheMlsK69Zy3FjPSwMGC1I4CiyLJUdQ1My
	 NZzMVT6P4xlDRs2n/us1Vq/AKKD5in6sPXl8Hm7bk7Sxmkh/YXTAW3BeLbFbHy4hUgmpy
	 BACp9MDkQsamoIxzqxZq942cVRVym1TZ9L5IfBjmqz22DtCVVqN6MRKQZh1NtkT0GIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=01u2pJ79Jx2GA4UGQFDp58GidjbzZMl/CEGLg2V7HYI=;
	b=ptta034S7IK7FQ3MZWnO4A0irCxTlmzUKlMFAK42+pG4jI51YKQkefxBekfyU4HVDz5H
	 TQNTvuJEnwfMhvPN57HXFXTNarithyFFIazNR6thxNO/lxPo6mJd+g/9CFN70L0iAj9bE
	 ExQQyvcjZpcC4aHQz9B+FddbpMoB5v3CM/8UJYu1sz/PZroezcds2CtrqAE0/mNgoTBNA
	 T4GLZEzuJTFvgnJ6cyeiWx0/MlDLpyPusmpQC6GIflZHTEpj5VSaYI4Pr1dSOEO3vza4n
	 DpyKlNg/zRV05OdIAf1nyy/ra2wq2qmKAXU6OFi4xqdLkQ+k3KGF9ClEtSJKGv5mg+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvSAvDNC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42645606A31A;
	Sun, 22 Nov 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvSAvDNC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F671F000C0;
	Sun, 22 Nov 2026 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379468;
	bh=01u2pJ79Jx2GA4UGQFDp58GidjbzZMl/CEGLg2V7HYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WvSAvDNCziNKu96yzFWfhtQex3diaiBd5SFRb2KsF/5Q1Tyato96Q2y5pkXT15ti1
	 Rf/ewEGrmNVJeaAuxb43B2kxHa4mQm8xNV6iM/Uz1WVFwSlqrKm/7HXYUDRYZQxLDx
	 GhK/AK7Wo452eTi2FjZvNxa4g+jjtBfIH3jrZjBKsknIM9P6N4olqNTDLUhQqzrXxQ
	 5y4P3Ww1Tw7ffoRlBjplql5MzHJz+gWAaCC83Pq3Q0s3MIbcIXzqpc5fXwBInuf3D1
	 nX4ToKqi1gdybPCDnu9cXqLzcbSHiY+C+bLoeLcBFV7a/RJCDKdr8an8ZknLMoq7nz
	 qgy46fsU+J9pQ==
Date: Sun, 22 Nov 2026 20:31:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Akshat Chandra <notmissinge@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, Lukasz Kulga
 <lukasz.kulga@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: Add support for Sensirion SGP41
Message-ID: <20261122203101.453545fd@jic23-hlaptop>
In-Reply-To: <20261115055941.362185-3-notmissinge@gmail.com>
References: <20261115055941.362185-1-notmissinge@gmail.com>
	<20261115055941.362185-3-notmissinge@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 11:29:40 +0530
Akshat Chandra <notmissinge@gmail.com> wrote:

> Add a driver for the Sensirion SGP41 VOC and NOx gas sensor,
> connected over I2C.
> 
> Expose raw VOC and NOx signals as resistance channels and
> allow userspace to write temperature and relative humidity
> compensation values.
> 
> Run sensor conditioning lazily before the first raw measurement.
> Calculate an estimated VOC index and leave NOx-index calculation
> to userspace.
> 
> Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
Having read Andy's reply I considered skipping this entirely
as indeed it has a lot of simple stuff wrong.

Anyhow, this is at most a quick glance to highlight a few things
that jumped out at me.

>
> diff --git a/drivers/iio/chemical/sgp41.c b/drivers/iio/chemical/sgp41.c
> new file mode 100644
> index 000000000000..f094ba22b7aa
> --- /dev/null
> +++ b/drivers/iio/chemical/sgp41.c
> @@ -0,0 +1,542 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sgp41 - Support for Sensirion SGP41 Gas Sensor
> + *
> + * Copyright (C) 2026 Akshat Chandra <notmissinge@gmail.com>
> + *
> + * I2C slave address: 0x59
> + *
> + * Datasheet can be found here:
> + * https://www.sensirion.com/file/datasheet_sgp41
> + *
> + * There are two functionalities supported:
> + *
> + * 1) read raw logarithmic resistance value from sensor
> + *    --> useful to pass it to the algorithm of the sensor vendor for
> + *    measuring deteriorations and improvements of air quality.
> + *    The values can be read from the in_resistance_voc_raw and
> + *    in_resistance_nox_raw.
> + *
> + * 2) calculate an estimated VOC index (0 - 500) and expose it through
> + *    the in_concentration_voc_input attribute.
> + *
> + *    The VOC index is calculated using the raw VOC resistance and a
> + *    configurable calibration bias, exposed through
> + *    in_resistance_voc_calibbias (default 30000).
> + *
> + * The driver does not calculate a NOx index.

Generally don't bother saying what is not done.  Those sorts
of comments tend to become wrong fast!

> + *
> + * Conditioning runs before the first raw measurement, once per second
> + * for a total of 10 seconds.
> + *
> + * Compensation values for relative humidity and temperature can be
> + * configured through the corresponding output attributes.
> + *
> + * The sensor heater is turned off when the device is removed.
> + */
> +
> +#include<linux/cleanup.h>
This sort of formatting bug shows that you need to be a lot more
careful to run standard tests and read your own code before submitting.

Oddly this rather convinces me this isn't AI generated as the
LLMs tend not to make that sort of formatting error.


> +
> +static int sgp41_run_conditioning(struct sgp41_data *data)
> +{
> +	struct sgp41_tg_measure tg = {
> +		.command = { 0x26, 0x12 },
> +	};
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < SGP41_COND_ITERATIONS; i++) {
	for (unsigned int i = 0;
> +		if (data->condition_count!= i)

Fix formatting to conform to kernel style.

> +			i = data->condition_count;

This is unusual enough that it needs a comment on why.

> +
> +		temp_rht_payload(data, &tg);
> +		ret = i2c_master_send(data->client, (const char *)&tg,
> +				      sizeof(tg));
> +		if (ret != sizeof(tg)) {
> +			dev_warn(data->dev,
> +				 "i2c_master_send ret: %d sizeof: %zu\n",
> +				 ret, sizeof(tg));
> +			return ret < 0 ? ret : -EIO;
> +		}
> +		data->condition_count++;
> +		msleep(50);
> +
> +		if (i != SGP41_COND_ITERATIONS - 1)
> +			msleep(950);
> +	}
> +
> +	data->conditioned = true;
> +
> +	return 0;
> +}

> +
> +static int sgp41_measure_raw(struct sgp41_data *data,
> +			     u16 *voc_raw, u16 *nox_raw)
> +{
> +	struct sgp41_tg_measure tg = {
> +		.command = { 0x26, 0x19 },

What are these magic numbers? If they are command codes I'd normally
expect to see some defines for all the ones that exist at the top
of the file.  Hopefully they have names that make it obvious what
is going on here.

> +	};
> +	struct sgp41_tg_result tgres;
> +	u8 crc;
> +	int ret;

If nothing else sets order, reverse xmas tree preferred.

> +
> +	guard(mutex)(&data->lock);
> +
> +	if (!data->conditioned) {
> +		ret = sgp41_run_conditioning(data);
> +		if (ret) {
> +			sgp41_heater_off(data);

There is no code in this function turning the heater on.
If it's in run_conditioning() then I'd expect that to be side
effect free on returning an error. I.e. that function gets to do
the heater_off.

> +			return ret;
> +		}
> +	}

> +
> +static int sgp41_write_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int val,
> +			   int val2, long mask)
> +{
> +	struct sgp41_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP: {
> +			if (val < -45000 || val > 130000)
> +				return -EINVAL;
> +
> +			guard(mutex)(&data->lock);
> +			data->temp = val;
> +			return 0;
> +		}
> +		case IIO_HUMIDITYRELATIVE: {
> +			if (val < 0 || val > 100000)
> +				return -EINVAL;
> +
> +			guard(mutex)(&data->lock);
> +			data->rht = val;

This is unusual enough probably needs a specific documentation
file for the driver. I guess calibration requires rht and temp?

Doing that via output channels is fine but still not that common.

> +			return 0;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->channel) {
> +		/*For VOC Calibration,*/

See kernel comment style. It's not quite this.

> +		case SRAW_VOC: {
> +			if (val < 20000 || val > 52768)
> +				return -EINVAL;
> +
> +			guard(mutex)(&data->lock);
> +			data->voc_calibbias = val;
> +			return 0;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +
> +static void sgp41_remove(struct i2c_client *client)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct sgp41_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	ret = sgp41_heater_off(data);
> +	if (ret)
> +	dev_warn(data->dev, "Failed to turn off heater: %d\n", ret);
run almost anything against this code and that should give you a warning.
In general look at how other drivers down powering off of elements on
remove.  devm_add_action_or_reset() called in the appropriate place
will do it for you.

We almost never need an remove() function in a modern IIO driver.

> +}
> +
> +static const struct iio_info sgp41_info = {
> +	.read_raw = sgp41_read_raw,
> +	.write_raw = sgp41_write_raw,
> +};
> +
> +static int sgp41_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct sgp41_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
Given no power management (which is fine in a new driver) and
the lack of a need for remove, I'd expect this to go away in v2.
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->dev = dev;
Why do you need that pointer rather that using client->dev
where appropriate.

> +	data->conditioned = false;
> +	data->condition_count = 0;
data is zero initialized so as long as those are obvious defaults
this probably brings nothing.
> +
> +	crc8_populate_msb(sgp41_crc8_table, SGP41_CRC8_POLYNOMIAL);

This needs to happen only once how ever many copies of this driver
existing. There is infrastructure to doing things once in the kernel
and we have started using that in IIO for crc tables recently.

> +
> +	mutex_init(&data->lock);
	ret = devm_mutex_init();
	if (ret)
		return ret;

Take a look at what this does. It's a minor gain to have the debug logic
available but it is worth it for one line more code!
> +
> +	/*default values.*/
> +	data->rht = 50000;
> +	data->temp = 25000;
> +	data->voc_calibbias = 30000; /*resistance raw value for voc index of 250*/
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get/enable vdd supply\n");
> +
> +	indio_dev->info = &sgp41_info;
> +
> +	if (id)
> +		indio_dev->name = id->name;

Prefer that we don't use id at all.  Just hard code the name
until we get additional supported parts.

> +	else
> +		indio_dev->name = "sgp41";

i.e. Just this option.

> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sgp41_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sgp41_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		dev_err(dev, "failed to register iio device\n");
> +
> +	return ret;
> +}


