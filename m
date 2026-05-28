Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F6278156
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976587; cv=none; b=H9tvB3oBS2u5RFy8C+7ifGgtWQ8oMhT+ZYzbz+7xL8HGbBQmffbo+3Yuf1k/2tmFQ4uzpFpREYo7kwb6Iwp0CrRLXgmcGC/bXxR+Zauky8yWxbTPkdveOKQx39ofY+T/uaR8f/PxonIa3MVzdkgwlcFw16KhqUNMpVigCO9aYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976587; c=relaxed/simple;
	bh=ikJN4+ppf7CAL6VedXVT9Rr0ah5xg0XI8JjcHi2o698=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfPjWO1z8XtwQwocvOO37awO2AtmA3QZuWWqZNukscC8qZ9z1rYuzad0M5pI/nwRor9t0iOJkWf/OtiDN+qhy7hUK+XP/TZwe3fn9H9dlQyS4bRvq2PAainh2OjbgbSS/AYZm27vpb2HSKrKusP3GRSeweiSJ7OFtO7iprN7RWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZVB5wdZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZVB5wdZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ed9336049so2449647f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976585; x=1780581385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZIl+KJ+fQQlmznLbm0KPLsHpzwpU8dKWXm9Uhfft88=;
        b=KZVB5wdZ8jDHgQuJWHY6pp0+Tja+/EWI/SMPJDGBzyxHSaYtIWpaCys4rljse6xnfl
         zi+ox4YwyWqDlGLc3kF4D7MpBOqVI41qor4TD5tFSZ+465w/A/wbvaGAgyoAhvu14hqw
         o5wSAtyGP9NhrUYm8teO6a2erBynU33RnZI9gy4PmSr7wx3VHXNpOJq0ElWrxJNf/koX
         zGwHEGGbfQQ8EauMyKt/6u4XdaFyqnbrCdbiO2D8OSF2vEgFB9tF73sEXUOJBNJLncuR
         IdRKDdu1bO07+eyoOAiBdJCRSyHnBUeGh6+wCuytehzdVc8FYZvzNzASOYyB6XIZklMB
         BuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976585; x=1780581385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZIl+KJ+fQQlmznLbm0KPLsHpzwpU8dKWXm9Uhfft88=;
        b=TeNXYeJzUAKP3A6l8SxJN2S62EN02cz4GAzJtd6yxfvSGHRgfa+9Mbaf7k2y7mZuj1
         unke3M5SUwzPJDqpittJLWCo4bII/1ZC/t+qPMRrQbnI3LG2gcQdpQsMKk7UMETZLDJ0
         mRFIKsoGw4Nh9SjfyNXzliP9x32XogO4TCuyogwTeKUShr3qLIAYX3DIaK3PMkxqUaTQ
         2ZQC6/F15w/jkCWHcG7/cXDBR8JaUIT2LA5ZpvgfgWBJIb07gwhZ/o/3ITJrdOdOySr5
         lJeFC47zb6PUBZt1BkFt+FQz9MnyIS2LLa6PahQELH+ladBvvgcNZ1jZ8FFSC0EDS8rf
         xEVQ==
X-Forwarded-Encrypted: i=1; AFNElJ86nR2Gz+68DujJ+z7g8uIjPudgLrau0VBDkx4UB3hGwZ5/lrj3ubeVncQXkSLOiPvLypQ4lugFZ3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLjSrFZmXTHC67EbkeppYY1BcDf/MKoDmKuShJdfwnjI4g3Zr
	BW+om2Hx11Amryt/hakOh23IOpdcw4TzLfjAI/sLoT+hZqhrpUju3Y9m
X-Gm-Gg: Acq92OGCSkYNmIckcs2zXS+rBH8ohGFyAgns8rLQ05A1opaZatBhb9+Trv07QILgmU7
	suHOxgkurjMcABbixOyQRCRoePD9FNj+zZjJgfyaZEHWn65da3o+WLyZA6HxrsPlsc8ec22Lkk9
	XCCfh0GGUIr/ebzopw7e4Hn8QIZCPidJLWkfMqmf61KmbMpPPDoiq64PgYht0HBKkQjTrF3U/VW
	kPonQSXy/gvPJrKbn2SSwFzb31BH1l/c6a3iG2X2mRvAFVE9qJ8uzU8tgkbCT4trMuNobNt93rK
	dzgEeWLvFR6c/ZAA0VMN0oUKZr2UzigJUMRRIKPFyGtCoRZp3MYu2VX2sVgIy2UBt3dSMzBm2y1
	+q1Uq1HvLxL8RuCO+X770goGNx+9RsR4dPWEtbsc7LK858vs6uNHeBXUBZ4uBv0r6JPR0C9xKUb
	Aj7xlsHWxkW0JJBZbNUe6nBt3DDi70IJJECY6bRZvjeQnpNLdiUWEQS1PgLtAcfPHPpaZqit828
	xg05b5QuuClm+ISBjNhs/9rXbOlD/oRHXADxM8/VzEohNGFld1ppSZUUYMA
