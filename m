Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBC2F8EBB
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329671; cv=pass; b=H+jokN+sZI4fmbswOgZukZtgJfMw7Cc9hyoR+uyu8dwrwM37LhQNYoMMYcOuRkO78g1IMhKqAli+oPWukunQWKBhSl+7UHJA20vNGzkBoW3hEYjGiEwMd7biIG91/VauhaMwiB41CkFFhFNrjpIHgglEbY64ARzxyPk+sfXbx2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329671; c=relaxed/simple;
	bh=2qfIE+Uj+kCo8x5ekxvSZlCY0fOo6OniwoeiUF4wN+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN2VG0sKnAvDhofYTa0NESa4Rkga5gOB4SS7ifK1srbRtQZPA+p1Rx5tjShWmTwul0EAnSRJbr7WLrM+4MNVQ/VZRfTUGHQEhxL9iCvtzXh7WdtUvDo3+BbGGUrQTKi+I79TxRe3yM1To4/T1EXt+7lvlB47l1tzbtN2hDf/h0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUsdVRwn; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUsdVRwn"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a535e7c00so34119737b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 05:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778329669; cv=none;
        d=google.com; s=arc-20240605;
        b=llVSNblWx/vSw1IH1gX3JSD4ZQ/2LCwDkWbV2hxFKJLn1S7m2c10ukD6n4LJ/oXZjf
         gEUIrGrrMDUQ8oINsw0/jWUyrSBskeLLcCSSpKlXns8RHYpS1nrsitdOQmkO4nPiA1Ec
         8VC7agnx5RGDSQ9+68++aRQgZzZBzY5GRipkqDXlEXbHsQWi2Ybt7DzJcU1/xl1fWJmt
         vRvhS2rV51u45XAPFoR94xw4n+QBr9U6NHsFf9UpSRoS5Ge3xVcTR6apaoDbrr9OUTD/
         ORbaKKHEWp1hOGGqSnG3jfe1Sdcl4TMBXC9SVtamPUrlFq66vrTJh2gmdxU5Mb9bv9kj
         G7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/CUTeoP6j2y78MqiqLoSIyp8c6EmIMmXSLEhxKoV30=;
        fh=XTBKpK9nNwIl19KIotcW7iLbA0DogX82zBrY71LQ7ng=;
        b=Om6AaDbhFou7NRy19Pdgl+TN1xjmw9XPRWVbHVsk0KVZCjlmqsPpIqUYTFY2KteIfQ
         QF1Dc8Kyf++Ev+/fMqOk3t9/pnQU9O1PTM8RQor4TRdGtdyS17PhjJbLfYaeipP4Wjiz
         amzpVnpSZQVdx7S2JMzgxLGBwQzezbgHT1CoHNX8pFHdBOzTDKqMOS94zkQU7YlqetjU
         4J07J14dXuWEBB2dBkq2BAC4X309+y71G0Z3Dv6LhktB28TBmZL5b0S9a1IbGxKC41jr
         PdI2NqRAocXsGekxpf09OlSLdEy3dc1Ki4zMSpNel+F1KebCSVlA7966Z6+4kxo4RgcD
         gVsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778329669; x=1778934469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/CUTeoP6j2y78MqiqLoSIyp8c6EmIMmXSLEhxKoV30=;
        b=FUsdVRwn3MMVKhoclhPuCPYc0T6YA0GUQjm5O5q9Q7FtuDGvvJ3n9GS5XdM0LBvbSU
         MDkZqvd33HMp5/6fmmtXtCli3whUW7aZNI6QhYum9+bt1hnUp7qiI57cu7VKgurxAF/w
         7CXRGOZ6yvGXqKDXmlx22sWOYoyrdrSV9t7y79T+qJwaGIiF+pzMI3WvzQFUhTKtOw1D
         KtQIc77n9sx/TXURjuCaTZsTqZJTQEYewaHT2jLPMrtiHjciiySMmaitnee4GxyCBCtI
         dD7If1urgz7sR2pfVr0oRt+RA0aYs1aM5PN5wmuRTwALJJhNMfB5QsHOoJOo0K749sdD
         9jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778329669; x=1778934469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/CUTeoP6j2y78MqiqLoSIyp8c6EmIMmXSLEhxKoV30=;
        b=KEd2VPWZ+kKtnSHXSwLLTI9vA58YzXRzrGYAbSAxq6havM7L2Pz7acwxf6tL5gjG6Q
         D+SiParmhfcRhXbHdunjsDXxaxI+IswGMw8VsJoNsKUqrnsRATmRmoxcQz3821ZeXm95
         2D9h36w3G+jKXnbBGrzEp2FhwGvCkSIja8tRks3DNGFofwZL/XRjhYIrxip3OjdOz7x1
         LDTV2YOjChapQHYf/FffjnyPoYUWdh0HWdgX7XAAtqMcbnvgh3sFAaBz5RoYy6QTH1hg
         kradTzCMi3t+INiSqIZiOeTULCJ4W7s0IyDsnAl1LsMmmMvCkN2VowX/i3SXXRFcffdY
         rAyA==
