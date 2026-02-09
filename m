Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939926ED48
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673118; cv=none; b=b2sqF1pr6BuP1eZ1nvvgQJOyT/EXHeZU0WK2MIhtEfeVivCsbBNTCqgomLHt6Sdaeek9HmbvUOxhEQ005dsDZ8gGQ9x9uCvDxa+PogIfgGiEX9REuKNLZfJAYQ/bCdBtL6M7ki/yxxrA9VVyKbSfKEts+KUZg76Wnt96ELFthfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673118; c=relaxed/simple;
	bh=5GHYEKMlDul7BOm0jgDqV+4gn5HRhQHy4qrYeQfhomQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTOOU4jIKHhHSa8+iz4W2Bz5qXe/QFyGp+ZdzKAFNCQzgXnD+A2hZsyaLt5F69vdbbGgrRv5UZ0a3j8RjybLS6OVA6ViXFE0Dly8TaiStUd3RaYdcTCnOTCGbl9c+4DLlin6RHz3fNQXVeeE4wvUhNKGlXLrs0sBWdNnp/tiVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSzneRZK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSzneRZK"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89470513c62so8808586d6.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770673116; x=1771277916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q102/CAL/7wui07Domg8kQEolGIu9Ft5psDg1cdjPtA=;
        b=aSzneRZKCV/IQoZAC7nu2OnqYHIYxVnLZ2ZH0Qrdnuqgw76l0cJRRBLYtSnbUQlrFs
         Y25VJkHjYasUdcfA9QRQxPXG9hgwuJ1sb4XG1K+d41ORTkEsLvPJ4Y1OzU1am81snKLF
         /+IIB1KJB+UVV29ebBkGbdEjYEVLdGI0sgZQsnLVsJVqJRVz6e3odJe1UDNwAu3quLLW
         tTavBzu4/vcAbqMQ/M8OsOWxnokwNXb9p/qBmJpjYIlaAAe3EZVCM+Zr1O0zsqw8XXFp
         oAMKRitzAj8TJfbQTgSS3nSXMrb8I1wD28ZH0iFUbPQx6H/VmQTyQDzLiNH/BXwEMUuP
         W9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770673116; x=1771277916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q102/CAL/7wui07Domg8kQEolGIu9Ft5psDg1cdjPtA=;
        b=CfbyXBhBziGTt+HQ1k0w0SLz3SDJJcKJ106JbMduQECn9HnX3991Vx2XgjmKcUZo79
         BQOrJO8E9DBckDmJ54HsN73uLPpE5nPQLnShlZx/paqo694yHFBCTIL3xJlgeD/lsSEt
         LoOzMgmhy2MRyV6KeCPnPLiaFvHXWhjco6ir85E74W++t0Me4JUHTD8ojK7jZTI+RLqD
         MAZ4SdvMbcAgq0aHMj46jW3T5YspBx7eUsnOvvIoQWb5ZA+jS/koshJD/a3b1u9/RF3L
         mylWF5Paf5upp5y1G4glvu6Xl6+N4u6mBruNf/gB4VdL0urEy/vNyjaRNDjB3c5rzxS7
         pMnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBA0LrM8XMANKWIN3E4p1UkOTFT2LpflJxy3S3Dr97wYkNaQ0FYlhoO5SWlvFj5cjv1/VTN4gpWx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGZL2C/V8tEnfVB+eDifj725huP6CevOQy9tzK8voU5IA2O5L
	VXDks9lHBZRkeyP0rQUBRM4HAv/pyka7EcpZWdklfTNjweRWYLGUFUvt4fx66A==
X-Gm-Gg: AZuq6aJzNwO8Zwli9SV6xRvzbjY7xjCh8Zs3EEKq3DSIkTKv473xmNk0Iw5inrXEJe8
	+1paGioEtJytLYxIfO/wh5t05EbYHdEBpplJP2hZp6sGn+HwWvgWOJaaKWRLc8rFbuGf1Dpld/8
	nFjGzaop7+Z+466A5zESTamLTPnxWjIW9H90FaeVOB+ihJpWFlbtwhgLw3lrYTP5VF2ZZ27We0V
	kS60q2g+POXYdh8acG8Ga6eU1vbbPp5HWc5dJuMVVj3z+4OqRz+G1xeStEPmVZi9Dp2aA5Ya4ER
	RnfJMQq88EiWTmByg/q6T7MT/ZS+a8bhfJMjrJiNYyYNahNl8Iw9M0f5EEnjmTh+uK95DW11kVS
	9OMXi7326NaSNtPGvBnrQzCP6tNMyY+z6uISBTFstaJIwgb+rLGD8uh11pBKITGPcibf0LmrI0N
	h75wMFWJ2k088+98xq8QA9LtJeBpnGr2+HPKUKX7s8JV9P9dIPSa8PlHdfrCzHlmmTCalpaBuGE
	Q==
X-Received: by 2002:a05:622a:1392:b0:4f1:ac43:8122 with SMTP id d75a77b69052e-506398657d8mr138801681cf.1.1770673116300;
        Mon, 09 Feb 2026 13:38:36 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com (200-100-197-209.dial-up.telesp.net.br. [200.100.197.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5064f581107sm55698271cf.28.2026.02.09.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:38:35 -0800 (PST)
Date: Mon, 9 Feb 2026 18:38:31 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ad7768-1: fix one-shot mode data
 acquisition
Message-ID: <aYpT1zES5la/8TTb@JSANTO12-L01.ad.analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
 <c4af45393ec299d0fbf853fa8ec224f475e5901e.1769889074.git.Jonathan.Santos@analog.com>
 <20260207164851.51874c46@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207164851.51874c46@jic23-huawei>

On 02/07, Jonathan Cameron wrote:
> On Sat, 31 Jan 2026 22:35:20 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > According to the datasheet, one-shot mode requires a SYNC_IN pulse to
> > trigger a new sample conversion. In the current implementation, No sync
> > pulse was sent after switching to one-shot mode and reinit_completion()
> > was called before mode switching, creating a race condition where spurious
> > interrupts during mode change could trigger completion prematurely.
> > 
> > Fix by sending a sync pulse after configuring one-shot mode and moving
> > reinit_completion() after the pulse to ensure it only waits for the
> > actual conversion completion.
> That smells like a race...
> 
> What stops us taking a long break between ending that sync pulse and
> the reinit_completition() such that we have initialized if before the
> complete()?
> 

Yes, you are right, we have a race here. The inital problem was having 
the ad7768_set_mode() before the reinit_completion() because, almost 
everytime, a new conversion is done before setting the one-shot mode, 
so the complete() happens before the expected trigger (that never
happened because ad7768_send_sync_pulse() was not present).

> You always have to do it before what ever ultimately makes the complete()
> happen. Have you seen an sign of the spurious interrupts or is that
> more a conjecture of what might happen? 
> 

Agreed, I can put reinit_completion() before sending the sync pulse to
avoid this situation. But maybe it is better just to remove the one-shot
mode as discussed in the patch 2/3. What do you think?

> Jonathan
> 
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index fcd8aea7152e..8d39b71703ae 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> >  	int readval, ret;
> >  
> > -	reinit_completion(&st->completion);
> > -
> >  	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	/* One-shot mode requires a SYNC pulse to generate a new sample */
> > +	ret = ad7768_send_sync_pulse(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	reinit_completion(&st->completion);
> > +
> >  	ret = wait_for_completion_timeout(&st->completion,
> >  					  msecs_to_jiffies(1000));
> >  	if (!ret)
