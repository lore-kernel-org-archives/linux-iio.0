Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CD2E9757;
	Sun, 26 Apr 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210630; cv=none; b=mJGJuo9tx+dJaZMImJkTtzp4HXjx2vHOX9Ysvc1vN6CETshWxvlegHzZnpLJitSxC2lTKXz8L9QCIn02mWc8J4WxeLeARAj9anoQkPCdvslpKFg1ceirqfvpz8+SaqhguZIdwdop7QJX5aPvLbZ39xCvV5hVMjTPJR3G7yD6i5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210630; c=relaxed/simple;
	bh=V0BeEEiJ+tOKjyQIOE4sdp5oA7PjD6XioK1+VoOQp50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9nDHiW06zByUFSEisqrVbXQP9Ix13iFuwDOIUGR0tfoMMk++Aq9eOsiXkw8uHqwL95A4+f3OQlz6VVgMSEX0LQAAzCU9LLbpOEEn1X5yFHItBOxBevDiM+0iY8A8DphlDpBuJCAtUdSpuvwjRl4hU+cE/RJbBvpOTK2AwcYTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN1yxXli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN1yxXli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD8C2BCAF;
	Sun, 26 Apr 2026 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777210630;
	bh=V0BeEEiJ+tOKjyQIOE4sdp5oA7PjD6XioK1+VoOQp50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JN1yxXlihMZ7R+HRXFTNJen3I0a0ggS02M8CXAqzLFIqLnZ++JtcpUpa+Yu4Ml4LL
	 czazQJ9B759sTeSeQy8j09rMQ4IJvXs9miMMBMLKY/wPntjAi0FBXs6aQKTNvhq5gp
	 pO4WWU3rfiMtjiOCWh4t9n8iyztZ3Vv6qs9kea6n/V49oo6LrCVOy0nELeGaJnKHl2
	 qi+65k0gZKD2ek5BU1+r8nxpfh0ej+l9XdHXkiWZF6u8mlSgSUtRY+oHt9E48HGLKg
	 QQfze41s+XCabOFp9hG8TvNwLiQKUIXzU6TNfIq6EMPSlhZTEm8BABbll/fiObNdf/
	 MUS95pSPjBazA==
Date: Sun, 26 Apr 2026 14:37:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 04/10] iio: dac: ad5686: add of_match table to the spi
 driver
Message-ID: <20260426143700.4bd8982a@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-4-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-4-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:05 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add of_match table for the SPI device variants to be consistent with the
> AD5696 I2C driver.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied. Note I'll be rebasing anyway in a day or two so
if anyone else does want to give tags I can probably add them.

(or feedback that means I pull this out of my tree!)
> ---
>  drivers/iio/dac/ad5686-spi.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 73e6c998add0..8fef0e6d33ff 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -119,9 +119,30 @@ static const struct spi_device_id ad5686_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
>  
> +static const struct of_device_id ad5686_of_match[] = {
> +	{ .compatible = "adi,ad5310r", .data = &ad5310r_chip_info },
> +	{ .compatible = "adi,ad5672r", .data = &ad5672r_chip_info },
> +	{ .compatible = "adi,ad5674r", .data = &ad5674r_chip_info },
> +	{ .compatible = "adi,ad5676",  .data = &ad5676_chip_info },
> +	{ .compatible = "adi,ad5676r", .data = &ad5676r_chip_info },
> +	{ .compatible = "adi,ad5679r", .data = &ad5679r_chip_info },
> +	{ .compatible = "adi,ad5681r", .data = &ad5681r_chip_info },
> +	{ .compatible = "adi,ad5682r", .data = &ad5682r_chip_info },
> +	{ .compatible = "adi,ad5683",  .data = &ad5683_chip_info },
> +	{ .compatible = "adi,ad5683r", .data = &ad5683r_chip_info },
> +	{ .compatible = "adi,ad5684",  .data = &ad5684_chip_info },
> +	{ .compatible = "adi,ad5684r", .data = &ad5684r_chip_info },
> +	{ .compatible = "adi,ad5685r", .data = &ad5685r_chip_info },
> +	{ .compatible = "adi,ad5686",  .data = &ad5686_chip_info },
> +	{ .compatible = "adi,ad5686r", .data = &ad5686r_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad5686_of_match);
> +
>  static struct spi_driver ad5686_spi_driver = {
>  	.driver = {
>  		.name = "ad5686",
> +		.of_match_table = ad5686_of_match,
>  	},
>  	.probe = ad5686_spi_probe,
>  	.id_table = ad5686_spi_id,
> 

