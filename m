Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F03FCB34
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003828; cv=none; b=LZ6zhkClI0PX0CBnGz4GDwu8IfRTv5LXGo6siRBT73sn/PD6WVcCtPjCZWPNKy9xes5ypBQu5quTMfnQCzn29hEGQEVj8Tljv+YkZrt3wWb8536s2SYzvkI66MS5oG+0H0MNcEAjuZ+5w/FS3+nQTdroj8C+yRT4hCiwjVIq3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003828; c=relaxed/simple;
	bh=LKxo0fMd2e5AxYLGvb9IhES/FecwFKryZEiDRHJ+mlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRuYV6+6vtmfawx76XPkc6ITqerCKiD+Mm+gKW0nHlEhTkLCszoE3DSZNCXKmRk5j0ECzyoAd+gLXKMOjCckiVB8b7o5iJS3eRo3v21T11Y//FWf0CaUvKR7RiAsv732TebaZM1RyC2rId1FjZnSFFiwLDvzf6D3FI+lvVdQjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZubZSRdo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZubZSRdo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6924a68e3f3so597498a12.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781003825; x=1781608625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0R1/uOav6x+N5u8la1mzmW5tGVKOxiRp9V60pMgD0IQ=;
        b=ZubZSRdofBGJQftKMUc5iy2QOJ2xfy7ayJgwhOzg3sJji291iZd4dFwgRIADlxzQT8
         /xeEQ4OAYuH7rkpf02eXFbCvdRzHuxMoTK4czdIr0shQfADihfMDpSYxQrV1xK6HatI9
         QsYh9fDuffomalsZMEY22EZAvMpJoztvnb1kx0DaIK7ePvHCWw41T6/R+ZrFwIcPLYMq
         wDCFeZli5C0ZbXIVyStenJFJzu6rm2+yYxtoAXkI84NmfoWtedZaGPBZHRJEFMSjU1kB
         TZOlMUK+9aCPd/BdWmD3XJ97+g8jNkr1jIPDU1AYYN8+WYNG6do3FH31ypWwrxHXfp8L
         bmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003825; x=1781608625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0R1/uOav6x+N5u8la1mzmW5tGVKOxiRp9V60pMgD0IQ=;
        b=DV1dJ5CBjDcZPopd4bBtB8wvJZsO6aLYFtiEfJoANlxz8e6x/DO2qqYvalV3MOsgiD
         cQS1R9ZUeVT1RCZQJ9EWPboh8+xtzygWQN6U0fajn0//8iurdG9s7WApgLicHXBFQIEh
         5V3tjVl/TaXXiiDF//03SWtVSSK5DvkuvAcd1wTQGZ2cvXeJDYTiT+veQVonE9AIx/MU
         qTkrJL0MHxjrgEbXXGjcgFxTXKwAybrfApECG5T8pdfK9HQsWFqM3+/VjtvpsQyph7jm
         NF+Og9n7vPmnY63DwKW+Qs+/U4/kzn+5TpdWueQzJ7lDNrbVwVkRYQf+icjfeGXLInBp
         JQhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Pufr6rEKf4Ca1a1NsNwc+yVpoGxI3osHBxKOQNXZ7DPI9dZx3x2IN5qGqGEQUPKUKGggOZ/TurwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKRjh+Cf+XtUuHKlmx5yGHH+zqf9E62rn6EZpzT6mZOm2fogE
	LY1GQ/NdAxFI/42n6bLkvuupuOX/nahTLNczzTSRJtZkkdb9YtW3D/Wz
X-Gm-Gg: Acq92OEYlgZlrxZ8OVW+5PZwOkGIbJ1OANKqQrlc4gzm5CVBvZLQ/GnstHntKOFiomc
	IADGhEylIihuJZZPA8/E75R+WKCh5yXQ9rnMv88/w50NxPlBcDsARtEkD6HyFPZ8ctXUCcIP32B
	WwIzLa8Hgg16jB1FaarJtDZAEfMAaWRI/49lTJhpbACzXwAu6ugnDS26e0PXwr9AbBt3nk7PDzl
	fsVlYpS9n/AR3taRj2mQNW2QZ+p8WSnDjc9XEV75AsaDWhCu7UitQpOKTEgseUzYzBabCIuIqXR
	0psxCCrWNLNTcriZhRaCSKtljAYnDyNTpq3Bxs3b3DbpyGBPKkVDrG54a8NbiPD/3+78vLdumxM
	pZedZjtPO/+5og5BVv2iV0DY2ZuABJsbfb0eDlZCRGqV6DYRVn+S24qNJwAktGqqxN10gtB8dL3
	TzlwOIjb1OIZW4Q7GnBnVRCeswVXb8PwLJOuEVSz673hfO90+Qj0SrPvMS8bRxjWTgxt+SM9pd5
	GitV1UL56viHrBXsHwJHyZcGMUa3WRWg9ER6S8ZDZ1oJU7M1eZIeg5MPR+8
X-Received: by 2002:a05:6402:3905:b0:68a:c316:34fc with SMTP id 4fb4d7f45d1cf-68fa4e27b23mr8291432a12.9.1781003824324;
        Tue, 09 Jun 2026 04:17:04 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f34asm8762792a12.4.2026.06.09.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:17:03 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 9 Jun 2026 12:17:01 +0100
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <ltafhuqwbdnj7qadn2p5f7exwcpz4fvr5jaizj7q4peqgt2x4b@z23ss3usjskv>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>

On 09/06/26 10:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Premature reset line deassertion during power ramp-up due to the use of '_deasserted' combined with a manual pulse.
> --
> 
> commit 61717352bc99739a9f89195c3320a934e033ad38
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: dac: ad5686: consume optional reset signal
> 
> Add RESET pin GPIO support through an optional reset control, which is local
> to the probe function, and include a delay for the required reset pulse width.
> 
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index fc3863274b291..700798b80f044 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> [ ... ]
> > @@ -506,7 +508,15 @@ int ad5686_probe(struct device *dev,
> >  		return dev_err_probe(dev, -EINVAL,
> >  				     "invalid or not provided vref voltage\n");
> >  
> > +	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> 
> [Severity: Medium]
> Does this prematurely deassert the reset line during power ramp-up?
> 
> Because devm_reset_control_get_optional_exclusive_deasserted() automatically
> and immediately deasserts the reset line upon acquisition, the reset line is
> driven high while the power supply is still stabilizing, before the 5 us
> power-up delay has elapsed.
> 
> This creates an unwanted rising edge on the reset pin during power ramp-up,
> which could cause the device to enter an unknown state or latch up.
> 
> Should this use devm_reset_control_get_optional_exclusive() instead, which
> does not modify the line state during acquisition, allowing the manual toggle
> sequence below to safely reset the device after power is stable?

It has been discussed that it is better to get deasserted and manually create
the reset pulse. Will move this down (after the fsleep(5) power-up time). Or
better move this up (before the regulator enable)...

> > +	if (IS_ERR(rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > +				     "Failed to get reset control\n");
> > +
> >  	fsleep(5); /* power-up time */
> > +	reset_control_assert(rstc);
> > +	fsleep(1); /* reset pulse: comfortably bigger than the spec */
> > +	reset_control_deassert(rstc);
> >  
> >  	/* Initialize masks to all ones */
> >  	st->pwr_down_mask = ~0;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com?part=6

-- 
Kind regards,

Rodrigo Alencar
