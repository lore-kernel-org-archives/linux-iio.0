Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF343F9F25
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302855; cv=none; b=UQlo17Xvzzktt8RzeqpmK2buHWfQfpZJahHyO6P4XhJO67aJP7HLYIiDzsJSelgzXICNJAC/iTghD4WMQaYPjz5rBkGI3zzl5YSGARp8tw1bicP0I5xi+gWWEQMOhTXkpGmPvCD9kJcapIfHF+X9OmmlbeVZKnyFnoUgVmY8PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302855; c=relaxed/simple;
	bh=GtWAvNoa8liocTFIE29GV3PrLzqRKVIbyQdAYPsgXsg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPb1VHBcOFLNqm63FIV8xNvi+4FpZN49s/ni0MuB6+Lx80enHAV7e64dGYRq9Pua1sabcu43EWdLfF3Inq/LqQG5iHUO01mQG+5yvbwFvPz6KF38pGfPxiilt0hrGHNEqQDUnsg2rWdOZG5XOlwk9OTPE+Ygm50+5cI5nv3N/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQAVt12I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQAVt12I"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44e1860558fso3331757f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302852; x=1779907652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hEwaR6TEFLYShpta6veHoxTDP0ik8niJki4wmQa0RY=;
        b=EQAVt12IbPCrpc2rNHDrbX2HJWDPnRSLUJ3LwZMumBGjkgVcHLhN2JE9sX26byQqM1
         fJtY9osxEJydypLMFZKL9mJiMD4ffHzmJ34EkXWh/5fEUCH/OBA8ez7e01BHYSddZz05
         rzwzhq0tbdwbyM1J3Q8Mpmsx0og6xco2+KF65emtihqCh0DSxwvTZ65KsbJEurlYeIYz
         kmA7J7vdlWQvKbGaDCTNlxlDS8bu1/HnSRkBIjvPPwK/jM+L3dOfcvz2tryfa8/pFCHf
         n1w0lZxOVFwootJB/FmqRSLNDJKg6seXTr4UN3V3c+1SbJVyqm7q42tHtdzqkOGRlzVR
         s96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302852; x=1779907652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hEwaR6TEFLYShpta6veHoxTDP0ik8niJki4wmQa0RY=;
        b=GbIsWuB84YRIVltKzE/u71wbcMZotqPZcPoR5Y2dxSUCHXDOk286DFR8en1og8+PpO
         MiyfNwiPuC1EBEnUtNCsSIEY/ZdNi7wU2ie/VPVS3GQZ5Q9Co00EIey/bUUGEpnJCNE3
         aPFX99LCuTq/WgmmOEquVdOv0IP6YTgB8yq84fbhIJ0QUKvpUPrHsLPJgjbNwDWaeGPY
         t3hfm1cuKBHTQ///U//1DLn4IJVjbK3qI8gteCRTqMo/+kDLsNIPN8qhbtH5cKR1QCE5
         EpsGw1AvTkS9lNTDRHa9MI/8yD/qG+EhK71opGiHKDCVrHFOxH9qw+1ALex69bmFKHg6
         mc/w==
X-Forwarded-Encrypted: i=1; AFNElJ9U5NdDnZanZHB76Nk0kvzcyqvSwChbzsAIGrxjbKQlDUOWo5iRKYc7P3glCKFpi/a9RRgjcoh8pfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoemIEnc2FURc+8pXOm4/1g+qy5cvO/n0fhfP75skJcdbPC2r
	VbThz55B+zVquoMZPL92BlUL/MrHbGt/Qm9cUV+NuSTzR5iwCPVxuK5TBQB1PMsx
