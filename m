Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70634C901C
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856329; cv=none; b=StTuhOqjT87BIu0FlE5CHulGRaHjBxPM7T8J9TbasmaYdSZoH9l7/rQFtm9b73iEGkeBMj7WBX5fsYLMJgAA6/y+DcUiCXNaCXbdzrnOZmt+8/ZPDB/Ju5+Ul4P/hUvpi2SgeshW+d1lc6Pg3t6ZKMT0A+VWRMoonDGHdpldt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856329; c=relaxed/simple;
	bh=i8ymRyp4e60Xjd+PpOlDes/VCNeSWWlD7ldvgNuYrOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MP7pTl32zEAmOe7qu0mqUlxm0HReFbKx/7p+AywTbG+OeeOZLN/4z31CYZVBCxe7odt7aE1rgu5lTd+YxeC2FXP5rJ8iTUT/2QJB2QAfR93G5uqpLevv6AJ3q3G8rAADBLwqEP5+WMYXw0LNjnawVzBErWcPyzn/ZPa4xSH5NZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b73X64yZ; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b73X64yZ"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso152524241.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787856326; x=1788461126; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Zft/vSIa73biU2xBfrEJch6tyNiIXvMhfWRYn9XxXw=;
        b=b73X64yZQCKSF4EZ5sKVrKHx9Ip+l+WUdRkNVTzRRyueWosqhcbwZ6ng7l+2ufTkRQ
         CPu5F7FFUevZS5yFb8tq9bW+IK4Z7KppBpcBVJ81aMvfjsLXHCkbVNcHHO563nYlQn21
         aDptEwreG6eMijzyasNKoyi83J3F8AEmaUCvZr7yJHcMn5wsVQ6gpQ6FTZY4l6Uzli7P
         +a7w/Eox+vBBucOtN8dfoXKCF1OWFEOCiG5At+RDbKIjF3OxRu31fLBAFcvxd5XWiZDp
         l++6WTfRdoWCWwzRxP8vGV34HdMzWJ94PmBGF704WCLM4zBPNihN4ONHivtVdOB4NKiv
         aziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856326; x=1788461126;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Zft/vSIa73biU2xBfrEJch6tyNiIXvMhfWRYn9XxXw=;
        b=q47kjyv97cLTIl6oaW2nVmXtg/MSnI5i7V8C8q4TV3uU50vkDbH2kCeyJlD/QvVZyt
         mrxvOe+jzZI5Gdd6tZGzJq9aVi+5ZKwrctcLjdukuJiH7iTCjvMwDEnFaB6Q1SQsznry
         Cbi9wOy2Ya7c4+/8C9Qp96A7MiK3QTYma0rvfnj9AmmL4JEjQpBTFgIRriWsu8Y62TgR
         ykjMpnohHPHUkSnZMOh1e50CHfX426mDvnQHmU0tX53NFg6Ww+yPZVve7D4grEYl96Iy
         DXO4WANvNhTA+7Hl73FpS0MAOykzI0DEBWx4fM+qdrpoyvG45f4o3SmG6Sh19ZsqHjDs
         UTtg==
X-Forwarded-Encrypted: i=1; AHgh+RqHcV6CbgSt3gUlfQgnq+e8gbxThNTGv1f4fZ9YWRHgEC77hCiiP0Bvff++SYOgc3z/NtRCYWKb7a0=@vger.kernel.org
X-Gm-Message-State: AFuF++lcwEls45UAOVki6gpSeTdq5IQ64u5+Bs4Vg+7fMThH2lX+36Ph
	CIjc/tA8TMWTlFeRikP9rkdD5vnDP4+2Al/sirncUCv9Bz7lak5TSnYl
X-Gm-Gg: AR+sD13uTVrii8K5piN4hw629OQj4hINyXoE90vJ3zXNwn/c6abOb2fDocU24WohSoM
	pQf6alNyuiAvyfxRWpgHpyEWMPd0lLg+QkCKPbBcxNPemLh3zZ29yWgiRjn0GvVGuVdvvZgcMKz
	XNDXgM1u1S0VGrb/kmbOYIvB6Px+RDyOaTNqVifmsLZ+5LNNYAUQMDueFgiyfIC+7ZsofmebcXp
	NZsEJtJ207WtxgZ4DXvLLFvJWZEkUcZQsv5aADKlA+cPylZZx2QZw9BHujMyx2PAFgVgMfO1A5W
	pT3og2SpPfaOPNteaNWOw+UrBPRM7bEGcYaQenjhTufngjcuhAC0z8/f/h49Gxl4hwOVEbkyJcv
	qfMqkwZrvHL2vi6Op/rRpAlf6pnU6MRG0ViD/PaMVg+n/xzfr8w7c27/cUOSY8oKf0AzjQgrBID
	JGK86klTGpY3uJddoIhIFzpK/mZ1AG3m2ktFDHtPHGFELA6B8UxOBj
