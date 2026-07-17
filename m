Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFD2DAFCB
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278868; cv=none; b=MktQrWD8eR7zMK15wDUkqyTZC+UAI6M6b5ONq3B38YFWR8jdNz1emP0g/GwMEb+3obzD97q+kW09XlulwbFoH9MJSbjKZUJnWm9oe+0+Ci6N9nPfsChOT1AltVSAY3m4xw2uP5nz08sh4ZRMx/YCHYGkkiS/TBg/ozxRH81PXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278868; c=relaxed/simple;
	bh=hBKE11kFXeBhrQ6CVyj82fNMOPBdKff1X/FeyW5jrXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrkeNKuD5VRvFhGpxrnJQ/c+joP6e/uzjTZobKHfGJzukCQok8WXtrsfv94U78nC4v35HzXxihe5T5JyseYxRWfbC3KcA7tM/qDCuCsmn6UxnaV8gxsKDkjtI3KsNQwsh0RcVvQN5Ygjrus1phF7gH5j10abMi6a4muP5xtW2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AoB1YgN3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AoB1YgN3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47dec32798aso7740945f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784278865; x=1784883665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hBKE11kFXeBhrQ6CVyj82fNMOPBdKff1X/FeyW5jrXs=;
        b=AoB1YgN3BoUoVupd5wccOo9HnOLjnPV+PbI1W4PYzWhhtE9ADq+1A6qHN30dXjLDwj
         aSLhtx3ICMiT3rx1vAWdnlZUCBIoUMF3TSPqRJX6UCFslaZ1vnuPsJxd5q+n7truZ/h3
         LNC0JO9n0bQj08x6ZKRqMo1uthZvrj7ufqiOicISdMop1s05Wh3wYDoF3mrDzoM3Waiv
         b6t0jE4Nk2hHcaNg350akvLg1i/KmNRuFWqdzAwlMiPB2xQU3+AcCCE++K5E0MMvHDhk
         GIIHIxKDtUx4RWojeRbGphjgV5yU3Fo9MU16HPvJq2opfaejOtP7jutvllgYWSe4DzoT
         GJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278865; x=1784883665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBKE11kFXeBhrQ6CVyj82fNMOPBdKff1X/FeyW5jrXs=;
        b=hiPNuQTrXPfWgEYEEzIewJSbJ52OrdPRowjOoGuIvldhp1Uvi0m3u8vflyw5wWvz5C
         6KywDJHyRMUSYgcP+Y4ghUm/xOcfT+luKHwqSsoDZIqYVzQCb7tOUF91qU4iBTLXcqS1
         YdnOOWEORSO8zfrdJqDkks/pEj0OYrd05n8UsPzs6va+jSeg3htjowOGm0WniaglmJlD
         FUCIcWBusYsQGJBEw7I9pPhL+xl5UkRP0Sxxj3XSeHFl/+RZP/4H3Y/V2bRrqTruXl2W
         19UhkgHQ3K9EqVFGvbj4G/hDZLc/RMzbHtXzfdwN1vJ1IBIYmHkeCStgm/0y7wfyQ/Xl
         p9lg==
X-Forwarded-Encrypted: i=1; AHgh+Rodbmre78I8DZWN7MAu9esP2bqCvKzgt2AhAJcR0FF8KSEsvp9hqF3xL4smTWqll1CKXx997N6K5Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvvnO+DRJO2nuh42uyERU7eYM/X9dGWAZ2RxNuP5dNfciC1ac
	Ov6CpFaXDcDMab4ERGbAlu8irK7X9J+mMMYqKurw7FyFX2AVMZBN8yX4HK3j9WD3ees=
X-Gm-Gg: AfdE7cnfBXEyY85fEDUpYhjBn4DE5n0KtvFLylX+jQnO5iA4+h9CqOMDOCBLHAztEqi
	jf/GMtf+cFPHcBk6HtiVZKtSZZFBV4EtdMj5yypCPtjlrQbF5JJtcdVOK5xNll6DQXTb6JPbcXf
	pPflT7/LUa3b7kjGxUDAj89cTV3P/vt+/6as0mjxLVZn2STKHZbeR5RUgYLG3tlQLpNu404n4og
	B3jKYVGI+jhkJuf9pIEYNQTIm+yCd9aLKZMX4YBK27tkWAXGJmTi1CCgn9C3Vt8cFIBxq4qJvmp
	bH8yoT5G7ScjWLHthy5eVaqlMuOC4Vmm+cMIwERD8OgceoIhZBu5wPCIEnOWW5XpRaSD7o+hCHP
	hdrUGtxLSwecDGPubfSqcbwrYar/o5vmPWtkPIyRYu3awmksJQIeooM7swCN3oQyGw4B72q68Ac
	CbcOVR4Mq4Suli1Gedq65DTBFlMycKEXNFv/tlrVts+9byJEZMYwfMow3AD7AU8uj9og==
X-Received: by 2002:a05:600c:4fc9:b0:493:ad1b:b38d with SMTP id 5b1f17b1804b1-4954a512d82mr20084655e9.37.1784278864712;
        Fri, 17 Jul 2026 02:01:04 -0700 (PDT)
Received: from localhost (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49549a3e56fsm33414285e9.5.2026.07.17.02.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:01:03 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:01:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: dac: ad5710r: Add driver for AD5710R and AD5711R
Message-ID: <alnu5e8PX3ZjpYht@monoceros>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <20260716-iio-ad5710r-upstream-v1-3-e848a4bb701f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vydgxj5snaasavru"
Content-Disposition: inline
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-3-e848a4bb701f@analog.com>


--vydgxj5snaasavru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 3/3] iio: dac: ad5710r: Add driver for AD5710R and AD5711R
MIME-Version: 1.0

Hello,

On Thu, Jul 16, 2026 at 03:59:27PM +0800, Kim Seer Paller wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/spi/spi.h>

Please don't add <linux/mod_devicetable.h> to the list of includes. I'm
working on getting rid of that and all the *_device_id you need are
already provided by <linux/spi/spi.h>.

Best regards
Uwe

--vydgxj5snaasavru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpZ70wACgkQj4D7WH0S
/k5fHAf/aE3czFNEtV4VL+mdJc3P4dipMfRLlAYu+8AU9xQagCuj0+kceTV2yYjs
phvQS78SLQ8d3eSdPnhv/IskyAKUQW6OekIE4V+47n+2wmFH5zacXD8ZnKVot7CW
dVGNsMz+TZTp5glinIu9QfNaZ1lFuevCPmN7IiBtZ7CogL42KQLWRdVtKIW3iTUi
A2nr1d/eB/zrAMrHZn81mJMUSy7lNg7m+nSXPqvOCynaPubEUFnLUc4NVXmztfbx
/R8IibP5PssuH8fGYiM8wFZ4kb8VVklRjby3Jfepy/C/BRkdI1sVU7kppQNcletn
bxU/qpCVhSGBiSK5FG6p8oPr3wZsgA==
=E433
-----END PGP SIGNATURE-----

--vydgxj5snaasavru--
