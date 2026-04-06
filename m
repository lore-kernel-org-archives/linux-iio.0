Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BB3B1B3
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775458402; cv=none; b=Lc4iFCEp+mzgB9ceJhgjDjlyK+L9Bkpzolh5/zkzRqAuq00A/TgcVEX4NRBPGPkgXY4v+7T4NRi7gtzq259ShxMvDGSLz5zXYUZR9alxR0IQ1SX4y4mGpcO/d/VX8cuiKVH3AGpNeO7XXMPYn0espD+bLXiIJpxWc7JIDpEoLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775458402; c=relaxed/simple;
	bh=nqk8PywZmHoqBwcjzAa4roi521RE2tTEpUp+nEegfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7bMGHcJjofZlq3tzKBWz3x50MdZiXXrhxr+T2aA5sR1rkB5gDcxMKmt5ofXBQ8QJKdWWodzYVYQs3IVlKO21NuzVCKViRdmefh0LTbpxYqy0gu8ObYv7Cr7TF+cOKYsXUioDtmt2b5aMzfGkfkxvvjQKx4IbY4iy6XRwg6Wd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSJpBlZn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSJpBlZn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so1506382b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775458400; x=1776063200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Gwit8zSJQVOO0HI2APVelm6NDI4k3joD8r90p8JhfY=;
        b=hSJpBlZnbUUVaFV6R5L+mvAqibdPbU/odEt5JuOgVPyksLO5tfgWH7+reH8h1ShTxY
         X3CUdZu1moM9IaW6P9G0VROBfbQdCqdwMN+QeOae/oGyryx4jDOtRrMHqZBHSS8RqRxk
         qTKrEjKvNumt2VjIdzS+ngQzs5gyNUVEW1ByEKK/FLq2S7jBG67d/N+3/q+5RvwrI2gT
         RhcklxJ2neCqKSAB3+m5YRRlbUjoalhAIqbZVEYBMS14i+Y80CgPqD9AgWw6lcN6HNh2
         GuK6Qymb0YpZGx5z617o/XOjQ4ZVhzo2wtyAvbPylcXKLhxpAAip+j2kqmVjtr0mePQR
         2irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775458400; x=1776063200;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gwit8zSJQVOO0HI2APVelm6NDI4k3joD8r90p8JhfY=;
        b=ZqhN070+VHmgSW5AS8DGu/Anr8B6mLf7RtQJLStTmXgN/uwrupaBumCngOg7xGRQfQ
         egHq8tdNTvVaJwK1QOQ3oQhUSyaDdfsJAfUMAkQmKuBK5dIHBZ8c88Yxu++AwpE55MMW
         sakaRbRaL4EG5MxdMZ945wuwXXX9HcRgpIe4ENLOBq9vYX3vqgJb5oaloCY3hWyLxbTW
         k6VTue4uD2LxQ/6o/RND+ecoLVIOTaZPXEDMlrSJy+RHWpDQUXOfmQfRBImMvBxBH9tt
         WE8jEsoZoqAF6rqHt1/7Z1WZS/EE4LuIuVf6bwqiakMBC96kM8SHsOcOBpRGtmztlbbZ
         4I7w==
X-Forwarded-Encrypted: i=1; AJvYcCUkgmQ3mCGcOvnxl/PJKb5wU+y//1bkcQiXNwqgcq7A3mABFJIp+aCa0caZjL7AL10cAezj1yM/I94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+wGNHQdHuOuEQZNq0RcFuECJkvPGYza7UZSTPxoD/N3d4JK9
	3WLz8575bZVp+esNYKv8rkEMAxIKd6XRh86qUlf+dlvLxPjRynDKOYGK
X-Gm-Gg: AeBDieu0wpZeW4OUPmZ+MffEa387Mzz5ZNHdwa+UtnHrAq3nBxxgt9fTGUIrZZCR2+r
	RknpnXasWK9i7qZSbuexT14+O2GCRGxreySldZn6/xKRVj1SKZSSnjHxesPKaYOOxujam5cpbBt
	3rck79xFH/avAfJ/bJP9iMg98pAeJQW9whjLYaoFCh4aA1HzoiSbLsBUd7QjQsszIwGrAcTrZmz
	hrdr9jiNL2fX6JbtovaftBFIl0bMQBzwQ48fQcypHH4GjqONN4HstZWZtyLwMwM6IA+GCGMwjdi
	TDgV4jNHnzDQGH0cUt6KmNRveJpf1CyjT+wMFSLmJUIWDJp8jZ8z8OXlmvEXlC/Y8ZuA2Uv91hm
	yZ0Jj76oXWHD1m+ejEzeG4dyB3FNVXKg98EELG6DHJlnx90WYr3veQrrMkxeAPBPMgbxfMwnfBA
	ffQD2M1zjXpludam+9kVR2KXjgMuskbGiBEx3vyaI=
X-Received: by 2002:a05:6a00:b82:b0:82d:24f:2511 with SMTP id d2e1a72fcca58-82d0da3dafdmr11745283b3a.12.1775458400300;
        Sun, 05 Apr 2026 23:53:20 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c71e62sm12513761b3a.44.2026.04.05.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 23:53:19 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:53:14 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: imu: inv_mpu6050: control vdd supply using
 devm-helpers
Message-ID: <adNYWgzZFmoBW7cj@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-3-andrej.skvortzov@gmail.com>
 <ac01WETv_jIcYvRL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac01WETv_jIcYvRL@ashevche-desk.local>

On 26-04-01 18:10, Andy Shevchenko wrote:
> On Wed, Apr 01, 2026 at 11:27:36AM +0300, Andrey Skvortsov wrote:
> > vdd supply will be automatically disabled on error condition during a
> > probe and on driver cleanup. Since the vdd handling is moved to
> > devm-helpers, only vddio regulator has to be disabled in the
> > driver-specific cleanup action.
> 
> ...
> 
> > -static void inv_mpu_core_disable_regulator_action(void *_data)
> > +static void inv_mpu_core_disable_regulator_vddio_action(void *_data)
> 
> You can rename now _data --> st...
> 
> >  {
> >  	struct inv_mpu6050_state *st = _data;
> 
> ...and drop this.
> 
> >  	inv_mpu_core_disable_regulator_vddio(st);
> >  }

Hi, Andy,

thanks for the review.
You are right, but this variable will be added in patch 3. Do you
think it's still worth removing variable here and add it back in patch
3? If yes, I'll change it in v2.

-- 
Best regards,
Andrey Skvortsov
