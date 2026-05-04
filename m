Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B335E955
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886031; cv=pass; b=e4/SK2pLbJdnKp8XstpmOLRwJsTElUk9RYnK9QBDH0J5uSzJFGyQQEbPZY3gawwR4IdBT33zX3yXQKnlAKwGHMMdpXQAakJ3ThVAZQj/G9xsHMi/+uxLkM+Q0sTgMMSyF6Uro6tVbmklW9avwS7gEcPaK34ZMSvrOtfyjGtR/jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886031; c=relaxed/simple;
	bh=O2fZPsfqSQ4OKYb6iJ6bDKokAFpPVLhixFV2aWIx7mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNjYjnFgQaGDdQA3nDi5IIhI7bJYUCeqXWMp1qQJrZ+VAQ2+Xo5jzagTAxelu7cXjl7rDQDN8+8+n063TDPwTq29UqN43aVznokL1e1puCdJ6U0fg3CnnKAKdAKCwgcz24mV+mwM/uV9+t6PHp6GT9589b80mXBjEUpdDAllGh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdAReXZ7; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdAReXZ7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso43689175e9.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777886028; cv=none;
        d=google.com; s=arc-20240605;
        b=cNmyP41E6BwuuqewSfVCemAVsLQofaoHXoHsbpD/hp6vrngJktmcIuXKBzERJYgCs8
         rLuW6YMy1CGfrMltBgxNvI8atYL6jVcss7PhcMbZhLRx8edsZelhzYvaWH7XZTiUtLip
         Rm1vdEwahmbZPY+uUpa7RfsZDfGU8vFxoRdl+YpRoZhFsJijK/kQE6YD1PYWQY4cNix1
         edikR/uU+wiu34NihRAj4JbhtRgK+U2kUhC57jthSdO8A+UYmU0Nj934FJb4CVhXXTJ1
         DKobJdkOHAzMYC+v+uyqDWp1jazuyjqoRPavrDXAB9+uY8VJ4g4zAryisWsKHrJov61A
         YFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H65pSKjFcR+GV6WujjE4KtRDFB3rFip0KegtnBmCFTY=;
        fh=ye8J2R7F1k/c6tbqTLGoEQQi6DwOGwLTIqd5Ud0Aq2o=;
        b=gNSpON29hRTWT4InR/FWw28iHxLgm2GQZ9C7boi2NEFhMX6GdUSAp9Ix/D7Jw9tPUR
         kyRD++oMOU68jKx+9ijqKnaEwOMWEP9gf5QMbGspvxk3r8jSwU66iNt8XsqXYVPgSytx
         y6oMqbQyUjiRAyMzTy4y42dyBL8ywf3zX2bs6Vx+FqIf1+BFoTt6e0eStU1YJXGbyD5G
         vbCiBJ9Ih9Uq9c3Jxq1xZ34OgiboJUTmfGYx3aDl98UfpsmsHds6FxPql+4/NT5NjvlD
         KIbI5ESQwr6x40uRdgyD/3PUCNh+mydcbDzrXlwsqRUkbC9U45nRpRDPwcwaOTeiqssK
         5/Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886028; x=1778490828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H65pSKjFcR+GV6WujjE4KtRDFB3rFip0KegtnBmCFTY=;
        b=OdAReXZ7LmuP0x3/GHG2iF3nPWMAUl2qctErj4D/RZ6FL7G6zNN7qFwhz3EC/+hzir
         tTX2u6pj8GbI0L77EshonQufkne0kCgiX1O9XMVK6GWwHYFobfNHFVMnOGhONmvGNmyb
         g72RlFm1YgUz0JpzE172cOU2t3ga8/oQ210BMn8P5OAlyku+uCi41DYK8xUHeyHnpPjt
         4QV1Vself6t0Tmjau6CL9beA9DUTws80gYJNZBgaZBlwrrN8dQXgPX7n8XGM20WsGbkO
         cmoLTXnBB8C8TSDa5u3NJu3qqXeyA3nGcstn6QR/92Tmbc+Ra00PwXiT/WpB3ItaZNS/
         Ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886028; x=1778490828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H65pSKjFcR+GV6WujjE4KtRDFB3rFip0KegtnBmCFTY=;
        b=bbFb9GuRs35yFKRuFn1WxveEbRiz9WpwHAlG2TbMWJs1OtKQfQASTtwUZFicXVl+dM
         C7LFSprCjPgYcDDw95TUI/T5dI1WuC1lZxM8OCQaONYGAWdG0o9Nex8vwzDpsnWBsQrx
         /05cQeYZvQI1WA3OiKApCFKu77a01Guz+eBICGb74F/tvd2cZ+pTg7z6rUwt0RuSckbr
         X7e3qs+qPuKonbnZ7GYjfLbPEj0P2ZH4M/w8mQ7jTZINUHist4Pg07qLwpL3y5ediZH7
         CUFLV9VmLinSrUpOVOtLxRkTpQ5G2Cu/bwtrk+NlwqIXYjVJwKL6qZprP3NM2HYqZPkA
         DE+g==
