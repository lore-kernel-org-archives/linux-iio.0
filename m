Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3502D3225;
	Sun, 20 Sep 2026 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865596; cv=none; b=ClrfGZE5bSZKYl3sEwPc9a+O2okuIeie99rAyfoyuwQMgD+vISt8N+l8N0buqXADeZq4gk+eWhdm1oph4MCUml4/za3LEVda31T6pNGEcveWdXkxVrTOTiEEP0BuyqCbm7uEsr7RywJSE89g+EFOD6DHuOC0YKiz7XIcgd43GAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865596; c=relaxed/simple;
	bh=baL5FdezyJpw0WdG3hFVDydrZTj66S9G9b+cQUt4DJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwAoH7+75G5hTRGYfUNkBiXOY3t/5IWmDe8pZlEBXEuMS3dci98Iawg2TW63UV3DMwll1dLiAiPKgg0RSk4ygDUH8Vn0DaA2IpwSexwwCG9N/X8c+cCYctLu7SSQiWRvm2/9jmR3DfhqlVWzgv4zCmsBHpy66Xojs9LyjMRn7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO/w/Kp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO/w/Kp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D21F000FF;
	Sun, 20 Sep 2026 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789865594;
	bh=9hJp49Gq8lhC7HaZtvb3HUU8DHCTVPncgTmT5nXugTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eO/w/Kp78hwcvvIePw7MpZ7/XoScURSWS7fatJ9msVlOjz0/m2Tc6BcDc46i9QATb
	 hwC1VfEMkGc7+OwLQRrbdAbC3jkhop12WSAegq3fsis5bZUklOfm9HIqGkqWvwDUTB
	 KitxLZG3nrymnKy8adWnZ6uZW3Grc2uQjwwDzwnfT7LC719PJafASpWLTHUk6MjQEr
	 volfSp0+VtPu5XapQC+JbYkbhhi7PF+LqWrsPekNrrEKL5VLbryLfa8rnP9OkCa9sU
	 eW6j6p6UvbXgkEne0pjX4txtrvy21UOziKwo2vJipxgNR5dpYXePgq+RJklUk9BVYI
	 a0fTc6AW2ToZA==
Date: Sun, 20 Sep 2026 01:53:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20260920015310.0c13425c@jic23-hlaptop>
In-Reply-To: <20260919223854.13437-3-m.abubakar365@yahoo.com>
References: <20260919223854.13437-1-m.abubakar365@yahoo.com>
	<20260919223854.13437-3-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 03:38:54 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> Add an IIO driver for the Sensirion SDP31 differential pressure sensor.
> The device is accessed over I2C and reports differential pressure and
> temperature. Each measurement is validated using the sensor's CRC-8
> checksum.
> 
> Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.
> 
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>

Welcome to IIO.

Sashiko has some feedback on this one. Please take a look.

https://sashiko.dev/#/patchset/20260919223854.13437-1-m.abubakar365%40yahoo.com
the DO_ONCE is a sensible suggestion and cleaner than what we
used to do with the crc setup in init().  Note there may well
be other drivers doing this wrong today - I haven't checked!

Generally a nice little driver. Some stuff in here looks quite
like how we did things a while back.  I'm guessing you perhaps
modelled it on an older driver?  Anyhow, nothing major - just changing
conventions.

Thanks,

Jonathan


> ---
>  MAINTAINERS                   |   6 ++
>  drivers/iio/pressure/Kconfig  |  11 ++
>  drivers/iio/pressure/Makefile |   1 +
>  drivers/iio/pressure/sdp31.c  | 194 ++++++++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
>  create mode 100644 drivers/iio/pressure/sdp31.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 214aeee76..a053a530e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24855,6 +24855,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  F:	drivers/iio/chemical/scd4x.c
>  
> +SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
> +M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> +F:	drivers/iio/pressure/sdp31.c
>

Add the initial Maintainers entry in the dt-binding patch, then add
just the new file here.

> diff --git a/drivers/iio/pressure/sdp31.c b/drivers/iio/pressure/sdp31.c
> new file mode 100644
> index 000000000..934a3afcd
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp31.c

> +
> +static int sdp31_send_cmd(struct i2c_client *client, u16 cmd)
> +{
> +	u8 buf[2] = { cmd >> 8, cmd & 0xff };

Given it seems to be handled as a be16, I'd just use one for it
complete with a cpu_to_be16() to put the data in the right order.

> +	int ret = i2c_master_send(client, buf, sizeof(buf));
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
> +	return 0;
> +}
> +
> +static int sdp31_measure(struct i2c_client *client, struct sdp31_reading *out)
For below, pass in your spd31_data structure instead of client.
> +{
> +	u8 rx[9];
> +	int ret;

The thing being serialized by the lock is the contents of this. As such
I'd lock in here rather than at caller with

	guard(mutex)(&data->lock);

That to me makes the lock scope more obvious.
> +
> +	ret = sdp31_send_cmd(client, SDP31_CMD_TRIG_DP);
> +	if (ret)
> +		return ret;
> +
> +	msleep(SDP31_MEAS_DELAY_MS);
> +
> +	ret = i2c_master_recv(client, rx, sizeof(rx));
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
> +	out->pressure = (s16)((rx[0] << 8) | rx[1]);
> +	out->temp     = (s16)((rx[3] << 8) | rx[4]);
> +	out->scale    =       (rx[6] << 8) | rx[7];

get_unaligned_be16() for each of these + appropriate include
for that.


> +	return 0;
> +}



> +
> +static int sdp31_probe(struct i2c_client *client)
> +{
Quite useful to have a local device pointer given how often it is used
	struct device *dev = &client->dev;

> +	struct iio_dev *indio_dev;
> +	struct sdp31_data *data;
> +	struct sdp31_reading r;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);

For new code
	ret = devm_mutex_init(dev, &data->lock);
	if (ret)
		return ret;
It adds some lock debugging related stuff.  Whilst it tends not
to be that useful for how we use these locks in an IIO driver, it
is near free to turn on so we prefer that we do that.

> +
> +	crc8_populate_msb(sdp31_crc8_table, SDP31_CRC8_POLY);

Sashiko got the race here if multiple instances of this devices are
connected and probing in parallel. The DO_ONCE() magic should deal
with that for you.

> +
> +	/* Confirm the sensor is present and learn its scale factor. */
> +	ret = sdp31_measure(client, &r);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to read from sensor\n");
Once you have dev as a local variable these sort of prints that only
go a little over 80 chars are fine on one line. 

> +	if (!r.scale)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "invalid scale factor\n");
> +	data->dp_scale = r.scale;
> +
> +	indio_dev->name = "sdp31";
> +	indio_dev->info = &sdp31_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sdp31_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sdp31_channels);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id sdp31_id[] = {
> +	{ "sdp31" },

As sashiko calls out. Standard now is named initializers
for all the ID tables.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sdp31_id);
> +
> +static const struct of_device_id sdp31_of_match[] = {
> +	{ .compatible = "sensirion,sdp31" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdp31_of_match);
> +
> +static struct i2c_driver sdp31_driver = {
> +	.driver = {
> +		.name = "sdp31",
> +		.of_match_table = sdp31_of_match,
> +	},
> +	.probe = sdp31_probe,
> +	.id_table = sdp31_id,
> +};
> +module_i2c_driver(sdp31_driver);
> +
> +MODULE_AUTHOR("Muhammad Abu Bakar");
> +MODULE_DESCRIPTION("Sensirion SDP31 differential pressure sensor");
> +MODULE_LICENSE("GPL");

