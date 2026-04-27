Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0282765D4
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=pass; b=MhQDOhzkTkz2pqqT79Z5QsLNJD3TEUcEucA+gri/8OXHc32+qvJcfP5goCsMi1JGV5oqilZVn87c0YU9mqZku56nsvvbAhyyhjA4Sor3btgxAeADSdFBgXgZ/E8EYuxlbm9itNBIF3+JKnmvD9LrDvxdgsymWSiNgSNQXgVJLwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=779Q1h8lZokAu2leNrYf5FaZQtvojipngO2ogdm0ejc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crpp5xhdyEAfXJaNs2Dqu19BmHJDbZhOTZLRpl+/xekUd9Dz0K5tb5YWgiIV+LPiOevFu3rLz2YFP5Ps2wy4sPzaLAJC8jR1hxs37U/u/ijcIoUVA+zz0RC8Z/YuIuwY3C27dnyOq5ngraevKmvtFPmq/yStlVane2pOe05IlYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmwf4GvP; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmwf4GvP"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651b71f5cffso1208016d50.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 04:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289409; cv=none;
        d=google.com; s=arc-20240605;
        b=XQvyr623t7zPj9a/9yEhTh87A4etblLfskzbt393OIj/wb3KecwJJQaJhGWUJTVlDU
         JgO+9nyPchudchJXm6i6KkqYu2/wP/mNyLlqi89E6IF3OSKVP1tgKov7W8M8fcCnPzYD
         M//bddSIW/3ltyvU04rw9UXFxN02GW9GQ7cZP8a9NKHQhaceAxmxgz5+iwSxufImE4W+
         3l5+SbAjJi91Z0tGvt02P2xRbnxm7hBUqLtfcMT4I5dO4/juBmbRZATxASxmZVEzLnTN
         6iS39p62/egGUYJ7+Rcu+IcrB4rJfdWirUH1HHsmYZK3xxQvUqdJQ/F66igmJrHYi3gr
         JQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fn+eCqQ18h0FcRITaqNoFwNcJcgkc90n/rg6OwMedeA=;
        fh=EDCreXpUbZ/Pn14jEEgEPC9+/bBzJ+5UaUgvSxfjd1w=;
        b=VDrRt1V19/n+EBb4hSIN12Z8vJx9DA340bsYf9FpF4rIqN+OsGNETswopnd+YZzqPy
         MV2PQld5NhyN6jEbj8SeQDjBebNRQ1XQyP9zHiqKqKgpf7kt2AhIOhuesc28W/BTeEFR
         cWx7QT7cBEytQDE4vkHtw1D9zlaUh7aWtw5S3Zx6N3LjJdWAZx0TJRqgZLpwouDUdX8z
         pIN+q/R52tzbA90Z7NCXPEDgVvZnzi6L32LiTtkKUjWlUwiXq/L178IJPFYYC9bxC/J4
         5d5uzsjRSmG7rC6FarIeeN6wlzPPfMiM0T3ouWg5uq3odfLykX8n3X3Q5G89bL5PRx3H
         lLmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777289409; x=1777894209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn+eCqQ18h0FcRITaqNoFwNcJcgkc90n/rg6OwMedeA=;
        b=jmwf4GvPxFd/U/RUngRx+L4hBVh62HNQNz0buW7dCoh0T+kCYQubMaXDCMDFNWCU0W
         kw0DcgVGlhkw1KrnHY4af8JRAAHmx+qEm6NUGlJgZqKIwjA649DaVZoaOiNW9lG2CVqc
         18MkqIJGFr9cHrZN62noAIa0lsLzV/woItEjTKbsQahD3XqWMUBAJczJ63gKTtaO1RTW
         bTJjuAEWhvJD3oGZcw3+ZpDq60Ceeuew5+r8bKQxa2vfXjIX0nlmeD42J/6aFWnkHeGY
         ZTIfbtd8q9v5gAn1+36D900Wqo/v7wXk3W+U4FcjjRlUQXZxW7JXv7jZzXc6MvZ3n6cg
         Uehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289409; x=1777894209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fn+eCqQ18h0FcRITaqNoFwNcJcgkc90n/rg6OwMedeA=;
        b=UW0acrX8w907tr4zWUACAxzlH/r46ZDT9UxgAOjf0Ug5oVpUWAqUcolqSi9MZ50VFK
         7fuMJLti7wX7vRNFoUiCnTt0ljejPBdoXTdpGufkIy3tr/d6dPgslm4hDyHPNury8ChD
         bD6+Iuc4ARxX4lANzdBoOtayYawfiea485KZFw1o24Tn7+3f4g2dms42c21W7lS5EhMF
         DLzfA2DZtu+1nCuYOElO3xp+bU7H2DVm6K04al6zlWxWB1jm9MEScKEkRdj/RTwiTFfW
         PuW51a3dYjLvM35HodrYhhqqwvFRq+NiJ5FEI3Gzi97aIYX59v6mK/gkIUaYRXbUJd3K
         HiTg==
