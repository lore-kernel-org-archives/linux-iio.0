Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE93A5436;
	Wed, 29 Apr 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457280; cv=none; b=rW+aCMJ6/d5yG75QqwM3jFkmvzcr1hvAjC9IdH//Q4RAgQzBOuMkoSjHCnXHKaAFNjzlyd7tFvnLES6/Iyw53FthnvIJBligaM174bgEJk0ZuHbGPNglSbWdLQkNnYpx7v21opcTnLJGZ8wARG6sYTaSpZ690bNPxDUFXC6t/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457280; c=relaxed/simple;
	bh=OC2Sp1y1h5YDnAdYn8rrUESUkQQv3wsGtrkKprNusJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IruXxLgN+PeF7Bh9k1gfRmPfsCNZdqPDzJ7Ipgl2dLYIoVfl7Yh9u3KlRCEl4WhuEiD706xNlPUiyPq1BeI3O9xG3hIb1zFhp8NNQGgU/zyabuBYeqhEiuY2OMzJzLuvi+68UF2Zdal/Y3btg2AUHMHvR8XSnel9xsPOXW5G36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDZJeKqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDZJeKqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6DDC19425;
	Wed, 29 Apr 2026 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457280;
	bh=OC2Sp1y1h5YDnAdYn8rrUESUkQQv3wsGtrkKprNusJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDZJeKqTCAfUiyWpla6KpB1qvwTK5tkmx4GWlKAg7rFOCCHxR2ivXvfi9WomCnNTX
	 B5qvOLdLaXmRmmdU0k7g6IJCifDnX66G5Cs3lUeNLxc9xYbAVqmgScmDzFk6UnGMsJ
	 usT5B8PIfC80vVyCrI969Xa2LphGTH7rPG2e3Yc8zM/Qnpq9y/nHBS6p2l6VvpuKOb
	 jrpdv5hQ4d6MCZzSCWWjqIs78CYPUzf9G4jGmSFaO6YmcKH29KqtiCaCJobThuz0QR
	 xO75qf4a7AjR+qMaDz+3zB+dRXSye0RLapv1Sa1sv2ZbkQS02mfyzZYCvhT7J4MWAh
	 yySWy9pH6l61w==
Date: Wed, 29 Apr 2026 11:07:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 04/11] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <20260429110750.2cab924b@jic23-huawei>
In-Reply-To: <20260428-ad5686-fixes-v3-4-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
	<20260428-ad5686-fixes-v3-4-9cff7bd67a15@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:02:19 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.
> 
> Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Backed this one out again for now.  See sashiko review.
https://sashiko.dev/#/patchset/20260428-ad5686-fixes-v3-0-9cff7bd67a15%40analog.com

I took a look at the ad5310r (unhelpfully called ad5310 in the
majority of the driver - something it would be nice to fix!)
and there are some real oddities when comparing what we send
to that device with the datasheet.

Understanding not helped by the bit numbering changing on the
datasheet between tables 10 and 11 :( Feel free to suggest they fix that!

Anyhow, I think sashiko is correct and the stray 1111b will corrupt
the command bits and maybe even the reset.

I haven't yet asked for sashiko reviews to just be sent to the mailing
list, as I'm still personally getting comfortable with how accurate they
are - but I'm thinking about it. In meantime please do take a look
at them as they catch things like this (assuming it is real!)

Jonathan


> ---
>  drivers/iio/dac/ad5686.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 69358dd66cbc..b31d0ec5415c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -25,24 +25,35 @@ static const char * const ad5686_powerdown_modes[] = {
>  	"three_state"
>  };
>  
> +static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
> +{
> +	if (chan->channel == chan->address)
> +		return chan->channel * 2;
> +
> +	/* one-hot encoding is used in dual/quad channel devices */
> +	return __ffs(chan->address) * 2;
> +}
> +
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan)
>  {
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> -	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
> +	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
>  }
>  
>  static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     unsigned int mode)
>  {
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
>  	guard(mutex)(&st->lock);
>  
> -	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
> -	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
> +	st->pwr_down_mode &= ~(0x3 << shift);
> +	st->pwr_down_mode |= (mode + 1) << shift;
>  
>  	return 0;
>  }
> @@ -57,10 +68,10 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
>  static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
>  		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>  {
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
> -				       (0x3 << (chan->channel * 2))));
> +	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));
>  }
>  
>  static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
> @@ -82,9 +93,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	guard(mutex)(&st->lock);
>  
>  	if (readin)
> -		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
> +		st->pwr_down_mask |= 0x3 << ad5686_pd_mask_shift(chan);
>  	else
> -		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
> +		st->pwr_down_mask &= ~(0x3 << ad5686_pd_mask_shift(chan));
>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> @@ -464,7 +475,7 @@ int ad5686_probe(struct device *dev,
>  {
>  	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
> -	unsigned int val, ref_bit_msk;
> +	unsigned int val, ref_bit_msk, shift;
>  	bool has_external_vref;
>  	u8 cmd;
>  	int ret, i;
> @@ -489,8 +500,14 @@ int ad5686_probe(struct device *dev,
>  	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
>  
>  	/* Set all the power down mode for all channels to 1K pulldown */
> -	for (i = 0; i < st->chip_info->num_channels; i++)
> -		st->pwr_down_mode |= (0x01 << (i * 2));
> +	st->pwr_down_mode = ~0U;
> +	st->pwr_down_mask = ~0U;
> +	for (i = 0; i < st->chip_info->num_channels; i++) {
> +		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
> +		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
> +		st->pwr_down_mode &= ~(0x3 << shift);
> +		st->pwr_down_mode |= 0x01 << shift;
> +	}
>  
>  	indio_dev->name = name;
>  	indio_dev->info = &ad5686_info;
> 

