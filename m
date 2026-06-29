Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7C3B5847;
	Mon, 29 Jun 2026 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773483; cv=none; b=lONvGdAL3Uib7WqodfZRPRe6CgQzaOzw1rHtHH61u1A6M3mSSSK6L6kR8CDqwfM7pS9Aev2PYdBS/QJMHIcQw1RzEsHEstBUjGL5NAN2hH/ONvOtb5CwAwEcvCvnWYzZG7u6S3X6sdTC3h/uIEdLuZq4r8FNOJ8ONJdI/C8qcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773483; c=relaxed/simple;
	bh=LZW1qfwUK2Tw7XDdZagMVR+r8D6EptW893M5SIKMDGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp5xiH27YYPsUtIYHDLjvncqDfTKWAkXwdCFop1Bw994Mk4QZ91WsTK6DEWcP58ertkCXFNWGpVAd8PNUQe1MRUmq7trikt0HHvM9jf5NED/hZO6j0Wj8NRU8RfeZRWJ7Xwb/EvQE0Bep+4hBBIIf4p1zikGB1j++pdcAgVjBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acUPanfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acUPanfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7AA1F000E9;
	Mon, 29 Jun 2026 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773482;
	bh=5zYMBreOiWJj2aMnbmrkdiGcL/9YjDpSnQAT3SpIfbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=acUPanfWpMA6ecO3oZ6HG2rLJFEpyDuLjiqE2Fzm6ISxTn6AOAqSxSSELFKYR0SPa
	 xZxjGAv1r4ngr+V4/KKEeGZb3ZMwUQ5uqg8xTncEx2ayLaBsL1MoGlvtyPlmP/7DjO
	 LoC4lK38boxNG9Y6BteDrS1NB5G/SRpTA+LsKy8Bnrj90IeFWgQXhpYKaf0jHkIATf
	 twG2x9vPe2Hu2x7ufroamLpEfVw/JqmJIz88G0fRZDUZtreyylNihFWjIdcxDpftNP
	 o47CxiAnyf9nduzUwpB5dbpYBWrQ6aO+3J3XnTU0ruQCnvyacnVmaRMd4ot5jOi3Ap
	 uouE7niLK+i7w==
Date: Mon, 29 Jun 2026 23:51:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260629235118.1abc4067@jic23-huawei>
In-Reply-To: <ajpO9zaZbIl3x1uC@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
	<20260622221550.374235-2-jakubszczudlo40@gmail.com>
	<ajpO9zaZbIl3x1uC@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> >  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
> >  {
> >  	unsigned int i;
> >  	unsigned int size;
> > +	int ret;
> >  
> >  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> >  	for (i = 0; i < size; i++) {
> > -		if (ads1100_data_rate[i] == rate)
> > -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> > -						       FIELD_PREP(ADS1100_DR_MASK, i));  
> 
> > +		if (ads1100_data_rate[i] != rate)
> > +			continue;  
> 
> This will look better if you break here and add a check
> 
> 	if (i == size)
> 		return -EINVAL;
I just saw the result of this in v5 and wondered why?

i is controlled by the for loops stuff only so i never == size.

I'm not sure what intent of this comment was.

I am fairly sure what Andy is suggesting is the following..


 	for (i = 0; i < size; i++) {
		if (ads1100_data_rate[i] == rate)
			break;
	}

	if (i == size)
		return -EINVAL;

	
	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
	if (ret)
		return ret;
//note that we 'could' do what some other users of ACQUIRE_ERR()
//have allowed
	if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
		return ret;

I'm open to hear if people think we should allow this or not.


	ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
				      FIELD_PREP(ADS1100_DR_MASK, i));
	if (ret)
		return ret;

	return ads1100_poll_data_ready(data);
}


> > +		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);  
> 
> > +  
> 
> This blank line is not needed as they are coupled, but I don't know if we have
> an agreed style in IIO for this.

FWIW this feeds into the commented bit above.
> 
> > +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
> > +					      FIELD_PREP(ADS1100_DR_MASK, i));
> > +		if (ret)
> > +			return ret;  
> 
> > +		ret = ads1100_poll_data_ready(data);
> > +
> > +		return ret;  
> 
> As per above.
> 
> >  	}
> >  
> >  	return -EINVAL;  
> 