X-Received: by 2002:a05:6102:3a09:b0:783:cba3:cf0c with SMTP id ada2fe7eead31-785977fdf41mr160038137.6.1787856325569;
        Thu, 27 Aug 2026 11:45:25 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97cbe34c7c8sm5365290241.11.2026.08.27.11.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 11:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 13:45:17 -0500
Message-Id: <DKZY65U6LPP1.AIH4CZKUGVWJ@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-7-f89925d72792@gmail.com>
 <1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
 <DKK9S36LB543.2T124NE3TNETN@gmail.com>
 <f3ea3859-aff1-4c15-9302-095119faec78@baylibre.com>
 <DKME9LSBXSXA.28PS1V6ZAH79O@gmail.com>
 <20260816225424.27c9d223@jic23-huawei>
In-Reply-To: <20260816225424.27c9d223@jic23-huawei>

On Sun Aug 16, 2026 at 4:54 PM -05, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 15:24:46 -0500
> "Kurt Borja" <kuurtb@gmail.com> wrote:
>
>> On Mon Aug 10, 2026 at 11:31 AM -05, David Lechner wrote:
>> > On 8/9/26 3:28 AM, Kurt Borja wrote: =20
>> >> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote: =20
>> >>> On 8/7/26 10:58 PM, Kurt Borja wrote: =20
>> >>>> Add triggered buffer support and a data-ready (DRDY) hardware trigg=
er.
>> >>>> =20
>> >
>> > ...
>> > =20
>> >>> =20
>> >>>> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
>> >>>> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN); =20
>> >>>
>> >>> don't need second one to be aligned, they aren't independent. =20
>> >>=20
>> >> Ah, I forgot this observation in the last version. These are used in =
a
>> >> full-duplex transfer, wouldn't that require for both to be on its own
>> >> cache line? I just started learning about DMA. =20
>> >
>> > No. In this case, it works roughly like this...
>> >
>> > - We fill the TX buffer before the transfer. (CPU access to memory may
>> >   just live in the cache at this point and not actually be sent to RAM=
)
>> > - We request to start the SPI transfer.
>> > - The core SPI code flushes (or maybe I should say invalidates) the ca=
che
>> >   on the TX buffer. This ensures that what we wrote with the CPU avail=
able
>> >   to DMA.
>
> Extra fun - it has to flush the rx buffer too.  Because...
>> > - The actual SPI transfer happens that uses DMA to access both TX and
>> >   RX buffers. (Again, could just live in a cache and not be sent to RA=
M)
>> > - The SPI core code flushes the cache on the RX buffer. This ensures
>> >   that when the CPU reads the memory, it will see what the DMA just
>> >   wrote. =20
> If the RX buffer had old dirty lines (could have been used for something
> completely different) in it, that is modified data that hadn't
> been written back to RAM, then this flush would wipe out the hardwork of
> the DMA by writing those CPU cache held rx bytes over the top.

Makes sense too. In this case, if both buffers share the same cache
line, I *guess* that would just be a redundant flush.

>
> (Next bit is just to scare anyone who thinks they know how this all works=
 -
> completely irrelevant here :)
> Don't get me started on architectures that do clean write back (occasiona=
lly).
> Thankfully I don't believe any of them also have non coherent DMA as to
> be able to do that nasty hack you have to know no one can see it.

With "clean write back" are you referring to a write back without
invalidating the line?

> For more fun, one large CPU vendor thought that was the case and there is
> a spec out there that has a magic flag to let the OS know it does this
> because there are cases where you care.
> </rant>
>
>>=20
>> Oh, this makes a lot of sense.
>>=20
>> >
>> > Since there isn't a time when CPU and DMA both write to the cache line
>> > at the same time before a flush, there is never a time we could have
>> > an issue with stale data replacing data that had not been flushed.
>> >
>> > It does mean that we can't update the tx buffer for the next message
>> > until after this message is done, but we have to do that anyway.
>> >
>> > What does cause problems is if we just had a regular unrelated variabl=
e
>> > after this in the cache line and the driver updated it during a SPI
>> > transfer. If this new value was just living in the CPU cache, then
>> > when the RX flush happened, it would write over that new value with
>> > stale data from the DMA's version of the cache. =20
>>=20
>> Thanks! I'll look deeper into DMA, it's very interesting.
>>=20
> Wolfram Sang did a nice ELCE talk on the more normal flows for this a
> few years back when he was working on reducing copies in the i2c subsyste=
m.
> https://www.youtube.com/watch?v=3DJDwaMClvV-s&pp=3DygUQd29sZnJhbSBzYW5nIG=
RtYQ%3D%3D
> Is the one I think.

Very interesting talk, DMA is way messier than I thought. I guess it's
the price of supporting so many different architectures.

I recently got my hands on an FPGA board so I'm gonna be playing with
it, although it seems DMA is still way out of my reach :p.

...

Thanks for your review! I already finished v4 and I should be able to
submit it tonight.

--=20
Thanks,
 ~ Kurt
