Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E482C2349
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130725; cv=none; b=muQsPs+cEqEtQ+2NMFgn3PF9s0U/lMFnwoDOchb/X1k4icKvaAyp5MxKwH48WAGaqvVLzzsvZmvbQ4iMMQvK6zx9pWcZJYAnM/2At/BEdMrvobBVher6Zo9FF0tTdfYR8/5LmDt30BPnJb8j9S1n7j//YPvk22JbnCHEOB2yh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130725; c=relaxed/simple;
	bh=cjDFScpnW1m1H9CNg95Pcn6/dttJpeTt5gAmTLS1VgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnUhdn6/vcHg9qBDTnNaDLABv/YkZYPoyD7J+oTqITYbcqIa3HWv6P51l44xgTam+QqAh99tvSmUImQohMnTkReGzWjXooUuOmJm7FO9R0s3iHwkxeHKL9xQ8JjmNlMeCwARKomRGUePlvputHHtoM27EbvxJlSgIpSt94J2dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAy8I5fC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAy8I5fC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF47C2BCB7;
	Mon, 18 May 2026 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779130725;
	bh=cjDFScpnW1m1H9CNg95Pcn6/dttJpeTt5gAmTLS1VgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAy8I5fCoXi9mdu8E/Q4qQx88TLhdNG2T53Av0FWFrLHnCYpRSte9HdItHB4J/4ZJ
	 JW6qob3rtMVoZHZMlDakgGDIYHeNXkgtt8aZqkVx/0GXjyeC9aUPghQLFckM+5NIVF
	 +hN6IPOYY5oIA6cUijb7r54feloLOOK3Ce+/tk95d8yjYJCHMkAw6xBzZOGf+7TrX1
	 I9tWQ3kpVzcYqapu6ykydeSrK1UbTYXnIu6YhJpDSwpMVA+i8mVlKe9va5hhXpZAaV
	 tK5WY9TMNcp6bwy7iZYPsoyoC9NRunPQxZNZbatCyJUXoU2sE9xVb8taQ006bL7/rw
	 qBZfKmBDUunTg==
Date: Mon, 18 May 2026 19:58:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: linux-iio@vger.kernel.org, eajames@linux.ibm.com
Subject: Re: [PATCH] iio: pressure: dps310: add FIFO support
Message-ID: <20260518195838.7afa1808@jic23-huawei>
In-Reply-To: <20260518165320.1301071-1-zoone.rupert@gmail.com>
References: <20260518165320.1301071-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 19:53:20 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The DPS310 has a 32-sample hardware FIFO that buffers interleaved
> pressure and temperature measurements in background mode. The FIFO_EN
> bit was already defined but unused.
> 
> Add register defines for the FIFO status register and sample type
> encoding, implement FIFO enabled/flush helpers, and wire FIFO initialization
> into the probe path after dps310_startup() has established background
> measurement mode.
> 
> FIFO initialization failure is treated as non-fatal so the driver continues
> to operate via single reads if FIFO enable fails.

I'm not sure I understand why one would enable this?  You've not
modified any of the reading paths. Normally we'd expect a hardware fifo
to be connected up to an IIO buffered interface (via chrdev) and provide
things like watermark control.

There are lots of examples in tree of how to handle fifos. This seems
to be maybe the 1st 5% of what's needed.  Was it perhaps meant to be
an RFC with some questions?

Jonathan

> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
>  drivers/iio/pressure/dps310.c | 73 +++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 8edaa4d10a70..5b031c9573d0 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -53,6 +53,19 @@
>  #define  DPS310_PRS_SHIFT_EN	BIT(4)
>  #define  DPS310_FIFO_EN		BIT(5)
>  #define  DPS310_SPI_EN		BIT(6)
> +/* FIFO status register */
> +#define DPS310_FIFO_STS		0x0B
> +#define DPS310_FIFO_EMPTY	BIT(0)
> +#define DPS310_FIFO_FULL	BIT(1)
> +
> +/* FIFO samples are read from DPS310_PRS_BASE (0x00). The lower 2 bits

Wrong comment style.

> + * of the third byte encode the sample type; the remaining bits are
> + * the signed measurement value.
> + */
> +#define DPS310_FIFO_TYPE_MASK	GENMASK(0, 0)

Smells like a BIT(0)  We don't use genmask for single bits.
However, you mention 2 bits.



> +#define DPS310_FIFO_TMP_SAMPLE	0x00
> +#define DPS310_FIFO_PRS_SAMPLE	0x01
If it's only 2 bits (or maybe 1?) then 0  / 1 
is fine.

> +
>  #define DPS310_RESET		0x0c
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10
> @@ -90,6 +103,7 @@ struct dps310_data {
>  	s32 pressure_raw;
>  	s32 temp_raw;
>  	bool timeout_recovery_failed;
> +	bool fifo_enabled;
>  };
>  
>  static const struct iio_chan_spec dps310_channels[] = {
> @@ -843,6 +857,61 @@ static const struct iio_info dps310_info = {
>  	.write_raw = dps310_write_raw,
>  };
>  
> +static int dps310_fifo_flush(struct dps310_data *data)
> +{
> +	int rc;
> +
> +	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			DPS310_FIFO_EN, 0);
> +	if (rc)
> +		return rc;
> +
> +	data->fifo_enabled = false;
> +	return 0;
> +}
> +
> +static int __maybe_unused dps310_fifo_read_sample(struct dps310_data *data)

Given the fairly obvious __maybe_unused what is the point?

> +{
> +	int rc;
> +	u8 val[3];
> +	s32 raw;
> +	u8 type;
> +
> +	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE,
> +			val, sizeof(val));
> +	if (rc)
> +		return rc;
> +
> +	type = val[2] & DPS310_FIFO_TYPE_MASK;
> +	raw = (val[0] << 16) | (val[1] << 8) | (val[2] & ~DPS310_FIFO_TYPE_MASK);
get_unaligned_be24() and then mask.  However - why not also shift right to
drop those 0s?

> +	raw = sign_extend32(raw, 23);
> +
> +	if (type == DPS310_FIFO_TMP_SAMPLE)
> +		data->temp_raw = raw;
> +	else
> +		data->pressure_raw = raw;
> +
> +	return 0;
> +}
> +
> +static int dps310_fifo_init(struct dps310_data *data)
> +{
> +	int rc;
> +
> +	rc = dps310_fifo_flush(data);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			DPS310_FIFO_EN, DPS310_FIFO_EN);

Align to just after (

> +
No blank line here.
> +	if (rc)
> +		return rc;
> +
> +	data->fifo_enabled = true;
> +	return 0;
> +}
> +
>  static int dps310_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -877,6 +946,10 @@ static int dps310_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
>  
> +	rc = dps310_fifo_init(data);
> +	if (rc)
> +		dev_warn(&client->dev,
> +			"FIFO init failed (%d), continuing without FIFO\n", rc);

Why continue?  The hardware either has a fifo or it doesn't. Any failure
in here smells like dead hardware to me. Hence just fail.

>  	rc = devm_iio_device_register(&client->dev, iio);
>  	if (rc)
>  		return rc;

