Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8039B97F;
	Mon,  4 May 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910717; cv=none; b=bvlSvJ98Hygpodj0mkW0ZOsPzOsDV3M6lCaEMtDitnukKLZA083nfq6OR5tA6FtujS3AyZ0DJU1b1C8s+vXMQK2WvIsnT3m96u4oL5J9sLGJY89zmqR5Q2eCt/MLnNMKMiOm252zthKOqrggeEJZP4BstL9ijtIRqydLK06WDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910717; c=relaxed/simple;
	bh=lfCKtOn5gBh+SUUBH9z2HRRQ4gOiSVmsSkXV6SYijnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hccOZoX9q6zRM+OZiUp1IyNa83lImf9AopoYUd2h3ju/93HokzGYkDwO1mqT8FPJJ4o2fLwEEuhTFeAaQoiuBJOjifMKt5TOPAd1CCMwECO9TzhPjcu8eEaRBIyHtF0ctm3XEUTq9P/X7tYXew9RgnUmnGo3MzJHF5fnmD76Rw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIMdJA4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIMdJA4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5355C2BCB8;
	Mon,  4 May 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910717;
	bh=lfCKtOn5gBh+SUUBH9z2HRRQ4gOiSVmsSkXV6SYijnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vIMdJA4ujyJ8asuH14Tb6OB3tf2NcINKiaWvnz472Po0hOkA9PK8OMM4NkpmPEv99
	 H6KJd1saKVvKOn8FAN3mUuXxf2ZL+92+xyRDsEiYXPzZniBOaHtf5EB7pnbwDD/LiV
	 S5bdY/tgMogd42j5NYJjQw7wrDkUj+8vgxF1FX1id7QLy9Q4fMdp0AtYN3nii9zV3L
	 sAJJdRZ2DjL5i23I1QzWhfPNRzf638CyCYHGbrd4mz+v3TqzLTH/oNt3kJ0H1qd3nx
	 fTptyX0pTv5p3T5c761sBxQ6nUkZk01TXuKcyiSTbs+vvv8DDX3o45D5vJyGljw76R
	 ZEY6oSIFr4nQw==
Date: Mon, 4 May 2026 17:05:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/11] iio: adc: hx711: pass iio_chan_spec to
 hx711_reset_read
Message-ID: <20260504170507.590724b9@jic23-huawei>
In-Reply-To: <20260503120949.80292-11-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-11-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 May 2026 17:39:39 +0530
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
> ---
>  drivers/iio/adc/hx711.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 98fb617ea32b..2229df17f350 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -269,7 +269,22 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
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
Really minor style thing that I'd have left if you weren't having to do
a v7 anyway.
When you have a 'bare' return like this that isn't directly related
to anything other than we reached the end of the function, my slight
preference it to add a blank line before it.  Some kernel reviewers
will insist on it, I just consider it good taste as makes the return
more obviously separate as a logical thing from the line above.

> +	return 0;
> +}
> +
> +static int hx711_reset_read(struct hx711_data *hx711_data,
> +			    const struct iio_chan_spec *chan)
>  {
>  	int trailing_pulses;
>  	int ret;
> @@ -283,11 +298,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
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
> @@ -301,7 +315,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&hx711_data->lock);
>  
> -		*val = hx711_reset_read(hx711_data, chan->channel);
> +		*val = hx711_reset_read(hx711_data, chan);
>  
>  		mutex_unlock(&hx711_data->lock);
>  
> @@ -391,8 +405,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
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

