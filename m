Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F429B795
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309240; cv=pass; b=dQEwstaT4UbcXzLa8MII03A1uZlsBj5BSyARk3UTJGKNrZ1DBi2c71TxuFKODJyJdxhKe26poTe9A75sQxVvK/SVXke0apIIWeaK/YHP4LEV7qxa+OuZF3Vy/XW4WYnVHT7As1bpbYMzrDPHAEW8fkUJtpdPoLZwTaIoRCko0v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309240; c=relaxed/simple;
	bh=OC3+EmPLTEor5PVw47zL3BXkFlIvHh3rzC0GTriEJqY=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WysGAbWIV16QEPJ6kYCb+L8bYFQgczAOpglE81UFW4JYb2jZnc259689DEzUkHzWZI/4Xb1NbAqLkwVF5kVS/rUj5PxZaHTuUdxFuyY1oAuRNksGfA+Zb3nfNnaPDqotkji9pIIq0iX04tC3Vk/2PBGUbxktyfOm4LRazk27mgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spjKT3QD; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spjKT3QD"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c337cd6614so581632137.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 00:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792309238; cv=none;
        d=google.com; s=arc-20260327;
        b=RLrzA0IbOLU1cLUedT93q7bTO2YQGqU7IqPEKdr9xMBVtROu5Azoh/OwVGs/31+gcW
         sKujOxMmLDB+OQK4xIpMTDMY+Hx4VFq+jK94w4AruNj11rKM84Uw8eRqQeuDsJYPd4x3
         euq8YneXouFuVrpjeAieCSF+GODTpxQq+VQVoikqfF1pXwGcwOh90YR4RkE60CF6rlc/
         0Wr2EZWwU8c9mv1T7PiWFL7Aihl9bWaIABhY0hFlAND3mREGFz3jgg9hkaPrIDA0YFj7
         nj8xI2B3oCTUxYdkWScGs2np3Q65GdyQ1nsEO3wShjPrGox+xA0DW9iCFjV8l23TbH2w
         M8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=W3zkFDAliGrfZVNHab7+yemqgQKzuzRr7Soqpwrq/Ts=;
        fh=flme67Ps7A8JaYw0WbhelGXVvo1NEbJ7DC37T2DGyHo=;
        b=Qo2ZyWvEbFWyQUuKmMjvd03MI3DPRCJUU8+F9hxOWmQuUGlbrlknYAC4sG3GYgAy/g
         EQcsMaOo/wOExKeqmBNGJCBR6ofzQX9roLEkLOb2xjw63FAA9fQytXFxMMmZO7TEYlnx
         AF1Rhm0/ZbzCcKUYpejmk7ZGaZ/VRn2S+rKUEgWbQ5XaRmfQvzknh0Jj6QHk6rq8eHqH
         UNrxWHAtI5y3wC8K/uaf/HiNZ/cFzldVZodQ+ZLxGO9z4DM7yinaNJgN5fiUQjl38lzO
         CyXI7EBox14tzSEz795hYFZ5fZOj62kkjTAZUstV8v/A9mVT9rYOz1FRptHfAg2yGFM7
         4RkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792309238; x=1792914038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3zkFDAliGrfZVNHab7+yemqgQKzuzRr7Soqpwrq/Ts=;
        b=spjKT3QDeLFQmJbNoxjfqU01v4f3kc7Z3W8U5aIdkhjyUUC05Mxzi15EGgIr7R+8m+
         SVBFKAMbDu7Muh4bDr6KES9fJykZ8t6SI0FjpkBSk49+2ugBmw5frwWfxNoBMDM5MPt9
         4+lliaTPEy97DWodukof/20S3JpHf3cXPYDtx72SsGyn4spZ0D93j5iqcjgF6pjJIa6W
         hCQ6aXACoJntDU0JZ+CYFhne/VAwiZQx9EILE3WuTKZPCaU+9cSxawRBB2avQi9ZEZAs
         CHJVpCpzB2/ssZgZ3iaR3PT7yBoGfwuMyNyv5BQHxgChGffgMYFm5zyxygZnHT5as7SE
         UcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792309238; x=1792914038;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3zkFDAliGrfZVNHab7+yemqgQKzuzRr7Soqpwrq/Ts=;
        b=SI9VOYN+LlUVKwKdpANqi/yLlL/3vJqTTNR1wFhjOa2csgSz4Dx8w4bazuBrVr42Hq
         jz1BtiuQGyipvhfufJPzII6HYMm3qJnHgSYWsR5bZ138SRtbiJyMB9TtVt66pleaL8X2
         5vnbVa0SeDKSqRI0hIxyQaCjJLTpuoT9IwAXrZXy5ze5fsENp0QHZA5AFVSbxMsGxZ43
         GMZpvOdFZEJ3MhaJlYeWWjxO6lxRmLlBeYBg9LxfhYsBsJ3XSHFSdz4mXHrVKPW85TLh
         T24wRuCx4mKZZqzQZJC0/ceubtzUjYPprLvqssep7ObGUSnv2Ett0D0F3GseA3ZJqBe/
         SKhA==
