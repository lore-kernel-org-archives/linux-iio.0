Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B64CE678
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360095; cv=none; b=Rcacbvbx6uQdzTeBRgRq8WkQ3N2enpgAt0ydP6FlpKXAUtAophlyP945nzZpWpJuoTiHVcCgZ/I5lQGqZxRLCbG+NX95uv3WHpA9LUFhKNXmWihwpHGLO4dGPxcxBA0JiU5KzVkX6/8F3HmtXoY1TskKxLbz8KMUXn5e7NmRV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360095; c=relaxed/simple;
	bh=fzcoyo69KXGefqxSS7X+PXbTEIdF4MESbyCrnQvBXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKo2NyZS78qxi5o0kAV/F0Bb7T3m6G315j0MFRSKv876dafD9A9AKlga5e54bgZjOVQgNzDKJj4gDSZYH7xtyDOg6DHKSXZUsPhfWcnfy8RRTGuVQZA6pTrzaUCdWYCQoMEqa8/Nf4fCrBWh45PGSDA0RrYwIHwQUvOsrfev7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmVcoQ1h; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmVcoQ1h"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccec25014eso300685e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360092; x=1790964892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nej2ob9CdbG1DOfUQmIUHXKCzCnebeOZh/kYsDtKROw=;
        b=kmVcoQ1hfWs9cBttQGO1Jasef6AIuEEjIKAAxzQtD7S1S+L98Qz24z+zyyQhmP3PFe
         KmU9ZCXafI9aJCpWjeeyRDPiHcYSepnVy/GK/3Lg/GHvPQsxkjlcihAYZ1m4/pVHhZof
         Hcnym0vB1nylJGSJnISXQYzxAHBvrfhTpBQNxPDQCUIbEi2BsV/r4eJYC5gXOQYXZICh
         8Kxa6BhZ2w5roEzYzer51izVVSPAgr+f7SOcc+n9rvozoRJ6dbVK6VriIZ5Tx/A/7I6W
         /hkEZ1Xc8fcG3OSV2v127EpYRBb9al5bvRHFCbyV8jHW2+x3R2FeECKPlfTYmGIfGF1h
         KQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360092; x=1790964892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nej2ob9CdbG1DOfUQmIUHXKCzCnebeOZh/kYsDtKROw=;
        b=Gxw3nJxoRpfVoFkCU5nZTzjeelOxNHKlP5cS/PLPdvAqFP96wjaKT3R2qWH+/uTIBb
         vjVZQ27EJWgQ9YHFcLOJ12e/RlEDHoLrcIl973vj/4qq9G8bXVI59d18RAGCRmDPEgvq
         veNSvz24NSEATSzWxQb1YxNL7/A0DXIkwlb0RRV0ANG15X3F2GwcyrEsLQ/UNhI3EV7K
         dTOAlf1be0LD+rCfYsBgvlZXfA5WNcKhpoAD+tX/mZTDYdKtvjSEyQjRfvZDVLLf0btZ
         CS/bkvy38nx3zLJFtOz98l2t5pkygZgFc1Z3T6I0QEqA7PiTLeIWTYMIvhJLsqq0lDip
         6tIA==
X-Forwarded-Encrypted: i=1; AKwUvBwPeBa26Fpo/UJTnJu+1XH/mhXvOnOLMkf0pJwLCIt/3ZKpvnuJxlWL3Lb4L8dotfCkZIsAYhUKFrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kXSjmmnPZLU0GtDcLpNtioJAkxM9aFwH2nNjh1HhaoeBKeM+VB
	kwIXGKB9AXYNtJShc8HahwYLEPbADkvFC3fiXX9Sg8CYKI+DPnoskFfj
X-Gm-Gg: AYBFou0Y4EFCxsfnLvnGS60SwmLcbvsRqRIfQdFswrpUVHt7YhOgdw1L4k+uJnzakf/
	Qif812z5Gb0ScTNR+9w9lxSHSy0JGxAr4QjcjB1qyN3bIhWHU7MbfFrJiZFbMwozN1adGtp9lbg
	nw1wBFkitMm6riap5xR/xrqSdRgk4H5n9kjxa/qlhKKUtAcwTmin2YkhhbLWDHt0Vp7WVFpCHRD
	4/yt1n7hDyb/b2OQ0bK12AVm2W4nAjhND88BW1tUD+GWl9uACTRrx0vKufcDyxysnE5CTJLII22
	HeDK+68kfuiUaEVbM72BvGndeh5ptLgrqcRKnIn+pvXZd5TRvC/fWE0zSAHWplLGE/iEJPQABvj
	zTgkDydwkfqBIIGqNtit/5CuSImcwILoESVkBFJH5gxgg/PS7k4h+uovy10PLVK/fbniB7AJ/qy
	so32WnPbbA2lmQs1qkwJHRzQtrRDFtbuhTFX5PBKAFnAGB/DQA0er/F4HYr4CokSw2WFr9/0TX2
	M3ru6uSVEJHt5lZl552XlL1q3r7No5xQKIBd4SCnJ3UP/q9NcnQ98yW6oa7qIElSm+o
X-Received: by 2002:a05:6102:570a:b0:7a6:96d6:f791 with SMTP id ada2fe7eead31-7af1d3af54emr2566143137.16.1790360092520;
        Fri, 25 Sep 2026 11:14:52 -0700 (PDT)
Received: from archlinux (dynamic-190-24-104-85.dynamic.etb.net.co. [190.24.104.85])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-986e6921964sm1313460241.11.2026.09.25.11.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:14:51 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:14:49 -0500
From: Carlos Casadiego <cdcp206@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Olof Johansson <olof@lixom.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: check reset write error
Message-ID: <ara4pozxB_VzwxLf@archlinux>
References: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
 <20260925040500.0f637249@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925040500.0f637249@jic23-hlaptop>

I have not verified this on BMC150 hardware.

The datasheet documents the soft reset, but I could not find a guarantee
that the I2C write is acknowledged before the reset starts.

Given that, I agree that propagating this error could cause a regression,
so I think the patch should be dropped.

Thanks for pointing this out.

En Fri, Sep 25, 2026 at 04:05:00AM +0100, Jonathan Cameron escribió:
> On Thu, 24 Sep 2026 09:48:45 -0500
> Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org> wrote:
> 
> > From: Carlos Casadiego <cdcp206@gmail.com>
> > 
> > The software reset is required to bring the device into a known
> > state before reading the chip ID.
> > 
> > Check the return value of regmap_write() and abort initialization if
> > the reset command cannot be written.
> > 
> > Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
> 
> Just to check: Was this verified against actual hardware?
> 
> Quite a few devices get going on their resets before sending
> acks on i2c which means you get an error on that particular
> write.  That is often why you don't see an error check on this
> particular operation.
> 
> 
> 
> 
> > ---
> > Changes in v2:
> > - Remove the blank line in the tag block.
> > - Add Srinivas Pandruvada's Acked-by.
> > - Link to v1: https://patch.msgid.link/20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 46bb36d9366e..43a39e1ccce5 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> >  	 * Reset chip to get it in a known good state. A delay of 1.8ms after
> >  	 * reset is required according to the data sheets of supported chips.
> >  	 */
> > -	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> > -		     BMC150_ACCEL_RESET_VAL);
> > +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> > +			   BMC150_ACCEL_RESET_VAL);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error writing reset register\n");
> > +		return ret;
> > +	}
> >  	usleep_range(1800, 2500);
> >  
> >  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
> > 
> > ---
> > base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
> > change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
> > 
> > Best regards,
> > --  
> > Carlos Casadiego <cdcp206@gmail.com>
> > 
> > 
> 
