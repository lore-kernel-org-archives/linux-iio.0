Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8442D2496;
	Sun, 22 Mar 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199110; cv=none; b=WIJBElk/O0pGgdUWIukV4aOl8eZVkGZrhpvO+LPshFbCvLh94rgz/TtVbhhiuovMsOeEPLaRFLCenXFTxFT+dTBOmArGQ0s/j8fbkG9dZKt6Jl91AHAJizv9vwbbZceac+SApdnpKCeyZU7+lMeO7AQDe5k3I1y4+k2XOZFGKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199110; c=relaxed/simple;
	bh=uGBlV3SwEiSNdBBaOJvRAEZhlJzOg5qo62gFsF9LFNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQCFB/0jcBy37X6Tt/ja39RzMiCKR5mq9qQiaCX9xFHgERkkEHSPH+83OU2sCVrENKTTg1Xeo16pDgY4vzxUj5XRzjlExd2AMUmzpuaMqP0Z8jfDxkVouVcofkcMctU4iJiCsQE7fsv1j+/bDfiEIL8IassgN5H/flqANk/l+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpaHhjat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpaHhjat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E581C19424;
	Sun, 22 Mar 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199110;
	bh=uGBlV3SwEiSNdBBaOJvRAEZhlJzOg5qo62gFsF9LFNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpaHhjatazicnVwZ548cib2lVMPqRYnMXUS4tVriOxZZCI8167/fcQYoFCM4iOisk
	 dZbyTbp2ROROwDVbhbjZ485dHbt/cdZCh6FzA4bXzvXOxp8D2E3W2Pd7GLvHESI4xg
	 C6eto5bL5mMOAYJDTtw8x/B5yaxRBl2KPsAkZuEFA/QWEdOg4zFlbU6JlOhXE0bCXp
	 EZSVTK59q+8P3m+R6I86OxjQ84u4FYtm1K7n4UumbMfX7mNvdZzeU96AFlUAwMQgcE
	 zOtwYqyCvVKetZMfAU2K6BqarZFwRPk4oAqNsfJmWDpWf+he3jxQZRno0uhUWikWn2
	 Y0h2AaUsbYoAQ==
Date: Sun, 22 Mar 2026 17:05:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 5/9] iio: frequency: ad9910: add RAM mode support
Message-ID: <20260322170504.027e8e69@jic23-huawei>
In-Reply-To: <20260318-ad9910-iio-driver-v2-5-e79f93becf11@analog.com>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
	<20260318-ad9910-iio-driver-v2-5-e79f93becf11@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 17:56:05 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add RAM channel with support for profile-based control. This includes:
> - RAM data loading via firmware upload interface;
> - Per-profile RAM configuration (start/end address, step rate, operating
>   mode, dwell control);
> - RAM destination control (frequency, phase, amplitude, polar);
> - RAM operating modes (direct switch, ramp up, bidirectional ramp,
>   continuous bidirectional, continuous recirculate);
> - Profile switching for RAM playback;
> - Sampling frequency control via profile step rate;
> - ram-enable-aware read/write paths that redirect single tone
>   frequency/phase/amplitude access through reg_profile cache when RAM is
>   active;
> 
> When RAM is enabled, the DDS core parameters (frequency, phase, amplitude)
> for the single tone channel are sourced from a shadow register cache
> (reg_profile[]) since the profile registers are repurposed for RAM control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
A few minor things. Again I've left discussion of interfaces for docs patches.

> ---
>  drivers/iio/frequency/Kconfig  |   2 +
>  drivers/iio/frequency/ad9910.c | 464 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 462 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 180e74f62d11..a5b2e5cb5269 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -29,6 +29,8 @@ config AD9910
>  	tristate "Analog Devices AD9910 Direct Digital Synthesizer"
>  	depends on SPI
>  	depends on GPIOLIB
> +	select FW_LOADER
> +	select FW_UPLOAD
>  	help
>  	  Say yes here to build support for Analog Devices AD9910
>  	  1 GSPS, 14-Bit DDS with integrated DAC.
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index d3367e211dcf..747f4f407536 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c

> @@ -1288,12 +1610,26 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
>  			return ad9910_reg32_update(st, AD9910_REG_DRG_RATE,
>  						   AD9910_DRG_RATE_DEC_MSK,
>  						   tmp32, true);
> +		case AD9910_CHANNEL_RAM:
> +			if (!AD9910_RAM_ENABLED(st)) {
> +				FIELD_MODIFY(AD9910_PROFILE_RAM_STEP_RATE_MSK,
> +					     &st->reg_profile[st->profile], tmp32);
> +				return 0;
> +			}
> +
> +			tmp64 = FIELD_PREP(AD9910_PROFILE_RAM_STEP_RATE_MSK, tmp32);
> +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(st->profile),
> +						   AD9910_PROFILE_RAM_STEP_RATE_MSK,
> +						   tmp64, true);
> +
>  		default:
>  			return -EINVAL;
>  		}
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	return ret;
Seems a bit odd if you can now get here. Probably means some return missing
that would make more sense than a break somewhere above this.
>  }


> +
>  static const struct iio_info ad9910_info = {
>  	.read_raw = ad9910_read_raw,
>  	.write_raw = ad9910_write_raw,
> @@ -1503,6 +1922,13 @@ static int ad9910_setup(struct ad9910_state *st, struct reset_control *dev_rst)
>  	if (ret)
>  		return ret;
>  
> +	for (int i = 0; i < AD9910_NUM_PROFILES; i++) {
> +		st->reg_profile[i] = AD9910_PROFILE_RAM_OPEN_MSK;
Add a definition for maximum value and explicitly write that via FIELD_PREP()
as that will make it easier to see what is going on here.

> +		st->reg_profile[i] |= FIELD_PREP(AD9910_PROFILE_RAM_STEP_RATE_MSK, 1);
> +		st->reg_profile[i] |= FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK,
> +						 AD9910_RAM_ADDR_MAX);
> +	}

> @@ -1519,6 +1947,24 @@ static void ad9910_release(void *data)
>  			    true);
>  }
>  
> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
> +				       struct iio_dev *indio_dev)
> +{
> +#ifdef CONFIG_DEBUG_FS
Why?  There are stubs for debugfs_create_symlink() and the compiler
should tidyup the rest if that's stubbed out.

Whether this interfaces makes sense is a question I'll leave for ABI docs.

> +	char buf[64];
> +
> +	/*
> +	 * symlinks are created here so iio userspace tools can refer to them
> +	 * as debug attributes.
> +	 */
> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
> +	debugfs_create_symlink("ram_loading", iio_get_debugfs_dentry(indio_dev), buf);
> +
> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
> +	debugfs_create_symlink("ram_data", iio_get_debugfs_dentry(indio_dev), buf);
> +#endif
> +}

> 

