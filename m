Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072015ECCC
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691772; cv=pass; b=B4O9NTF4x3JSTDB4xqqbPvnYaK2xER/ThqXPP1aCq3lxSuhO8AFRVhQauh7/ZNMpPSSjLIEzvf3ax9mKWPy9cXzh2q1aBImDGNCG5vuf8SKCE/2yE+9EmNXZ85wdk6wbyP7PIM/jQpGSJiC6BfF/988GdqRYPMWfb+QAq1FXYsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691772; c=relaxed/simple;
	bh=WKQL0SZfsOzmKqOW+VZEXhYVkAaBLFGl4neaNeU3mUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+kazp2Et55VLvq/Gc9ZhmVgR5PzwUDM84p9Hvn7fW2l7W4M+8Pr+EOGDwmA3fMQ4+ILrH7zqV5lIYHaI1w8UoagTxV3jM2c1hA8jg614mSHP2S+TNC3BJi/6BAIldFNqZtOCF6HqSK9Y2VafZPuJhXpolgVYo4ka/bj72Ao3SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiBzkunv; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiBzkunv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so2214227f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 23:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779691767; cv=none;
        d=google.com; s=arc-20240605;
        b=fqE1WH4LRgsvbINgiLwZxz0WDn+ae+OhxzlYIHPyg/6Tf/tUHuDA05ijmHDyC/xTVA
         hS4vWQivrJZ5FgQeaDi9quae/I17IGILLk3xWKSmGGtPxugyvEXhQtfFzNng0uEb7p8F
         N0ij/Q8E6hN+OsZfN/16u52D9fOXIsIMyYCqX7IiOGlsMOBGowH/y5/vB8Jh6uYeuFO1
         Zib68QbcBISRXo/g0L8yTzZ8qNAHb06HOnaz5qPmu2ApomK8wKTcBt9MvokRvWqOsqis
         tXTnn2tvfKtIj6eCpljvthDi7JxyHvCdZpsdouQTDwP8af0FMFwk6gMQXuImxnM79SZW
         7Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ssSVsr9lYvzBe9PZ+cw6PZyqOJvBLPTJwm3YateXmow=;
        fh=pLfWm/ZJiFsnwAXu5q6mHg75UAtaC957tyZ0JH0NqFc=;
        b=auLmY+Ngz/IU2x4sKySkiNS+5rZ+ezpadIwdqO8Y0KKDVID15H/6Tycul6NSmOjZKv
         ncUkn25loA8XFn/daUNqxjSydWjDJbtX2epQdUpqZJA1Xn0UKz102fr1UdPfefG+VBuq
         ZyXlAjbitvXF5sBFCcwl3TGYWRSAGM8hjr4gqhQ230gi+86JViASxxKyVCu+g8ITUJPl
         lBF5zC4XFr5xCt2yalr10raOuOeB0Qa4KvPjvhiCRlUfiLWu6GEJ2FTOe5kx8pR3W0C/
         O0V3odBzAEFtEelKS+/6cp2WfnWjHVJVlvN4wANj6aRlaYcIKATZqQYeCA76oXzLhwDh
         Qmaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779691767; x=1780296567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ssSVsr9lYvzBe9PZ+cw6PZyqOJvBLPTJwm3YateXmow=;
        b=LiBzkunvlaXSuDuYeCHF2Wu3v/lyTQ6cRMPWu2686ntr968eZEfYcMU/aOICQVToP7
         uEO5fCDnYk1XRxZI/OLf8tl3kBSaq33UyMMJZmmOXc7vK1OhEz2CfZqMJ5Jr30VTAh6o
         1VM90TxpXI+jR1tTGUBiCvPu+Yeo8z1CPq4IQZp7g+2Qw3qnFnFfjDPxOQax1WDQcQMT
         qfHxOf1fB/fEa8TdgET6BhwSBmZnlPacpoiWPT/PMX6xBNtipg7+H53qDlSG0iKNf67a
         QCnDtJpFEcub9Dzosvcl/iIZGc6cxtngGRTDHLVLznPj1mk0uVFp+ajQ/ZkArEkdmMrq
         yHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691767; x=1780296567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssSVsr9lYvzBe9PZ+cw6PZyqOJvBLPTJwm3YateXmow=;
        b=MH2SN1LLt6kECaLDJPbr0Gd/IwIGvjBOjMqoMS6X5MK42NVvs3CxqrdAk0IU5Hi9o4
         rzPbUahj0uowl1DmTHDKd7zx6A8Dg+0KreHkZonC+8Rk+Of3WdX4hlm3z9RUjnNTh4Xc
         z90U33xrlLFnxeRMW7ErIKYproyMdkESDnPxRKqLnxLENkNLN19UKctqwq0KU8gazetE
         LdQjk9zG0LnaLBmtQcLFUh0AwLwxPkpWym7ZaiW12m5dkJd39Y4e/Bawbi8gBfqqegcI
         NCvdCFQhVCEftjJfJ61mf70V/oAf5SBsdhn3UGUck0OhMNRDAONezxgvTkZxdRaHMQ7g
         Sx0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+gst2SAhaHYE+ysVNDGkT+j2IONEcKP8pMk/yBIxaE8MWI7S44ocS7h8HepkIzrRKOk2hvn0uBeDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5x+sM5JGYVNj7X++CQTq8dRTLYegLrhBlA7ULOII4UOrvAZgk
	eZLDv1OS9f7S6AJQhkDKFFo43ZTGxlrdYVefQL/g1eQVq7ZgEZLr6/sqqsu3pvr69Kot1RiYv+u
	dLJeWggmDcvMiSYkcPxb0a2xCwSw7D6w=
