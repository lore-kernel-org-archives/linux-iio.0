Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C31E98EF
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780876858; cv=pass; b=cDztiz1a+UhmxKt4iBxwiZoWNDVaG6QlqVhHQuGoyJZpahP1fqStXVaQ9tz3xpVVog2VNLD7u1n4WMEIF8v8Ca3m48i0HyjY4ShQD+vOEBhtTrxlJnbcPlm8f3Fdc8JEVFzK0BwPnUMuFqwtxOOLY40vuuIU1bdksKhl4nj4t1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780876858; c=relaxed/simple;
	bh=VuwmmwFxGMekqquc1DCDYbDslGEIlrnt5yEYKf680H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwlWVdDCMp8VsPyZQGv4KHIkxIl3MfLD7Sd62/wD5CqRPnasfXHl6U4DaTQVa6u0RBP8v7iu92zp15g7i3cNYxrAt60L0WIYjjOxaV/fknjiBZJxe+n3D/Ca2VY3rt8kgcSnZH67zbqycWpOoPS/bQ1P4VA8c3W7TVYHQY/mLC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkH3otez; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkH3otez"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307263ad0cbso4714993eec.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 17:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780876856; cv=none;
        d=google.com; s=arc-20240605;
        b=Cp9kZ5tugS7DVQzSuUnE+xVOna0G3zVxlvdIQd27bV0qIN45Xkavyreq8O9DZvwj7+
         X4YttDssD/L3Q+//KErjjXAJu6CuL0Ds4IM3CIgoc91Ifbap22cF4Q8NxIfRwVcEdc1N
         lFlQfSXBxjbcb4CKKRX65YeUbufPxGgiST+BQKA4UVnPyendH7fxwcPL3Mq3G38XPQ/o
         EFFg/8YqIJ+EoZZDs+6MQYfCZGzDCB5JZs3jSqW+Q8ODBwwBzM+g90vDaXiCmRfqAwyI
         8q1axR5iFcCNSUWtnoQQxwsGETMgrQ8qRQ7f139Iz9YrqxRyLRr2hVAbPAw98qSttygY
         nOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6U/zVL7rPRjDbkA7h7UTZUE6hh6LQLfurYbgFDIpVw=;
        fh=oDQ61pzT2SwFz8IQEjgLDpMnB15rBqlvEal+DYV4S54=;
        b=M5/cVto0bd/oh5ZTWB4dcMqKKEfZ/0SShbMNiEdf00/WGdaACoQ7kMrt0H3ygXR343
         qO2ZM6N+/26kDYgslEezpy+mIiomGwLext1YTdD9TmdSJ0MrozVFWWBQ6L5Y1Zpt4bbo
         S5ZjO8VduIvBBf3Mu9rQoXcbUhEUOa1PSECJg0Lom4i75piK/LhvGW2rFE7Go0EtAVkM
         UhVwMk4ArIcb/5Zn/42YkQG7os4xQoLIeU5HlFnrhDncs2wMDfcTLGN93bmnDD3FNbdQ
         7Nd1XUqUXchIZxak50G2PZ/0AiLGPSAsYAOaxiYcjDCsKzRRVPgQeLmIolfQ92n1BXwQ
         2Q+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780876856; x=1781481656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6U/zVL7rPRjDbkA7h7UTZUE6hh6LQLfurYbgFDIpVw=;
        b=mkH3otezm0qtNWzjW0ytoNsQWLVM8ms/mzCt8jIioqpc0gxUVbo5W9DnqpPbiX5b3e
         GifL5K/PVJq2O9KbXGwGN6YGRRnkNk2gS6tteYiuXkz9Yz1yupoRX8D61Qv+DTY6UgOh
         EVSjDtLeXr4YW7CBbz4bKbufRJb4sn84nYCxucMajsiHUkNtwyRqt2UV/nJ5QjZeKoqu
         AnNR8IXs4EQ/p0HSkbAAxlwFpjcg8hxg2XCACT0/l/VP6h1v9IuEQxfnEII0Wp4nfm/P
         RHeBkF937zC8RKOOdBAqbdmH0nC09UdWJz7k68dS518Vg+zz2/YJFhdFiOedrNLUOCKe
         RLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780876856; x=1781481656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6U/zVL7rPRjDbkA7h7UTZUE6hh6LQLfurYbgFDIpVw=;
        b=tFGYo1OKUKlizAbr1fd+FhneRQZnRV0LI7LrOWLF5ZAZW83gGU3aRrNLfOva9Pm70g
         VOvWLgE5davQ6oMUbSSgaYXIk0KS+GrjUh08Ml5iCsVaW/YWSUouIdPcZkavhn1febHJ
         /dntXnG6r3dpGoDWrWA9i6fdYeOIukJNPn2fWzo+hBV7chMvT4YN1JNOZofRJwMT9S2I
         0htr/g8mk9IY8rwSdH72daye1LjGuyjC0dg09iNjqITrK3ADQfwEkxXlOMy1tNi2hkYm
         +aD5a4EzlhzqiieCkJEOXppW2JHI2SSCCt8CHjBUSxymKTtf9bgJ/g77Vy8ZAR1rOJ2V
         /Cfg==
