Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9D1E25F9
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475968; cv=pass; b=dwYj7MrGjXUUbfbgS6cAxi0EX0sXmAk60UcSURoXN5KPkwHTdAoBfa1koFi62cHRV58073o8w9b3Ffv+5dJZv7y7n3hk4aT6cJD/Hj4vNVgfAu/m9SyU1h+JGpOb5p39gx2nWzbijkG4c9sAhISU0eNrzGWJ4wfDC4p6RKt1Ew0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475968; c=relaxed/simple;
	bh=dorc2jvd8IAFLeLMHgCimXuzt5KoUF4vBWwPH/4RwkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3QMrafmfbNZcSTHHVp/z5uf44p8Z3F53CuWxQHBA1BMSgPoo43WaPaY5y96EXmZQ5viETSvSGCl6xXyDEeY3HA+PU4vl4Ula3P2FrfOpL0Gk7WZJheQcFmg6RYZQT40JWRKbEpjhWCNkPT4/Z+sRpNRj7XJcrcMKBit2AKEiKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZVdHqd+; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZVdHqd+"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46260385so148682207b3.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 08:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777475966; cv=none;
        d=google.com; s=arc-20240605;
        b=VwLMJpuH15YiZloifGtDd6UmTlRe1tilNtSoPqqjn3rTi6FomeyQZz5eEJura1iXVz
         Mb5Tq8xVQwTOM/jCSCRVIRoNn0j4iQ4QphM7UlkXMMfT2el+aG4fwEtURql7kqI3h92L
         cPxs/1XybjFxndEtIBKkQEkHJhBA1QolUCi30orxtMCIXAtn4osreeUsy/EYBH2ttU5G
         DyiB3AUw/ghXygr3mHED+Jl8f+WRJHkYtl99/FviGdIB9zJ+V88Yf/FRL/1mGT4qxZm/
         JH8BwtwQGcG5zpm/iDw345d/3FUYvHTGxDFvEKk8xgtaycrjK/ZRvPlZ42S/kC2U7HBQ
         CgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNrx+z0HtKTfpFuX7BPe/KGORPWEzp0KLUBFRb+Whtg=;
        fh=47UewQW+HCxna7fwbHCvu5T9yKAC8RJ0ZgZvnEsPZCg=;
        b=GwShJ0Q70d8vRnONQMRyAwlkFK9MNlW61z59eZwomkDm0VGZIS7MY2mD2kD70Vp7at
         8zhVeer8jPHtVnvQxGlhlfKWLpVRGrZljXUAt7YKMQGSNwQUvHwAFORBtXAsjzVuja6b
         xk7zXfFdHoPbZBjBkrme3khGMNb5ryldBLy4QmmrAKGy22dZkPa3Z4mT4VMfjhY1VTQt
         G1AEkSsnSag20/nKYulIIlskaMUKaHFI/8UsObwA/KCJEvtR5cwqzwsEuIcyTYsz3nh5
         9O92nvwGZYhPSKbOv08Dz3q3bbTgq6EpRdhjNzvR/0bxPBF3R33pgwXQFoVmwlSUzJUV
         tZsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475966; x=1778080766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNrx+z0HtKTfpFuX7BPe/KGORPWEzp0KLUBFRb+Whtg=;
        b=UZVdHqd+BfW8FbtJ8clmEFyVfD9qSrOWHsxe6E7PL+PVyRj+V6/SgW1QfixNH5UlUZ
         qjHvPUdXJ8LVJ/Nxw5cjNLJiMiqLjtOrrTCPd/jZyN2vqrJVdo7b17+JBGfF/2A0X4p5
         ZvEKaegcBvNH+ByOM1QrB6PfpVfLQ+XSDq8SsVK594uAq/1CSUE8dyIFA8AhrxoPB3cC
         Su63vktw+Pb9XX0pLD70aJM//3KT84H7cvZJRd9QQaLZFsgOTQgmMBPyRSFKS6Hl793Q
         iszpGfBe/7ACCt9UahoqTXXbtBk4AitYAKLQsj9+hTvQWmfV1REy1HsVkdQsilXm/TDM
         O6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475966; x=1778080766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNrx+z0HtKTfpFuX7BPe/KGORPWEzp0KLUBFRb+Whtg=;
        b=U5Fx3w7rB7Wqrz/loJ0R7qcqrpyUeeazw1DOywCywBclOAGBgpdhBSXRFo0aMdJN+A
         ZK++tqxwk57RZH2BZTMwz3DL5kEqRNANhL+VK92dLW6USg9+oRhNtGlvne5Y+MJoJF8g
         u9pEiWm1hAA83QilsPHLD9uX7GDNJTYk3LY2mREYdsndjIQS4V6QqRlQWFct+b0zbJG6
         fdq5KbtX7iP8HqFprrdcEKPPqjLjaPrHtkepDlZJ6a8CkTlZ1wH1rxQEu/NdiN42hzd6
         st2nyvDRmP0Lnm055/FdmJViQYNbWRfj6TvMcNGvOBg4eJw5rvpErv36nooVD2Q1webx
         x+Zg==
