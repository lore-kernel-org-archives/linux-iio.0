Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A76342CB0;
	Fri, 23 Jan 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160358; cv=none; b=S351X36cwtpPv1LRKKu+pVSlFg3EL+2xvfGL3HhMdMlNBaOLdvy3v6he4mkXkybCSgyIz3SksnCDNcwjR47Mqr7s8dZuYPVVcxFJHn3h+1p0gMwcL9zFh3Bn1WI8LsZDw4FdB+VtU3xxX71Hc6cnQ/62w2bYLx1ESF6LipMppdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160358; c=relaxed/simple;
	bh=3tEshxzJOU/wgE+yqwpdHdeX7nQ2dd5+FGhq9qJ+ZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7VC6uy+tL810+lbBst+dZB84uqBaqYCE82bgOISoWggqI/Wl38J//Aq+9joYfz5pCkoX0HohlI12ZodioB6axmgyC8KiVltOldykld5oL4rZ6Ovz1sqduF7KwT1QOftJ+ZUpvPgSsVzB7/xjFiHwGn9QAPV1YdCwl5eXfv1LKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObzZd/OH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObzZd/OH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAADC4CEF1;
	Fri, 23 Jan 2026 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160357;
	bh=3tEshxzJOU/wgE+yqwpdHdeX7nQ2dd5+FGhq9qJ+ZqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObzZd/OHSF4/5W8kZzYKVAYOzJcXa+Clrfr5FwM+5Ff5XgAMimbFZ6oa7pKxhTELg
	 spqxOBDVcVhm2ThTys2UfJpviTceqOsiLfbl4144xZyc+kPtQTarlMQPSn+pyxCk4J
	 poogLME2tdeFUN7qrqZFVP3cQtwcdRy6F0N98gLsB9x51TfYYdzMQ85DoAvDrkHQit
	 pqQFg55xwhgb3Z64wrIEdj3xNplluNTAHHdMmvjy3e6+zfJ7m3h0oCqTQbBXw8eiQy
	 aORqCDtVnu4kKMQaqTKNg2Lqq2BfhRwV0BSB1emJrwQBU655YRKzanVmLGlPCWh2Dy
	 3/OUqR3BP9lfw==
Date: Fri, 23 Jan 2026 09:25:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Cc: petr.hodina@protonmail.com, Song Qiang <songqiang1304521@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: vl53l0x-i2c: Use raw I2C access and
 read full device ID
Message-ID: <20260123092546.3ebbedcd@jic23-huawei>
In-Reply-To: <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
	<20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 18:19:58 +0100
Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Replace SMBus byte reads with raw I2C transfers when reading the device
> identification registers.
> 
> The VL53L0X exposes its model and revision as 16-bit registers, which are
> more accurately accessed using standard I2C send/receive operations.
> This also avoids depending on SMBus byte data support, which is not
> guaranteed on all I2C adapters.

Hmm. I thought it was emulated wherever possible.  See below for
request for a specific comment on what the subtle difference is.
I'm also wondering from this description if it actually works with
smbus but  isn't documented as doing so?
> 
> Read and log both model and revision IDs, and validate the model ID
> during probe to ensure the expected device is present.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 45 +++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 6901ce7dd835..a2de4cc16a43 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -320,11 +320,35 @@ static const struct iio_trigger_ops vl53l0x_trigger_ops = {
>  	.validate_device = iio_trigger_validate_own_device,
>  };
>  
> +
> +static int vl53l0x_read_word(struct i2c_client *client, u8 reg, u16 *val)
> +{
> +	int ret;
> +	u8 buf[2];
> +
> +	ret = i2c_master_send(client, &reg, 1);

Add a comment that a stop is needed. Otherwise this would
be i2c_smbus_read_word_swapped()

Sigh, seems ST liked to make everyone's life a little harder ;)


> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	ret = i2c_master_recv(client, buf, 2);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 2)
> +		return -EIO;
> +
> +	*val = (buf[0] << 8) | buf[1];
> +
> +	return 0;
> +}
> +
>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	u16 model, rev;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -339,13 +363,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (ret != VL53L0X_MODEL_ID_VAL)
> -		dev_info(&client->dev, "Unknown model id: 0x%x", ret);
> -
>  	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_supply))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> @@ -372,6 +389,20 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = vl53l0x_read_word(client, 0xC0, &model);
defines for the register addresses.
I'm curious why they got bigger in a patch that doesn't mention it in the
patch description.

> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to read model ID\n");
Given these long lines, it would be good to have a precursor patch
struct device *dev = &client->dev;
and use that throughout probe()

> +
> +	ret = vl53l0x_read_word(client, 0xC2, &rev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to read revision ID\n");
> +
> +	dev_info(&client->dev, "VL53L0X model=0x%04x rev=0x%04x\n", model, rev);
> +
> +	if ((model >> 8) != VL53L0X_MODEL_ID_VAL)
> +		return dev_err_probe(&client->dev, -ENODEV,
> +			"Unexpected model ID: 0x%04x\n", model);
See comment on other patch. This breaks DT fallback compatibles and
the benefit they bring for new compatible parts being able to be run with 
old kernels.  Just warn and carry on with whatever the firmware told you this
was.

> +
>  	indio_dev->name = "vl53l0x";
>  	indio_dev->info = &vl53l0x_info;
>  	indio_dev->channels = vl53l0x_channels;
> 

