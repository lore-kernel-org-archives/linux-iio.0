Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03722F49F4
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408461; cv=none; b=GjZ1/pp1Vz/Py1mXq0jxWHQWd9vCAx7Hc5zymFQPIPOc9HAA4n+ToJ1sObUBWNtiTmbBF1fEF9Ki9Hxf7J2L4bNH00QaN/Dyitbi3o375s99AEhxKXe66o0aP2SuT0RuODo/ynUuJ2GibY8NocFPvvPUnzgqDKNAlppZhM5ZHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408461; c=relaxed/simple;
	bh=fTdvT9L9lkY2cBOC5Au5MZwyFqY4qCif1Pwb+FDDmeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkTvzr8rTwNueQh+mh1vJCwC5QszZP2trxeDgUP6SgByTvA3pGg7soBJm6n1OLAc9Pi9akRnlnVnIUytyAMubTD+u9jsuq7RU/tTt5ZTy/kfQ0YDGF1JRWCUxbH92B5HNrtf6AXEFfuexsuUhP2/SoGeh5gFooX0LDytoBvnAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnBDZqli; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnBDZqli"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352c3e74fe6so345084a91.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770408461; x=1771013261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7zhVi2pCvQp0g0zHGUDNUrgeJhf3EOI7v9q5ENZWro=;
        b=dnBDZqli8LrbpHlRnOec8dr2Oi76gXO+EtBJGmTgv43LySAT1Mc4kTyJCvgLKNBEj8
         jsd7v+n+hfyXNejFyN/0JXi5a7XAU9e/fjh063TWAcvPjzAXxVK6d65fx2fT0i86z68T
         lDitE2qMZ8OICYS/iN627Hco2u7btrNkEqm+B9x7txEJpxTxK1bmYNXV4aDJpmKXvJwF
         UYhaHeAHq1wFUezSA8BU9AMeVrSV6jZdp+fOACsilPPs/DXdmJY52PNqk3OIoTWySOXv
         kpq3MhplTE/R2yHMGgj/77lnxh1kVWAm+pZhC0JP9fz6XonbpCH68YVf9woxUjFYDeOK
         8AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408461; x=1771013261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7zhVi2pCvQp0g0zHGUDNUrgeJhf3EOI7v9q5ENZWro=;
        b=pgBIV/DvTw5Vgr1+n3ljdhEtnLyvlEHtidfIrsVX4o0DCLfwN9I4OSX30h7EsGdTpR
         yLeyfzbXUcG6tqfkmv6/PjepxKSkSedwyPOUmNae2Q0RRJpl8PUeUg8VPtqdS//F5dgf
         YmUvlgRCmVCjG/Nv5X2WtEPUfofchJLb2Y2QHtcV7MEVuryglRnNoC7LVTGdNcGhvsaf
         nE96zRcyMiU4LhzFd4KkIhfYS7m9amGbbIGTrsxFESRA3DisT/4h9qwlbRnym83tRYUF
         6z8bO0erV7gt19loQR8p9/fy+wJdd1XzDyK0A5c/BHJfOLNnutCYwE1zYoZwSl4TaQCV
         KStA==
X-Forwarded-Encrypted: i=1; AJvYcCXmuShJmXyb6ZTMOGTWOXQFcEEbjkLSx0WXdZnUU17KHZGEc0gR5Zw/HRn9aXJr+9VSZvs6lHwY3Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAUlhXSD1OniTivcCdO2eokgWV0h8lI7pXsjD8KMTBUqiVKbE
	arS4WiOjRvJyJZG1sVxG9bhY9zRQilUStEF3hfywvyzO/6/qjFR3h5fh
