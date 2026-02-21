Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DF8834
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632592; cv=none; b=hCmracNzqD9Nj4rRgqpywOOyq30W3Rc1tdwmFj5NRN8kUWdPN87fmHRnIOd03gngnmnYlmKilsA36GkbY/sEZLmuKEcTQXtfR3EDPg/ZdZ1mtmddRkFXR5y60uWRCnixRs8WfW6/YxiwRrX/6gRPWKAYy6KIFqOTvLfT9FgL5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632592; c=relaxed/simple;
	bh=8JNOX9dWuFwDz+EmMsHW8yfFbSy5aoeUIhaCQe4LJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezuNL/03+hA/Ksnsx8RAxrcySwOrRIVC/4mdcKW0A+e37S35ACyQlBOKOF4CHwGX1Xm9wIkpfsmzRb3RsS4EaQ98Iv6KsXrHCYlPi+EBwnb/DpX5RbvMBch2qUhBIslZP9Ty4gsPpXjMIyllyYpFGPD3AcPvOf92TzSngOmg01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIAK9CjN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIAK9CjN"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba90683995so1243455eec.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771632590; x=1772237390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SZ9VJ/eluyKCRvTt3Ztw07OUgb5OwU6SNdkdl2r0CY=;
        b=RIAK9CjN+n058lN37QCxcczi465WJgp9jMXPBDZawoIJ90S+2qP/a6CjpfF8X1f+AP
         JW2DVpdUzw44+zESbA/kDrMUAfbDUv0ytNfDGoY0bxmmo7Xlb36jFwOyfIXq0qEQnO2e
         XxfRaUpfVET+3xLdC/oB4EHvBMKh+tnWwtvRB/GJIzam/YeaFDJbfGeEd7gyX0dFyoLw
         +oG6YJ+AD3o4WuihuwpeHuKXCp3fJwZJIwlHssmtgu70wUwjEal7J4Y4CS24ldrW1tCG
         cb6ltDF1voGiTYWfw73Vv6pfHisC3mzZ6QpJQ9n+pORbNblHO55J9uArvjEsCLIpzojG
         LoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771632590; x=1772237390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SZ9VJ/eluyKCRvTt3Ztw07OUgb5OwU6SNdkdl2r0CY=;
        b=cpdSDYbJT+SrX+QnQq4Y9J7AdTcua+pTgzGwaE8BPoFP23gEK6+s77CRNSrhdSh9Fg
         x3gEottdlKi80RKbL3rvq5TmF/ECsMA+yHMITYAbroNnh0jTXc+QnljXrg2lQ+ctMZPp
         pZxcxCvX0T3l0klJs49KTiWQP/hLXfI84tURYBYvI7x8132R410l5rSzIfG/4GEa0bL6
         gQw3shmE3s0arsfbzZJlmJ8NQkxzlTPhZObLAaMnhBFbq9keYxQKNdEKmRy504AyEhDq
         VWvB4GRDR1yyq53mNZE1EsVV+Weh+RT/ZVGEbwrZXpSOzFonDCBta0tZbBnDyH0KoY5Y
         XWrw==
X-Forwarded-Encrypted: i=1; AJvYcCU1HFhAM9BHMJZzGrCxsyv5fDwk4ZFwvkjwaq7i3aMsvyxmgozYNW5CaFakqex7pXGUKM/UJKlDSHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRE/MyweJpeqTk1C6uRYkTxCvt/c39tmWbuVXC4e2KiA+nB3r
	yI5y7diSt7vGxBvHO9WmeZAASzQzQJhgRZKZHZRyKuqLTWmP9y3zdoZurDfDng==
X-Gm-Gg: AZuq6aKfUhmXGJUDKwmAB85FW5/PMjcF5zIdZVITLhUwLFTCz0gQVgollTEb8wqxYuY
	/F2sq/yY1Ry1eMK1/ltsXl0rI8JZ5A7z88EWQl720DBkcLBOTp66Q6Rp7g0EfiFCZTrDqsUlJSm
	8s1fZ3o2apJx1wu6WGa1asulob0KqAgfvaCiPHsVk7LuD3P+Fv0sUSQqNBvvjqzsH29pY6Cz3rd
	uTpNGDl0IlmpBX9XwrVHhFvcwKVQ+rnCAnOtc+67ZgcfTsFnTAL/9dBd/sZx9FFmUWQFF7mLcQY
	YwcMyOlcz+LdNnrs2LduU9f6tvbJS7PP6BZwetM3wsAvzRNx9dqY3E+ypphD/BsEG4OK6CgkOki
	Lq4kYrSpymclZh9Nj4CwOF1ziFmgedNQAL2dqOHdpiwvUHCRq+GMxno/LAv+GeEDCrwzdR5qgTW
	kVxOzXQOX5WJRsScJF+lnKWkALiY2yy4k953OPePcui3qynCpkmNRj15uo2qBrpT9h
X-Received: by 2002:a05:693c:3009:b0:2ba:7b2a:6a5f with SMTP id 5a478bee46e88-2bd6076dbb8mr2561244eec.8.1771632590304;
        Fri, 20 Feb 2026 16:09:50 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:30e0:64af:2b48:14be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc35362sm408486eec.30.2026.02.20.16.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 16:09:49 -0800 (PST)
Date: Fri, 20 Feb 2026 16:09:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: adc: ti-ads7950: complete conversion to
 using managed resources
Message-ID: <aZj3deh1Em1rz3au@google.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-5-dmitry.torokhov@gmail.com>
 <aZbC51ezuaT5Nwq7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbC51ezuaT5Nwq7@smile.fi.intel.com>

On Thu, Feb 19, 2026 at 09:59:35AM +0200, Andy Shevchenko wrote:
> On Wed, Feb 18, 2026 at 06:29:28PM -0800, Dmitry Torokhov wrote:
> > All resources that the driver needs have managed API now. Switch to
> > using them to make code clearer and drop ti_ads7950_remove().
> 
> ...
> 
> >  static int ti_ads7950_probe(struct spi_device *spi)
> >  {
> >  	struct ti_ads7950_state *st;
> >  	struct iio_dev *indio_dev;
> >  	const struct ti_ads7950_chip_info *info;
> > -	int ret;
> > +	int error;
> 
> Unrelated change.
> 
> ...
> 
> >  	spi->bits_per_word = 16;
> >  	spi->mode |= SPI_CS_WORD;
> > -	ret = spi_setup(spi);
> > -	if (ret < 0) {
> > +	error = spi_setup(spi);
> > +	if (error) {
> >  		dev_err(&spi->dev, "Error in spi setup\n");
> > -		return ret;
> > +		return error;
> >  	}
> 
> Ditto.
> 
> And since there is already dev_err_probe() in use, I would expect this
> also be converted.

But that would be unrelated change ;)

> 
> Would be also nice to use
> 
> 	struct device *dev = &spi->dev;
> 
> to make less LoCs and/or make them shorter.

I actually dislike introducing such temporaries in majority of the
cases. It makes it hard to follow what device we are dealing with and
does not make the code significantly shorter.

Thanks.

-- 
Dmitry