X-Forwarded-Encrypted: i=1; AKwUvByqy61VTlV8wun9M9CyyVusZFOelwfwfn4xJV/xsfNg7U7+b51xS/DMPIgPFx07RP0p9fOyr9zqGBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRhrhGu291epHACYCaulcDNMaqrXa4M+pQLUfSL1d1rc+iFUbj
	W6hrCkqHFat98ctO59CpA++fMEeZFOgfR12Kro6Tt6e+tEru6/YFYbHXqbrnAC6BSCP2R+10Yi6
	PU8VO6klqtM4db1EBjqkQzRUxM6sMHgU=
X-Gm-Gg: AYBFou1kIFV5pKO7Exbo8zXEO26V/ioioOTf13EpQf7AgqpnJ0qdQzdGyMxGGApAQsB
	Qpjd8q3sK/24aryR8jLuTTPb2mZhwomX5HJX8BRMLjW1oF0ax8Z0DR5+rzgoAJ6qu9v0EP0233V
	5ei8QG/OKJVwOebkNUJecpTSkS0uKfCDE43hvPecSUs83vMHWL8ZvMXwYTObVupEsYtQhedHCgD
	KyxJ6eJYMTAWp90H/78U+nV6g2bciDqw2IxuAyxFF3DG5RnT7eJIH3OX55KvhW6n7BHfbek8cbZ
	l4y+gMDQCvH4yr8V6Cj9+JUNJwKl3ZTmQS5xn5JOsEXQeFA9ONehONbm
X-Received: by 2002:a05:6102:1625:b0:7af:fef2:8ecf with SMTP id
 ada2fe7eead31-7cc3691cf50mr1706262137.8.1792309237980; Sun, 18 Oct 2026
 00:40:37 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 18 Oct 2026 00:40:37 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 18 Oct 2026 00:40:37 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wenqiang Zhao <berringtoni36@gmail.com>
In-Reply-To: <20261017195037.5501e184@jic23-hlaptop>
References: <CAF2O-sN=PM1MUaWzv2r3zT0TozZZje+0eYPiJLQV_LHB3-Qj6g@mail.gmail.com>
 <20261017195037.5501e184@jic23-hlaptop>
Date: Sun, 18 Oct 2026 00:40:37 -0700
X-Gm-Features: AclHuK8JKWALdvzAXKzaA9KhVvONm7cTVLuGr-8oL3l9JjZbRIhf609lS0VNoFI
Message-ID: <CAF2O-sMFDgcgGFTPvga_iwkyqTX8bHUmsTp9rS8Xc9_5c3zFvQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: adxl345: update period cache after
 successful write
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If that isn't easy to fix, look at using b4 and the
> web gateway that can use.

Thanks for flagging this, Jonathan. The sent-folder checks did not
catch the corruption seen on receipt. I will switch to b4 and the web
submission endpoint, and resend the unchanged period-cache patch once
that setup is verified.

Thanks,
Wenqiang


On Sat, 17 Oct 2026 19:50:37 +0100, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 17 Oct 2026 04:48:25 -0500
> Wenqiang Zhao <berringtoni36@gmail.com> wrote:
>
> > The ADXL345 event-period read path returns st->inact_time_ms. The setters
> > for inactivity, free-fall and the ODR-derived default currently update
> > this cache before writing TIME_INACT or TIME_FF. If the regmap write
> > fails, the sysfs write reports an error but a subsequent read returns
> > the requested period even though it was not programmed.
> >
> > Update the cached period only after the corresponding regmap write
> > succeeds.
> >
> > Fixes: 8a1536cc4a1c ("iio: accel: adxl345: add inactivity feature")
> > Fixes: f6f22950d925 ("iio: accel: adxl345: extend inactivity time for
> > less than 1s")
> > Assisted-by: LLM
> > Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
> > ---
> > v2:
> > - Keep Fixes: tags on a single line (Nuno)
>
> Sadly I think your email client or server is fighting back. I'm still
> seeing the split one. If that isn't easy to fix, look at using b4 and the
> web gateway that can use.  Avoids any opportunity for email corruption.
>
> > - Use a Latin-script name in From: and Signed-off-by: (Nuno)
> > - Drop the long validation notes; build-tested only, not tested on hardware
> >
> > The missing serialization between concurrent sysfs callers that Nuno
> > pointed out is a separate issue and will be addressed in a follow-up
> > patch.
> >
> >  drivers/iio/accel/adxl345_core.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> > index 6c9080d..cd58304 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct
> > adxl345_state *st)
> >  	odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> >  	val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
> >  		    min_boundary, max_boundary);
> > -	st->inact_time_ms = MILLI * val;
> >
> >  	/* Inactivity time in s */
> > -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->inact_time_ms = MILLI * val;
> > +
> > +	return 0;
> >  }
> >
> >  static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
> >  {
> > +	int ret;
> > +
> > +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> > +	if (ret)
> > +		return ret;
> > +
> >  	st->inact_time_ms = MILLI * val_int;
> >
> > -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> > +	return 0;
> >  }
> >
> >  static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
> >  {
> > +	int ret;
> > +
> >  	/*
> >  	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
> >  	 *
> >  	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
> >  	 */
> > +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > +			   DIV_ROUND_CLOSEST(val_fract, 5));
> > +	if (ret)
> > +		return ret;
> > +
> >  	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> >
> > -	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > -			    DIV_ROUND_CLOSEST(val_fract, 5));
> > +	return 0;
> >  }
> >
> >  /**
> >
> > base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
