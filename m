Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98A2BEC45;
	Fri, 25 Sep 2026 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302435; cv=none; b=LJ9Tvn0nYanWstspysNsV9L+3L+0NafTLrC5jxl49f45k4QbiD9PS+xUjW3VjUg3h4u1UUt+PBj3bfU2miWjh1ERxzDnDnihOZlesvk6pSTjDhIJsLMEBGUXEnnGwLH4akEV0aceA3VYNEnPw8AIXr4cgJ4MVMmsQNqkrZ8ua7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302435; c=relaxed/simple;
	bh=E3+VPMIMqNjn7TIvI6+dKg71VKeOQzRxkIJO625IroA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyVmTIkHJbTLWbnch1ODm1RSmPRdPQrHvSxAJiAKNW5YbHZASe9rGIYel0AC8JLld6hBT9FyYTMD70maUp8wQwlSxdO4huIs+HgP2Ecl78bsVVZ0b6ftDAmXY84Za0WQ/+H2JEmUOEKfIDxoGIZ2qVEltjSY22I5YVNZLxL97uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQhc3y9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQhc3y9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4421F000FF;
	Fri, 25 Sep 2026 02:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302433;
	bh=xp9K4f/nOxcHvzmhzqbSKxy9T4IWX+OGFn+rYa+qM7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AQhc3y9JeIA+tx6QXgprbu9CzDTClK2MB1L0ZJm4ZvDoCGhPfOeSMPptvljMhlO4g
	 apEELWAhUQwJzhUpvdXdmntXBjmAIXWu/ZiksDIENBgyRBzucXGTtiEhngaOR3L3SH
	 Sfg0zLcoguqpU26RM3kq1l+lWKoAuCBqdiMhXSv4yh1e9KMd5em1Xt4hCJf8Gs+6RM
	 gEjkL78x0kYwKdGI/mmS9v/YED+IXM8Yd9z+lm6AnSQMR8sZDxRv1DXjS5UcLTReyv
	 qg2LovKgySRCMY7cAp4qr7oP4qkbJyMqnOJ2PbcrYt9BvT/NvJmygwnm5eg4E6+WVD
	 w3Q8M3VZJeJmA==
Date: Fri, 25 Sep 2026 03:13:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20260925031350.249cc7af@jic23-hlaptop>
In-Reply-To: <20260920164724.32019-3-m.abubakar365@yahoo.com>
References: <20260920164724.32019-1-m.abubakar365@yahoo.com>
	<20260920164724.32019-3-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 21:47:24 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> Add an IIO driver for the Sensirion SDP31 differential pressure sensor.
> The device is accessed over I2C and reports differential pressure and
> temperature. Each measurement is validated using the sensor's CRC-8
> checksum.
> 
> Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.
> 
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Hi Muhammad,

You seem to have a bunch of comments in the code calling out changes
from earlier versions.  Those may well be helpful whilst developing
(or are they LLM generated?). Either way we don't want to merge them
into the upstream kernel.

Otherwise a few minor comments inline

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/sdp31.c b/drivers/iio/pressure/sdp31.c
> new file mode 100644
> index 000000000..e661a7af8
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp31.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/once.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define SDP31_CMD_TRIG_DP    0x362F
> +#define SDP31_MEAS_DELAY_MS  50
> +#define SDP31_TEMP_SCALE     5

I'd rather see this one at last just inline in the place I'd
look for the scale.  The define isn't adding anything that isn't
better indicated by how it is used.

> +#define SDP31_CRC8_POLY      0x31
> +#define SDP31_CRC8_INIT      0xff

> +
> +/* #2: build the command as a be16 and send it directly. */
> +static int sdp31_send_cmd(struct i2c_client *client, u16 cmd)
> +{
> +	__be16 buf = cpu_to_be16(cmd);
> +	int ret = i2c_master_send(client, (u8 *)&buf, sizeof(buf));
Tiny thing but I'd split into
	int ret;

	ret = i2c_masster_send();
	if (ret < 0)

as more important to have the code visibly coupled with the
error check than the declaration of ret.

> +
> +	if (ret < 0)
> +		return ret;
> +	return (ret == sizeof(buf)) ? 0 : -EIO;
> +}
> +
> +static int sdp31_check_crc(const u8 *word)
> +{
> +	if (crc8(sdp31_crc8_table, word, 2, SDP31_CRC8_INIT) != word[2])
> +		return -EIO;
As below. I'd have a blank line here.

> +	return 0;
> +}
> +
> +/* #3: takes sdp31_data and holds the lock for the whole transaction. */
> +static int sdp31_measure(struct sdp31_data *data, struct sdp31_reading *out)
> +{
> +	u8 rx[9];
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = sdp31_send_cmd(data->client, SDP31_CMD_TRIG_DP);
> +	if (ret)
> +		return ret;
> +
> +	msleep(SDP31_MEAS_DELAY_MS);
> +
> +	ret = i2c_master_recv(data->client, rx, sizeof(rx));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(rx))
> +		return -EIO;
> +
> +	if (sdp31_check_crc(&rx[0]) ||
> +	    sdp31_check_crc(&rx[3]) ||
> +	    sdp31_check_crc(&rx[6]))
> +		return -EIO;
> +
> +	/* #4: use the unaligned big-endian helper instead of manual shifts. */
> +	out->pressure = (s16)get_unaligned_be16(&rx[0]);
> +	out->temp = (s16)get_unaligned_be16(&rx[3]);
> +	out->scale = get_unaligned_be16(&rx[6]);

Trivial but it helps readability a little to have a blank line before simple
return statements like this.

> +	return 0;
> +}
> +
> +static int sdp31_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct sdp31_data *data = iio_priv(indio_dev);
> +	struct sdp31_reading r;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = sdp31_measure(data, &r);   /* locking now lives inside */
> +		if (ret)
> +			return ret;
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = r.pressure;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = r.temp;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = 1;
> +			*val2 = data->dp_scale * 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			*val = SDP31_TEMP_SCALE;

As above. *val = 5; is better than a define that brings
no value other than making anyone reading the code go look
to see what value it has.

> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int sdp31_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;   /* #5 */
> +	struct iio_dev *indio_dev;
> +	struct sdp31_data *data;
> +	struct sdp31_reading r;
> +	int ret;
> +
> +	/* #9: get and enable the sensor's supply (auto-disabled on remove). */
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(dev, &data->lock);   /* #6 */
> +	if (ret)
> +		return ret;
> +
> +	/* #7: populate the shared CRC table exactly once, race-free. */
> +	DO_ONCE(crc8_populate_msb, sdp31_crc8_table, SDP31_CRC8_POLY);
> +
> +	/* Confirm the sensor is present and learn its scale factor. */
> +	ret = sdp31_measure(data, &r);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read from sensor\n");  /* #8 */

As below, these need clearing out.

> +	if (!r.scale)
> +		return dev_err_probe(dev, -EINVAL, "invalid scale factor\n");
> +	data->dp_scale = r.scale;
> +
> +	indio_dev->name = "sdp31";
> +	indio_dev->info = &sdp31_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sdp31_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sdp31_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id sdp31_id[] = {
> +	{ .name = "sdp31" },   /* #10: named initializer */

I'm guessing this is an LLM trying to be helpful and highlight changes?
We don't want that record of changes in an upstream driver.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sdp31_id);


