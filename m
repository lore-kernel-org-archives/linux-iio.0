Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7702EFD9B;
	Sun,  1 Mar 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772367017; cv=none; b=FSsr09E2He2191Cr0Nc1AxDH3R1k6pb3witQe5xdsq9PUZ38+wRSSpPgG0HGmIpnWeyToVF5y711xaSJAa0GH9WacW/2JiXTg2VFOQITrcpYf//SlYNlY0B1gCQlkj+leMlEb/C9OJ/jJkgYUIW8+h27tj50T4EU5PlWjEkdjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772367017; c=relaxed/simple;
	bh=EM4nV+8wPjflb/uK5rfNQ01u7nu9dx+td63hr8gBYqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eReOSoSPuFy9Xas5iSypRtGhKpFHfxKaToC3TNlIyq23+EX9vlyMw8jVVquwLDyj/pyUCLDymRcduXALwFk2OX10tvM/c3kYyrxwRQDLwk2imKzwmYcxy0GSFM3PZOCRsPO8WaXv/kqaQq43vVrVO+mYW5PBpNFKe0Grte15eGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXtT5LdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXtT5LdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2561DC116C6;
	Sun,  1 Mar 2026 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772367017;
	bh=EM4nV+8wPjflb/uK5rfNQ01u7nu9dx+td63hr8gBYqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXtT5LdNqKSU/knI4y1CJrVJ2i5yT+9W8SVl1BA7xmfx6aLn7Pm06oMPkRM1ZLnMU
	 PskskT1n736sibTGyKDHFC1Pz9rLXUbacKix6sIJ/1jze3i6X51L8NjH13kLg5zo+w
	 2Zpkpc0J0fTrp63lPELSKyq4xy2O9lL504U9pTSh/nURb7SOofQUHwlfDDkYc99329
	 /LYs/zq51j9JUUdnmrdoi3+VZe/He5XLzzrPmeGetk4gAGcvLcEDenXA1euZ4Yh3X0
	 HkvVSGKJ83wnBPqrG3lS/l7NsvbkeLxlSaBFelEKGByO5nVCqInBYqa2zZ/SXJ87UD
	 /YarGGCGzWy8Q==
Date: Sun, 1 Mar 2026 12:10:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 jonath4nns@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <20260301121011.4b5d2238@jic23-huawei>
In-Reply-To: <ca6f9ec7-ec58-4628-b41a-c2e4beb67777@baylibre.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
	<79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
	<ca6f9ec7-ec58-4628-b41a-c2e4beb67777@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 11:18:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/23/26 5:59 AM, Jonathan Santos wrote:
> > The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> > the capabilities of conventional triggered buffer operations due to SPI
> > transaction overhead and interrupt latency.
> >   
> 
> ...
> 
> > +static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	struct spi_offload_trigger_config config = {
> > +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> > +	};
> > +	const struct iio_scan_type *scan_type;
> > +	unsigned int unused;
> > +	int ret;
> > +
> > +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> > +	if (IS_ERR(scan_type))
> > +		return PTR_ERR(scan_type);
> > +
> > +	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits);
> > +	st->offload_xfer.bits_per_word = scan_type->realbits;
> > +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> > +
> > +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> > +	st->offload_msg.offload = st->offload;
> > +
> > +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> > +	if (ret) {
> > +		dev_err(&st->spi->dev, "failed to prepare offload, err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
> > +	 * continuous read mode. Subsequent data reads do not require an
> > +	 * initial 8-bit write to query the ADC_DATA register.
> > +	 */
> > +	ret =  regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
> > +	if (ret)
> > +		goto err_unoptimize_message;
> > +
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &config);
> > +	if (ret)
> > +		goto err_exit_continuous_read_mode;
> > +
> > +	return 0;
> > +
> > +err_exit_continuous_read_mode:  
> 
> I wouldn't mind a comment here explaining what this read does.

Given I'm not sure, Jonathan, can we have such a comment as a follow up patch please.
> 
> > +	regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &unused);
> > +
> > +err_unoptimize_message:
> > +	spi_unoptimize_message(&st->offload_msg);
> > +
> > +	return ret;
> > +}  
> 
> ...
> 
> > +static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
> > +					 enum spi_offload_trigger_type type,
> > +					 u64 *args, u32 nargs)
> > +{
> > +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> > +		return false;
> > +
> > +	/* Requires 1 or 2 args to indicate the trigger output signal */  
> 
> Would be more clear to say "up to 2 args are allowed, but only 1 is used".
I tweaked this.

> 
> > +	if (nargs == 0 || nargs > 2 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +  

