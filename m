Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81B2DF68
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778378427; cv=pass; b=pxAb7qeeA6aPUroNAvy1aDGGVIAj3IYVgjr3JCcjqM7Qh4Fv9Z+vQvgtmbqkASCF4nkTdJi6GnEe8TxZB3Q9kQI0MetQmnacKZQ/gRok1nfCCzYYMztBBxXeIrdmJjQ+ckynINLZ4x1Wa7g3RPb5XIR4fG+1qdOdlfllmURDOpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778378427; c=relaxed/simple;
	bh=pUI1z7i7mQlBpC0C/OpSH1TNtGxr3q8tqLoXXv4K8Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsfIIPDRL06thHluwowb3m3py0Ms2TFszEjYN9lLByA0Gh4GbSK/A10LsU408saDg7TjrtgM4eY61mxbRZey7HyqS/VvuVI1CMTLA7jS+pb2FQ7BnVa1c8OiFOhsdxCBrlDSnlItlNyT5G8MacgWda0i7mwvwKkBbkMj+TgzMGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkziDjLy; arc=pass smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkziDjLy"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59dea72099eso3075187e87.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 19:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778378424; cv=none;
        d=google.com; s=arc-20240605;
        b=OVOLv+BFQvujz+gepn8o3Gdgn0aHCgnhDnaa36mGMDsvgd02EFarmMgEfXsYiCbQGP
         rOn3I0PPnQST2ho6yBN8Pbekva1Amq/CbvBzLPF2kNZvCX5JkinRKKbXUryIwOA/B5Dz
         Dx6FzgHoTJvkMvKk36XxyOvSaw1D/NfyOAqeNY8E+Ow6PXrikOqIOlVY5wlG7l++3fiV
         KsQIxA1iCb8Dry6nr8OT4bKV5yj85TfHF6XEzN+0Ru/pch/CDp6gtirTpa06iyjyOFmk
         HDWWOCnlIlPTTb8C+eIKWrBf7l0paQ5LtYmUBL4Woey91RWWqqLKZVqeQDdGDL/H7hOI
         DuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TND6KxJoYNL4nBC3/lGAR/tckoAP9dbwYM7OnK3ow60=;
        fh=1FeswxQJlYqvkPix4ecXsAEH/FktqovLrSo4c0wkS8s=;
        b=ZYlRUTKmkmcKrelSzIWVYD4gZv622sov0t3BP7AwG1atRPok7AJknnQjsGKQs5Dpqp
         k14hC67bTckR+TVWoHsJPx/TlkEWixMT3SSZ3PueCO1K1jFCz0oBqRZSQIsQYZRQuD5p
         cBwJP/eMgc88UOkAreRg4ICOO8OjQJOsLWKRRC7N3E8o0J0lwW79eutiVqvoBEySOE15
         GAlTs8vHFGfX1uyVHPseczonuk7WtDWaBD3ZhYG33y7mqRhUFT0d+XZQWmYUlWa99wMp
         fuviZHhhteJEVwnRIuzJYmivadmsIFQCgm3p77xpKqhjmp2yIU/9TcsZr8elk2k2wdgx
         bc8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778378424; x=1778983224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TND6KxJoYNL4nBC3/lGAR/tckoAP9dbwYM7OnK3ow60=;
        b=kkziDjLyGUnNUP/ZBUjccpUZSZMcVHbX6FIN2W8GVzYKIcMxolmVDrkgztf+wqVQC6
         3cgNER3u6RBMsgZEzGe0aOSMjWkbmO9im+68Dpp/eHftZexGYesFI4uwYnJBTx4S+j07
         LasMYSI3ppv7ASyYdplHt7YLOT4g6NTse3kU5jEvUIqbebB4EAvMkyue3CKm9K3I1oKx
         CLwogmv6LGCiS7FVMe5vLyrdld85JaIp3SDjw+08qKJJjHQJzGtgiKwDpQH/SMVQX8BZ
         aJOQE7C2NFK3VjeJCNBJZZwbY0Rkj+PCOs+JRZFcMODGFmwxawpHfern3rGHY0zawW/l
         lq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778378424; x=1778983224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TND6KxJoYNL4nBC3/lGAR/tckoAP9dbwYM7OnK3ow60=;
        b=qxhMNUWEu2xhXKSeH5TK84XZ41hB8qUN7nueogjr8RNRgL77v8WY4s0l7bGBRs1YaG
         B+nXhGvpf79dI60nbxU0pN6wz493JzdDC3xwoOIbwE+TFZpB+nZW/HZ4xXlac6xo4RTm
         PUUnkiojQGMcefzkjOq3KrBYNPTCHfAvZcirjN/Crg/JIMMb+4OAI8kiAMntJpk3GCKm
         w8GaQEPbmdW85j4FZm1K+85qKRioEr9IWgRrC4TprYRgDdoGW65el3JzSA7BIMEVC20C
         AV3qXj11XGArJlb3Ew6GWyRlc3yLHXgFFLZV7c4YK/ClzgFFSe7ICusRwQ10KWouUevQ
         wgvQ==
