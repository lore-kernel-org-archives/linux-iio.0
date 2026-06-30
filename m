Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECF3D890F
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795896; cv=pass; b=s0A+jAELXQxDHejjpmJrwg2730GmDAYTnSS8qZxGhKMIyeYf1shE95EUzKt+PS8uhfhqis0/ean3vBZkyvIICgCotBRBV1tcQjRy6LEj9SMaSd3cz4tLrtcHW+ATYX0598iGRu3/75GYk8/j1RxyCd5bjPaa8fi74CGJTqa07pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795896; c=relaxed/simple;
	bh=JSmL/2riPz7JdDua22+DrV1rd4FHdRa+ItDrM60NlcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/dd0Us+N5NBduN0ewCad8K0OgVEvFr0L4aS77C4iPQkRE6W5Nw4Iz37aCY0UNlts9eHvNca2BxJhfrXxUBpxkPVSOeOckH4eXQjNsQli2WiHbwsMOoVrOJVAiWtmzjVAq/ETJqJvRN2qR2R14AxHSdIl5QZtcdx1+4VEDeS84k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7s3oo86; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7s3oo86"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30df5854e1eso212752eec.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 22:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782795895; cv=none;
        d=google.com; s=arc-20260327;
        b=ss799Vn30YT6SGnIgfPkDwz7iQmbPU/Thx1p2hm/c+w/hnEjFV99ufyIjg3iSdxXVl
         UIySGFKlAHH+l1Q03dnexEoXHj+xCuWvYF315ihyUmjrKr98jEURnaOLZu+olkcwYZ1F
         BNGMXLZhpBdRGrvMlReGBCmi5Y4aNiPq4REqAj2XFqCapNgaKj/50E7mhpAn8LQUqNZi
         5OeZyQXWyqx4Vd66jQRWe+mhiS+GJ5OqNlkYYIuObLbK4ilkg6CTPdHzsjLCQ/8F+4MR
         AbUu7xw6Wy1JgJlteZu8TDq23ICYrNzivrtq4Q6Pb1IiZjnVoHN5TURD5hKP9eLAUqQB
         IkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+C6hj2XUPcZex4S9rTTRGwiYoI9zoWRu+B/pN0fu6nI=;
        fh=zKJ6BPrrNXtp/swEACiDXp2xez8a+ySko8f9NQOOyQY=;
        b=LAcbSBIqhgzgF2vrjH/AL/zKz57SNnJKwfJQu0k0ENrVcbYJMd5PF8aI4+o2LRIFXR
         HUMZGsNcJ4R+PpCxW+9Wd3pu8TdX1whqMsiAK4BCZIhGiZTwQA6lJhsFF4I5qFFqptrY
         wpUbNBtXJ+xQhBTIBSrytUvYbQxKYBDmS99fjs9k4fgh4qY4Y/+aNBjNVdcMVAZqoJd8
         W5ZIdJvwE3yGqTQ6iDaZUZNrSGbl5d9mRo6hJwNC9iTB//260Y3nYLxKq/lJlwBwx1x/
         /WPE7WlGCe5hCTnnajMsRSlLhJR37WzVJs1k9kjIE3t8y99NUs+p4E6NDvjtfilfNv6G
         UHSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782795895; x=1783400695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C6hj2XUPcZex4S9rTTRGwiYoI9zoWRu+B/pN0fu6nI=;
        b=Y7s3oo86WY2u1SY/lSGxsVtfwox4MP/6Y7P25p+l6waC6Q0lX7o9PciRgFhJ0XjYCB
         2nTP+DED86f2daE0LKwQt//ZS9MdvDQpMuUDZZvjSXk1o4zoW+YOzXlWV59Q7Cm9ZNY6
         Fgw57QW7pOSb4EfxZlXOfKU03szIOsLREhEy4S495VIcjDwxAqNGMoEqAyS6SrlDrKgm
         GG6GUWcH2rmujjBkOjlL2XgHubMqBRYBh54hv/cHeiUhMG/876QCAbgAGBUggWaFiqRo
         d/2NYelJwXwFKiR2iJ28z/FK7ZcSDS8NWFnBmZNzLkYjIegwL+wQ8UZC6usNcgWPgOTM
         xgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795895; x=1783400695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+C6hj2XUPcZex4S9rTTRGwiYoI9zoWRu+B/pN0fu6nI=;
        b=CeIH/zP8mDUdrF5bjTUA5AD9tpbVMNsjakz/BCaWr4Sl9VGtOo4vnxUklkGOd4hOHc
         9QV+NwvGvm6430lCqrxY1YRlsBbYjwp+nqYbkEoC4/c2NZcJbhhulVD7kRcTJ2EI73P8
         S2HwSKgQPRFBiSnJCQgUKskOfF9oBC7abqoFe4tzb54EfdTeLd4P1DhH6ZKrj09XpjS2
         RqzMp1+0CLFA4SJ+eT1XedoZehjWlF18FPdk/eWNk1bo8Gx6K/Y9jyUYi4OU9Hk3G02/
         w6CsVAkNCS2z71A8CRxslnZ0AwHVQELK+8XcAbiaLLsTVTJiKEakxKKiGujtxCi0mKLp
         Phxg==
