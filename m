Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C11390616
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743945; cv=pass; b=ApJ4GXrRalQCe9uA2Wmajturc7yKv+c6+m5FdHwqp+A8DMrMKwq19KV+hs0fWUCFZyeBHpvseHFHdfZy4OXMXxQTnv5YN9Z8CGLv/9hMykG2S752GKu7/cX56yNH1siDNt/OBMyQFvwZrdtPoaovWYVxYHfeO/xwHVzy5VjZgLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743945; c=relaxed/simple;
	bh=xZQQ2jsY8Gds4YAn9e8B+Vn+W8udOLbAEFE8PIBNAJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAl0qNmJmhwEEZ7OH1StZOIdEAAC0793uKuzPhnQT98wahYuOlLRm7AngpMe1ZgSv4wHZeXl6YTTETBjU+pKZygHi04mIvA4TIRtqUvtzt1N9/JOrRKeNlntzjwZLKAWfo15wEiZJsIt0cthIaunqa7HjKcXJXXPlYLq18CFEJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN2u+N3C; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN2u+N3C"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a14580111so5577895f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 00:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778743942; cv=none;
        d=google.com; s=arc-20240605;
        b=Sc8Ng2XnnmkTGe/8vn6cDEtGWdyx96KqhA4cB24/U8ZfQDmW119+BJp+GIj70B02GD
         9DuKPmPnAneqgt6opAYCimralRfdegpudHWavqh0VP6U9cMUGU2KNLXKZ6mRBGtOFJ6F
         WMI8LnwtJEz1yM095+14ikJUE7yE3aly7hGp20PHDmK6VI1nix47kq58CSUuF+tW/CjC
         QLJn3TeVc1dDYToh/7ZJ+6rfEDMtp2jqjGuB9d2sGnEvrXpp/Z6uePujwPDkA0kX/lRu
         21Q0oenauH0ZOxe9wFeIeqgVCXbAH4e+vNiGOBUgrIv3WrtSDiqRRlxzmQ1Ibm4M002Z
         TjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ol4YGTHSHAsC6/QhQStMUey9/GMdJMxJVTKF3sKpABc=;
        fh=kRH+wc10jSKtLQtyijzIHgnb5gS4vnBjSSpn28p2qNU=;
        b=bTjVRtL2TaSo/hOoaz9hgg1av00vzWXXPsskBw9Fvi3BJBqitZ1t9qzyvZWHK+/wiI
         aOJTiB9PKLm9d9DAPKwR20LxNn+rDdQdOeh2/+9jctEkYcR6N1xQ9qcolSQPNQjcpF2C
         Sdjaq99D+scDdZGp/U4sdgrN570CMbenvGm+K8KrS7yJi+lKGjYd+U/sTe4GXgn2iggh
         dAyD0REXycDOiFGea3GvDe4m+EyEcs9y0JRo+aLJw3t3hDNHjJpRvaLsbEQiNuRzfLu5
         s83OKpOH8R5JFv/k9Hu5m3W7weSlgd5TjOE/Ye3K49YtFG71ClonJkGgzwNfRBXnMgin
         kgpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778743942; x=1779348742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ol4YGTHSHAsC6/QhQStMUey9/GMdJMxJVTKF3sKpABc=;
        b=RN2u+N3Cg37geTF8McQNRm6Uxp/GClatiZ7Eb2kEUGhYMNlEV+w/IAzhjKYLZlbV/2
         29GgT04eJ3LY1wtEo5MTqZJrqkByCIuIP8km6RAQ/XxBf5vG+kMNugR/gE/K8XL/QHAX
         jdQxRC1/TSzK9N0YHk7SGqZ/Q1uwktCnvFmdYmG4F0+lsgncidU1Rqqm20532My8/Yw8
         Z/kSDQS4J3afeYt9QWA6LBBTxIgXCleDGbI4UvwIRnWZVwuR1vS7kbxxJrTiOWqJYCIN
         M41q7REhKVLnMMEDIo2YXOjcTVZ9i+zhwLh5a1RUd21HySKAwmzkUl0vGs41/iz33V1l
         R12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778743942; x=1779348742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol4YGTHSHAsC6/QhQStMUey9/GMdJMxJVTKF3sKpABc=;
        b=WI3bBgaof6wLAIWqrJEUQMbJ7ceR96Xo+y3e8sHv6MrDtFbhhNkFbmjhABMDb+dpPz
         Ppj4WqI/uY6MkvsTy1pG+/C/Ji+wcBVI9HGZ9OR0X6EKAK2+lVDXtrYV44wz6yFkVIyV
         gmSzWpKG/Adtjyk1Ho3LW0Fz3O4IBDBH3N5yu7ul0hWOsANEoDUj1ssgqlUDCm64TTTf
         vlqyNeg/0R2e+hO9E69zgJt+8yUJKJHgYKzAUvsbXWcbjdV06L0UjzyPuih+8Sub9QaH
         ezBz9oK9hY5L0db+wV+Pn4CH85mYGfdUaXn/Akc+0thzAmX07R9g2Nopz3ElVWx4OLcF
         8F6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/nvKzb4OOXP+V13+rHC6aAjW2eZt3am3MSnQm2fs6uxHP5oewBDadJ7ZaL1G1SPsYDE+JY88fW9MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnRQNlmrgEhDDPSCKURXb//xeQFKKGYS4cP+TltLGmX6n0u1K
	j7bziuBTDkQ9ozhj3muOKw49BLuWaTkYv2qx96J5Hkc1264mk+a9kkKC0LizM7LdrkajXsFnoKw
	hTDzkq3xiXtaZ2Ij/GHAFfJkLyF+zsy8=
