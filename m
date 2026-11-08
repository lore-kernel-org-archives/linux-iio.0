Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169089;
	b=hc1CEmpKHZvlfhkj4V3A14uY+0PvJDC6KfUtHfEvaw7FXMRq/EZrWRLZxe5vB2IzOdeV
	 M3in8Ffc+oiWYGWQv4ojfsAKft3QDrHqyXGW9r05uyFKFfRfDxwyB2Okl2GVb70XlEEgu
	 9Y1b23MVLty0psvPj0Tm8A+VOtVVcKLL7NAm12J/s9Jp5bm1Cb6BMjlx0V0uqZTp4PunJ
	 MUVHKh1kdUpuLMpdyRWHc2ZHTC8602iERtPGrK5LTwMgHukT+I9QSThbjlH6U91kxRxsa
	 0aioDdjrerLjO0h40Mcx04Y7CzI9xLSW0SZd/3xAcJvkZg9EHPQqHxdMH7nkqSnQ7YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169089;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZKmMOaENMpjbb+mX2tdM//GScrnFKcVTAdh0GVElmZI=;
	b=Yh0PMQ/DxHDbS+Or4KssQ6bygKh6YGnghXObnbYIIjJdDuPvXFf+iRjTXaJhYD6L4dA0
	 0TSeOVBeTSy/wZ+1S3VjKnGe3iH6CAntgMVhw7LiCtTaBPmMSlDPiVQmz799TR1nkseZC
	 r/I7malGbYF8vaStuTx6cIE8PFfrOaQV89qy6oGevxgVewS3Rnmu/eW5RdIWjdKzvvzb9
	 belO+qi0gpRgTFf0S3HVHFisWE2Tljz2K/ffr3knJUhyBVO2bx/ELX+Dq0zwDBpfCF6vP
	 i40By0vlbbEhgHoQwpvvFm6Cd3HI2/5HTdOctG1LnN57WuzM3LxoGDs3sRE6e6zsa1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEACSFIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C021606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEACSFIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D31F0089F;
	Sun,  8 Nov 2026 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169089;
	bh=ZKmMOaENMpjbb+mX2tdM//GScrnFKcVTAdh0GVElmZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lEACSFIwNqSYsX7pIq8nqlwKrCNE55hmEbnPOw8Xv8S3kwPcc1DflLJKpwIm8e9Qy
	 yYcPmT5Rbw3eMnBLrUbChjlmVxYmlqzadF2g1hZzAXbK5eEMoiGa/CWlbQvGXkZ94s
	 wkr4Js5a0wTksxWJJ7DvRppNUPHxsjxqxXwdqfzzATlVK+2aqTvnxgRFxQT1jw3wlt
	 pPtyinUh9gaf8TM90iv+gt9Eju/p5jyv/ltr+xJLlYKpC7aAdrtwNGgUBHw8aHr3K9
	 GcX4lggj+y2tLell671616xRb1gOpP0N9HCnyAZqla0tD08F1HseUitQcw7eu1ZdbE
	 OFT/5aiPyC+RA==
Date: Sun, 8 Nov 2026 20:18:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 31/39] iio: adc: ad7887: ensure tx_cmd_buf is DMA safe
Message-ID: <20261108201804.598c9d38@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-31-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-31-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:49 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> SPI transfers require DMA safe buffers. Mark tx_cmd_buf with
> __aligned(IIO_DMA_MINALIGN) to ensure it does not share a cache line
> with other data.
> 
> tx_cmd_buf could share a cacheline with data, but the next patch will
> obscure that a little so separate marking used for readability
> purposes.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied.

> ---
>  drivers/iio/adc/ad7887.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 62aaedbce748..b1d9da19e7a2 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -63,7 +63,7 @@ struct ad7887_state {
>  	struct spi_transfer		xfer[4];
>  	struct spi_message		msg[3];
>  	struct spi_message		*ring_msg;
> -	unsigned char			tx_cmd_buf[4];
> +	unsigned char			tx_cmd_buf[4] __aligned(IIO_DMA_MINALIGN);
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> 

