Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E1427A15
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516378; cv=none; b=k6H1IuF8zFCBCtbQ6K3L9gWDilAmWtNHt/dwIG+UWrybdthqUSuWzKxYDIviCE2g+OACuDumZocJTJBqXldjNmm+l6ug3HocKp/OtnC7QgsuyRQCiGoT4OmzIhMu+LRG0ZHhRxR0HrDTTUx9oSDQaBRNdW+m6ddX4L3jQay8aT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516378; c=relaxed/simple;
	bh=XnwqT4wyZwsrxFgEJ7buaUw5Z+V2Lcf7k7xB80cndvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJi+yICBJ9l45YFPZh/72ETjvwAeHqLo9lBZY7EsKehXQhNRlJ7IceDWZWJVJT+MMcmRAfFuiLm5IFWsr5vG7Rnq8iWynLrgvLVCXUnfWxXsLdrQM0HWKCTtjcFfcM/VatfcW0esRAloS1vGdJC+tXojqMf3YJ/6XEGb1X03Xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr9OprIv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr9OprIv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bce386d5b85so245428966b.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516375; x=1779121175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFB8aDj4n7MU6F/50FP4Ye00tlcUojozuCe3rTfZpyE=;
        b=Lr9OprIvgfdpMHg+aqakgIgPUmpDDwZLqzj6wjKonqo1n2jQ1pfcSJOjX1sFFnolVs
         JYjHMzyhXfHWeeHl3/QVJaXDoUb0+E9lbK9XCxya310oBsVrXr1+6z7SBHc9j4ZjS4m0
         +kzJ5wfATO34XQ/accRVRonElR0OEfwRecKWo2iq4PbPin3kJnfENGBEi+2mDqu8EgOR
         WaISbXeJKeXHDlFFTej7cqkFPhO34MQn9srW6glWvAPKjqoiKwRPf/qMzDviw8EW/TUy
         uElk6yVJrYpi8S0IZGgGPMj1XjtUo89mnDIeOjlmjVjiDN4GzRIENf/20cwqZaUsPEKX
         U1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516375; x=1779121175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFB8aDj4n7MU6F/50FP4Ye00tlcUojozuCe3rTfZpyE=;
        b=tWA+6DlNHccFcTbQD4gWyzi6aAc6Z9QUSmyf/NU0RuQSnf4r+t8b+h71i2KKH4Bcp8
         5pv+ybwU4036YcVT7PTzRdvDWRCYYh/l3O1I1+K8W+OqOqXW5CBQe72BDjQYAIueBTTC
         4m4RLcSk3lD4sJMQykwwHQGA1dREICAkK88oZdhX5jq18Ar1Z0nTXsppPyyEHFXUsqDW
         jSMFwWjvZ1FGYhik/EzUpvluQZx75tJHsK5z3RmgiKs7cSYpcg73frim8DJvIhRRF9Dt
         23ZS0TyAZdRV79QOsTjv/QEtl6NIvMR9Atdcu/OZSAAOL+m1znb5Pt5of2cOTEGKR/nr
         eE1A==
X-Gm-Message-State: AOJu0YxILSH6XXiczwjUzPpDHYXFvj9RHg+H7uYTwif4gVC9QnPW51qh
	1/QmEAgPPztCRAoGX4ARjx7lbs8viXoW34gF05fHsdB/q7ssGiZAxIVI
X-Gm-Gg: Acq92OGlOhKPNo+d+S+PsPQd7KNtCB2JoNwYWJrr8TeP7HnlV4wh2cdVx4GQUzbYg7G
	r2rYDGSr1IwRhMJphL6bwlMQI+44oTBL+D1ezrVLRS0KYyeuO5RvcxgAk6hcV533DYZ3GyrxzNm
	jy/h4H1ZxuHEQmLJVcMLLOC0Ncjn1Q11TcnAEa8uYYOvGdCtmDwToID2zhl+lXLlCoRFvKqvtQg
	+Z1ptgK30lCWUqF3XJ3GipiCqP2dnsvyKqn4YMKaL6PTWjl1feVWinkjazmx1Vpbwd1suHe0TQC
	qDQaH4gBEwx4YW+kNDtgdr9ym1B+4Kk0sgsFTz2JbsVSR4auRLRvzNkLa3V1dpxVUhCjt52vHZy
	yOegmnL+Sf9ERb8r87tjV/sVPKQwxL8muZieUoOpEXw7DVmQnWDkH0i3IM2pLflGQiRW8q/rzjy
	hrNfANUmqdCc4ys0ewWkI/XorfDriLxHpBcJ/7f4wGo/0jlTL6
X-Received: by 2002:a17:907:e143:b0:bc6:41f0:9b2f with SMTP id a640c23a62f3a-bc641f09bf6mr911998266b.15.1778516374824;
        Mon, 11 May 2026 09:19:34 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bccdd39aa19sm329568566b.58.2026.05.11.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:19:34 -0700 (PDT)
Date: Mon, 11 May 2026 18:19:32 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 0/4] iio: light: add driver for Broadcom APDS9999
Message-ID: <agIBM3T2BEZPFles@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <20260511132112.66246dc8@jic23-huawei>
 <agHzLu-W7MBNXxmx@gmail.com>
 <20260511165310.2c439cbc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165310.2c439cbc@jic23-huawei>

On Mon, May 11, 2026 at 04:53:10PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 17:19:54 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > On Mon, May 11, 2026 at 01:21:12PM +0100, Jonathan Cameron wrote:
> > > On Mon, 11 May 2026 12:14:42 +0200
> > > "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
> > >
> > > > This series adds support for the Broadcom APDS9999 ambient light
> > > > sensor. The APDS9999 is a digital proximity and RGB sensor with
> > > > ALS capability, featuring I2C interface, programmable gain and
> > > > integration time.
> > > >
> > > > This chip is considered by Broadcom to be the 'successor' to the
> > > > APDS-9960 which has technically been discontinued.
> > > >
> > > > The initial driver implements the ALS/Lux functionality using the
> > > > green channel, which approximates the human eye spectral response.
> > >
> > > That's not normally a good approximation unless it is also has
> > > very bad colour curves for green!  Better than any other channel
> > > on it's own but still not good. If we had calibrated sRGB it would be:
> > >
> > >  Something like: 0.2126R+0.7152G+0.0722B
> > > for example.
> > >
> > > The lux vs white light and lux vs incandecent light are fairly linear
> > > so 'maybe' it's good enough but it's a bit of a stretch to describe it
> > > as an illuminance measure which is what we'd need for it to be measured
> > > in lux.
> >
> > the datasheet states: "Approximates human eye response with green
> > channel" and "Uses optical coating technology to emulate human eye
> > spectral response."
> Hehe. Marketing. They provide the light curves that show it approximates
> very well the green part of human eye spectral response and very badly the
> rest of it! :)

haha. fair enough.

v2 will keep thr IIO_LIGHT channel and add IIO_INTENSITY for all four
channels so userspace can do its own weighted lux.

--
jose a. p-a