X-Forwarded-Encrypted: i=1; AFNElJ/Dx5GUVwVu/Qjp56KDLZZ7ljkjFWIBu9gXjnFGmTj9Ys0RqFfVXKlRwnhuexgW0jxAYGfnINZsvIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlTS2NYotSCnC5ZrnNvoCE7FlULaKkY/ezmEP65Bt1JioDlGa
	i/ae2sPActt16BZ929xdXcm1xvE+cqnPx/2+iKhDLevSMaNXTU8U3AjD7dvtmvdFOTaxoP0UpTb
	pJ93RZ8Zy1GJ1JcdoMJeZcauKAvQfJGI=
X-Gm-Gg: AeBDievqTgRBEkazbcTuBom90uCRStybcCgkiTFBhlUdNojboWKez/RagfBmPvZ3/Xw
	HPjC3zWrcsQ2y9HlkV609m0UWj2K0Q5xhbDhQjUHXMuNtPtLVN93EIcKBRSWNRTuC0ibcqgiTMa
	ocnIu10IIeAsQkVPD6BriCpn+MJwsmgCsaUUQt27/F3zaNRE7Lr6YDG2PAkZf9LLfuNCiw6PVS4
	nz7vS5i5xXDSaVDNcqEnnJNY+gdrRTBqyHVZ4qQAJohP37eVHv3c63H7Wtxdmz0bqRuP3v57TbC
	U8aWogxcVjh1o1gyoL8K
X-Received: by 2002:a05:690c:e3cb:b0:7ba:f6b4:358b with SMTP id
 00721157ae682-7bd1dac9a1cmr43620817b3.43.1777475965685; Wed, 29 Apr 2026
 08:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428222600.91322-1-m32285159@gmail.com> <20260429114154.290e588d@jic23-huawei>
In-Reply-To: <20260429114154.290e588d@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 10:19:14 -0500
X-Gm-Features: AVHnY4IkHCsUyk3zwveal1M2-nYrNJNwA-0g7EWxDjTdV8f429QqOP1J_WcqUek
Message-ID: <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Jonathan Cameron <jic23@kernel.org>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Wed, Apr 29, 2026 at 5:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Hi Maxwell.
>
> The use of the helper worked out well but it also made me look
> at some existing code and wonder why it is so complex!
>

Glad the helper worked out, I'm also on a similar page with you about
the code complexity. I feel that if there are similar patterns in the
code, we could probably condens those down into either inlined
functions or macros (we want to avoid macros for obvious reasons but I
digress). If I find other patterns that do this kind of:
lock(&my_mutex);
ret =3D my_function(params);
unlock(&my_mutex);
then it may be a good idea to consider writing a helper-wrapper in a
header that takes in a function pointer and its params. It would take
more thought, and we'd probably have to avoid variadic arguments, but
it may be a good idea just so we can keep the same scope and keep the
logic clean. Just thinking ahead here.

> >  static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> >  {
> >       struct iio_poll_func *pf =3D p;
> > @@ -468,11 +481,10 @@ static irqreturn_t rm3100_trigger_handler(int irq=
, void *p)
> >       struct regmap *regmap =3D data->regmap;
> >       int ret, i, bit;
> >
> > -     mutex_lock(&data->lock);
> >       switch (scan_mask) {
>
> >       default:
> >               for_each_set_bit(bit, &scan_mask, mask_len) {
> > -                     ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2 +=
 3 * bit,
> > -                                            data->buffer, 3);
> > -                     if (ret < 0) {
> > -                             mutex_unlock(&data->lock);
> > +                     ret =3D rm3100_guarded_regmap_bulk_read(&data->lo=
ck, regmap,
> > +                                                           RM3100_REG_=
MX2 + 3 * bit,
> > +                                                           data->buffe=
r, 3);
>
> Hmm. Not one for this patch, but the only reason this doesn't
> hammer the lock is the bitmap is one hot.  Which is why the read is alway=
s to the same
> location in the buffer. That could have been a lot easier to spot if inst=
ead
> of a loop find_first_bit() was used.
>

Thanks for pointing that out, I didn't realize that. I don't have much
experience with the bitops.h macros, but I think that would be sound
for a separate patch. I'd ordinarily include that in this patch, but I
feel at that point we might be deviating from the original purpose of
the patch.

> I don't think we can ever get here with no bits set but maybe check that =
as well
> (it's not supposed to be possible as doesn't make any sense to measure no=
thing ;)

I'll consider it for the v4, but I might send it as a separate patch
as well since again, at that point we might be deviating from the
original purpose.

best regards,
maxwell
