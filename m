Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A95387371;
	Thu, 23 Apr 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967764; cv=none; b=uDvPKw30/YwacD8/prUhv3wXZvscif4GleG8L2I2XxpnRkMIfu2ob6ZZpBhiELQxLkRDJRka488ShGieT2DSSebMIWtoHOAH9QlOlYDl2SMtLCT7QSU8H5cOCRvg8RfMxkwPR4ARe4wO0gohxX8L5urVG1EKmtqZMQhgEUvWb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967764; c=relaxed/simple;
	bh=cbhQnGo0FzkneMoMvZ6mq0hgLBtbsLL/omUeKvQraow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOkKmuspp3OFhQKUroY+Dzik208xkIa1qjnm3iUlq8zBTPDvp7rAMDca2pbo6BELCo7TzZoZ71Gr5iIozx/WLYCODV32xO9ylPPnS042wS3qtikFlnUbsAU4i2hoPknMZXN9PygjMupF7d5+szKGaoRza2AUNNHhIFHOBGv8v0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1ac9nzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1ac9nzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5470C2BCAF;
	Thu, 23 Apr 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967764;
	bh=cbhQnGo0FzkneMoMvZ6mq0hgLBtbsLL/omUeKvQraow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J1ac9nzT8tcBqf8YM9jj1i6F9GDdXjI95NnJpd59TeiWKgGWdjdM4OUe9ndGOv9Y1
	 OxmqIEg3wW9w48KtJ4rd62InaR+Vdk3adfBKp90ZuscKriIr2n2aN3ldo6cNgLNmFh
	 Y0GrpHYCaepmE2wyYEr1sfJDF+ciFtUifjsb9ImSAA33vCzWI/W4BL13mTlbuQ1ZzX
	 HUUY1El6sqEzjzUhJvus1rmbL5CWA+tmei1X7HgmU4XRC44KPf22RkAi3KGQHsRnxC
	 CG+/DppTxrM0p7365MaeycPOcDvlmuxJAdAN6aWh7mVCLDz+Zmnq79YWqZHipcaxrF
	 FhO0DKfHdUwqw==
Date: Thu, 23 Apr 2026 19:09:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 15/22] iio: dac: ad5686: create bus ops struct
Message-ID: <20260423190913.712f12b1@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-15-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-15-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:49 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Create struct with bus operations, including a sync() operation that will
> be used to flush multiple channel writes at once. Auxiliary functions
> ad5686_write() and ad5686_read() are created and ad5686_probe() now
> receives an ops struct pointer rather than individual read and write
> functions. Documentation header of ad5686_state struct is updated
> accordingly (adjusting renamed fields and formatting).
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Trivial stuff inline.

Thanks,

> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 7004d0d1d97a..55f49dbbbd39 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h

>  /**
>   * struct ad5686_chip_info - chip specific information
> @@ -106,24 +113,23 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
>  
>  /**
>   * struct ad5686_state - driver instance specific data
> - * @spi:		spi_device
> + * @dev:		device instance

Unrelated fix. Separate patch.

>   * @chip_info:		chip model specific constants, available modes etc
> + * @ops:		bus specific operations
>   * @vref_mv:		actual reference voltage used
>   * @pwr_down_mask:	power down mask
>   * @pwr_down_mode:	current power down mode
>   * @use_internal_vref:	set to true if the internal reference voltage is used
> - * @lock		lock to protect the data buffer during regmap ops
> - * @data:		spi transfer buffers
> + * @lock:		lock to protect the data buffer during regmap ops
> + * @data:		transfer buffers
>   */
> -
Likewise - though feel free to do this one in the same patch as spi -> dev.

>  struct ad5686_state {
>  	struct device			*dev;
>  	const struct ad5686_chip_info	*chip_info;
> +	const struct ad5686_bus_ops	*ops;
>  	unsigned short			vref_mv;
>  	unsigned int			pwr_down_mask;
>  	unsigned int			pwr_down_mode;
> -	ad5686_write_func		write;
> -	ad5686_read_func		read;
>  	bool				use_internal_vref;
>  	struct mutex			lock;
