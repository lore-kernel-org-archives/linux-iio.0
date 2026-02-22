Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56182CA6F;
	Sun, 22 Feb 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765040; cv=none; b=Q6Msr4eF2sazmmUEL8mhW3KB2lUGhw80/sbIIUT0VsQG3X7ymz3lyUlTla7AO3FOcLNcofbNVXtImIrE7f+iEKMGubNNGACL+yrenoWwTHnxpjetfVn2HVzWK3QewuSbQc0Zcfd6YnnRWGv0gqyewdAYTUODly8yb+1VH3AaWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765040; c=relaxed/simple;
	bh=J1r46UicWupRVFBjJAGR5ikJeJ/wp4qNjFbIYUPpkhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hpn6Ws9bgMTnNmjt7Hs7v684MnyUIyD75sd9ukMXyviLhDKLgjaADvsokdm4DkTwsCF2tHkeswhPRpgxrTG/Zg3BWFn7UklvZN4Kj22nqKcjM9eTemzHiQ4HWde50xsoN+UnaVpazIXmFLnydCDPbLi1bDWcrsHJeE8Pfm/7hMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvm2B9Z/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvm2B9Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D442C116D0;
	Sun, 22 Feb 2026 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771765039;
	bh=J1r46UicWupRVFBjJAGR5ikJeJ/wp4qNjFbIYUPpkhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvm2B9Z/g5dssuhFpwcZPY1SxTV3NjRJFLcHcSZ/6AAQkd6CTuFzzQrWs5il0gPze
	 V7LIGZUbcCUJghDDl43bzPnQ9yIs6XIIUZCsdL8mlKgpAywdJ72/qoPpaV3oMmaaex
	 xMfA6weV5YawI8Z54e1AwB3shKnY3NchqeVyWk0fizfjzOLr96EiVmJgcZUd39fHk6
	 XSEMXX3Lo/2w0RkzIAOrWtWkXF8OMaQDrWRvpfF6STXps2GT4SRBJmvcxYgt8MmtKt
	 PqiDZ8v24qIfTrtFwgRzsSPUqWwiQrhOUTZQ6JoK7vhW6e4RfBn/1sjp+tqnVuVtTE
	 +181xK1PRFTew==
Date: Sun, 22 Feb 2026 12:57:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v9 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <20260222125703.00e3152a@jic23-huawei>
In-Reply-To: <20f1dc8eb6bb692eb6eb814a49e54309d973a9e4.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
	<20f1dc8eb6bb692eb6eb814a49e54309d973a9e4.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 12:00:39 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi. One really small question on ordering inline. The other thing is mostly
me expressing surprise around the PWM handling being necessary rather
than any request to change anything.

Thanks,

Jonathan

> @@ -971,6 +1205,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
>  	return 0;
>  }
>  
> +static int ad4030_pwm_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +
> +	st->cnv_trigger = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
> +				     "Failed to get CNV PWM\n");
> +
> +	/*
> +	 * Preemptively disable the PWM, since we only want to enable it with
> +	 * the buffer.
> +	 */
> +	pwm_disable(st->cnv_trigger);

Feels like there should really be a way to get a pwm disabled in one call
so there isn't an edge case of it being on briefly.
I'm a bit surprised it defaults to on.  I guess this is because DT can provide
the parameters?


> +
> +	return 0;
> +}




> +static const struct iio_scan_type ad4030_24_offload_scan_types[] = {
> +	[AD4030_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 24,

Really trivial, but why this order?  To me keeping to the
order of the fields in the structure definition makes a tiny
bit more sense here.   So realbits, then storagebits, then shift.

> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_CPU,
> +	},
> +};
