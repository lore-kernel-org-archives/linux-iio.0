Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5640584E
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112572; cv=none; b=d3mVndx2rzdaLyHLOWyaxeZlYlUKHTXR2qOnvPRsOHS+x2WRc1KkOuIyNmU8f8TTSPkfg0LWuq5ppbVeGmPGeCA3Y3FbCaxffgCc7ZZvyeV+xyp/3WfRSJrdAvTbkILhkpBWE2hE0pRTXXNHTaVrSr1NgHP7/0V/racHSrQj2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112572; c=relaxed/simple;
	bh=7PYWyDB4Tn7TiZned7wl4oL9ZhY8sxerOLPnB7cvazw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJnqD/uUIU5RkKeGPc+creqjYgQmbwCHOVItX3Jc0dQU7rD6n7OFpSA0iUROLc/UsIYYV2OUwVcD3MJ2M2JySOPh/RN/T4cb73mjYUlzLQxnBKT6goSrZZ+9lP12lEAR9Y10fSTXUBAwBKttUjkyvyIuQMfAjZoI2v8NboQBuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBeiy9+U; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBeiy9+U"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-453903ee4adso2000152f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112569; x=1779717369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whA3HAwlP3oQO6TDs3gsI4mQnJoVp09bWwnO3EouNKY=;
        b=QBeiy9+UTTEbteNqeXJieqWp1wZhMJA4y+nOietgMO6IulbXZzKc4YeMV00VVReR35
         Ln71jmNGWdLoeOOUravE3b51kAlWU1LShAX3mG3HgrRDKScB1zLWNpXhHU9qUtX1fBqD
         /pFlEqv3PGcznZFMqcRxvRT5aQ3v3ct5wvg08/XCTTXWx7YZ0yb1n2IPWwqHt+o7pg5h
         g6tyRrYyCmgHu4KV24KNQUQCSN6/SDEgNvImRKfaVLgbNUdC629LK67Yi0l0HMOeH0Vi
         j0lPselblh8mecmF4BWN1vL2bEsnk6fvcn6R5aLlO3AJlWwUm0QqcP8292dilrBcizSm
         WBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112569; x=1779717369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whA3HAwlP3oQO6TDs3gsI4mQnJoVp09bWwnO3EouNKY=;
        b=ZZqKmQuKNQ+4gaxywIVx42RQb8VECcV0qrpfw0Nxu6DH4NgTLIDSANU9WDqXG/SZEn
         s1FKMMcqWEXvzW6/t67nWk3OhjO7Ycr55MUiPawdvU6+I++Vz3C5cTSEPt7VZ7HIPXaC
         TQWbZ8UgFIcBInMWOfWMZabKJtzOzwWd5KMu9EdKLtlAVcsfHb6E6SLI/yeTUnwnHlDo
         h3Ilm583wlFbqQCVPVg/tjB3Wx+ZIeTHopk7nG745N3CYxcz+1LV0zK6H/DpGc9CRxkF
         BqrqxmSjJrs76fz09YIvcLOge42lYS/um69+7vwVu3PTldsSSfWUteEZ3FosxSyFlQ9Q
         4dyA==
X-Forwarded-Encrypted: i=1; AFNElJ+qQfnGzL4fhVaV4DqA4sWpcfSG82hi7FtSsdcBkehpdUcmehxNXKIzjrcgLQUZBagO4qp/wOX72W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMNfpLJ2maeW61Lh4xnYKH9G930Jvf80uNpDTl9OFzQtLb09h
	NoVu6VUx+d6y0XSkoCSnmtIvQER7kYr5YbVRyf93mGNMZsb9FCJoYPGx
X-Gm-Gg: Acq92OFMB1f2EMHwv7dPmClbUIZN1A5duuEYEo0wy0FhZSmxzLXN02RrT30aym5fOBo
	6k+HhAqT2sBGk83CJ0+or/+qeSpJRUH2/wAIJAJkLcibOwNpe071vQZBC+xm50nlwjrWCTEnj9m
	Jwzpek3Yxw9s4L73D9Xr7L6rzhyc3ux65C0mrOLOYq2V036zAlZ89qyQ65IzVCTyNhNbYjDUgrx
	3Xo8N9sENL/sj1RNMyO+tT1LYmp5itKRVLwGvuO+8b54InhD0fLMBRwAmdTzSG6Q+Qio4o1duz+
	67zCE3obK6MswFTRYdpgEVSNa2Z39IAS/vodOabF0Gp8g/7EBsOHaC1LnCz224tLvz2wnpW5zDw
	zQwns6t26CbuGtgf57L0IMXKmi/GFt2MY7U7FIilNBNBxakta2UWucHGnwTPlkuRwr2E40jgCAz
	IctBcZGoGOYXKpqzUrdyCfZi0tgEocA/TWNcvR/uDXo6MZ80mSGY4olJhQomp7XmQE47rIEXvz+
	j30WCPB5qk1k1fP0SvoiusfnYAwNuNYFU9l9HiTF76hxywUdA==
X-Received: by 2002:a05:6000:2503:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-45e5c35e7bdmr23840457f8f.6.1779112568906;
        Mon, 18 May 2026 06:56:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm36551076f8f.19.2026.05.18.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:56:08 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 14:56:06 +0100
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
Subject: Re: [PATCH v5 02/13] iio: core: support 64-bit register through
 debugfs
Message-ID: <unsohuo2hfsa7zzhprfpvtbatmu3guew6jpal7k2wvirpzwxfn@rjb4uz3k5dp3>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-2-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517-ad9910-iio-driver-v5-2-31599c88314a@analog.com>

On 26/05/17 06:56PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Silent truncation of 64-bit values when written to a 32-bit register access function.
> --
> 
> commit 64785a0c1416e2cf718b558aa7a2cc9ac39b2d81
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: core: support 64-bit register through debugfs
> 
> This commit introduces a debugfs_reg64_access function pointer to iio_info
> to allow 64-bit register reads and writes through debugfs. The file operation
> callbacks are modified to prefer the 64-bit variant when available.
> 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index e587aca79b8e7..5c8404efd0a56 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> 
> [ ... ]
> 
> > @@ -429,7 +439,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
> >  
> >  	buf[ret] = '\0';
> >  
> > -	ret = sscanf(buf, "%i %i", &reg, &val);
> > +	ret = sscanf(buf, "%i %lli", &reg, &val64);
> >  
> >  	switch (ret) {
> >  	case 1:
> > @@ -437,8 +447,12 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
> >  		break;
> >  	case 2:
> >  		iio_dev_opaque->cached_reg_addr = reg;
> > -		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> > -							  val, NULL);
> > +		if (indio_dev->info->debugfs_reg64_access)
> > +			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> > +								    val64, NULL);
> > +		else
> > +			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> > +								  val64, NULL);
> 
> Could this introduce a regression where values are silently truncated if the
> provided input exceeds 32 bits?
> 
> Since the input is now unconditionally parsed as a 64-bit integer, falling
> back to debugfs_reg_access (which takes an unsigned int for writeval) will
> implicitly cast val64. If a user provides a value larger than UINT_MAX to a
> driver that only provides the 32-bit callback, it appears the value will be
> truncated rather than rejected with an error like -EINVAL.

Maybe -EINVAL can be returned for that case indeed. For a debug interface I
did not see that as a problem.
 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com?part=2

-- 
Kind regards,

Rodrigo Alencar
