Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB43F99F3
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484094; cv=none; b=XmebuZ954k4JcGVwO850V2nw3OyQT4SqW+x4wPG7MNhBrjc0DwoYovJaUw3V4132xJdyNd0AqwXXlrWxMFbdr6cZhXflxFD05s1QYKZAphquSU+uREz+1SS8ZJ7js0IMsLswk/Tk3zogcrQ3tP3uwWZdXTBwJnncyMpEJQc2lPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484094; c=relaxed/simple;
	bh=v1U243K3UtKUTKLGdFcex2bh3SpHT5e8KAoGSxE9O2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPNa9rLptHQOf6QtdAUk5lWsQmF/DIifDqEwaB4eAsV8fqqIgDLVeFE4zjqhCM23OJhsd1+ureWwRfEieCygDgAvxAxj+7fol2ytrxFZb8zClCPN7g9Ws7+5QI+0jDek/NZCjodvuDmUJBOPCsgZlq6pxgHd5DIE3MzIkSXuI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhmJA+Sw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhmJA+Sw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45fd464d51fso562116f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484085; x=1783088885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1U243K3UtKUTKLGdFcex2bh3SpHT5e8KAoGSxE9O2w=;
        b=NhmJA+SwPWR6K37K1sjB+c+AkkQyhrZ24LJyJfcPFM3WW9YU+wc4o2nae4MZ38rIL5
         sAkuB8pjBaOEqmqiPAVLjbpYe5+TgrYU46GUAG1qiHk4rTbSjlpP6gNpLp/fFbLZu6fu
         HuBNc/IJrr9348X/M74zHwNQgNhRqLUQXb+QDkC5tjsoMubYPpCLVAONwEIjWByuPxpc
         W26i6GkWvAgRmIdrq7Ht4SVGza9mYXM8eAQmo/AqgCBPkuRd/MupCLayulPxbCzDXmus
         zQ4Rsv2/pzWqNY4/CFywd9QfAsRVYKHLoT5B8wbOJHhgM/hwDfBlWpm1PplmSnPGPKde
         U8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484085; x=1783088885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1U243K3UtKUTKLGdFcex2bh3SpHT5e8KAoGSxE9O2w=;
        b=lcgmI6kd1NyTN/wEAxO0JcQ90nK/SX54Yt/iUgqhiK2zO0PIf/uot2Z0ERXO8n3bxQ
         2+UPGODPB4rCrMBk/H1OP1sIF47IECuC4pJz0WNJURSAA/XiPmHvErODcJYop4gO9piA
         QeUUi9rwjkQ8DOmznKg7dKer9uOtrn7QTSkuhfo+dAkKiRBhmAlij3Zc/IFkSU8vmIDQ
         1zSmN+RyghtA3aYthUxJJPIcKhgSg9vHBxoTwo3awHOMXupiGn1hzbCbUdnQCHXMOxfc
         PK24rs2WJmHkt+DDPz41TaI3IPRy64//0D4pk/O0y0ZO8JzjNxhHiFCf4BcSUBfldwIv
         puug==
X-Forwarded-Encrypted: i=1; AHgh+RqPRkD88sOqXijZUGiE4GAAuMWGuDxVJ5KmeSdA6mJJc3NfJGcHWrxs5m276wL6oDtAYZxEcJnvgG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuV2+6O3/RLKAy3xAoZRDbBAl+lGRMOvEhK2lMjHMe6ETzg4N
	RYSaVaL057h0QEmgxxSK+QBKyXIQyYPuRdSh8leO5WOMKSnNJWj+eR8x
X-Gm-Gg: AfdE7clGu3ouaSfAwOpwqbypON/U79NmAH1USJifGAuFU7AqouKBMGlwP5NEi1dicwv
	uD+Ya12bOx0CJtQT1K0NY5l5Mo7IBt980qYq0/B1+VaP3BkiDrzZSgM1C0tSK0vwP59LbKUqWOh
	bp9XFZ118yftCJYV0oR5UP8Liw8rJeG2pj40VZWO32His9kjrQnnV2uPz13nr8QbARqL96MLj8u
	EaH/rXfHxKewoTeL/5DBgI06rTyw1V5n9nHUHDohitWohtb3PMDII5Y5H52/xadtGs5HqNbLrS/
	8/VyHLvkw8CYVGzAEA7Wt06toav4uQLo8zlykYhIoOM3gYjHZEInkXXo/Y9J3OH6jXH8Ro1H7Aq
	SxFiEO6Q2YFv1QnZpV1WcNEWKjoy3iOywP7wp/X1BdR3vS6/mc6UwYp40eXjlpU3wf/2cWhALnQ
	3Jbc3aJTY+aIMkSQdpwU2LWZZ62Llzq9noP34GfaZM8JqggNW2K4dTbQZLufktVx9584BfIb1Ta
	zuAYj/fCHmur4F9PmV4IPxMSbUqDLcbnPn24VjKna3xuSBTtyJ4m9T9m5OZK96JbDYrWt1bL2xb
	abrIAuBGepAx5TRGw9xV9Epb6rqkbMp5LLPbN/kn/HX5DeedIZ6+nzc=
X-Received: by 2002:a05:6000:290f:b0:43f:e990:2f5d with SMTP id ffacd0b85a97d-46dc34bbb40mr11873373f8f.35.1782484084729;
        Fri, 26 Jun 2026 07:28:04 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46ebf4e1b95sm7972813f8f.1.2026.06.26.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:28:04 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:28:02 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg
 <david@ixit.cz>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <20260626162802.0000716b@gmail.com>
In-Reply-To: <aj6EhyuOxBqDDf0X@nsa>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
	<aj5v3rDRlY7H39Tq@ashevche-desk.local>
	<aj6EhyuOxBqDDf0X@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 14:57:05 +0100
Nuno S=E1 <noname.nuno@gmail.com> wrote:
> I'm not sure we have a defined policy for that in IIO. Now that you
> mention it, maybe time to ask...
>=20
> My understanding always was that Jonathan takes care of Ccing stable
> but maybe he just does it and being nice about it, does not complain :).
>=20
> So, Jonathan,
>=20
> Should the sender take care about Cc or not? Or it does not really matter
> :)?

I always add a Cc: stable when submitting bugfixes, only this time I
forgot :P In the end Jonathan decides whether it should be marked for
stable so he can just remove the tag if the fix isn't backport-worthy.

--=20
Kind regards

CJD
