Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD162030A;
	Mon,  4 May 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910181; cv=none; b=IloTVljo9kgCQRcYu7nd8sE9ln3+DvUpKaTn9ErQfgJ9uqLaukyypw6ZufBrfqYqgVcFRASPiR5CqcEzKlzYerxXUi2Q+TVABfcERaUPnojXdTEBjv3K8cjrDmOxAaVfnrXRX+4qQ9fg3GMe3JOS/4ScK4xrOL0BX1PwLOTtb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910181; c=relaxed/simple;
	bh=W4Y+REOu5bxW35bMh9al56ELd9ANVBuNvDs9bt7EY4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4p+ciPQZq7zkYfj9ewEmJ7bw6FOxM1qMJ0gZnP7dFHPjjj9u5lZvUS+dUj71k6dRQoeiQKjz4VDIE9bP0s3mcEMqAAUlAd8mV6fHlwiRR1XZqKNsPsz5vmKeMhbyokERy6xfq4W682UfuHzLmxNfsoakMhtlGRZvJv22GbKQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikn6frTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikn6frTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504F7C2BCB8;
	Mon,  4 May 2026 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910180;
	bh=W4Y+REOu5bxW35bMh9al56ELd9ANVBuNvDs9bt7EY4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ikn6frTNO2NyTc3AVlIqiBIYTt5+YARMsLwEk9hOU9j9XWLQcsfjKSd2Offi+3wTF
	 ZPCPOWwh2sn+UovIfnFNA60aaEpvWBG2kPsOH0qfMhkgLscI5ykYeTyIIqRoFZAoDO
	 PZ5HL/+aS85KHTBDUAJegYoXXX32HowAR1218QMbbh3AZVa7juY0P17jIB5tYK/Mvj
	 avZBBuEA2xXgUH5JRAQy2eOca4PSIJ9/8q/YTlfEOBYjPdGOFVjQfTkHIPvvVwt0tf
	 91cy9sdgMzfEF37bFkmLPcTcXAcHNnrD9ukP3krSc6766aBLjh5xq13Yakqq9VXqV6
	 NLKOaCy6T+/Hg==
Date: Mon, 4 May 2026 16:56:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260504165610.1dfc832d@jic23-huawei>
In-Reply-To: <afJWusvDDjuI-m2k@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
	<20260429054544.123862-12-piyushpatle228@gmail.com>
	<afJWusvDDjuI-m2k@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 22:06:34 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 11:15:44AM +0530, Piyush Patle wrote:
> > Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> > interface but uses trailing PD_SCK pulses to select the active mode.
> > 
> > Model the HX710B with variant-specific channel tables and IIO info,
> > track the active channel across conversions, and use the fixed gain
> > value when computing scale.
> > 
> > Also update the adjacent Kconfig text, file header, and module
> > description so the driver text matches the newly supported variant.  
> 
> ...
A few follow up responses inline.

> 
> >  /*
> > - * HX711: analog to digital converter for weight sensor module
> > + * HX711 and compatible ADCs driver for weight sensor modules  
> 
> As noticed in previous round, shouldn't we fix weight --> weigh?
Just for clarity on this following are correct (I think)

Weight sensor
Weigh cell

Not that I care that much give the meaning is clear for all combinations.

> 

> In accordance with the kernel-doc, name the variable "has_fixed_gain".
> 
> ...
> 
> >  	/*
> >  	 * triggered buffer
> > -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> > +	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
> >  	 */
> >  	struct {
> > -		u32 channel[2];
> > +		u32 channel[3];
> > +		u32 pad;
> >  		aligned_s64 timestamp;
> >  	} buffer;  
> 
> I think I still doesn't follow if this kind of changes affects ABI or not.
> Jonathan, is it usually okay to inject more entries in this structure?

Good point.
Using an explicit structure here is now misleading.  The timestamp
will move if only two channels are enabled vs all 3 enabled.

So this should change to instead use IIO_DECLARE_BUFFER_WITH_TS()


Also unless this driver explicitly writes to pad that shouldn't be there. The
aligned_s64 will ensure the padding is there without it and generally in 
IIO we rely on that rather that adding padding by hand.


> 
> ...
> 
> > +static int hx711_set_hx710b_channel(struct hx711_data *hx711_data,
> > +				    const struct iio_chan_spec *chan)
> > +{
> > +	int ret;
> > +
> > +	if (hx711_data->channel_set == (unsigned int)chan->channel)  
> 
> Why do we need explicit casting?
> 
> > +		return 0;
> > +
> > +	ret = hx711_read(hx711_data, chan->address);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = hx711_wait_for_ready(hx711_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	hx711_data->channel_set = chan->channel;
> > +
> > +	return 0;
> > +}  
> 