X-Gm-Gg: AZuq6aIPa3XsDhq5PDmv5j++gs6hnwqQBsesFokpGqjh3OM7a3vccFt+RJUHJtxdhuz
	U4nLNi43MIHLSgv4DDEik/PcdNMkgRHrz6JdxjAUdWxyZ96cTNI6CU3VnJMJnn6EspShFLyFzzg
	FHVOPq3B+2fw5p05hgauGfjc3XQc5s+S8vga/6CmyekITY4whn+ZMna6vqp78Ei46Xb4SBD2L2V
	zbGdSjxKdvesqx0806v5aqqx4mNcbP71GZoMo5cpsYL6vm3JmLDDfPxDUk3Wd5uKg7z4JcN/79T
	k/8qo6VACkSAt9vU65dvmMPxDMWoDN5rtqeDxWcNgduoIcGMuoj9ppDBkQwAwsTghkiItzA8GaX
	5qtRVmXQclzhP00Kr03oCz6jLHcAnxTC2BoF1I5QNB2W5aUZpYj/QFh82+89f9IjKjCJpcARkdX
	JQZkBhfQEkxBzR5ZwbzzGaGzR/QJ3KAszViVcUsSNvznLC26VhwBzJ4z6cvnwaJyfplAgW3tTwx
	LwLwwIsais=
X-Received: by 2002:a17:90b:570b:b0:354:9dcb:1943 with SMTP id 98e67ed59e1d1-354b3eaf97bmr2523538a91.8.1770408460836;
        Fri, 06 Feb 2026 12:07:40 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com (200-100-197-209.dial-up.telesp.net.br. [200.100.197.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549bf19230sm6414887a91.0.2026.02.06.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:07:40 -0800 (PST)
Date: Mon, 2 Feb 2026 19:41:14 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ad7768-1: prevent one-shot mode with
 wideband filter
Message-ID: <aYEoCscolCfvasJ9@JSANTO12-L01.ad.analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
 <fc00e0592c79bd301cc29dc36731241ecadb9f53.1769889074.git.Jonathan.Santos@analog.com>
 <4eacb9b5e846b74df5ebb02f1c77135fb1b2fa0f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eacb9b5e846b74df5ebb02f1c77135fb1b2fa0f.camel@gmail.com>

On 02/04, Nuno Sá wrote:
> On Sat, 2026-01-31 at 22:35 -0300, Jonathan Santos wrote:
> > The AD7768-1 datasheet specifies that the wideband low ripple FIR filter
> > is only available in continuous conversion mode and should not be used
> > with one-shot mode to avoid malfunction and incorrect data.
> > 
> > Add filter type checks in ad7768_scan_direct() to skip one-shot mode
> > switching when wideband filter is configured.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 8d39b71703ae..374614ea97ac 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -463,14 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> >  	int readval, ret;
> >  
> > -	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
> > -	if (ret < 0)
> > -		return ret;
> > +	/* Wideband filter is not available in One-Shot conversion mode */
> > +	if (st->filter_type != AD7768_FILTER_WIDEBAND) {
> > +		ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
> > +		if (ret < 0)
> > +			return ret;
> >  
> > -	/* One-shot mode requires a SYNC pulse to generate a new sample */
> > -	ret = ad7768_send_sync_pulse(st);
> > -	if (ret)
> > -		return ret;
> > +		/* One-shot mode requires a SYNC pulse to generate a new sample */
> > +		ret = ad7768_send_sync_pulse(st);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	reinit_completion(&st->completion);
> >  
> > @@ -496,9 +499,11 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> >  	 * Any SPI configuration of the AD7768-1 can only be
> >  	 * performed in continuous conversion mode.
> >  	 */
> > -	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (st->filter_type != AD7768_FILTER_WIDEBAND) {
> > +		ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> 
> 
> So the idea is to still have continuous mode running and get the latest sample after
> we do reinit_completion()? If that's the case, why do we have the one shot logic? Does
> it bring that much added value? Asking because I'm just wondering we could just let
> it in continuous mode all the time.

The concern on having continuous conversion mode all the time was that
sometimes, especially at higher sampling rates, a new conversion (DRDY) 
occurs while the controller is still reading the ADC_DATA register.
I was initially worried the data register might be refreshed mid-transfer.
However, after reviewing the datasheet more carefully, that does not 
appear to be the case. As the ADAQ7768-1 datasheet on page 76 states:

"The register driving DOUT resets by the last SCLK rising edge in
an SPI read frame, or a rising CS edge, whichever occurs first.
-> The number of SCLKs required to reset the SPI interface
depends on the read configuration. The 16th rising SCLK edge
resets the SPI interface for a normal read operation and up to
40 SCLKs when reading back ADC conversion data, plus the
status and CRC headers."

Then I guess we could just remove the one-shot mode.

> 
> This also sounds like a fix so maybe a Fixes tag?
> 
> - Nuno Sá
