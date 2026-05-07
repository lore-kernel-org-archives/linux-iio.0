Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883E3B3BE4
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156655; cv=pass; b=JAexsxEFwOBrH86ermW1DOWqnkyPaNpb6ZVlhSTcdNDyHDUh7EztLqQPCUZ0BS3K56mx2wO1CACmrAmnHfTx1EXMzOxeMvSa37zDzm7MdDX4ya3xNGsqGFwawbRyyh2PV7Y0YKu5f2Ygb2TktQkqHkKZXpH+cIoeVcLYRoqcNkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156655; c=relaxed/simple;
	bh=EsHJHHBt5y4NUdrexGz5/oJH57IF1ck2/R/ya2gXYHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZTaG6bv6SNKuAhZkymbsvxNxX4ftLCHEXJjPIF1JuQPzrV754+rSnJF/lReMJ87COQb9v3ZKIE4kuLJ8T/UMo+RgRQkca+cUd6Livr0qajBVGRdG8hKyzKwtOOJ0mYgrcCbhuD7MKqKa6hCIe5OlhiExMKf0qO7rtP91ox7/qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSR8HVzA; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSR8HVzA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so7814295e9.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 05:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778156652; cv=none;
        d=google.com; s=arc-20240605;
        b=aQWGPyvyqhByunqN0OnBUW7a/Y+Mxw/neTpIEEnQy1Z4p1YejTIU8vCWaX0yx6Nxqx
         bUMil8pYWtvvVLB6vb0aPK0fOLZDPeFWEO4xX9KEY11yQ/YPSyVCGjCMi5KjtmPHzOYv
         OcN5udUdDU+SgwLe0tIXdNaItHm+VoI06JkvWKk6UJLpeLHKblrOeHh9yFu+89niQI1q
         gfncVErv3v0e8NINsod3LjtZ5He5mxvx+NO0GIP2wWOOsmKUgYnYfIvW+TbWxRZy96/7
         77/HfqANWMtlftaKVEy3JvcRGLVrWN2WZjqsO8wRYEG5TJBlVH5gk33QmvESeIcz+PLl
         eRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mWHHBf4Fu0RmnfhTTyveY4EVv/2e1vqDxgbVEw2OIOo=;
        fh=QolMVvs7qwpz8hkgmymjqsmnTjjqTkLhwK8B+WazNa0=;
        b=lMnrwTBlkWENCuicG+xKjBbxk0c/9HEo9SUflsWju/MSJgdpRbcjDittfDzrrXlneH
         kAwUZ1sMEs5ynP5MU9sSSFZtx2DkGrKmuretjKe19HNvgJqBqIViIYPF63JhLg8g0DzD
         eMi/717HcUDElC9TbNohy8ZhcO9sQV79SrlfhMJEQc843+PCor1ukpz+Wt5/Sof5t5UT
         GU0+8EgQJeSMjjEWSHfHtxmjGNoErRQqDvc2nX4tbw52IlLqvDyZlhsGh3t1OKVXPdoS
         mmBfLqGAiYzuAdflntFa7JOZbKWn8DlegW7qZcvodmY+rFEdsnO3nSnCIGpRYXWNJMK1
         5LGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778156652; x=1778761452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWHHBf4Fu0RmnfhTTyveY4EVv/2e1vqDxgbVEw2OIOo=;
        b=kSR8HVzA52xx3r+L/ssm1NujAs0vBDzq3dSGx37hU7PnjBWkre9p+r/kCXGxP7rWMe
         UqWeWBGPUsWBbRNmil1/MheO8G7H42AycA5ERa5TXOw/7MM8fcWC6nLy9BkyDbQwEZWq
         mccvt/U1k8uJ9rj2VWUVsK1KVHaDucVy7TmnzCzmZsr0DYw1AZZm1P4KXqaFqBn5WKT6
         4ExcLzlp33IMvDXYd1ccLfXTYfqmZ2iM+2UTyDDGt8QT+t0n5AI/YvYbMbpnnIq2kDrq
         jO0G8noilt+o2pWZwlo6MxR1zxK7x0IM6gMxihfVW1pJQhiKAfTCMEz+hEOmCrXMT+Hx
         +Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156652; x=1778761452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWHHBf4Fu0RmnfhTTyveY4EVv/2e1vqDxgbVEw2OIOo=;
        b=B2hX1D/vzSKgUUvK/d1hJO2bGjhnH1B3R7qAq9s3eVN29UCI5mmmjYfnL+o+7VUlk+
         zdNHvRZ8RG7zzM1AU/HEuFaTvRPcW9YZApi42nq5xS5Ur7EfDEZAn7HXAKfs6rezLzjk
         5kmD1tf4fKd4QiGBD7yPepTB3J4Em4ZTNiHI671KILvQrp2b3c7M6dMjX0HMTMbPd1HC
         I6urm/dCYDs+lMee3d+KiHVIeQ6qKRj6adu56xDg4xofHxY+/HuRgxVExgKvCemunEhu
         ma7MXfzbiB8wefOkwBJiZQsVOHnzQK9ZubfTuayJ9d64bPsbFTJ8TaIYYdK7jlh3srDx
         Dh1g==
