Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E898240611;
	Mon, 14 Sep 2026 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347208; cv=none; b=lJF+CKlEy1HhH0ahR2Ew9id2C3jXtvz6GPRx5Jo4HDPiMh9aBotry8W+5/KFbXhphdQ8pUB9tkw4J3cX7BxbL9Qlh8ITgjv5rXL7Nv/wD9WgY9omi9Q9KCpoQv2Z/HoaQBI05uaqODD3mp9tBHR9e8iSudT2+BLufbClqf4JDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347208; c=relaxed/simple;
	bh=2mfU6bJobFGVctSPpt34UIixLUKf6QvBFPBOSv6+4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFw/W3Wz8PRqvrrxYYJLg/Vs9YS8Mhawbe+Xt1YAXcGfDPhtoxytwcV3NC3ygbmgFPhCEvK0DPtcK7JNDxYsqokKNSzQlm2RqdFIG2kdwnlCCcDvNk+MRMyhS8xC+oIWvFxQTBJb9tlzLKe3P/IemSGmMdMcWXKRoBNTjwRf0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNoGhSul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNoGhSul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1523F1F000FF;
	Mon, 14 Sep 2026 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789347207;
	bh=EvdBU/BPGdCJ9O4rwkTZNCIxxcIP/v4mYKhQ5OdYXs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YNoGhSulG1LdunF2VNjNoyLfQqwFH3GDnJfmP3MSFh3SMRiYujIFdvRyQGGMD8G8M
	 KMGwnrF9fveRbedhmxgBr5OuXTFiRUaxFr4fAzY4Fqb/kiU33KRHjZy9le1IZMsWO6
	 v96G2oynRwnEFzrcpNHLshQ7fdVJzCY1gkrlaWykdRPeG+wohG068i4DRjCcxt/llj
	 eqQUuBOp3r+SISWS0KtoT+y7LO8cBah56KoBmVenC56+F7XbksmNPgwssaXgAZbRZz
	 U/O3nwuvAdTxAi+B4Mb0l8fpBBqw4JjA2gKwJb/oRWpDh7UGNLIG4E675FVKoswSbE
	 O5VBOWCnsngNA==
Date: Mon, 14 Sep 2026 01:53:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: accel: adis16201: prepare driver to support
 additional parts
Message-ID: <20260914015321.7a660ab5@jic23-hlaptop>
In-Reply-To: <20260913085307.13846-4-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
	<20260913085307.13846-4-shehryar.amd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 13:53:04 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> Introduce adis16201_chip_info to hold per chip data and adis16201_state
> to wrap struct adis. Move adis16201 to this infrastructure. This
> prepares the driver to support additional chip variants by keeping
> chip-specific parameters in adis16201_chip_info. Additionally,
> adis16201_write_raw applies mask directly on value.
> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>

Sashiko spotted what seems to be an interesting bug..  Seems
the adis_buffer library code relies on channel ordering matching
scan_index ordering and that isn't true in this driver.
https://sashiko.dev/#/patchset/20260913085307.13846-1-shehryar.amd%40gmail.com

There should be no negative side effects reordering the
channels so I think that would makes sense to do.

The buffered data will be in a different order but that will at least
be the order the sysfs interface claims it is in!  If you don't
mind doing that as a precursor to this series that would be great.

See the spi transaction building in adis_update_scan_modes() for
where it is going wrong.

One small review comment inline that means making one more thing const
to simplify the code a little.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adis16201.c | 78 ++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 2ce5c409b..e0bf7df50 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -87,6 +87,22 @@ enum adis16201_scan {
>  	ADIS16201_SCAN_TEMP,
>  };
>  
> +struct adis16201_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *arr_channels;
> +	unsigned int incli_scale_val2;
> +	u16 write_mask_incli;
> +	u16 diag_stat_mask;
> +	unsigned int read_bits_incli;
> +	unsigned int num_channels;
As mentioned below add:
	const struct adis_data *data;
> +};
> +
> +struct adis16201_state {
> +	struct adis adis;
> +	const struct adis16201_chip_info *info;
> +	struct adis_data data;
 and drop this.
> +};

>  
>  static const struct iio_chan_spec adis16201_channels[] = {
> @@ -217,6 +232,20 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
>  
> +static const struct adis16201_chip_info adis16201_chip_data = {
> +	.arr_channels = adis16201_channels,
> +	.incli_scale_val2 = 100000,
> +	.write_mask_incli = GENMASK(8, 0),
> +	.diag_stat_mask =
> +		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +	.read_bits_incli = 9,
> +	.num_channels = ARRAY_SIZE(adis16201_channels),
> +	.name = "adis16201",
> +};
> +
>  static const struct iio_info adis16201_info = {
>  	.read_raw = adis16201_read_raw,
>  	.write_raw = adis16201_write_raw,
> @@ -248,16 +277,12 @@ static const struct adis_data adis16201_data = {
>  	.timeouts = &adis16201_timeouts,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),

As below, leave this here. Just look to access this whole structure
via info.

>  };
>  
>  static int adis16201_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> -	struct adis *st;
> +	struct adis16201_state *st;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -266,22 +291,29 @@ static int adis16201_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	indio_dev->name = spi->dev.driver->name;
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODATA;
> +
> +	indio_dev->name = st->info->name;
>  	indio_dev->info = &adis16201_info;
>  
> -	indio_dev->channels = adis16201_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->channels = st->info->arr_channels;
> +	indio_dev->num_channels = st->info->num_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	st->data = adis16201_data;
> +	st->data.status_error_mask = st->info->diag_stat_mask;
Given we don't have too many variants, I think rather than
this copy and update pattern I'd just have multiple instances
of the structure type of adis16201_data. Then put a pointer
to the relevant one in the info structure and just pass
in to adis_init() st->info->data.
Then you won't need the diag_stat_mask element.

Costs a little more static const data but simplifies the code
and I think that is the right trade off to make.

> +
> +	ret = adis_init(&st->adis, indio_dev, spi, &st->data);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;
>  
> -	ret = __adis_initial_startup(st);
> +	ret = __adis_initial_startup(&st->adis);
>  	if (ret)
>  		return ret;
>  
> @@ -289,14 +321,14 @@ static int adis16201_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id adis16201_of_match[] = {
> -	{ .compatible = "adi,adis16201" },
> +	{ .compatible = "adi,adis16201", .data = &adis16201_chip_data },
>  	{ },
>  };
>  
>  MODULE_DEVICE_TABLE(of, adis16201_of_match);
>  
>  static const struct spi_device_id adis16201_ids[] = {
> -	{ .name = "adis16201", 0 },
> +	{ .name = "adis16201", .driver_data = (kernel_ulong_t)&adis16201_chip_data },
>  	{ },
>  };
>  

