Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B7261B9B;
	Sat,  7 Mar 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772893215; cv=none; b=VTV2JH033jisLfinWQHuIxstAO58j4YFE7PkJCZa6HX1OyMsW0KV0yNXVkFQeKe6V8LIkWz9E+j8lqq7tSIrnQu8GvCoyswAD5eE/Ci49XUP7EnPCswwsoee8GKs3XewKw1Gj1OTVAoeVJDU0ttt7c1YVxtNXaLhpxlLxhSvXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772893215; c=relaxed/simple;
	bh=a5jVNnEzNzRgAOkThx17Lm/fR+3+iFoZser1WqgJoZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2TsbUFj4IMjOCVgXottARVmSXutoyRzagCdXfxGBOtUE8tOUH5b4t88vxouBbZYSZvsKS3X9jCYYFAgvJBihpTmfMKKhzalVZP833rW/tda87XXtJ6luAz3dywPJy3ZvccWLv5RUfsE4oguo2UxEA2+tsn2xFEsplo/Qw4rStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr0zmgXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr0zmgXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311ECC19422;
	Sat,  7 Mar 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772893214;
	bh=a5jVNnEzNzRgAOkThx17Lm/fR+3+iFoZser1WqgJoZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tr0zmgXzPq4pdzVp/WO1b5jtLPurs39ZW1JPWLMstsB+++ggnyLspKPTg5Q1de4Aw
	 NCW30gLKb7+w/q0IzMy1BB7gGYZttOf11SD8PUxh2Tfw+FEDgaQFuvGXp0VmtFlhw5
	 Tt+Hx2msLLCo7/W0AsscgqdMxs6V7SRBgXF99/JUjxYC0ajVwKS2XGpjH4rEgVZl8l
	 EpxCgmr1kCNI2G95rNUaKP9wZsGDkMhGaHoWsouKrGQcf1cGzwooVOphw6PlqJRZ6W
	 BqVUf+BS1eT/8neIMP9acVtKaTXdYFqSXpelT8xTZAPDU/EvpMp+YMD1gjL97DBERP
	 n2fRfMMV9ZWcg==
Date: Sat, 7 Mar 2026 14:20:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <cosmin.tanislav@analog.com>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ad4130: add new supported parts
Message-ID: <20260307142004.7bfd5de1@jic23-huawei>
In-Reply-To: <1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
	<1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 09:39:04 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
> 
> The AD4129 series supports the same FIFO interface as the AD4130 but with
> reduced resolution (16-bit). The AD4131 series lacks FIFO support, so
> triggered buffer functionality is introduced.
> 
> The 4-channel variants feature fewer analog inputs, GPIOs, and sparse pin
> mappings for VBIAS, analog inputs, and excitation currents. The driver now
> handles these differences with chip-specific configurations, including pin
> mappings and GPIO counts.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
A couple of things inline.

> +static irqreturn_t ad4130_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	unsigned int data_reg_size = ad4130_data_reg_size(st);
> +	unsigned int num_en_chn = bitmap_weight(indio_dev->active_scan_mask,
> +						iio_get_masklength(indio_dev));
> +	struct spi_transfer xfer = {
> +		.rx_buf = st->scan.channels,
> +		.len = data_reg_size * num_en_chn,
> +	};
> +	int ret;
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err_unlock:

Needs a rename seeing as no locks involved.

> +	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1300,12 +1416,77 @@ static const struct iio_info ad4130_info = {
>  	.debugfs_reg_access = ad4130_reg_access,
>  };

> @@ -2100,34 +2383,46 @@ static int ad4130_probe(struct spi_device *spi)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to request irq\n");
>  
> -	/*
> -	 * When the chip enters FIFO mode, IRQ polarity is inverted.
> -	 * When the chip exits FIFO mode, IRQ polarity returns to normal.
> -	 * See datasheet pages: 65, FIFO Watermark Interrupt section,
> -	 * and 71, Bit Descriptions for STATUS Register, RDYB.
> -	 * Cache the normal and inverted IRQ triggers to set them when
> -	 * entering and exiting FIFO mode.
> -	 */
> -	st->irq_trigger = irq_get_trigger_type(spi->irq);
> -	if (st->irq_trigger & IRQF_TRIGGER_RISING)
> -		st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
> -	else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
> -		st->inv_irq_trigger = IRQF_TRIGGER_RISING;
> -	else
> -		return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
> -				     st->irq_trigger);
> +	if (st->chip_info->has_fifo) {
> +		/*
> +		 * When the chip enters FIFO mode, IRQ polarity is inverted.
> +		 * When the chip exits FIFO mode, IRQ polarity returns to normal.
> +		 * See datasheet pages: 65, FIFO Watermark Interrupt section,
> +		 * and 71, Bit Descriptions for STATUS Register, RDYB.
> +		 * Cache the normal and inverted IRQ triggers to set them when
> +		 * entering and exiting FIFO mode.

That's special.   The binding doc needs an update to say which state we are
expecting an irq description for.  Obviously not a result of this
series but nice to add that none the less!

> +		 */
> +		st->irq_trigger = irq_get_trigger_type(spi->irq);
> +		if (st->irq_trigger & IRQF_TRIGGER_RISING)
> +			st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
> +		else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
> +			st->inv_irq_trigger = IRQF_TRIGGER_RISING;
> +		else
> +			return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
> +					     st->irq_trigger);
> +	}
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
