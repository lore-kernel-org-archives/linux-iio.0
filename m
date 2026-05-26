Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAC3B9933;
	Tue, 26 May 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813343; cv=none; b=jd/vFQZGbtYJN9AE8XHf/FY7D6qiuZAmLkKpXb3oiIZr7RFEH2j2755NaXaaocfpEYRRZvGj8caWpBi9DidiTnQnel59w1/z82ryBAw67iaZyeNZTEiFMSvonMVLayCDRIAnBo37wdT27xGrQ0H9VA0wTIhCY1ZmGSVT5yFMo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813343; c=relaxed/simple;
	bh=+b/2FDm44BYVimQz5KNkxkQyefbSextrJyDGK9b1GMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRfMbJS6zZuomc2Ee9ja39MuAAw/GaEDkD/lk4IdVF+ekO2y78cAsSU5+3Y8xSDsdXWNkG8DyQTq574vlfigQXRIItQBy/xpdYm3etmuWd2Bkp+aMUUnuxlvYPYtpc+gHjIrquK/PM/yFuvv4g30LhhMakFRHlJAIyPzpHgfWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2hqW+KA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2hqW+KA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFFC1F000E9;
	Tue, 26 May 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813341;
	bh=xZZ0K9Fo1F3j4GMSgNa62iwtfEmYqiQnJ48IkSSIqRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H2hqW+KARje2T+fXdXXT9BYGAKwPMIvJDZOe97eINgVGX5AraTw4JJzj0tOcM48dE
	 ZR2364zuxp0vzd3qsnccJiFdhGyIjUtGLYQyhhJWCcLnMDGREhpzeO0NDaqZH/nV77
	 0psGadfzfJJBu0cz9M1Ungnl+A5GJF0PmRKmmQCJn6dXZi0idA/l0pOdD3Phsb+aaN
	 TSOEVQcx4d4DfkcI6WZXhRnoXCx9Nt1+AMPpp11wEN8lXFXrR/gB50ZfIze4Levdki
	 7sTgoHAjydDW9ckeHZuqm4buuLQwyYVelqhgif+hhoAK30TS+9mP4nIZy1TFBrUmVR
	 k2CPqYkYPf3Cg==
Date: Tue, 26 May 2026 17:35:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow
 sensor driver
Message-ID: <20260526173531.4422ae40@jic23-huawei>
In-Reply-To: <20260524205112.26638-4-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-4-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 22:49:38 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Add an IIO driver for the Sensirion SLF3S family of digital
> liquid-flow sensors.  The supported sub-types (SLF3S-0600F,
> SLF3S-4000B) share the same register map and command set and are
> distinguished only by the flow scale; the variant is detected at
> probe time from the product-information register.
> 
> The driver exposes two IIO channels:
>   - in_volumeflow_raw / in_volumeflow_scale (litres per second)
>   - in_temp_raw       / in_temp_scale       (milli-degC)
> 
> Continuous measurement mode is started in probe and stopped via
> devm-action; read_raw() fetches the most recent sample on demand.
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
Hi Wadim

Hopefully I haven't overlapped too much with the review Guenter did.

Various comments inline

Thanks,

Jonathan

> diff --git a/drivers/iio/flow/Kconfig b/drivers/iio/flow/Kconfig
> new file mode 100644
> index 000000000..355857a6b
> --- /dev/null
> +++ b/drivers/iio/flow/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Liquid / gas flow sensor drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Flow sensors"
> +
> +config SENSIRION_SLF3X
> +	tristate "Sensirion SLF3x liquid flow sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say yes here to build support for the Sensirion SLF3S family of
> +	  digital liquid-flow sensors (SLF3S-0600F, SLF3S-4000B, ...).

We try to have full listings of supported parts in the help text as it
gets searched by folk looking for a driver. To minimize the churn consider
a bulleted list with one per line.

> +	  The driver reports the volumetric flow rate and the embedded
> +	  temperature reading via the standard IIO interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called slf3x.
> +
> +endmenu

> diff --git a/drivers/iio/flow/slf3x.c b/drivers/iio/flow/slf3x.c
> new file mode 100644
> index 000000000..e4ee1a04a
> --- /dev/null
> +++ b/drivers/iio/flow/slf3x.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sensirion SLF3x liquid flow sensor driver.
> + *
> + * Copyright (C) 2026 CMBlu Energy
> + * Author: Wadim Mueller <wadim.mueller@cmblu.de>
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/unaligned.h>
The gap before this header and others in other drivers is an historical oddity as it used
to be in asm and the blanket rename didn't tidy up the white space.
No need to separate it.


