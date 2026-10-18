Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755777404E
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309235; cv=pass; b=WjsIpi6VNhB2NooHmgxl2h9Xr1B8cR/hiyNzAKX7uv9rDzSt7oxENnFO3X+YqTQ7fS8fT6R/xoKz+Yd31Ljwsyc5RjbmQAEpr1oLXQCdUxFvkMw3BbvPfzsAMq1o2Vq2Qa0F3twMV2mN7l5AiEz/ggcDsNRE1ZEZ4+fjoInA6xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309235; c=relaxed/simple;
	bh=iNH5cBPj5R6PgQA/TFvew1uzSSWMiMYGGjLD0JtSrhc=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGij3Vo8yMHGMUjPE0ynmFrFg23ndsw4twplsRm8OyRQkzaQjnyqspKUdFK0Gt1LRBDYu9ESO9fpOtwLLJGGfMh5wznDUlFLq+Wctkxf2FR4kS4HfLT5QMvf40MOBbXgaZafZwxN8Vibbe12PgUIU158R7n0EcjsZVp4aHRrhdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUMPJJZF; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUMPJJZF"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eac4855401so34394e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 00:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792309231; cv=none;
        d=google.com; s=arc-20260327;
        b=SoxdoAZQMYqRRyt9dx6808UoBK4XKg3TloUUq83LRtJ/UOkPOUjhi+A1ufuv3nKP38
         Cmy86UbpQYZZSJLisw0Mx1o6bOPHFTHxZGmt1I97BXa0k8nCtgJ93Kbjru7NnHj0FWVx
         5edI291BiWsITK85nibN6Vn+c+4eK81L1wRJjDqPU5mNz9Ad7BP3nOiL/oWm6RCAXRsW
         55m7pTNnbfyr/f0osDQ9wj7hTPHF7z30LGTRo15bwul6AyvazQIrC+pG1E/X5GagNIAs
         JXvr83+zanBwnktGbe30HItz7r0XUSuob5pXCcVVQWe5CAYj//XBUnFg3g+GOdqibEB7
         uyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=PiknuQleKQZdkN7TMk/Fm0FoygQpJUvDYZ+IhR/rFZk=;
        fh=Kenx65x9g81DXc4LI8GYE8ksPJ2sUeCfVf4CEtSXhJM=;
        b=Rojnl1LUJzhyvuVNO8XEXZ1+MbR0gKQkq4GIc3ted1M3d2xV2uqGrTyIOvQkB57PEK
         r4ONa+BGoKzRKE4y5FRbK/9ZHdq+zgRRMySGoC30RWPCJxx2nssv3CnsyWT+WcphPIVr
         i0cW262ykHV86/JksVe5Z3ZY2HeZXEAZgx+pRzH6EqJr6NAGwRljQFYd1KR+gFa300cV
         yfvON42se8MS2+IGdO6DZbKZxOCU+Ul7EcaQnCPDHx7VmJ7c/r8ryuFDduOQ0cDHOjgE
         8W4ELEFNL2iYsmF1HgIKv02+1Su+Q/nXFcmTvOkScE5EouvI9P7st2RTatVwWZq9U5tL
         zeog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792309231; x=1792914031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiknuQleKQZdkN7TMk/Fm0FoygQpJUvDYZ+IhR/rFZk=;
        b=dUMPJJZFUsHAqIAnqkBGj710qM01j0e9BlFqpmfzkJw1qVGbIZhDpfFnQpI6fM8DVT
         saAXD6X3RLz54C3eQWBrJnFUAImBTlaLeh66RibM1cDPC1aGprXRD63rWRMRI6hffWSr
         svdBszhHtGop3gEqr5ci13L2kOZMOTdtYzohlDNYsKL/XcpZAEgbXnuxryL0gbupd09l
         2QKXZTXG2st16+agn+sj0S2mKgs7oiV6dmyTItqBSDm4NmaXLGmFXFoFdbjJpNvWz6Uz
         sTFnVqF8v/JgrT+/D26cUIjg3dfpB2/UYA9MuFQpAH9CVZ+Jdf4haA23x8jSz6L7IX0l
         F3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792309231; x=1792914031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiknuQleKQZdkN7TMk/Fm0FoygQpJUvDYZ+IhR/rFZk=;
        b=BBIlJWFwM+hCHhL2zB7MWEu9+VJXU23ijvXJbNfndzTtFBWg0Vn9obAPi4XMsDHKEm
         HPiWpeaFl8AjKL82tBfnKGuAMZIJmu7a3GJDe5sydz/UsAuXTBqDIAtzqGXKuaVIFwaE
         aBZrrvYE6yAMyCYG1/QvwgZUW61EhO+Zy0mb+djqViJUVOakdsglSskLQO3aJgID/Ce5
         hHfM6+6diHQLzmSGovwrhsAHWG9M7J71R4t67jY6xC3hGT/7Y3fwnYVFYlpTSQnuqXwz
         G7pFEvTwqYUsqlGbFTr8+2p3Y6fvDiHUpZ+q+mNJ+aKGNvFjbb4jHuHOgDNAJnn65Hc7
         J7Pg==