X-Gm-Message-State: AOJu0Yx5ITuidESNQqzCWjB8fxeyxeId/T9dzremSpVoQODyQC+XsTRJ
	WY4jzlGwvfGU5OYh83yiLJ0IhmPFRd58R9KOEVJJIcbcmoIZ+md0CtIyS4NGO9DHMWDgJlBB4Rr
	LtBZ1i3kNYJHAOdea7Bl8tIqPdjLXNzk=
X-Gm-Gg: Acq92OF4zsMQDsDuQx+S5RgSRzFoDrfkrmrLC37zeFPHng0IbhKCA81f8/o9kTPYeBI
	qocld/HEgwkw/6Dq5WV+by9u5g8OTlwbx/p8ZVqT9dAlecJhHRaQQcKDS2BEJbgMxYKLuuXU/PE
	+nZaTHbmIjXNswFcb4dINe05LEIhKpI1+slFsj7YKJcinNWM/zBiCDel/JS8f2gOP/EDuapzd2r
	3NYTgrtw/39gGSvkxTUkjDo8RiuXh3UeniGPw98ug2RALN1tp13Gkih8cVEdVZtggqxbVFpGXUc
	WI3XB2qTvbgKNlC1O+9M2FoodgDxRI5DFUHc/cdR9ilshpQQev9N
X-Received: by 2002:a05:6512:2256:b0:5a8:8db6:b1f with SMTP id
 2adb3069b0e04-5a88db6109fmr5937652e87.24.1778378424284; Sat, 09 May 2026
 19:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509090320.85481-1-dennylin0707@gmail.com> <CAKqfh0F+rAqAwdu=BtagPa2D-F-TANm8Tx3RCOoLyZXkYAn2pg@mail.gmail.com>
In-Reply-To: <CAKqfh0F+rAqAwdu=BtagPa2D-F-TANm8Tx3RCOoLyZXkYAn2pg@mail.gmail.com>
From: Denny Lin <dennylin0707@gmail.com>
Date: Sat, 9 May 2026 19:00:13 -0700
X-Gm-Features: AVHnY4LZNb2ydQINtTmvXcR-KwfUE7QOTj-W4MjCiP5irhAWA0AT3jcREx_Wze8
Message-ID: <CAGEkeHcqG2_c7Ls_=ZMkKfR_MpSNiuRO5d159oWfuN_A6qNEoA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: check SPI write errors
 in probe
To: Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nuno, Maxwell,

Thanks for the feedback.

I agree that just warning is not very useful, and we should bail out on
errors if we check them. However, I currently cannot test the failure
case and I'm not sure how the device behaves if the switching sequence
is interrupted.

I've reached out to Analog Devices to clarify this. For now, I think it's
safer not to change the behavior until we have confirmation.

I'll follow up once I have more information.

Thanks,
Hungyu

On Sat, May 9, 2026 at 1:26=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
> On Sat, May 9, 2026 at 4:03=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
> >
> > The probe function issues three SPI writes to switch the device
> > from the default I2C protocol to SPI protocol, but ignores their
> > return values.
> >
> > Switch the repeated SPI writes to a loop and return an error
> > if any of them fail, as failing to switch the protocol should
> > abort the probe.
> >
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> > Changes in v2:
> > - Return error instead of just warning
> > - Clarify that repeated SPI writes are converted to a loop
> > ---
> >  drivers/staging/iio/addac/adt7316-spi.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> [snip]
>
> Hmmm...has this been tested? Normally patches like these don't get
> merged unless tested since we need to know how the hardware would
> respond when we hit an error case and quit sending data, and also some
> of the timing changes introduced by writing, checking if its an error,
> then jumping back. I've personally tried this patch before and it got
> rejected so I'll link it below since the questions that you might get
> asked will likely be similar.
>
> Link: https://lore.kernel.org/linux-iio/20260426205039.125818-1-m32285159=
@gmail.com/
>
> best regards,
> max
