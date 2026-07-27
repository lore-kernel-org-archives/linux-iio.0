Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FB374E5B
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127218; cv=none; b=a/3m8xt2Z39CVGUk9nCbTbJA4V73Bzp3gH/e8fHyN6JAFWG9XiFYY8qUz8w+yS7AOzDRM9s0AVtD1VHIq6xVPs27Wk4ho4PshuGaIaVAj8CXXc4GyJfm7bhjqmP/8nyIVbgKLQoDr6u7d6Mp+JX1XTw+3MAaJADca77C+kMgpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127218; c=relaxed/simple;
	bh=KhayGZ8jwb8sLYOGw7j7nva3p7BUr11Zgf0U4g+3kls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKaHgFRPC2x6buETiNUNtqvODXN9H5RBFupDJwVR3CteBl62HBdFIlVtwgPISPmXxmknCbMko3ThUSL5Z0WaiJINaqGnzl3XTQldTT/jDt1TWSjm+KryjVQTD1zuT0FrDk2jT8LnJQXvGzC+0WCmD9hxUDsIj+fwQrgKrZADQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0qqt8XA; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0qqt8XA"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-969524c1aefso774239241.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785127215; x=1785732015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZW8tsZIKTlk51QueT1yxpi+p4RNZ9ybHTGQ8PcnIhU=;
        b=L0qqt8XAhaB71jIAl/xMh1p5Uab980iUjcaPp1NP6c25I8ynImCbzygeJ/hIXBIPPB
         vWlAf1oEKxtmEZ2aC2oH99Cs6XTtDMpBWfBux0wPSTetLKQJUn2swcXIkGn1KkwRRxqW
         Mtej6fLKcqSGEugPjiaDeUSzqxpY3eo/ObXGD2/JGkubcv+/sIdtxjrhuIJ40lpg9hE6
         2Ucu2UKLY300uGdT+hwo6gKizkF3mRQlW7LkHyzHv8UiNKGOIF85274te0hAjFNcyQBg
         4V81eTvFg+JJHe4OuK67BMykx0c+iagUUTDLOdKbI19QaKMeB4Fdr8eyHXd+WjsZVxrp
         ClSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785127215; x=1785732015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZW8tsZIKTlk51QueT1yxpi+p4RNZ9ybHTGQ8PcnIhU=;
        b=Onp0tNbd/FVSy1gbhUZB3D3QsWTG47KrBWdc3ikpIBd2JyN+XCaPIJ4cbbfmUDcrz5
         BgzwB7NpfbvmctsiNG7Ol3JHXfLPoYeQTgXw4kPJBTrj/pRtY4HXd5PTU/gKKAB8dm5T
         AuVJVZk4F+p8onm+9WFp4AJEakS/I7T8UoUn6cmbgGtxU8ZngF0B3nHFglmwfOcrKIVY
         rVLJ78kXn7LrR4h8TRkvYg9Qh3sUQhTPZ13O8OeMyD5+lErcXHSyRh3r1kJC99C0G2Lh
         reRqzVGq2s83/ZY/2rbhUI4y/bgAFQdpGbKyDxGjlOjwlXLpEkwd0LMVh4JUsZ4l1sDt
         ReJw==
X-Forwarded-Encrypted: i=1; AHgh+RoHP1KTuMPePteBlM7Lrzaru0CcDn8YMPRygq2JHq/XqKrSuQnofPkU4rgKCqObJqMQGtxBJg1GhiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA30nX0OWIT+qrH6wjhsmq109jkXxfghBhofxPW6OXW1wVLWkp
	5LTgtbShdqskfIzLMM5OeVhmwnJP5DHAzikXgOjW731P96x+Qthpv9HN
X-Gm-Gg: AR+sD10tOZlgXSdTkO4zb0cH/3ntlEWwyH9zPmIf5utaT0whz9egPvBx0dYV/xWu0P3
	giYhf821Vismszgu/AeZ9oXYyUIAAnWNHOZ4djBzOA0JL3RNXYJzH84FE7KSY/V/u3a4zObWV6R
	oZRHrHWZVpL7qvgAWIPNAjwgLkV1jB6jjponUsVo1qnHiZet48xqM02YiFXjaIWakrg/OYq5n/y
	KaLgZAjqZIDnhF5UGiofEkJG81R1lvb4qwCLU5HlEkrb9SJVriZi5bjNucQQA8zzSj6wG6W4LeI
	jsAtXYJSc/R5Fdec7w0tEyu38O+6XYFl7sEqenXp/7V2U3oL0OobdHlhsqeTatKEB29IaLB/711
	to7Mo4vRTbiVvoNaUA1e2ed/RePHhN5ycYbWugXa1dPykPnEga0RyMlgduCKSO2u5iyW2srOccs
	Hi9w0=