> +DECLARE_CRC8_TABLE(slf3x_crc_table);
> +
> +struct slf3x_variant {
> +	u8 sub_type;
> +	const char *name;
> +	/*
> +	 * Flow scale exposed via IIO_CHAN_INFO_SCALE in litres per second
> +	 * per LSB, encoded as IIO_VAL_FRACTIONAL (num / den).  The encoding
> +	 * comes from the Sensirion datasheet's "scale factor" (ticks per
> +	 * ml/min) combined with the 1 ml/min = 1/60000 l/s conversion.
> +	 */
> +	int scale_num;
> +	int scale_den;
> +};
> +
> +static const struct slf3x_variant slf3x_variants[] = {
> +	{ .sub_type = 0x03, .name = "slf3s-0600f",
> +	  .scale_num = 1, .scale_den = 6000000 },
> +	{ .sub_type = 0x05, .name = "slf3s-4000b",
> +	  .scale_num = 1, .scale_den = 1666680000 },

Maybe format this as one per line.  These structure tend to grow as
more features are added to a driver so it will perhaps result in less
churn in the long run!
	{
		.sub_type = 0x05,
		.name = "slf3s-4000b",
		.scale_num = 1,
		.scale_den = 1666680000,
	},
> +};
...

> +static int slf3x_write_cmd(struct i2c_client *client, const u8 *cmd)

Might be good to use
const u8 cmd[at_least 2])
to let the compiler know the constraints.

> +{
> +	int ret = i2c_master_send(client, cmd, 2);
> +
> +	if (ret == 2)
> +		return 0;
> +	return ret < 0 ? ret : -EIO;
> +}
> +
> +static int slf3x_read_product_info(struct slf3x_data *sf)
> +{
> +	struct i2c_client *client = sf->client;
> +	u8 buf[SLF3X_PRODUCT_ID_LEN];
> +	int ret, i;
> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_prep_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_read_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	for (i = 0; i < SLF3X_PRODUCT_ID_LEN; i += 3) {
> +		if (slf3x_verify_crc(&buf[i])) {
> +			dev_err(&client->dev,
> +				"product-info CRC mismatch at byte %d\n", i);
> +			return -EIO;
For all returns in stuff only called from probe() use dev_err_probe().

> +		}

> +
> +static int slf3x_read_sample(struct slf3x_data *sf, s16 *flow, s16 *temp)
> +{
> +	u8 buf[SLF3X_MEAS_LEN];
> +	int ret, i;
> +
> +	ret = i2c_master_recv(sf->client, buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	for (i = 0; i < SLF3X_MEAS_LEN; i += 3) {
Fine to do
	for (unsigned int i = 0; i < ..

> +		if (slf3x_verify_crc(&buf[i]))
> +			return -EIO;
> +	}
> +
> +	*flow = (s16)get_unaligned_be16(&buf[0]);

Prefer to make this a little more self documenting as

	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);
 
> +	*temp = (s16)get_unaligned_be16(&buf[3]);
> +	return 0;
> +}
> +
> +static const struct iio_chan_spec slf3x_channels[] = {
> +	{
> +		.type = IIO_VOLUMEFLOW,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +


> +
> +static void slf3x_stop_meas(void *data)
> +{
> +	struct slf3x_data *sf = data;
> +
> +	slf3x_write_cmd(sf->client, slf3x_cmd_stop);
> +}
> +
> +static int slf3x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct slf3x_data *sf;
> +	int ret;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vdd");

No need to turn this on until we are somewhere nearer ready to chat
to the device.  Normally we do it just before first access.
I'd move it down a little. It's also not optional unless
there is some other way of powering the device.
Just let the regulator framework provide a stub regulator if it's not
in the firmware description.

> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	sf = iio_priv(indio_dev);
> +	sf->client = client;
> +	crc8_populate_msb(slf3x_crc_table, SLF3X_CRC8_POLY);
> +
> +	ret = slf3x_read_product_info(sf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "product info read failed\n");
As in the other review thread, this shouldn't be an error a we want
those fallback compatibles to work in future.

> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_start_water);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "start measurement failed\n");
> +
> +	usleep_range(SLF3X_MEAS_DELAY_US, SLF3X_MEAS_DELAY_US + 1000);

fsleep() for fuzzy sleeps like this - it applies a standard amount of 'slack' time
and means we don't need to reason about whether that is a good value or not.


> +
> +	ret = devm_add_action_or_reset(dev, slf3x_stop_meas, sf);
> +	if (ret)
> +		return ret;

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id slf3x_id[] = {
> +	{ "slf3s" },

Please use a named initializer here like you do for the of_device_id.
Uwe is working on making sure all drivers do this and I just took a patch
that updated most of the IIO ones to do so.


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, slf3x_id);