X-Forwarded-Encrypted: i=1; AHgh+RrVXjwLOyv79JaaYbUAi9knzXVKL3zAAmLw2+YRB5YvWIX7Q9ipjcGyS7SrOtJicbhWP0XbQdQuVyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyepRaK7CslSTWSXVYLEp0UUW12aQKpji2G9NvV4UlnnoMmyH75
	S/pTqx5MpnAz6tTiUkyGZmifWqEYVNmMKFoK8edlC6jRNeCn3HpJ4tnYKVs+Rs2fzPBPlDU9lQu
	vRxReYnK+V4MkfGexWXZV5QNWz+X51rc=
X-Gm-Gg: AfdE7cmsTGgz5w/5BHBlzWdUBFCDtFue8bYpEYclpTM0+vdU9xUXCRm8ijU5Kgb0WK3
	dGzg3c5UnXWNarJHZ+5Bw3xYxi41otTbdygUO0RVdqsVbS204MHLsAFXiFfqvXlgIcCTq+RDBVg
	ZZq6eUYDFc1+ar+T7YAbmlG6ol6vznytlrcp5sZCCXtRglNPMF0bwFgP9GqsmNDp8VvmevesQVs
	Dg4ACZERZI91wupGumJmSTRc5LzInCUwAfDIXqTs+Xvfx+KwZge7en3xEagcN80tAd4xeUrU+HQ
	4khfkuo7dnzC2KeeNIGLMjaIhJ3RYlEdiNp/HrVG4zKMGl+vSR/5sBOlRyTU
X-Received: by 2002:a05:693c:3b04:b0:30e:d66a:3faa with SMTP id
 5a478bee46e88-30eea052cdfmr313611eec.15.1782795894553; Mon, 29 Jun 2026
 22:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628191337.937-1-kimjinseob88@gmail.com> <20260628191337.937-3-kimjinseob88@gmail.com>
 <20260630000254.1d1cf422@jic23-huawei>
In-Reply-To: <20260630000254.1d1cf422@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 30 Jun 2026 14:04:43 +0900
X-Gm-Features: AVVi8CdiEieYKWqJIPC16G_ZpvLkF5ev-gruUCYcVF1FK7T-4gCgQd__iRhQI3A
Message-ID: <CALMSew+=8P851Wdc=zDLsU5T9YC_ZeTHRotCzYiFP=LNznZhDQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 2/5] Documentation: iio: add Open Sensor Fusion
 driver overview
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will remove "initial" there in the next revision.

Thanks

Jinseob

2026=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:03, J=
onathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, 29 Jun 2026 04:13:34 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Document the Linux IIO mapping for Open Sensor Fusion devices.
> >
> > The overview explains that sensor channels are discovered at runtime
> > from mandatory capability reports. It also documents that OSF0 is a
> > wire-format detail and that protocol_major and protocol_minor carry
> > protocol compatibility information.
> >
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
>
> One small thing inline.  Otherwise looks good to me!
>
> Jonathan
>
> > diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/i=
io/open-sensor-fusion.rst
> > new file mode 100644
> > index 000000000..832901f5e
> > --- /dev/null
> > +++ b/Documentation/iio/open-sensor-fusion.rst
>
> > +Timestamps
> > +----------
> > +
> > +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO =
samples use
> > +an IIO timestamp captured on the host when samples are pushed to IIO b=
uffers.
> > +The initial driver does not correlate the device timestamp with the ho=
st IIO
> > +clock.
>
> Really small thing but I would avoid talking about 'initial' driver.
> It can cause confusion about when something is true and when it is not
> as we may have multiple non 'initial' drivers before you get to changing
> this handling. So just remove that word.
>
