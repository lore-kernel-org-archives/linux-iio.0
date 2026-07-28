Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF933B5310
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243951; cv=none; b=r67nas2/eknwaN/Tk+RbKFoEWGpBaSnAngZXnCltbjl/qIGVJm1CHM6tJb4V9CwSwOG6IZQdkAvRcOqRA3I1ZJ9pzxK3igSTXnl93KwN6B9KyVG26Cw8i60zRBV2iHFVd6/03a+WGDzUI/72fyJFfdFFQmqWzwdrKT4zRyO175E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243951; c=relaxed/simple;
	bh=r5WSFBmkwljdLSsc/dzbyuBziEidVcP84APtfukq1sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld8q8CZPLSeN9OFe4OsXn4W4LD7LvHKo4bTdGXSeezOmKYaSknFyCojewVeTufeV71Q7fw1PO7xV+hsMcjzmFhdzaQnNPQkaIGZLIeuAouU8mZM5gsqsEccRPS/3DZkozZLwoqaBLJNURQtwPhYbyt+apXgz3/z8MJqkOSiGwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8PhTYo5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8PhTYo5"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a4c6081f9fso803653b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243948; x=1785848748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbV6e6mV/G6JXllO00Yh3iiMBiWEbF5BD3K0uJ59MbQ=;
        b=L8PhTYo5UeFpJ9ul5GE/W8USpc3+oHRIx/CZnWlLoaYDGFnwuC4fgIg04QtSFN+W6q
         4Bv5rffa4u59wpmLtLz8mERN6gjZBCbxX81CHLHbEzq7JQjnOgzEMMsAphEAaRi1xDLH
         dQQCgD0loDXyLuo4fNbQ2jI6R0KJRe6FRUlsZmDVctUT+wpWXiH+n6/L10l2YHIvqu3b
         NcqSf2eeAIjNG3ss6EWGBTUqcQxIZGud25P+r05Zgd7LBlgXCOmD2lqbL4pxhVFCi9bj
         goOXlCNKGxGyJLwkOzzbudQR9i+ezNwkV5NNSVz/1KTrbkgfGX/KIn00Xif63mOka+c1
         vMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243948; x=1785848748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YbV6e6mV/G6JXllO00Yh3iiMBiWEbF5BD3K0uJ59MbQ=;
        b=fGaPJP+SgX0CYX6j8Y0hrvpad1JpXIAa6jbHXd6kmW526IjQkP66g3saUe9zAjoJW9
         DexDZgGC2CwT5Fy0SaHTwaUlHmQAzHqCIyaPQgdzd0SMt0/5I0Cqt+Jjr66tvtKhE+Y9
         Wnv4UxlVBgdNAdO4lc+FAiMt1/mitQpEAFzL43e09MjsREq9tAi/Y6xMY3bysMVjhZW3
         MhpUr6pYKVI93JXg9RrIT3sHGV7tl7AN2ph0b/SvcYal2CgEodaTCeMsQmPpWQrzeOMk
         pIOfhA1LrLe1OxRK+s1MvnnJo2IPa4lPVDglmWeVeB0+Ge4uMzF9fSZSXNNgP0zhEEK7
         sz+A==
X-Gm-Message-State: AOJu0YyUF0fxWAQ2w8u3Ysyf1/MFTXOnEuT5jRIIEREKnPBPAmZh0NPC
	sSfc2bL9JIie7Geo7LyqDSStrOqzGlxeAjGkYH7zeazl+KCvyjW3u2nGeXL+Eg==
X-Gm-Gg: AR+sD11TfiNssykLKmNFBkARmO5gQR2h8SPqsxbTx4x6hcFveGGoAxFcLDB0EXYfxDv
	dDnQACLWl95iq8sriY0g3rG0RnQfjMuJNeQRHG99Y2J2UvQE0Lc+S8Yxc44AaWs/mZ5hSoIkXs1
	M4Ieri0ck+yhV2B8XDkSvhMhZ1AduY6zfzFXf3I2BwymslbUBWYF8U+vObsjajkxsalcMG3H/Z5
	I6MvhuAo/98xuc0FRGF0STVhD1rz8vON6WNIuVI47sMEf4Tye+vFlqDC4tp2tGa/kn47F4bvcUb
	5LUl9JzKQUA5Xerc62RdWFjdTP8Cbt6Kc+q6vB6B51PB3H60CLxhcsqkJFwmuGAVy5nUqK74cB6
	6u+z6VRrOhoT7h2DLu1NqorDZCZitM1VGSkIkw4qvn1nakYtgjuzOL+hYauQxlla3NusuBHOODA
	EJSF5MjywgdJs=
X-Received: by 2002:a05:6808:14d4:b0:49b:c387:36c5 with SMTP id 5614622812f47-4ad5b9c0d7emr1443628b6e.17.1785243948253;
        Tue, 28 Jul 2026 06:05:48 -0700 (PDT)
Received: from localhost ([2804:30c:2739:da00:1cf1:e457:fa41:ad98])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab5d917dcasm8030680b6e.16.2026.07.28.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:05:47 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:06:53 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	robh@kernel.org, devicetree@vger.kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v9 2/6] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <amipbdc0tup9x3e2@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <6cf0b5541cce4816877ebe754ef7fc2f0e30039c.1785186980.git.marcelo.schmitt@analog.com>
 <20260727214213.D377F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727214213.D377F1F000E9@smtp.kernel.org>

On 07/27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Holding CNV high during SPI transfer breaks 3-wire SPI wiring mode.
> --
> 
> --- Patch [2]: [PATCH v9 2/6] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs ---
> commit 4d4231cee28f9742280dd61ed84f85cf3b4e0386
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> 
> This commit adds support for the Analog Devices LTC2378-20 and similar
> analog-to-digital converters.
> 
> > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/iio/adc/ltc2378.c
> [ ... ]
> > +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> > +{
> > +	int ret;
> > +
> > +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> > +	fsleep(LTC2378_MAX_DATA_WAIT_US);
> > +	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
> 
> [Severity: High]
> Does holding CNV high during the SPI transfer break 3-wire SPI wiring mode?
> In 3-wire mode (where SDI is tied to GND), the SDO pin of the ADC remains in
> a high-impedance state as long as the CNV pin is held high.
No.

> 
> Since the CNV pin remains high throughout the SPI transfer, could the SPI
> controller clock in garbage data from a floating bus?
No. That would only happen if the controller runs more SCLKs than the amount of
precision/resolution bits (non-offload use case) but in those cases we right
shift by _storage_bits - _real_bits, discarding any potential unwanted noise.

> 
> Would lowering CNV after the fsleep() wait and before calling
> spi_sync_transfer() correctly enable SDO for 3-wire mode while remaining
> compatible with 4-wire (CS) mode?
These devices don't have a CS pin. SDI is tied to GND in the currently supported
wiring configuration (single device normal mode). There is no SPI 4-wire mode.

> 
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > +
> > +	return ret;
> > +}
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1785186980.git.marcelo.schmitt@analog.com?part=2