X-Gm-Gg: Acq92OHJ3DHYRvcX7PQCIC39X+1JFtMUhmNGNwudp0SFlfoEbnfFDxfvlKEeTRUpZqg
	KKm/U0q4g0Y7JSAPQUC78n3+GWQUkiIqiVWQ+AOOdP+OFx8ZkyHdqLV/rJeM7O6OtUPg64uOmDB
	OkzO5dUhTmda5W0xbtZ3RUaIsUA+NczfGB2Wa6zQ0tU+19nzeNQSRMUTrFwQBQHFr9ysgyNA+H7
	3tBF0PZ7vPGWmQzqHYWS5SplbsJ4SZIfF48Fm/9JpSXYVvFRXEriZAnYDxI+xlPANdo2pwpbpsB
	O6Fn7rEQURpg3TR1z8yYdNd/O83NrZ7mF6qonm4XUzKn7H+5ibJKSFnhOh1bcmI8zK02CS/0puB
	xOb4KIv10NYHexlGZ0383r82lsc0L5ZdWl65OuukcUNa72hQFrvm76qubCrrztqpjDSc2Mq/cye
	7v1I1plAaLoMaEkGpXgN7ghNlTE9VWCI2l2f8808esye/35r9uQwBcne1dmjGK+5slBrRLmZPO2
	LqWQ+q0gMa4dwRFHngi3a6/UXGdA28VwN+qEBdhzeuHMVRkBMKwtj0odecT
X-Received: by 2002:a05:6000:2401:b0:43d:7275:c1eb with SMTP id ffacd0b85a97d-45e5c5dadeamr41206197f8f.39.1779302851879;
        Wed, 20 May 2026 11:47:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm56929827f8f.12.2026.05.20.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:47:31 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 20 May 2026 19:47:25 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 12/13] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <vqqvn2cgs3fbp5mq6xfac7iyosaqfrvgngqur4x355a3at7slo@ylrtd6fhi33a>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>

On 26/05/17 07:37PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> control Parallel Port, Digital Ramp Generator and OSK parameters.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows frequency control through buffers, this
> +		represents the base frequency value in Hz. The actual output frequency
> +		is derived from this offset combined with the processed buffer sample
> +		value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows frequency control through buffers, this
> +		represents the frequency modulation gain. This value multiplies the
> +		buffer input sample value before it is added to a frequency offset.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows phase control through buffers, this
> +		represents the base phase value in radians. The actual output phase	is
> +		derived from this offset combined with the processed buffer sample
> +		value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows amplitude control through buffers, this
> +		represents the value for a base amplitude scale. The actual output
> +		amplitude scale is derived from this offset combined with the processed
> +		buffer sample value.
> +

This will become just offset with altcurrent channels. I noticed we have a IIO_PHASE
iio_chan_type, could we have a IIO_FREQUENCY too? Parallel port needs actual raw
frequency values in that case to be written to the dma buffer.

Then we may have buffer capable channels for the parallel port:

out_altcurrent120
	offset
out_phase120
	offset
out_frequency120
	scale
	offset

Problem is that the math for the actual frequency output is:

	f_OUT = f_FTW + (f_RAW * FM)

where f_FTW is a base frequency (already scaled), FM is a
modulation gain and f_RAW is the contribution from the parallel
port, which is the already scaled:

	f_RAW = RAW * f_SYSCLK / 2^32
	f_FTW = FTW * f_SYSCLK / 2^32

so the above becomes:

	f_OUT = (FTW * f_SYSCLK / 2^32) + (RAW * f_SYSCLK / 2^32) * FM
	f_OUT = (FTW/FM + RAW) * f_SYSCLK * FM / 2^32

if I make:

	SCALE = f_SYSCLK * FM / 2^32
	OFFSET = FTW/FM
	f_OUT = (OFFSET + RAW) * SCALE

That would work for a IIO_FREQUENCY channel type, problem is that both
scale and offset would depend on the modulation gain (FM)... I suppose
scale should be setting that and offset assumes it is constant to act
only on FTW.

I suppose we can keep altcurrent for other modes as phase and frequency
can be attributes (knobs) for them. However, in parallel mode we are effectively
pushing frequency, phase or amplitude values into the buffer.

The polar destination is a corner case, but can be solved when both
phase and altcurrent channels are enabled. When that happens we can
change the scan_type with has_ext_scan_type = 1, so the 16-bit data
bus is split between the two.

With the above, all of those *_offset and *_scale custom ABI can be dropped. 

-- 
Kind regards,

Rodrigo Alencar