X-Gm-Gg: Acq92OFOQNvw/GVKHCrctXGkvqu+oGhe82XVi2RaS+8WS0QxgLUsi+JG6sgHgxlAwMn
	Dr7a3XlViKBp1TNPV5TjOvgmc9UVVh9EduyqsOVBf0+hbMAYqi342bzN5UOhG+6ZtLeU1gXVopO
	NXvWX5bDzeQ5WxJr4FkD/pZy4cL7u18AI39pIjFgiQ+JscvGWIoqgK7vlnLv6EPBjyO8JZEnoaS
	0LaMaU8umV/fBlWexnrRwPmpQUyYdL59K3mCUc1fgKrY2lwiDTSRXIIGB+P2CAUC2C/UDODeFpe
	tfrUxcHzzikKvz3y5WX3UD7hRcl5vd5jCcNhbAyjUOlQZGVk+NCVwf4BHKCZQkdnpKEXGc9ILWg
	4JsW3zAztsgjr6uV7IjRAFpJXb9J6hvVWS3Zqv+uXhrbCdLo/LUBm4GzmyD/7dpsjMr6BU+ixLU
	oc5Ei13H9vI5hDMA7e
X-Received: by 2002:a05:6000:2f81:b0:43c:fe66:43ec with SMTP id
 ffacd0b85a97d-45eb368862cmr21828421f8f.14.1779691766525; Sun, 24 May 2026
 23:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524020309.18618-1-m32285159@gmail.com>
In-Reply-To: <20260524020309.18618-1-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 25 May 2026 08:49:17 +0200
X-Gm-Features: AVHnY4KlO4D2KIVP42smtdkfcm_TknfoW5U6JV9qdvHiZ_nnm-WMhgBK6dv-cq0
Message-ID: <CALoEA-w7i4wQR_k9Eb6KPQLiLk6ZVrFmFoY9wHaO+7=ng=H-tg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 May 2026 at 04:04, Maxwell Doose <m32285159@gmail.com> wrote:
>
> Include linux/bitfield.h for FIELD_GET().
>
> Create new macros for bit manipulation in combination with manual bit
> manipulation being replaced with FIELD_GET().
>
> The current variable declaration and initializations are barely readable
> and use comma separations across multiple lines. Refactor the
> initializations so that mantissa and exp have separate declarations and
> sign gets initialized later.

> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Not really sure, but the title of the commit could be better? Perhaps something
along the lines of "simplify floating point bit arithmetic". Usually you don't
need to mention the function name in the title since it can be found
in the diff.

> @@ -89,10 +96,15 @@ static int scd30_reset(struct scd30_state *state)
>  /* simplified float to fixed point conversion with a scaling factor of 0.01 */
>  static int scd30_float_to_fp(int float32)
>  {
> -       int fraction, shift,
> -           mantissa = float32 & GENMASK(22, 0),
> -           sign = (float32 & BIT(31)) ? -1 : 1,
> -           exp = (float32 & ~BIT(31)) >> 23;
> +       int fraction, shift, sign;
> +       int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
> +       int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
> +
> +       /* Determine sign of received float based on IEEE 754 standard */

IMO this is an unnecessary comment.

Codewise OK.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