X-Gm-Gg: Acq92OElL5R4wad7FDh/gzXyJgY5fdziwwYC6XfNW2JRPjbs+ZdYJC8rCC82esWfqaq
	eOenB/i0R3dqgpKtY7aW/gFgtZQMyD7YhajTJDHEi3I1Hg3eiyRSfPrsENyGOAg1be9uFMk4gbT
	gzBYouYRJkr9KcuuGco0EULv4FXVy9XI3JnD8vBOE8+Whb//2hkKEu8fSoB4++udtijzJcjBEdw
	PJrxzAqW+IuyiebhgU2wqwmji1ksVvqK57mUu4WFvKcQ/V23aDF7Sg1QDb49os6VT0mnOaKY022
	TESFaF7u97nCsaOOQmIxHn/T170PwjAzbgKeHDogR46SYBzwX0Uem2ClrWE+BX7l2g9hioQdjod
	XFnP8HPhQLTQu3Oj+ZbOVt+otuzMHG6fmAlfl4u/PzjHt6HCHRsUV7pljqVRyguIEgog+u0J7tY
	zazeG4Lg==
X-Received: by 2002:a05:6000:2c0c:b0:43d:7d6f:f529 with SMTP id
 ffacd0b85a97d-45c7a4ef881mr10255796f8f.31.1778743942318; Thu, 14 May 2026
 00:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com> <agThqGpaYk7KNCv7@ashevche-desk.local>
In-Reply-To: <agThqGpaYk7KNCv7@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 14 May 2026 09:32:11 +0200
X-Gm-Features: AVHnY4Kx00bmKx6GizCDwfpbW1Kskt0DqkGM346smQDWeOyXmlOKg4A4tlUw76A
Message-ID: <CALoEA-zPQOK9f4SuDTxkKWP+ncvfQbzq=ehXXopHd=ZC55HbVg@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 22:40, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, May 13, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:
> > Currently, the ak8975_start_read_axis() can be called while the device
> > is autosuspended, causing two issues:
> >
> > 1. I2C transfers in the aforementioned function will fail or timeout
> > because ak8975_runtime_suspend() disables the device regulators.
> > 2. Since ak8975_fill_buffer() does not hold runtime references,
> > ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> > do not use a locking mechanism, it may cause a race accessing the
> > control register via the I2C bus.
> >
> > Fix this issue by adding struct iio_buffer_setup_ops that contains
> > preenable and postdisable functions to ensure correct that device is
> > powered on when running a buffered capture.
>
> I think Suggested-by: Jonathan is appropriate here.
>
> ...
>
> > +static int ak8975_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +     struct ak8975_data *data = iio_priv(indio_dev);
> > +     struct device *dev = &data->client->dev;
>
> Not sure if actually may use indio_dev->dev.parent here instead of this, but at
> least this one is robust against changing parent-child relations).

It being robust was my intention, considering this will be backported at some
point.

-- 
Kind regards

CJD
