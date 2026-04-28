Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2D40242E
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383369; cv=none; b=pjk2BFEe4SST3l5xIyTDYa63s5zxr/W05Tft0dcOAbWydf5Dy+/EGIWg1s9djmoX/A/B18rCV4g+YYAbsCvjYPcoLIKsoWTMbYEjd84S87q0LRvWOUWl88gbgBR0N4/REifzZJ2XxM3PD123uM94rkPqIQjws5L0DQ4xriRJN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383369; c=relaxed/simple;
	bh=YWQQoiHZ7IZSnDOFqtAI6/PWzAs1sY4d/dHrYDvu3yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBJmPqa4gJRogvmjGuG4ZzjYcgvu6eLWXARmep/ci1I/CeGv8OyhypLHYwhadGIpRaTkbI+qxJCGX1a1Jl7ihSptffmeFhFBjIT65tVi/04ovuHdkdU6C6il9KseTuFI2BEvPXsZxV3lLZdhQ/Y7bkq83WgdC+mRrp81ZMvNfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpc4ThK+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpc4ThK+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so138823325e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777383366; x=1777988166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KSUttvaTic5DYL1Jfs9PEfQhM88IfdUsheMHDUliQwc=;
        b=Wpc4ThK+VpbyOP1xtypoQkC6uN5NOTM7dbwW6oEuFLdflITLq0e+fFvtb/lLkeyKX4
         mARKcC57O0mgcKXTfN+Da5b1S+QaRsqVY2ZjosGd5tvtEb10m1gWSdfRwg/SJ2WV1b+d
         wAo1UIqgbD55XmJIAGKf0Zv6laDsbNcl2me+3gH4m7F952L6RTdxDR+slyKShQrO5z8+
         roldJUH7WpyBDjZ8eN4LVxznBQtJWQn+1tUU0Jd2fHd5Xlx/cBjMYaVqx1uSaLrJHtmk
         rykHalCQ0a4rkkzvPz1Nb+dg4gQwvtR2tX3cgNV8Uyr7l08JyeSd3/0aK4Dz1jxCcJTt
         oHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383366; x=1777988166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSUttvaTic5DYL1Jfs9PEfQhM88IfdUsheMHDUliQwc=;
        b=CU2vTSUZf7vBVdjFcWzgGkZGiyOdTeGrlt15Ovvkiu/N5BlRaUvjuoxzWlmRgzQNeB
         YfGJ9vcUWLtpt36NaHvvkGAi4tzjWmeaGUF2arflY0poNEN4x/mrZugEr0/NAhrArd+F
         7krkqE1PBnXJEQ2EbZSW90f8H2x0328YgQnsQkMC5/d2sUt1Q6YJLgELjy5DDVq1D/ZK
         r/8+P4K692cfVptVeaQTJNz2r41fMqKuhyU3gkvl55XYDhvAhUs+Bkubd9AhvMV+G8zL
         bANqhAuBWuTzkF2ySA2DRVXadKVDVjCT+V1ftRk6+ohKZiFWyGk/PF5aIVTtY3OSbVGS
         aBpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/MCApHTktJ4yWnGWC0q+lrl/Inzu3WGSnDRG0GDv4XFHZS6jQEnQmwzWFCo4rHqVo1Mv6LBNEzLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfkw4bdLoWqdMih5IWuSQdpqESQZzt6qSvZpRBPVgdgQIhDmuw
	dTIgjB0XiDW11sm5mpiHGbv3K8xLFbjcbI1QEwj8WGu62x23XXECfWUc
X-Gm-Gg: AeBDieunjggXHhbME8/0NUUKe1V64L/rYurazLTYgBemhmPpG6WDEDJjXSdcgGnrk81
	/K+JtDXehM0ftgitc836tmm3b6mo+8S+K5Tcl85Cwl/ySNO2E7IVQRhOws4TS+8dfIAHQk/Du5c
	0Y9HlX+UwYeP5sLN6HS/V9edwOurtf37akNiz52C01p+9cY/m5TsKVaEYM7zFXipqzm1shbsqGS
	fknETV5+uV9F1HLXnU33XobjFjT1fbL/C92muXu1M1ptmMF3lzTX+Co2NGz2tp2JX6/zi6ocoJx
	ZKsFktxsUhUXsXwbN5KnHTWLsAYsc/vtXnpY6f6matiXdE9WpqP8lyB5Cl96So/dPhQpV1v56aw
	jR+oBieBa5CAkjeH2I5+qX9tDye/S7LQ7I8CTUxrqLAkfot0lMZE5LHa6m16C8uLQhQS71cbkN+
	3MmlkCKiLKJTOoSo7UOiuDPxM=
X-Received: by 2002:a05:600c:6209:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a7ada0423mr7752485e9.3.1777383365755;
        Tue, 28 Apr 2026 06:36:05 -0700 (PDT)
Received: from pc ([165.51.114.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773e70c2sm59774865e9.10.2026.04.28.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:36:04 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:36:00 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: fix wrong scale value
Message-ID: <afC3wHzcwWMMgt3i@pc>
References: <20260428085415.52858-1-salah.triki@gmail.com>
 <afCTYDYCRXoxi37r@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afCTYDYCRXoxi37r@ashevche-desk.local>

On Tue, Apr 28, 2026 at 02:00:48PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 09:54:15AM +0100, Salah Triki wrote:
> > The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
> > leads to incorrect temperature readings.
> > 
> > According to the MAX30208 datasheet, the temperature resolution is 0.005°C
> > per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
> > 16-bit resolution.
> > 
> > Fix the scale value to ensure user space tools report the temperature
> > correctly in Celsius.
> 
> > Fixes: 9ee95ae4cffd ("iio: temperature: Add driver support for Maxim
> > MAX30208")
> 
> The tags should go with 1 tag per one (single) line. Do not wrap them.

Sorry about that, I will fix the tag wrapping in v2.

> 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> 
> ...
> 
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val = 5;
> > -		return IIO_VAL_INT;
> > +		*val2 = 1000;
> > +		return IIO_VAL_FRACTIONAL;
> 
> Isn't it an ABI change?
> 

Yes, it technically changes the value exposed to user space. However, the
current scale (5) is objectively incorrect according to the datasheet 
(0.005°C per LSB).

With the current scale, a raw reading of 5000 (25°C) is reported as 
25000°C by user space tools. This makes the driver practically unusable 
for standard IIO consumers without custom workarounds. Since the driver is
relatively recent, I believe fixing it now to match the hardware 
specification is preferable to keeping a broken ABI.

What do you think?

Best regards,
--
Salah Triki
