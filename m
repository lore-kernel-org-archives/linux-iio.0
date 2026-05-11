Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843C3793A8
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504818; cv=pass; b=CVXGQVhxortp6qIYJeq9nlDYbp1141AYS7tBv/nXeDcoXffqyhVo9W29evkqhmfO63wlLuK4GnXYUkBq/kefRZpJ61dHyIw+ozhtiLSQY55stbJ2JFYAahwXvdJrqyFis9nXiS+aNOQQzgebBGRIn6WWER+WUidy3UzCGaj5lN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504818; c=relaxed/simple;
	bh=4BvO/zQBhU6Zin4IwiJKbfVTvw5Wae/xIPKxl9ygjI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmRS9eOapi6EZdZxOkFEP1dUXGWhU9aW9l3RudG6BT9vT3shSRHXA6GSjaaAlY7XUeQ9ZrO+UGJ3PG4bA9kzcW7MAI5UBGj6VqJB2sslOzxH5C7X5ZJZHBS2HpZwLWAalIQ9R3AlpM+KR7p2o3SY3n4dcAVX2KjF0lMc2CHChsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni38hodP; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni38hodP"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c23248f3a3so11716657b3.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504816; cv=none;
        d=google.com; s=arc-20240605;
        b=CCUUas8wooehs1+RDBXhltaTjMtIKabN5Qyv4eQx+mTWYT8tDfRNbCXvM1dd0LI3Bp
         72ewI3c43zRhBq+sY1qZSIHQ66gcpLL5hPs7CVoUEAKyyDKifkFG0LUB+wotblhrORD8
         VGbXT6InUqjeHryL/Qy1Zlnr9Nrw7u7PCdL8yyD+mhYK9aiTB7wQXXULnKvK3k8AhAlV
         vubwC5rhfXEGwCYquNCiPu5JX7vZNHUxLTbaXEvZJFYNcp634vBXn+SFhsiyGu/Of0rh
         4CT3DEbtykgKAr4z4dBdDpVIzt4laf3qi6hp9s61RTlyZkK4mdQ1h7D+T3FHFHi5MTW4
         q8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yeRFt246thamc1v1zIYHej9YGBJf7rTRJ6nPINihISU=;
        fh=r+n3TQGJpjCUkewFYUxsMOjObHph4QBkQBomOMR00bA=;
        b=QoENuVQ4YuCgoliU5AYdzM/QV5avbnyBTLXIpB63bxnk/iW9okcIpgi5lsw2xU+rwt
         +QQkh1/9NrYj6Lu5PPSN8n2S63rzPCdXr7oE8QtER2ql1A3y/nwPYQaqDO3fulqwdqXS
         /vEOcj5vos5AYhCxG/rIqqLIilzdrK2uayDoeyTEt1AYiE6tGpu1xK41NdTzAnXbqWYu
         t04sue6YlpHJG0tzpEH/dnWNmJhEv8JwdwBTR62TmexngNTUrJsGb6OhXDZVuApmjwfb
         sXlApX7MUC2sxBL6Ujh8Zys/tfZIdmP2xJ4zxsTpbtLeApn+BnIjoA28cPoc4zZaakA0
         yLDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504816; x=1779109616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeRFt246thamc1v1zIYHej9YGBJf7rTRJ6nPINihISU=;
        b=Ni38hodPt1/Qi/MZWu2lcStvnIsmpwuatWr3tLyglmQF/fwY/0bHB8CyvB0eAw6e5X
         GB4obsOpvBNxar8ED8mp3SeH7P0elJBnjV1dSR465zVFEvB8QoOUIFPw4PLG41g2QjDR
         3YRdoAJ5453K2c84tA0jANEeuFyNfoJd5KdpoUqBOWqgsq5DMbqhvEXjSb+wDj0ysMHn
         93LwSka1Ky2dmyITh9fLZVtjhrf4bmVAENi1VQ4ZruMbs86VE0RfcrnLIVLdwidgF+B4
         DtoZPwI37MdMxcmihfl9RVATg/B4uHxha8BAOMBq99BzFknXgbgrgXo++PMzRe4FVqVH
         Ufbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504816; x=1779109616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeRFt246thamc1v1zIYHej9YGBJf7rTRJ6nPINihISU=;
        b=oWuVOiwzyTiTgGhq1+Dhe37yw/0EKCBRIHnsQPiRrHYEmTyJB3teksL2Nl9oLONhAf
         sGG82j+X7jkZIdOGfO5xhCk05/dy9fCPHaV8gxZQQDdxUTcSB7u5caoH8oou2L11c0Y0
         hzI7aRvfDGrv7QPGCu/k6Avpucp6qrBbMZ9rDEDkz90rtlGM2Lxa3J/SbNH5OA1Hp3Jo
         5nDiq1kz3AcULC9/oKaD3o3Ij2F6FLmvTIM/7PH8D6tx7sbaEO1QXHRn4chR5pnjD0re
         NYzbC7ZFUe8efAWVFttnq+ljRnLStJhoytS2CDFUdtGJPMk7jnzV5olyEffYKbwBjmqp
         BT9w==