X-Forwarded-Encrypted: i=1; AKwUvBxuDoLm3Lix+PvUgdg30pxsieylohXsEu9uWckWmdUOrdlbl5/Fd8WmO6w93azvK+fVF3zSO9qA+0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH+t8t6ONAr+4piobWWuyhZLoy5AlwOyF5w7MyxJXHsT9kqQfF
	iR8u7QOpxGSatrrwmLpLaJGn9pWQa2K4nB9RBBr64PMVQcP3Ekmjp3LriwVKmNev9752bQ4ZYWt
	lXYmkZdo7lIVAkx9+9A25O63QB83/GCY=
X-Gm-Gg: AYBFou3TKJ2/8tIKwLyIZMUM0OCRedK60afRfTGLeRILpJ+aeQNEK7MB5oFs4mOqzmk
	OOUOAKrjp7E+0AlZDaKgKj2uBIWlO/RUFLygT8fCsMj+tVjWnWHVoys96F/HXAaXnFqJM6vAIHC
	9L3HIyIjvI5NsJnMGktcR3uuSlffNpevB70PpAMsaLYbBVZUU3P0nyaCzytdCp5mwxGSJjKwgFB
	S6mzmZqgmL9kMtyhH6ABjoNs+arIkoEXJmoYob0m5VmH4OMOQDc95Qe8sjLzns/DA0xaKgBzdkE
	vPqKNL1shqfyZtwhwjdqN+KFjy8cEh6FCfCG3C9uU4/iTEvnnH+uxfrV0A6VeRJpITA=
X-Received: by 2002:a05:6102:5346:b0:7cc:23e7:e742 with SMTP id
 ada2fe7eead31-7cc369dd213mr1367935137.21.1792309231278; Sun, 18 Oct 2026
 00:40:31 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 18 Oct 2026 00:40:30 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 18 Oct 2026 00:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wenqiang Zhao <berringtoni36@gmail.com>
In-Reply-To: <20261017191310.3164205f@jic23-hlaptop>
References: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
 <CAF2O-sO3OJH1sNnm0TkDXkEwWPKM21+s0_iNgU-VAmF+kMWtLw@mail.gmail.com> <20261017191310.3164205f@jic23-hlaptop>
Date: Sun, 18 Oct 2026 00:40:30 -0700
X-Gm-Features: AclHuK-OmAEWgu0Yh6eWar_vIcBjdibwFfoT4ZkuKroHrklemOgvlV5sMBQrDcw
Message-ID: <CAF2O-sPVdSPuwvGp8vrNNZ=y+pbBw5BkPniT_chHFPBWpVNeow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: adxl345: propagate errors when reading
 event configuration
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Cleanest solution is probably to pass a bool * in as a parameter and
> use that to 'return' the boolean rather than mixing up bool and error
> codes as it currently does.