X-Forwarded-Encrypted: i=1; AFNElJ/0HevfQz+UOr4HZCNDWMM/Kvy2Ptqasec0bUoNXgqYs1hgk48HEcPWc3FKwHW4BmWIwMV8fMGq/2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XSBwFKjK3lZ0aKF4IGph4fZe2msz5MJBkVngO3U03wNblnuf
	e02QlWmHoQDZT/iwE4S6NQNfPlrkXHMln6lHMT0lMcXQ6FzvULzPDGPhZMh3SUqZ3wcJq9lPwyN
	ugF/wKZG9aDHLYPJqluEHgm8BixhCvVM=
X-Gm-Gg: AeBDieuwYvHJUFJ0ur3txMW6ba8Um0ORlOrx4SgZxzisFUCUHrXprPYpRtGpm/hvMFb
	q0IsKYJEZtCgQFtTR2lJe9Khda8ZiNhRju71tWJD6qe6/c5hk3rOObQCNQU7ZODZLjYcNHssSwk
	WdKrD48UVmjt4nQ5S903O/iE6SzJC6Yep8lMBK7STQoPalZO6qyendyaw0DL//0gK8oJPKH4PjT
	ZhyiiUqebQouukdt1D3UHtxf9bMJd14elgJMFTcOyUE6dbopSoXfTfKLAaUHH0rOZJG9IrpLE++
	3R64X7Wd9M1WcMGJr4JD8MZjAicgY1kqKrXja2dnLrscACgEsc5u2dD5BZK1Ywny0QpsIW89ktq
	oMUVVdm6XS23wZST84TuT6kO/bz9hb4OJM73SjreY188jNQdg55SssCgwzOOZdNrBGkS7FFHx3I
	S6X+y1fIaJW06ActTP7PVUOrXkTgU=
X-Received: by 2002:a05:600c:1c26:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-48e51f5c282mr130671925e9.29.1778156652223; Thu, 07 May 2026
 05:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
 <20260506180925.3fb80edf@jic23-huawei> <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
 <afxk7mDvc_-IHVDy@ashevche-desk.local> <CALoEA-za64VHBpw1Zh5LzvhJtgViwq30xpPb3NGMkuh=0_=HXw@mail.gmail.com>
 <afyBhRNuUOsa2dWP@ashevche-desk.local>
In-Reply-To: <afyBhRNuUOsa2dWP@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 7 May 2026 14:24:01 +0200
X-Gm-Features: AVHnY4LtJ8hxfj0G7qpXEGEcvSH8vN0ro3cniMniDm2Sk9HCBgXY5hXax_9s7r4
Message-ID: <CALoEA-xemuySxJt++yb+24W_2K1vpA2mxzopA=aXN+H1+N1RQQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 14:12, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, May 07, 2026 at 12:14:30PM +0200, Joshua Crofts wrote:
> > On Thu, 7 May 2026 at 12:09, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 07, 2026 at 11:19:32AM +0200, Joshua Crofts wrote:
> > > > On Wed, 6 May 2026 at 19:09, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > > On Tue, 05 May 2026 13:46:10 +0200
> > > > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > > > I'd just add pm_runtime_mark_last_busy() and pm_request_autosuspend() here
> > > > to make the device suspend.
> > >
> > > pm_runtime_put_autosuspend() is exactly doing that in one call. That's what
>
> (Okay, this should be read as "pm_request_autosuspend()".)
>
> > > documentation says about, and that's correct, however it might be not so clear.
> >
> > Maybe I didn't look enough, but I couldn't find a definition of
> > pm_runtime_put_autosuspend()
> > that actually calls mark_last_busy().
>
> Hmm... It's just there.
>
> static inline int pm_runtime_put_autosuspend(struct device *dev)
> {
>         pm_runtime_mark_last_busy(dev);
>         return __pm_runtime_put_autosuspend(dev);
> }
>
> Even in pm_request_autosuspend().

How strange. I guess no changes then.

Thanks for the help!

-- 
Kind regards

CJD
