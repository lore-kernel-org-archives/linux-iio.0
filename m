Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B81DED63;
	Mon,  4 May 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918548; cv=none; b=W6OVEJLKWEf4fqhHkRyRqNtYX/XrYssBHA31VTAX1y5e6PSYwzfO/qqD316cpbBZ/1ne46S7rxaa2viJk5MtcnAEcpWLEoq9vERN28hIlv9T7S8ZOcLMPHQ37MaDuiOT9YHXpmzkxuwE1BOUeY/L+flYHloolKcOI73ktkPpiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918548; c=relaxed/simple;
	bh=Jo0bMb9H44ijTSfFfhQ4fargPipTvFE09gFg7hlCjbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrMNg+rAnrAmYEMvGOtbqRMKxZclEzurUeNFKFGNsxVfXo7BtkE0ZPpq2RywhSMjtiDwX5zRBGghSLS/yWNHoR4SsJHCgmhWjUo1PN889vjeamAPZng8youPy6pQPLCrBheEHdsXt89FuvU5FoXMmusktgLOkdA+GPIxIHEl7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtHGlM7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtHGlM7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091FAC2BCB8;
	Mon,  4 May 2026 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777918548;
	bh=Jo0bMb9H44ijTSfFfhQ4fargPipTvFE09gFg7hlCjbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtHGlM7zpqqSdMOZYaEx9y3VmiBII1XKpmFJzGucchUKn/fPExUVSlmpihllna2fq
	 BjuO2LHH6T+mFh7YS+VYd+tLj0MEBb/YrbpLxCcb6rJqyRsY1jeqxFk3kEtNAOUnKl
	 qk/WSuvC3l3dQZCMzso9o/tTrwrGP6YKKIwuo+BD1opYEP1iKsCgkgXQ1IXP9KBRo8
	 R87DHXeM9ZuHDPTK7X8QX4Z2CFjaH1Ax/S+WPmme4yrQ46hJPjiwsc/bflYW40P/2z
	 6Sohm6DCSgmXAxKl5cYo3r7PnX0clQDx7mRTaOJ/bfQFZb8HQQkohsB5JI9Mb5mtbh
	 nK17mxPE3iX8w==
Date: Mon, 4 May 2026 19:15:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 03/10] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <20260504191537.17fb8d05@jic23-huawei>
In-Reply-To: <20260501221152.194251-4-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:42 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> new file mode 100644
> index 000000000000..7a02bbab3a63
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = (void *)INV_CHIP_ICM42607,
> +	},
> +	{
> +		.compatible = "invensense,icm42607p",
> +		.data = (void *)INV_CHIP_ICM42607P,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{ "icm42607", INV_CHIP_ICM42607 },
> +	{ "icm42607p", INV_CHIP_ICM42607P },
Very strong preference in new code to not use enums for the data.
That explains why you need the magic invalid in previous patch.

Can we instead just use pointers to the per chip data relevant
to each one? That usually means some externs in the header.

We used to do things how you have it here, but the enums always
end up proving a pain as drivers get more complex.  They also
encourage part specific code when it should almost always be
part specific constant data.

Currently I'm not sure what is different between these parts.
If nothing yet from point of view of what the driver supports
then don't bother providing data 'yet'.

Jonathan



> +	{ }
> +};
