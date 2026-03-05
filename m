Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EA3E1237
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730625; cv=none; b=mcScbTGIWy/FMcCPs0Sp3/m+LYk0+xqofwf8rrOef5vELT9/TsYLFc5HBXRH81vOYuEOvvVW2ovA9XyRs2mMZl1k6BoTFtnNKbfEZZpYCA5LFU/GIL1aBHXAmZ/tjVXMU2q/cnZI18n4p8qNycc1A5atGhhAPK7oLUVXjW1/6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730625; c=relaxed/simple;
	bh=SDqBIWixAtyUYp2BMahA0Ec8JAPIw1TCQXAaz4ApodU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM5LHZg7VwkOSxIcNgSQ7cRU17RaY2lEMAdiosh4p89sJQ7XJIe65YJ3Q7xL99xCtsVI70pWxqyDYZ21uO/+VZH6WNo3Kzfn4o6evDmn+dlvxF5bmBo278AdbkRd3eQqMkYnB1QlNJ/eIojO5IeZe6VtdTReFoIM4oFIFXsTS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt9lrio3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt9lrio3"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so5216147f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730622; x=1773335422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW5l2anCclK6NofmInPkb7vVHPc+6x+zYHwmPeTRZ1I=;
        b=Bt9lrio3DF67OpW2AoBneCH7HkciZxG7Nqv4yLNRvxx/bX6NHs19NmAWDp4s2dj3Dj
         so4zG1EbnCc7n0wPyKiNgywuPh5wLXvS8apg1AOG53Je9cKz0CBIVf9HVfjtdwU49ghq
         e9ZuE6ZMfmM7KWCn/gyAKTOsnmYTWmpkrs8GPVAKeOqgrRlPF4S0/y8JEweALt4+5f/d
         tx8noABqMDNhd2mafMTbB/SAdYIli9alQscRH1Ay+sPPdLR+8jVJ23e7rVZK/jFxHHe4
         BrrDWTlsfS7/vHZEBVbrPgInqg6yE7ChmxPd1y87ZGTS9437mETkh8HSWfckBRwhJytR
         PwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730622; x=1773335422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW5l2anCclK6NofmInPkb7vVHPc+6x+zYHwmPeTRZ1I=;
        b=nQWJj+a8bu9aetpgqZgOmIupPQOsCcspXwBPy8RucBtAbdYSTXlQhBlnI0mJLfCvQE
         mLVbsVx/iFs+L+3Mx5Y94zABYQrLN1QaZjxzRjsZGqC8v/5w9zbCzp2uLvmN9yRBaXjj
         7Zz/pRhvSsrRjYeUPrPhzcb4TyhW+5ueQkApdYxrAH9Zy1Sj/dXVwPUq+sjq2fisMsxT
         bSujIDpj+pNgqor/OkeH6Lqw8tbgTaAEdUH3sALgypWGswPqfoLsHIEfTKkXxVzx7C83
         eUaUyQEVE1y1WkLplrQWYSnSj20BCx/+/dujIsXotazS2IZcbi8I+EjA8AfJgbD3wwTr
         7k7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHJVlIh2107rIbl9kwtBWyCNlKjUBOtNfSMSgAleXyMKREy8AjOAerbJjwlswOESQZnM59e3l+E4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vwWEQ9p94bSxKZs4IwahNDSU/kgTB7ZtqA4T+ySsh3T91RjX
	eWfO3/uIsMY0EqvgXMOSCVU4srzg7mNNB7+FPADEDFofVYBth2xwbfC5