X-Received: by 2002:a5d:5f54:0:b0:45e:73a5:e1ed with SMTP id ffacd0b85a97d-45eb36adb4dmr48541589f8f.27.1779976584446;
        Thu, 28 May 2026 06:56:24 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eec5eba06sm2528147f8f.22.2026.05.28.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:56:23 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 28 May 2026 14:56:19 +0100
To: Jonathan Cameron <jic23@kernel.org>, Wadim Mueller <wafgo01@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxwell Doose <m32285159@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
	Andreas Klinger <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, 
	linux-hwmon@vger.kernel.org, Rodrigo Alencar <rodrigo.alencar@analog.com>
Subject: Re: [PATCH v2 3/3] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
Message-ID: <iks556caxplhs2pb4ca645xpuosoa7e4xkzldjfxuziwbz2cta@t7pndtbm6xbm>
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260527184257.141635-1-wafgo01@gmail.com>
 <20260527184257.141635-4-wafgo01@gmail.com>
 <20260528122244.2e408dd3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528122244.2e408dd3@jic23-huawei>

On 26/05/28 12:22PM, Jonathan Cameron wrote:
> On Wed, 27 May 2026 20:42:54 +0200
> Wadim Mueller <wafgo01@gmail.com> wrote:
> 
> > Add a driver for the Sensirion SLF3S family of digital liquid-flow
> > sensors (SLF3S-0600F, SLF3S-1300F and SLF3S-4000B).  The sensors
> > communicate over I2C and return a 16-bit signed flow value, a 16-bit
> > signed temperature reading and a status word - each protected by a
> > CRC-8 byte - in every measurement frame.
> > 
> > The driver exposes:
> > 
> >   in_volumeflow_raw     - signed raw counts
> >   in_volumeflow_scale   - litres per second per LSB (per variant)
> >   in_temp_raw           - signed raw counts
> >   in_temp_scale         - millidegrees Celsius per LSB
> > 
> > The variant is auto-detected from the product-info word read at
> > probe time.  All three SLF3S devices are factory-calibrated for both
> > water and isopropyl alcohol; the calibration medium is selected via
> > the sensirion,medium device property and defaults to water.
> > 
> > Scale factors are taken from the respective datasheets (Table 16
> > for SLF3S-0600F, Table 15 for SLF3S-1300F and SLF3S-4000B):
> > 
> >   SLF3S-0600F:  10 (ul/min)^-1  -> 1/600 000 000 (l/s)/LSB
> >   SLF3S-1300F: 500 (ml/min)^-1  -> 1/30 000 000  (l/s)/LSB
> >   SLF3S-4000B:  32 (ml/min)^-1  -> 1/1 920 000   (l/s)/LSB

...

> > +static int slf3s_read_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val,
> > +			  int *val2, long mask)
> > +{
> > +	struct slf3s_data *sf = iio_priv(indio_dev);
> > +	int flow, temp, ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> > +
> > +		ret = slf3s_read_sample(sf, &flow, &temp);
> > +		iio_device_release_direct(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (chan->type == IIO_VOLUMEFLOW) {
> > +			*val = sf->variant->scale_num;
> > +			*val2 = sf->variant->scale_den;
> 
> Sashiko (probably correctly) identifies that the formatting that the IIO core
> does for an IIO_VAL_FRACTIONAL only goes to 9 decimal places.  That means
> in some cases the scale is truncated to 1 digit losing much of its usefulness.
> https://sashiko.dev/#/patchset/20260527184257.141635-1-wafgo01%40gmail.com
> 
> As such we need to increase the number of digits or maybe switch to using
> https://lore.kernel.org/all/20260524-adf41513-iio-driver-v14-6-06824d9c15f4@analog.com/
> 
> Which defines IIO_VAL_DECIMAL64_PICO

yes, pico would be enough, but IIO_VAL_DECIMAL64_FEMTO could also be defined if needed. 
There will be a v15, then let me know if any changes are needed.

-- 
Kind regards,

Rodrigo Alencar