X-Forwarded-Encrypted: i=1; AFNElJ9hoEf8hH04PLJ/5n4OdLNdrOXAuryQl8FoCyh1+caVb95uy5oRg1A/Fyv+vACaW3zImWU61iqUWcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKMcQfEWOnKi59gaWes1CxZGqypSCWe+/7K5H1S9CWZLD8eo0
	Q2bO/jcBL4Y+SWLwdwZG7lUQ37NnfayvuXv2c1rLGJVTiDzGmWUQuxRolJiyFi8qHq1gKpEGSeK
	fXSRONBnW3/rhRVvKV3CNKjCR1V3oMX70KLJs+hI=
X-Gm-Gg: Acq92OG2iggu16AAVGUiRTGB2qiIpebh+gdVAr4fDetgHjcUv7XXJKjUklc5H+MzpNM
	MToIDQkfGL+D+C5OqO96gKkPAFtqqtDwefBCa7B1t9+BwLam2hdubUdEwsxdNAOBBMQSGMvCQcm
	dC9jcJ8xBVUDuaQRXjWKI5WdevxEh92JU/VOih5zm/wgLRh58hnpdeA8Q/ALAoVL2yaB3pZKFve
	/1Dz4e7mvVlSEC76BIhqWfwuj5zaHi8r5D7HKADWpVL7nBt1nc/ThKBbrRR4NT7PZDTBiwjMBQP
	AZVEp+1iX9gI2Dd6XbE=
X-Received: by 2002:a05:690c:288:b0:7bd:7039:f30a with SMTP id
 00721157ae682-7bdf5f2ce76mr240629717b3.48.1778504815811; Mon, 11 May 2026
 06:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508225501.86448-1-m32285159@gmail.com> <20260511130008.38592c5c@jic23-huawei>
In-Reply-To: <20260511130008.38592c5c@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 11 May 2026 08:06:43 -0500
X-Gm-Features: AVHnY4IJzvjkFeRzbpCdKj7qf1xzvYWcvoNFj1DzoVijFRs4kOde6o9hZwI8XnU
Message-ID: <CAKqfh0EnJ=ViAafjeWGPSnkR0fxhOGYnhopowK-+H0bn=GM3wA@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:00=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri,  8 May 2026 17:55:00 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > The current variable declaration and initializations are barely readabl=
e
> > and use comma separations across multiple lines. Refactor the
> > initializations so that mantissa and exp have separate declarations and
> > sign gets initialized later.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> This is good but we can take this opportunity to make it more
> idiomatic - so more 'standard' for new kernel code.
>

Yea that all sounds good. TBH I'd like to get some of the kernel dev
beginners to check out this driver since in some of my earlier emails
I said it was messy (+ I'd like to get it cleaned up) and there are
probably a metric ton of low hanging fruit.

>
> > ---
> >  ps:
> >  Hi Jonathan, I noticed a potential divide-by-zero bug on line 241 in
> >  scd30_read_raw(), where the value of tmp is dictated by hardware.
> >  If the scd30_command_read() call on line 236 assigns 0 to tmp, then
> >  when we run:
> >  *val2 =3D 1000000000 / tmp;
> >  we'll get a divide-by-zero. Will send a patch for this later.
> Good to know but not sure why you'd put that comment in this patch.
> Also as a fix, it should come first - ah so maybe you were indicating it
> might cause a merge issue?
>

Well now that you told me that the div-by-zero in the write path was
already fixed my v2 would cause a conflict, shouldn't be a problem if
I revert it and add some of the other fixes into it.

>
> >
> >  best regards,
> >  max
> >
> >  drivers/iio/chemical/scd30_core.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/s=
cd30_core.c
> > index a665fcb78806..be8c055be184 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -89,10 +89,15 @@ static int scd30_reset(struct scd30_state *state)
> >  /* simplified float to fixed point conversion with a scaling factor of=
 0.01 */
> >  static int scd30_float_to_fp(int float32)
> >  {
> > -     int fraction, shift,
> > -         mantissa =3D float32 & GENMASK(22, 0),
> > -         sign =3D (float32 & BIT(31)) ? -1 : 1,
> > -         exp =3D (float32 & ~BIT(31)) >> 23;
> > +     int fraction, shift, sign;
> > +     int mantissa =3D float32 & GENMASK(22, 0);
>         int mantissa =3D FIELD_GET(GENMASK(22, 0), float32);
>
> though maybe worth some field defines as well.
> //up by defines at top of file.
> #define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
>
>         int mantissa =3D FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
>
>
> > +     int exp =3D (float32 & ~BIT(31)) >> 23;
> Again with a field define this can become something like:
>
>
> //up by defines at top of file - and check carefully I got this right!
> #define SCD30_FLOAT_EXPONENT_MSK GENMASK(30, 23)
>
>         int exp =3D FIELD_GET(SCD30_FLOAT_EXPONENT_MSK, float32);
>
> > +
> > +     /* Determine sign of received float based on IEEE 754 standard */
> > +     if (float32 & BIT(31))
>         if (FIELD_GET(SCD30_FLOAT_SIGN, float32))
>
> > +             sign =3D -1;
> > +     else
> > +             sign =3D 1;
> >
> >       /* special case 0 */
> >       if (!exp && !mantissa)
> > --
> > 2.54.0
>
>

I'll add those macros for the v2. Also will probably add a comment
saying something along the lines of:

/* IEEE 754 floating point arithmetic macros */

best regards,
max