X-Forwarded-Encrypted: i=1; AFNElJ8/7h6WIOChBjGU+5mIeHImkTt+IjsgmmXg/gMAIysnezkzyCP1f7OpMRKinPp579nV0Zp92Mozeis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREmK8wNrIkDRjdRGaD7ZMI3WlNmDB76noAa66YaQM5lQM6LKo
	1jlgfSZxhUTcMTdD0f/u4uY3FEY10RQMFli+Ojr67NBiYOQMRrcYP6RDNtbcg9T3c9nG6M8pKOQ
	E+9M403UxeblcimtitbfpyNmg0Q57n8Q=
X-Gm-Gg: AeBDiesZiCoHbCPBkGNOFDJgbxlgnxLIB8V7el7DXFNWt/WtHw3mJ6EC003kjrR50Zo
	fJT0oBLW8se//+sGg2x9DT/tg/U15T2l1EJ8kjV0bs8ZAqlfWnb/eBT/g+v0Jzxp6/jx5rnUcyS
	48rn0JvifW+zsNK+wxDkLIPL3l/HB0XK5azsvAuxM9FybCFCi4mVTa0zdAEAUmQCKLFUmp0p3sw
	k33b8C2JUw5wuoZY/LlmGwEj5I2KcbLEcLX1xP3kh26pOXZY3WwOI5K/QoNfmwC7wllM5hWulv0
	dLv2GPOHT7fQgGs7yJGnfyMOQzvWCIteBE7zqHLeYBfbNHKHxQ5Pyj+hPu5wUqtL8SvOF54fd2v
	5WkKhvliNJS3dIwhcAxDqYIxrXy0A7t+q
X-Received: by 2002:a05:690e:b81:b0:651:d0a5:ce9 with SMTP id
 956f58d0204a3-65310b42e9dmr24160410d50.6.1777289409319; Mon, 27 Apr 2026
 04:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
 <aesyzOMUl2Iyjgjz@ashevche-desk.local> <20260424113600.4e76fdb7@jic23-huawei>
 <aetVGYQcq1NAJb7k@ashevche-desk.local> <20260424175753.2d0ca494@jic23-huawei>
In-Reply-To: <20260424175753.2d0ca494@jic23-huawei>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Mon, 27 Apr 2026 15:29:57 +0400
X-Gm-Features: AVHnY4KxSBBE_IguR9loByXCMGPNb2iKR3t2E0Ai4mLKqym4NCC6RdSBa2lq1v0
Message-ID: <CAE7dp2pUnDbEHPGvxVE5VkaYeV2rEWnTNfdqGaSy1DjZxge-Dw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, antoniu.miclaus@analog.com, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>

> > Why do we need to have kmalloc() here at all? I don't understand that.
> Absolutely.  Locally it looks like length might be large and therefore
> the array not suitable to be on the stack, but that's not the case.
> length =3D=3D 2 so the array only has 4 elements and can go on the stack.
>
> >
> > > This function is just overly flexible.
> >
>

Thanks Jonathan and Andy. I have sent v2.