X-Forwarded-Encrypted: i=1; AFNElJ+GiLtx67JpJy14vOYaJP8K686CENle3frZAlQ9leaMpjhk2ObMYjB0o1LzRAbwhGgS6U/KR0EYGas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7ygTVYkcRdBRlrE2gQwAbpFXxSyATdijsjMlMlVO840LFeHj
	064bWjFwW7BVJqt10c4hec1DCRh82By8JY/QRt8e5liASLAziMkbvFvVFiEzrXa93A4V1I3t+IT
	AVFIkB30SPXv7xR7LLQz2Bgm4pVF+s+w=
X-Gm-Gg: AeBDieviQxWo2MKQAdfljtFqnn6BOu1/9Lva+plblHHd/Oi/rpB2FVATHwZxIo36wo4
	QGTaak9fSnqhCPFW73QHFNf/72yHY+NI3533hFL7iItrbDUUxSdiBj8ZXHrghigg2eaHjEUuhVV
	yTIWdiec0t/BvZm7NUkipR4fZ59AhH5OcB1SeeOKYXrTWXnmHWJiobs53fw7V33Yd1Z4VdNpwbV
	jAlYuA7I91ywd49boqYRhBfK6AkhlXQFJsgvtRnbplwaoA9F0R0T/VEoXCJuejFAZhEs8N5jEGA
	eHDqRSlfvQc2gh87cQ9O565EjRiTjGCfr6QzL23ESRJ9UhksYFOnb26vb6LCDEemwq7HjYTq8Fr
	xTceo1FGZBUO/RCZzTFa+hWXKqGrLwwwZlQjQDJ8iopAbLvruaPAfXqJ4R5RLtx5FFbyVnrTAT3
	MQKImNOEv8PR5VHVRe
X-Received: by 2002:a05:600d:1a:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48d10cd6ceamr16919715e9.6.1777886027900; Mon, 04 May 2026
 02:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com> <20260428173540.28b7913e@jic23-huawei>
In-Reply-To: <20260428173540.28b7913e@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 11:13:36 +0200
X-Gm-Features: AVHnY4KGmudVtY3PGPcwaFYx3G_q0041xD1jCmxc0bn_mYX8raUi7ocKXJ3jzWg
Message-ID: <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:35, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 27 Apr 2026 22:09:45 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > This series is an attempt to make the driver less a rabbit hole.
> > It's a continuation of what Joshua Crofts started doing. Hence
> > it is based on his work and first three "patches" here are supposed
> > to be folded to his series accordingly.
> >
> > I have compile-tested them, but I haven't done full double check of
> > the correctness from functional point of view. Joshua, please do that
> > before incorporating into your series. Yes, my patches are assumed to
> > become the part of Joshua's whatever next version of the series, that's
> > why mine is marked as v0.
> >
> > Should not be taken directly by the maintainers, but any comments, review
> > are highly appreciated.
> >
> A few brief comments but mostly looks good in isolation. I'll wait
> for the fused set with the fixups applied to take a closer look.
>
> Thanks Andy
>
> J
> > Andy Shevchenko (14):
> >   drivers/iio/magnetometer/ak8975.c: fixup for the IWYU change
> >   drivers/iio/magnetometer/ak8975.c: fixup for the errno fix
> >   drivers/iio/magnetometer/ak8975.c: fixup for the iopoll.h conversion
> >   iio: magnetometer: ak8975: Inline timeout constants
> >   iio: magnetometer: ak8975: Avoid using temporary variable
> >   iio: magnetometer: ak8975: Drop duplicate NULL check
> >   iio: magnetometer: ak8975: remove duplicate error message
> >   iio: magnetometer: ak8975: Reduce usage of magic lengths of the buffer
> >   iio: magnetometer: ak8975: Unify return code variable name
> >   iio: magnetometer: ak8975: switch to using managed resources
> >   iio: magnetometer: ak8975: Consistently use 'data' parameter
> >   iio: magnetometer: ak8975: Unify messages with help of dev_err_probe()
> >   iio: magnetometer: ak8975: Use temporary variable for struct device
> >   iio: magnetometer: ak8975: Make use of the macros from bits.h
> >
> >  drivers/iio/magnetometer/ak8975.c | 253 +++++++++++++-----------------
> >  1 file changed, 112 insertions(+), 141 deletions(-)
> >

Given the relatively big backlog of email in the list, should I wait a
bit longer
sending the combined series?

-- 
Kind regards

CJD