Thanks, Jonathan. I have reworked both the enable-state and coupling
queries to return status separately from bool output parameters, and
updated the event-read, disable and link-bit callers. The 534 host
function-chain cases pass with UBSan; no full kernel build or hardware
test has been performed. I will send v3 after the final review.

Thanks,
Wenqiang


On Sat, 17 Oct 2026 19:13:10 +0100, Jonathan Cameron <jic23@kernel.org> wro=
te:
> On Fri, 16 Oct 2026 19:39:08 -0700
> =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com> wrote:
>
> > adxl345_is_act_inact_en() returns either a boolean state or a negative
>
> Returning true or false to a function that reports to return integers
> is rather nasty and is probably what lead to this bug in the first
> place!  Would you mind also changing that as part of this fix?
>
> Cleanest solution is probably to pass a bool * in as a parameter and
> use that to 'return' the boolean rather than mixing up bool and error
> codes as it currently does.  That will keep the return value for whether
> the query succeeded or not.
>
> Thanks,
>
> Jonathan
>
>
> > regmap error. Applying !! in adxl345_read_mag_config() converts every
> > negative error to 1, so a failed register read is reported to userspace
> > as an enabled activity or inactivity event.
> >
> > Return the helper result directly. Its successful paths already return
> > 0 or 1, and the IIO event attribute read path propagates negative error=
s.
> > This also covers the adaptive magnitude events using the same helper.
> >
> > Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
> > Assisted-by: LLM
> > Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>
>
> > ---
> > Validation on macOS ARM64 with Apple clang 17:
> > - Compiled the three relevant driver functions verbatim with the driver
> >   header, using a host regmap stub for deterministic read failures.
> > - The original code failed 36 error cases; the patch passed all 53 case=
s.
> > - Covered activity/inactivity and DC/AC coupling, each of three regmap
> >   reads failing with -EIO, -ETIMEDOUT and -EREMOTEIO, enabled/disabled
> >   states, mismatched coupling and an unsupported direction.
> > - Checked read order, early exit and unchanged register state.
> > - Used -Wall -Wextra -Werror, AddressSanitizer and UndefinedBehaviorSan=
itizer.
> > - git diff --check and checkpatch.pl --no-tree --no-signoff --strict
> >   on the code diff passed with no errors, warnings or checks.
> > - The full patch draft also passed checkpatch with no errors, warnings
> >   or checks after fetching the introducing commit for Fixes validation.
> >
> > Also compiled adxl345_core.o, adxl345_spi.o and adxl345_i2c.o as
> > x86_64 ELF relocatable objects using clang and unpacked Debian Linux 6.=
1
> > headers supplemented by upstream IIO/regmap headers. This checks syntax
> > and types; it is not a full Kbuild/modpost build.
> >
> > No in-kernel KUnit execution or hardware sensor test was performed.
> > The checkout is sparse; --no-tree disables checkpatch's tree layout
> > check. Initial draft checks used --no-signoff before human review.
> > The final signed email also passed checkpatch without --no-signoff.
> >
> > AI assistance: Codex reviewed the event-read path, identified the errno
> > conversion, drafted this two-line fix, the reproducer and changelog.
> > The request was to prepare a driver/BSP/kernel contribution related to =
an
> > ADXL345 SPI/IIO vibration-monitoring project, with reproduction and che=
cks.
> >
> >  drivers/iio/accel/adxl345_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 6c9080d..5983fc7 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -1176,9 +1176,9 @@ static int adxl345_read_mag_config(struct
> > adxl345_state *st,
> >  {
> >  	switch (dir) {
> >  	case IIO_EV_DIR_RISING:
> > -		return !!adxl345_is_act_inact_en(st, type_act);
> > +		return adxl345_is_act_inact_en(st, type_act);
> >  	case IIO_EV_DIR_FALLING:
> > -		return !!adxl345_is_act_inact_en(st, type_inact);
> > +		return adxl345_is_act_inact_en(st, type_inact);
> >  	default:
> >  		return -EINVAL;
> >  	}
> >
> > base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
