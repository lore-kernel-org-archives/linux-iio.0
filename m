Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022238;
	b=EIE+dMTJCMxcNpJnm1vM3uCK/Tu85iDYahoFYBQRutOeMDjvh4f8CGuDzgglsJZm9nqd
	 TaFJj4LSzQQbzLKRJecenFN2oyW1nyPVi3VHDNvse5M0nTQbq4ksxLH7IS56wf70TrAPD
	 /fAw3ihlDlYf/8seeVP3Lg0VmE6K+v33LfCJ17txEDLJk5qAY2Bvjt2UG+nlkYEhsH3uG
	 PyuFkrcgMG/6inbeEGZzFudgUYkNb3xUV2x1MHtYAIhfdsCCg8o51oAL17/AKxv3k+++Y
	 KSvS2oF/La0SskOGiUrCllhvoInvCrK7aXjVBXJSEMPyXchhKtV92bXb3NGsL4Ph1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022238;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1bU+23Ts9k7fqwmVRnmBAtDOJpgOkQlk4RYG0pmWGro=;
	b=BtPsEO4Rqgi9Sm7K3qtZVRpn9/7DtPGKEsfK9IroHzWCkltj+DPwyxli+S0Tv7O4ujDF
	 z8DV84IrQlyeYQu6NJNjfp0QFO5yOa4sVMzaHfEYuncaoBLgeJqop/YSCbQO9/2m6Qs55
	 QLF982LUGKQkCYkSRzZBcXKHdr/BfF8g9Rs4lRIAoKDBbDng+hpWB2tkQbFY4KNzW1vli
	 K3lMf6cEum/CjbDxXX/w/vmQ3AnftfY2/jNma78lc4R5lrYrD5zoSUFVBZMnnPDCLLNHp
	 0Ty0+Rj6IQWGji0Dnjs6FvozwZcZkNooWaodtprP7Ns8HJ6KXpOf6rrWX54ZSA/bsnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF6JEZge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AD606A326;
	Sat,  7 Nov 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF6JEZge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC61F0089F;
	Sat,  7 Nov 2026 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794022237;
	bh=1bU+23Ts9k7fqwmVRnmBAtDOJpgOkQlk4RYG0pmWGro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LF6JEZge394EUIaXdslskBxA6XnNuVGG0FH/X9Ocw+eniBhyZhgAOYCTxs9pnJYHE
	 66rXQuuUdx0W0pqgCUt/AKbEO5KQRewAO+TVNbBrIIrAghPmwt4Zb+kG2B+QNWRNo1
	 3Hbb45qmdrr9DLaCWSKInfNBDc+EtbJd4RNVwYm74CmmBNr+5VBP4KLCo2ACuHSQsY
	 4x3OUBN9PcZNBAOiyK2KhBej8mG8rGkG7YTMjS3jMH2/PC/2KCugPFKR1DIabTNREj
	 x/ik8QxpHu5y1l/bigYc0lKL8R+tGUNhQMRSSvrByFelEKxLdOJWglhoLqrQgOk3w9
	 8dVt+vNakrHUg==
Date: Sat, 7 Nov 2026 03:30:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: ltr501: Switch to modern match
 mechanism
Message-ID: <20261107033029.0b2d3ee1@jic23-hlaptop>
In-Reply-To: <20261106091943.35783-3-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-3-clamor95@gmail.com>
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

On Fri,  6 Nov 2026 11:19:41 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Remove the chip enum, break the chip list structure into individual
> elements, and pass each element using i2c_get_match_data().

Sashiko calls out that for ACPI this results in an ABI change.
The original code did the ABI wrong but that unfortunately doesn't
mean we can change this one as it is an artefact of a time when
we weren't so careful about those names.

So you'll need to put special handling back in for the ACPI parts
and that name. Some other things in the existing code noted inline
that would be nice to clean up whilst you are here.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/ltr501.c | 165 +++++++++++++++++--------------------
>  1 file changed, 74 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index cc5d7af44d77c..d5ce6468a229b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c

