Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088C437135
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140322; cv=none; b=hpteJcX5/6Zt4HLqLbCr9JPQJjfIn4Sg40HqUZrv3VophY4IuHivm+bSHPEqXr7WHpw2PQP+VaZn4GFigfzhuY1jqhxBzcAONmfp/KLEdpbCjxC7IXIodcXjH5YitdyLW+S9W5pcJzBXQw+kYXqIalix7RghfE+hA1dSuIl+3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140322; c=relaxed/simple;
	bh=342E++jBLjft9puIOlZ7pk5T2b/w/HbFwx0G1Sda1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKmAybCcvQYF0Q9P1i2uka4YV1SyZaTXVxepMzr6SywWNqCt/PrPbqNPDgsQtgc32eJI7sl4g8NDmfaaKbFosnNlYAeqT0XFrl4JytcniCYPkBAR5JxC3SvbVLzf9hGu9mf9C0BFoR9dZonl3GTSMnEBC2iLWqcMpjYvLZFqmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5OCPpwj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5OCPpwj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso4095425e9.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787140320; x=1787745120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBwot5MAFOKV94xjUQ6DV8U7OVQ8PP20J0qQhKJ2qDk=;
        b=K5OCPpwjjYYEyytJJBbfU5j+xy2P55/MYuyMQQIiJOcUJBAaPPniBZVnlUf4bDrVyN
         0WPwqBxIJFpe8KN5Qo+4LGb6NgWsYKTwuvwxy4F1ExBlx6VY+ccFBINrQHqBjLo4xBxR
         H0FcKYkOI6VkuDdNn14Ma6wk2wD7IaIZg+HH3Pc2bPTA28SZwr20LeMjVkvq4Pr+ak3u
         GtH8TtE4FMYUgBzKYKBXArjbQr/0iRGETpXeRJaCx2livyJkzqfvQwICAcGjhwo+a24x
         AJWlXv466hXVGmwFQfEaCOmdVjPLeAwoBUyc2DRJA5Ki3PB0/8mrYoDfh2ftdgM5/lUI
         3O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787140320; x=1787745120;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBwot5MAFOKV94xjUQ6DV8U7OVQ8PP20J0qQhKJ2qDk=;
        b=bG1o6RNCYrHl/dBq5Vkv/9+Kpj7W5vG5fk2mcDvmFsdgvm8W30Ap1LUTU/yo1Vs2pL
         oGZO0jUF/MxTHbP895nPwFDI/lJkCYPQxl6Xmkl2p5y8q6zcLoha3kj4vMUFvafCEDZ0
         OnjVrUt6gII5MMOXyHvkf8XFhRXs2+WAZnyOvWWfvVWzTzfGj3EWBEgoSmGzKsodoGEv
         ZidWXLaB0JdpS/8vEnK0jcKh4Y4Ihkcw6kWndbFM/ydPezYiZ2Qz/uDcquB0mNxpgalq
         r/Jb04W1OKC+l0PbwJZQP0MVUL7kVjTsmmsfEG+gc6LgDRMFcpZAOzjae69+y+0mEFpC
         W7OQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXyAq9NeCdkZ8c8kwBZ7YOVn6DZfbff5T69soeCWFqwhLAksHAmkVzKyj5JGNNaEuHMenYikno/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sgaXAEV6UytSHEt4MnKMNfcKpNU8WHjXiPUMGGf7jFb6e62C
	9/dbTONMNA3dxV63bCB3QdyAviuPOftJkragvuAU7Fzsw16QgulNnZdW
X-Gm-Gg: AR+sD123bOh6fkXaoefNSt/eUAetXBKx6CbsZUtNNC5dqop4jZdr9R8gEkYxUzzSvQ0
	1KaHQUhwIkndUZnWvbF2lW0HYpyy/Khc33KccQbWHZW1dYGkwRqkBhxVgzGFMIPXle1lyU8DLGE
	NuI8UYYv5fv4Ar+H22S9nHtuLQD5dHdWymj2u8uRJrrOhSIW9jxMiaf1mxRH28zXINWXuQgaqvZ
	XH/E3rCSV5PBZ96HCcd/W1ZD2hjH/lyC/1XU26dFcEWfZe+uGiYH0hEusXwayRHkqiWsx1d8piZ
	yNQyPtNwHSMbm63/gVOB6sz0KZjyJfVK/4U8+rW7Yh7/j6H+GMzd3JbXIqauA8i5O/bs8PZ/eyA
	1m02cwOd7cSK81ElDJz2hNQxmJ/wiso8UAqsHTCVKVUDrTtEFKCdwvg2IuC5UblMDj5jH5iupl+
	xiDwY3gvG2lLnL0pr7ykb+/zw8vNkG++8h71uQpNHElsUHMDyID9HEP8bV3DhxIlE/yenkduKHO
	6dhS1ZdZVQefYsYUTjW5YAxS8KG8/VvsGZsdKZzt7BlFUh+2pnXYCZFg6I1UnoO8MOXxclr5gQq
	Wo87Gn0urPeQsf9pyRQSSPvHNO3zUVP7u5fhVlmrO3+W4Bobe87pmGkMjUXBNRGmb1c7QY5cieB
	IMB3eTnVxWFrfmNifHus+Q6nZY3pp0eoSFgrfisE5NPFZ/nFa7UJY2LOPujwA+KUVXzuYpEAmHw
	+Gvff6
X-Received: by 2002:a05:600c:c170:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-499aa15d8dcmr79633395e9.4.1787140319342;
        Wed, 19 Aug 2026 04:51:59 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d9783sm5101103f8f.37.2026.08.19.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:51:58 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:51:56 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3000: fix frequency divider condition
 check
Message-ID: <20260819135156.00002b2c@gmail.com>
In-Reply-To: <20260819114101.28232-1-salah.triki@gmail.com>
References: <20260819114101.28232-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 12:41:01 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> When setting the sampling frequency, the check for `base_freq / 2` is
> followed by an independent `if` statement for `base_freq / 4`. If `val`
> equals `base_freq / 2`, the second check fails and falls through to the
> `else if (val != base_freq)` branch, returning `-EINVAL` erroneously.
> 
> Fix this by chaining the checks with `else if`.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

Good catch, this issue is 10 years old!

However, you're missing a fixes tag, I think b4 will pick it up
if I leave it here since I already ran git blame.

Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")

+ cc stable

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