X-Received: by 2002:a05:6102:4425:b0:6cb:d562:b96a with SMTP id ada2fe7eead31-7503feb7446mr3207711137.14.1785127215445;
        Sun, 26 Jul 2026 21:40:15 -0700 (PDT)
Received: from 45fec588b341 ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774e119b8sm4688785241.9.2026.07.26.21.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:40:15 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:40:13 +0000
From: Yuanshen Cao <alex.caoys@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2772: fix ALS calibscale readback
Message-ID: <ambhLVO6CkMVzqKJ@45fec588b341>
References: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
 <20260727031407.44a6d201@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727031407.44a6d201@jic23-huawei>

On Mon, Jul 27, 2026 at 03:14:07AM +0100, Jonathan Cameron wrote:
> On Fri, 24 Jul 2026 23:46:01 +0000
> Yuanshen Cao <alex.caoys@gmail.com> wrote:
> 
> > The read_raw() implementation uses IIO_LIGHT to distinguish between the
> > ambient light and proximity channels when handling
> > IIO_CHAN_INFO_CALIBSCALE.
> > 
> > However, the ALS channel is registered as IIO_INTENSITY, while
> > write_raw() correctly writes to IIO_INTENSITY. As a result, reading
> > in_intensity0_calibscale incorrectly returns the proximity gain instead
> > of the ALS gain.
> > 
> > This causes the following user-visible behavior:
> > - Writing in_intensity0_calibscale appears to have no effect because the
> >   readback reports the proximity gain.
> > - Writing in_proximity0_calibscale causes both in_proximity0_calibscale
> >   and in_intensity0_calibscale to report the same value.
> > 
> > Fix this by checking for IIO_INTENSITY in read_raw(), matching the
> > channel definition and the existing write_raw() implementation.
> > 
> > Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> Hi,
> 
> Fix looks good and the explanation correct.  Was this an AI found
> one, or did you either spot this whilst reading the code or best
> of all saw it in practice and went looking for what is wrong?

Hi Jonathan,

It's actually a bit of both. I first noticed the strange calibscale
behavior while testing a device with this sensor. Since most part of
this driver has been around for 7+ years, I wasn't expecting to find a
bug there. I asked ChatGPT for some ideas about what might explain the
behavior, and it pointed out the mismatch. I then went back and verified
it, and sure enough, it turned out to be a 14-year-old bug. After that,
I checked the rest of the file for similar issues, but this appears to
be the only instance. Also this was tested on the device and it works
as intended now.

> Give it is fix, what is missing is a suitable Fixes tag.
> Please see if you can figure out what that should be.
> No need to send a v2 unless anything else comes up in review.
> Just reply to this thread with the Fixes tag so I'll get it
> when I use b4 to pick up the patch

Thanks for pointing this out.
The missing tag is:

Fixes: 3c97c08b5735 ("iio: light: add TAOS tsl2x7x driver")

Best,

Yuanshen (Alex) Cao

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/tsl2772.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 244f44379c36..2287585711c6 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -1274,7 +1274,7 @@ static int tsl2772_read_raw(struct iio_dev *indio_dev,
> >  		}
> >  		break;
> >  	case IIO_CHAN_INFO_CALIBSCALE:
> > -		if (chan->type == IIO_LIGHT)
> > +		if (chan->type == IIO_INTENSITY)
> >  			*val = tsl2772_als_gain[chip->settings.als_gain];
> >  		else
> >  			*val = tsl2772_prox_gain[chip->settings.prox_gain];
> > 
> > ---
> > base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> > change-id: 20260724-tsl2772-calibscale-fix-0cc42518d5fc
> > 
> > Best regards,
> > --  
> > Yuanshen Cao <alex.caoys@gmail.com>
> > 
> 