> +static const struct ltr501_chip_info ltr301_chip_info_tbl = {
> +	.partid = 0x08,
> +	.als_gain = ltr501_als_gain_tbl,
> +	.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
> +	.als_mode_active = BIT(0) | BIT(1),
> +	.als_gain_mask = BIT(3),
> +	.als_gain_shift = 3,
> +	.channels = ltr301_channels,
> +	.no_channels = ARRAY_SIZE(ltr301_channels),
> +};
> +
> +static const struct ltr501_chip_info ltr303_chip_info_tbl = {
> +	.partid = 0x0A,
> +	.als_gain = ltr559_als_gain_tbl,
> +	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +	.als_mode_active = BIT(0),
> +	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> +	.als_gain_shift = 2,
> +	.channels = ltr301_channels,
> +	.no_channels = ARRAY_SIZE(ltr301_channels),
> +};
> +
> +static const struct ltr501_chip_info ltr329_chip_info_tbl = {
> +	.partid = 0x0A,
> +	.als_gain = ltr559_als_gain_tbl,
> +	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +	.als_mode_active = BIT(0),
> +	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),

As below.  Same for all the others.  That would be a separate
cleanup patch though -> perhaps do it with getting rid of
the als_gain_shift.

> +	.als_gain_shift = 2,
> +	.no_irq_support = true,
> +	.channels = ltr301_channels,
> +	.no_channels = ARRAY_SIZE(ltr301_channels),
> +};
> +
> +static const struct ltr501_chip_info ltr501_chip_info_tbl = {
> +	.partid = 0x08,
> +	.als_gain = ltr501_als_gain_tbl,
> +	.als_gain_tbl_size = ARRAY_SIZE(ltr501_als_gain_tbl),
> +	.ps_gain = ltr501_ps_gain_tbl,
> +	.ps_gain_tbl_size = ARRAY_SIZE(ltr501_ps_gain_tbl),
> +	.als_mode_active = BIT(0) | BIT(1),
As below
> +	.als_gain_mask = BIT(3),
> +	.als_gain_shift = 3,
> +	.channels = ltr501_channels,
> +	.no_channels = ARRAY_SIZE(ltr501_channels),
> +};
> +
> +static const struct ltr501_chip_info ltr559_chip_info_tbl = {
> +	.partid = 0x09,
> +	.als_gain = ltr559_als_gain_tbl,
> +	.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +	.ps_gain = ltr559_ps_gain_tbl,
> +	.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
> +	.als_mode_active = BIT(0),
> +	.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
Is it really 3 separate bits, or GENMASK(4, 2) to
represent a 3 bit shift?  

Whilst you are touching the driver can we get rid of the
separate shift by using field_prep() field_get() using
just the mask?

> +	.als_gain_shift = 2,
> +	.channels = ltr501_channels,
> +	.no_channels = ARRAY_SIZE(ltr501_channels),
>  };
>  
>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1393,14 +1387,11 @@ static int ltr501_powerdown(struct ltr501_data *data)
>  
>  static int ltr501_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	static const char * const regulator_names[] = { "vdd", "vddio" };
>  	struct ltr501_data *data;
>  	struct iio_dev *indio_dev;
>  	struct regmap *regmap;
> -	const void *ddata = NULL;
> -	int partid, chip_idx;
> -	const char *name;
> +	int partid;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -1480,18 +1471,10 @@ static int ltr501_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (id) {
> -		name = id->name;
> -		chip_idx = id->driver_data;
> -	} else {
> -		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
> -		chip_idx = (intptr_t)ddata;
> -	}
> -	if (!name)
> +	data->chip_info = i2c_get_match_data(client);
> +	if (!data->chip_info)
>  		return -ENODEV;

As above. Unfortunately at this point we'll still need to
do some special handling to match the existing indio_dev->name.

>  
> -	data->chip_info = &ltr501_chip_info_tbl[chip_idx];
> -
>  	if ((partid >> 4) != data->chip_info->partid)
>  		return -ENODEV;
>  
> @@ -1502,7 +1485,7 @@ static int ltr501_probe(struct i2c_client *client)
>  	indio_dev->info = &ltr501_info;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->no_channels;
> -	indio_dev->name = name;
> +	indio_dev->name = client->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