X-Forwarded-Encrypted: i=1; AFNElJ+IsmJFsp9Rw89KC8TK1hZgYmUIjD+/YnJ3vpBIN1KlU20lIDtQ4fFHmViN0ggVM4fCSQySyW4weZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4Z5TXjsnXJPEDofSHFAc+lz0Vacnlf3iZG1PGPuO/avllafh
	9cIn94Y9raW2pZszwuAwTT2akrlsD7NTMFl9Pwzohjf6XnaUat1iTWG3YvKImp3eCd6qtKX7eHG
	KCiX7nx8GHuwiw9Ab3ydMl17fZRpKSwFdrKntn0bRRg==
X-Gm-Gg: Acq92OGx8abUK4HVJxZPBIBNayjpwsSQwSy14qZTSZflF57ECb6Zaw3K/oInHc3O4Q0
	1IckNGJIN110rlQyM3Vr8w3rdcoQ4fCw3sWk5EF4X30mCG0eSG7OJoPoqyC00bVyT/iRQuDlahH
	vtnn/DJf41sr+gcpVm9kgxM242eJjTI0Tq9zmJ5PG5DO+IfrS+6X/yK4lAyHEF5Q/cf52QPKk9i
	YMPhLJmWUvdLVi3IED5XvZsr/eCgeKluiA9iid7+sVVQjUVKBCSnnyK6zn3Fm8D0a87IjfqmR6E
	uIJR8odzeQW2TqrImmGrpnopbkLx8NJR4jxW1mVTcluWc+KwiGJYTSUwZUdL03SePlvxoU9aYs6
	m7NcbyA==
X-Received: by 2002:a05:693c:3003:b0:304:d835:27f with SMTP id
 5a478bee46e88-3077b15d304mr6234605eec.22.1780876856248; Sun, 07 Jun 2026
 17:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531111605.2411980-1-jic23@kernel.org> <2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
 <20260603145551.3f97ed31@jic23-huawei> <CALoEA-yQrjLyt3vwMKxMy+dj4f43Cj8PfZFtkGPBBP41oz3Myw@mail.gmail.com>
 <20260604093706.1f02eba4@jic23-huawei> <CALoEA-ytCTBP8V5jSJLgCsxwyG_g-w2sh5QtutQqFoYzO7Qq=g@mail.gmail.com>
In-Reply-To: <CALoEA-ytCTBP8V5jSJLgCsxwyG_g-w2sh5QtutQqFoYzO7Qq=g@mail.gmail.com>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Mon, 8 Jun 2026 09:00:43 +0900
X-Gm-Features: AVVi8CcIvDmvac6xeYe7GDbkWmsRfY_XhUDAMbs6OmxCgO4LPDo6G_Im8GPKSNw
Message-ID: <CALMSewJRaX0VSS+eXgZjp1MYai6RHMTf0VBJjn3wFewGqPMXCw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned case
 is zeroed.
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Reported-by: Sashiko" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Jinseob, could you please test this with your OSF driver - at least
>make sure it doesn't stop the data coming out!

I tested the v2 patch as posted, with:

        memset(bb, 0, indio_dev->scan_bytes);

The test was done on a Raspberry Pi running 6.12.75+rpt-rpi-v8 with an
OSF GREEN prototype connected over UART. The patched industrialio.ko was
loaded non-persistently from /tmp, without overwriting /lib/modules and
without depmod or reboot.

With the patched industrialio module active, the OSF driver registered:

  osf-accel
  osf-gyro
  osf-magn
  osf-temp

Raw reads passed for all four devices. Buffer reads also passed:

  osf-accel: 2 samples, scan_bytes =3D 24
  osf-gyro: 2 samples, scan_bytes =3D 24
  osf-magn: 1 sample, scan_bytes =3D 24
  osf-temp: 2 samples, scan_bytes =3D 16

The padding bytes were zero in the captured samples:

  3-axis devices: bytes 12..15 were zero
  temperature: bytes 4..7 were zero

No OSF/IIO oops, panic, BUG, WARNING, or call trace was observed.

This test covers the current memset(bb, ...) version of the patch, not a
possible __GFP_ZERO variant.

Tested-by: Jinseob Kim <kimjinseob88@gmail.com>

Thanks,

Jinseob


2026=EB=85=84 6=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:43, Jo=
shua Crofts <joshua.crofts1@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> On Thu, 4 Jun 2026 at 10:37, Jonathan Cameron <jic23@kernel.org> wrote:
> > > Sashiko had some remarks about the wrong member being memset, however
> > > it seems relatively standard... human 1, Sashiko 0?
> > >
> > > Does this memset operate on the wrong pointer?
> > > When iio_push_to_buffers_with_ts_unaligned() is called for the first =
time,
> > > iio_dev_opaque->bounce_buffer is NULL. devm_krealloc() allocates a ne=
w buffer
> > > and returns it in bb, but this memset uses the old pointer, which wou=
ld result
> > > in a NULL pointer dereference.
> > > Additionally, if scan_bytes increases on subsequent calls, devm_kreal=
loc()
> > > might free the old block. This would cause memset to write into freed=
 memory
> > > using the new, larger size, resulting in a use-after-free and out-of-=
bounds
> > > write.
> > >
> >
> > doh. It is right - the patch is garbage.  1 to sashiko 0 to idiot devel=
oper.
> >
> > I messed up the line ordering.  Memset should be at least one line late=
r.
>
> Right, I must be losing my marbles as I've completely glanced over this
> even after reading Sashiko's comment :( At least my remark had some
> sort of purpose.
>
> --
> Kind regards
>
> CJD
