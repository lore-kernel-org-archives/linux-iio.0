Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0993382F4;
	Sun, 12 Jul 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783821192; cv=none; b=F9aF5gvThb+nzx/3LqWgcw5wNvFRgLj1tGg6SA3wmsVEyZOerDbpeuAlB8YXODRQyzQ+W19B2+3iB/WshZVRS6hNs6ObA3vFfItLb3phBlM7oUi9XdIdN60i70s/gyott+YQX7tC4zo7qc0kSsd8T03hqVN6y3fJdatjBmLtU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783821192; c=relaxed/simple;
	bh=yXM375PDm806Gs0Ti1Pat08+hMOs0N1uQrQtGKVqy38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt+AjnCX15ZQeLJtDHx5iQVkqYu8+ZEN6bGufbpgedxFa2cGYYDkQko5yyisU44Sls7R5GaECT890RGcBFfoBJpRZrN+T8j57fukO65s7rPU76KbJrInDzrkp/iqwbyEcnAK881rOmthGenTq45m28K75d5ecUwRE+tvrwu+KTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCR5Bisd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCR5Bisd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3593E1F000E9;
	Sun, 12 Jul 2026 01:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783821189;
	bh=byN/MCjeVIBXqR6zhSL8Vm67OAYqthX7rsuT1XR5O6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QCR5Bisd0kgFY7TZwZQvKUtsuCWr2POZJHAUA4wqyZ5qNcHS0hLUGr56VJJYmNce8
	 4xjhqi5C7LnPll3TFZ8kwe/yv5agUA9Y4aATdm5OZEBrQKhVBAA3CRmP4y3Wpjbkhy
	 l0n0i/aZiywziJA56mygBcU8dsUOvz2loneZsQg+E5fLafae4GU4n+33dXwU3gRA5Q
	 WfrNeB3Wq69TmH/xiBysB5/xElmGaIWzDeTX8sE1obxLYWiFXuiHmAfnvdJfjWw8pU
	 ZYwiMZDiwONsSIfO3iiGZRCAfCtEfZQXGlB3XXAPYabnxyE7OzOubKhREcrbUZzXww
	 fVuGMQp5uvVVg==
Date: Sun, 12 Jul 2026 02:53:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260712025303.014c02ed@jic23-huawei>
In-Reply-To: <965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
	<965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 17:49:53 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Support for LTC2378-20 and similar analog-to-digital converters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v5 -> v6:
> - Added comment to clarify CPU endianness is used when device native BE is not.
> - Protected single sample read procedure with a mutex.
> - Dropped mod_devicetable.h, include device-id/spi.h device-id/of.h instead.
> - Used iwyu to add missing #includes and dropped superfluous ones.
> - Used pahole to minimize memory holes in LTC2378 data structures.

A small comment about maybe splitting the channel macro into offload and
non offload variants. That would also let you only bring the offload
version in as part of the next patch.

Jonathan

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..c9f8b19e0298
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c

> +#define LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _offload)	\
> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      (_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> +	.info_mask_separate_available = _offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0,\
> +	.scan_index = 0,							\
> +	.scan_type = {								\
> +		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
> +				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
> +		.realbits = _real_bits,						\
> +		.storagebits = _storage_bits,					\
> +		.shift = (_offload ? 0 : _storage_bits - _real_bits),		\
> +		.endianness = _offload ? IIO_CPU : IIO_BE			\

As below. I think, in my ideal world the offload parts of this would have
been in patch 3.

Given how much changes in here to me it's a bit marginal on whether having
LTC2378_DIFF_CHANNEL() and LTC2378_DIFF_CHANNEL_OFFLOAD() would have been simpler.



> +	},									\
> +}

> +
> +struct ltc2378_state {
> +	const struct ltc2378_chip_info *info;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_device *spi;
> +	struct mutex lock; /* Protect data acquisition cycle */
> +	int ref_uV;
> +	struct spi_transfer xfer;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.

Trivial but I'd wrap nearer 80 chars.

> +	 */
> +	struct {
> +		union {
> +			__be16 sample_buf16_be;
> +			__be32 sample_buf32_be;
> +			u16 sample_buf16;
> +			u32 sample_buf32;
I guess for churn reduction it is fine to introduce some stuff for
offload before the patch that does the majority of it.. 

> +		} data;
> +		aligned_s64 timestamp;
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +};



> +static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * The internal reference buffer amplifies both the internal reference
> +	 * and REFIN by a factor of 2.
> +	 */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret == -ENODEV) /* refin is optional */
> +		st->ref_uV = st->info->internal_ref_uV * 2;
Maybe
		return 0;
as done
> +	else if (ret < 0)
	if (ret < 0)
		return
> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> +	else

and then no else needed?  It's a marginal improvement so I don't mind
if you ignore this suggestion.

> +		st->ref_uV = ret * 2;
> +
> +	return 0;
> +}


