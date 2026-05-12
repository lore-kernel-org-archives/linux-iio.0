Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF6372040;
	Tue, 12 May 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588528; cv=none; b=XxOrArrLbICmbAazPn5woZVaXqGSs/tVf0dGsiF/5/MIesqlYgrhT93To145qkXekCOB5A4l7kst57+xChSTlPZ3g1z8QNQkjtdYom9+Gdh8/U09ACMK7oD58vcW3Lp6Tixi6DtzW5xixRHKdErQVKloMjtu/iyNcCTPwgrJ4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588528; c=relaxed/simple;
	bh=5EqOkln7bOpHF2bgg8vSH6XUnlawHGp/WCBO5drJOws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHiCHu43lqWQjFYVSCF4gEFjQDRzcQFezCEVaAAfy3W5L/o+1MYGlXHiOFQln18HPtLj2P7I7+pj7E1ELKTnp/WzDZ4TDHG5fve0kTsC6VNxWLvtThFoIKxwMF6xRAEjjuOtmlhNWmMQUj96Oxu5W/YmgH9yP3Dm6z4G0c0J5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOWBd4Sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOWBd4Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F71C2BCF6;
	Tue, 12 May 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588528;
	bh=5EqOkln7bOpHF2bgg8vSH6XUnlawHGp/WCBO5drJOws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pOWBd4SgbsDN7PXxVnvLHEhUbz9EhVEBke4QX01Oi8iK1yscdDjjvtztztkzSiBgp
	 Kg7ItQuPiBiFuLgKWKK2Cc0QtJDmoXWsQP74DMG5grQrsZVkF88fj/dD3pLF8ph96L
	 Qv2coinn0CIgR9kCtbzIx7H94iMXt6OOWv3LgpiAEyJJqniFctMEQNhjN4inbP9XbZ
	 gfhyXht+dwJOOx/d3LfVyxITKBNbmst34BE/Z20uIh/wNI+mHJnPatKMSDRIvM5ud1
	 QIqs7Ff1XTBUYxEc3Ze6K4Y0e+NbsMhLlBwz64dBCWNZHsyM/3jwPzp18C1zFmJM8o
	 3uYjWwWZqWWZA==
Date: Tue, 12 May 2026 13:21:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 10/11] iio: adc: hx711: pass iio_chan_spec to
 hx711_reset_read
Message-ID: <20260512132158.628a9f41@jic23-huawei>
In-Reply-To: <20260511174342.123820-11-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-11-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 23:13:35 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Change hx711_reset_read() to accept the channel descriptor directly and
> update its callers accordingly.
> 
> Split the existing HX711 channel-selection work into a small helper so a
> later variant-specific change can add a matching helper without growing
> hx711_reset_read() further.
> 
> No functional change.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Again mostly for my reference (maybe put these under the --- in a patch if we've
discussed it before) the sashiko warning on v7 is a false positive because
we never set the active_scan_mask bit for the timestamp channel.

One day I'll tidy up that index so it doesn't mislead analysis tools and to save
a tiny bit off computation checking a bitmap bit that is never set.
Entirely reasonable that sashiko didn't pick up on that oddity!

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 0db2d2db9242..183568196d52 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -269,7 +269,23 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  	return 0;
>  }
>  
> -static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
> +static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
> +				   const struct iio_chan_spec *chan,
> +				   int *trailing_pulses)
> +{
> +	int ret;
> +
> +	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
> +	if (ret < 0)
> +		return ret;
> +
> +	*trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
> +
> +	return 0;
> +}
> +
> +static int hx711_reset_read(struct hx711_data *hx711_data,
> +			    const struct iio_chan_spec *chan)
>  {
>  	int trailing_pulses;
>  	int ret;
> @@ -283,11 +299,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
>  		return -EIO;
>  	}
>  
> -	ret = hx711_set_gain_for_channel(hx711_data, chan);
> +	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
>  	if (ret < 0)
>  		return ret;
>  
> -	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
>  	return hx711_read(hx711_data, trailing_pulses);
>  }
>  
> @@ -301,7 +316,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&hx711_data->lock);
>  
> -		*val = hx711_reset_read(hx711_data, chan->channel);
> +		*val = hx711_reset_read(hx711_data, chan);
>  
>  		mutex_unlock(&hx711_data->lock);
>  
> @@ -391,8 +406,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
>  	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
>  
>  	iio_for_each_active_channel(indio_dev, i) {
> -		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
> -					indio_dev->channels[i].channel);
> +		hx711_data->buffer.channel[j] =
> +			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
>  		j++;
>  	}
>  