X-Forwarded-Encrypted: i=1; AFNElJ8AyvauRz93pQdRzq9kKOWTXiWCExn7wMiMEO8UFJ2j07vL+GXCSyhLlrsQaaaDpn5TwbSjhOY3ALE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP5AgK1AaH26CJqRvLIjLDvxGxyvkMALuQgYudxVqTJBUM+n8
	kg+1tFwgn3dMvsIuKvWxmzwOBw5r/vpeV9DYgx3WmQBZ13rGlB1U8DyfcF1GUUfuTPgN/DEEUm8
	TaQpSfElVxIEGVVN9cx8QV1oV8Ho0af8=
X-Gm-Gg: Acq92OF+q9GH3ShNT4dxJ2gMCKwes8zpml5/E/1VtzojJ0GyFXLoFilV+yY3MuAcd3k
	4VU3ciD7dO/7KtxWrNPgZly3GLUobMeen0RIKmRYO6zScNL+Foq1pmMPBuAPIgR8Rqsui4kvtZQ
	F/GHZZZxqIhJlatyHJ/kTs/LnSWSOEpZV5Z5/ZYfiH9Bib++4Cqze+umpJKAWCoOJ0c/pOzYn6V
	PPab31JV76eIKQ6olYTWb2Wo08dEkbDrEEdQyup9ChjXeu4ZEkxJY5azuQ+8du9VIGpT0sMo+Qs
	gBzG
X-Received: by 2002:a05:690c:c4d3:b0:79b:d56a:a7c2 with SMTP id
 00721157ae682-7bdf5efc98cmr187980197b3.48.1778329669534; Sat, 09 May 2026
 05:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508225501.86448-1-m32285159@gmail.com> <8F49F478-AAA8-4AE8-B6BC-BF3C3923AAD7@gmail.com>
In-Reply-To: <8F49F478-AAA8-4AE8-B6BC-BF3C3923AAD7@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 07:27:38 -0500
X-Gm-Features: AVHnY4Jw62tf-F2x-w42QXyjRBIJ6HML3x-rTUwbtwhL9XVv-AoZLA8aRg_tqDE
Message-ID: <CAKqfh0FOJ+k3E8Kc5+acsvhK7ATapbhPsas4YZOzjXBkSRFKuA@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 9:56=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> Thank you for the refactor change.
>
> The previous version was more compact and readable. Splitting the variabl=
e declarations and expanding the sign assignment into an if/else block does=
 not improve clarity significantly.
>

Are you sure? I find it to be far more readable than the comma mess
that there was before, plus not a huge fan of the ternary operator in
such expressions. One of the goals I have as the new maintainer [1] of
the scd30 driver is to get rid of "clever" code and replace it with
more explicit and readable code. It's going to get optimized by the
compiler anyways. As a wise man once said,

=E2=80=9CPrograms must be written for people to read, and only incidentally
for machines to execute.=E2=80=9D

Plus if we need to drop a printk() or whatever in there to see the
variable assignment we can just add {} and add the printk(), no
messing with the ternary required.

>
> You can keep it simpler like:
>
> sign =3D (float32 & BIT(31)) ? -1 : 1;
>

See above.

>
> The IEEE 754 representation is already implicit from the bit manipulation=
, so additional comment is probably unnecessary.
>

I'll see if Jonathan will want to remove that during merge or if I
need to send a v2 (likely not).

best regards,
max

[1] ("MAINTAINERS: Add myself as SCD30 maintainer"):
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3Dt=
ogreg

> Thanks, Sanjay
> >
> >       /* special case 0 */
> >       if (!exp && !mantissa)
> >--
> >2.54.0
> >