X-Gm-Gg: ATEYQzyp3jXi2ttGj5RwZ2Rj29ypjsnFh9H6M8ix3bZJEwyGwkNiZymWAIF8M6zDEL8
	tRMKFHj01bYEZj4tYKEMGNCC0wga5+ro6gziAzENzKKgHk2XOYUZ76sV2bSU1T3XNs1lay0rWI3
	cI1fF3uNCVbnh+BcM3atVEHH7Hnbh47V4+KLP9oLHW7OBRsoIEDBmNnS2V25UTNLQ2pZ3odSAdx
	rSzUEF0Tdb+pFYtF4dqItqrT5BviYPpWTaOWg2CJ7e8I1uEwNpvXgKCVpR9cOw000bqveMzGuvm
	pG8UMwiAbLAa0lPMy4tFqduIQrqWgCC/EeW7Y4UjqupoRE2Bf894jwqUoQAck6kfxDa+nQ1LsE8
	uOpVI9Hq7/lLtoXZPdeu8vjWHVDARuz5qPp3UhEfMbUpKpbDomKi1gUvPVnVHSEgB3eqFPAg59X
	qmp3gnI9LMbM7kFK9sgy/RRCNtQWW/P0hH2Xco2Q3hTWqEQ0wnaGsbhUj7FKE3PcBuqEKHU8M7W
	mc89UFh5gL2RwzSHn705U8VzWt+gM95tz6sckHo1u+ynpFzDe6KGJW2Z6VvoWKEUA==
X-Received: by 2002:a05:6000:2002:b0:439:bdd7:425f with SMTP id ffacd0b85a97d-439d72477e8mr1054464f8f.35.1772730621954;
        Thu, 05 Mar 2026 09:10:21 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c4489279sm21552293f8f.20.2026.03.05.09.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:10:21 -0800 (PST)
Date: Thu, 5 Mar 2026 18:10:18 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jorge Marques <jorge.marques@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: adc: Add support for ad4062
Message-ID: <q7xddk2cswkfnlmmanafauzmapqrgfe55p3hekqztf24gd2t5f@c5x7l74sf5qp>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvT5FW0hXQwhm_@stanley.mountain>
 <aYX1qCSTSuIEt2GV@smile.fi.intel.com>
 <20260301123429.45d591a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301123429.45d591a0@jic23-huawei>

On Sun, Mar 01, 2026 at 12:34:29PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Feb 2026 16:07:36 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, Feb 06, 2026 at 04:40:31PM +0300, Dan Carpenter wrote:
> > > [ Smatch checking is paused while we raise funding.  #SadFace
> > >   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]  
> > 
> > Oh, this is indeed sad. Wondering if LF can donate...
> > 
> > > Commit d5284402d28f ("iio: adc: Add support for ad4062") from Dec 17,
> > > 2025 (linux-next), leads to the following Smatch static checker
> > > warning:
> > > 
> > > 	drivers/iio/adc/ad4062.c:1557 ad4062_probe()
> > > 	warn: passing positive error code 's32min-(-1),1-3' to 'dev_err_probe'  
> > 
> > >     1555         ret = ad4062_request_ibi(i3cdev);
> > >     1556         if (ret)  
> > 
> > 	if (ret < 0)
> > 
> > resolves immediate isssue, but...
> > 
> > > --> 1557                 return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");  
> > > 
> > > The comments for ad4062_request_ibi() say it returns negative error codes
> > > but the comments for i3c_master_enec_locked() say it returns "a positive
> > > I3C error code if the error is one of the official Mx error codes, and
> > > a negative error code otherwise."  
> > 
> > ...would be nice to have a conversion helper to get Linux error codes
> > from the Mx ones.
> > 
> 
> @Jorge,  can you take a look at this please and ideally send a fix.

Hi Andy, Jonathan,

I found nine paths that returned positive Mx error codes when 0 or
negative was expected.

i3c/device.h suggests returning -EIO. The error codes range from M0 to
M2; only M2 is suppressed during [RST|ENT]DAA (means "no active device
on the bus"), which is already done internally but duplicated.

I will submit the changes to the i3c subsystem after CI/CD and hardware
tests are run to make sure, since many paths are involved.

Note that the immediate fix is not valid, if a Mx code was returned as
is, we would like to return an error still, since that would mean the
target device did not acknowledge the enable target events (instead we
would convert to -EIO).

Thanks,
Jorge
> 
> Thanks,
> 
> Jonathan
