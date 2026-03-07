Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895C26D4CA;
	Sat,  7 Mar 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889538; cv=none; b=JjcUrHvQsky4ldkfxFbR6ZS0wHx6PbJrwmJ5vBdyqP1UyQqD31vat15V1slN2++rFpNIEGb2pRpdRL7THt1nmEd2yMB/OSk6xYa0ae8cN5u/YchRmCCnG+3wmv8I8+6ZrsGZUPTaa/VX99GLwRzqM+J9U2W+MD0hQpviwEPNhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889538; c=relaxed/simple;
	bh=CYQwTRO29fSsh+BWRH9G4A7LIvSuk9tukZqQc7L0Cio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPNFK+syPJU5I+ng8lv4tP/b2AjUQxx+EyEz07NauzAFriPbUXY8DzLh0bdHH3L1EgR5cIfSCZIWoh/RsB4FioRpYDHFjvdfr67bC3m9tZLtbwDdAn98EZ8IOuD/kSCyGgv1QaOIh9umixiSJZA6EsiK1doElbZgzET2tjkg3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN7IMT23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN7IMT23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4C4C19422;
	Sat,  7 Mar 2026 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889537;
	bh=CYQwTRO29fSsh+BWRH9G4A7LIvSuk9tukZqQc7L0Cio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mN7IMT23dfWd4BT1X7MpgD/LEUy50F2E1QWena5Jxb+n257hu6AMQnrJbPZNfhkVY
	 3OidIS0VZv2qEHoLI3yy+VHnH2CHg3m5/5xnkYWHi1RyqcMuillSBBJAvrcDUN1U7N
	 /RUYEo2eeT2NpBIlR4m2jShFvel+YHhooKr9HMcfj7MHqHhBUYKcBXZd1UqZTU8Ojn
	 ZC4G8zKuBc/usgZcbyY9zrpSRoIienxNtg6+dC7mZ7sSlYI8g0gsRToszcOXG7D1f/
	 SVBopHGui69y1AaDwtfHwuGY2BptQcpI3lXjf4CQQBiyFu8vRRe05bM2UANVT8bwO0
	 Z3h/vZD3fi9dA==
Date: Sat, 7 Mar 2026 13:18:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chunyang Chen <chenchunyang0908@gmail.com>
Cc: kuurtb@gmail.com, andriy.shevchenko@intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data
 rate
Message-ID: <20260307131849.609fafe4@jic23-huawei>
In-Reply-To: <20260305124302.129637-1-chenchunyang0908@gmail.com>
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
	<20260305124302.129637-1-chenchunyang0908@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Mar 2026 20:43:02 +0800
Chunyang Chen <chenchunyang0908@gmail.com> wrote:

> The variable 'drate' is currently defined as u8. However, the data rate
> values in ads1018 can reach up to 3300 Hz, which exceeds the maximum
> value of 255 that a u8 can hold.
> 
> Change the type of 'drate' to u32 to match the data_rate_mode_to_hz
> array definition and ensure the data rate is handled correctly.
> 
> Fixes: bf0bba486b5b ("iio: adc: ti-ads1018: add ti-ads1018 driver")
The patch name in this fixes tag is wrong.  I fixed up.

J
> Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>
> 
> ---
> v2:
> - Change drate type to u32 as suggested by Kurt.
> - Add Fixes tag as requested by Andy.
> ---
>  drivers/iio/adc/ti-ads1018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index 6246b3cab..0780abd0d 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -249,7 +249,7 @@ static int ads1018_single_shot(struct ads1018 *ads1018,
>  			       struct iio_chan_spec const *chan, u16 *cnv)
>  {
>  	u8 max_drate_mode = ads1018->chip_info->num_data_rate_mode_to_hz - 1;
> -	u8 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
> +	u32 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
>  	u8 pga_mode = ads1018->chan_data[chan->scan_index].pga_mode;
>  	struct spi_transfer xfer[2] = {
>  		{

