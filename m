Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C331D372
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798951; cv=pass; b=l7dd2VG3dKcXCfdkDaxNNmIMaJqLmgsLdddMnXx7MqKddo6VibdINvevEtWwp1I4EAOEwZvOqPZvabJ/LnBr6PpNbqvnrzmnpu9Q8NetTmKfGb5qSMSnX88g7LzGZAhMtOeuV06b/XzfOKSBtzr3gqfmyB1txNlkomUj0xSpXpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798951; c=relaxed/simple;
	bh=8wx8t4bqhd+6+tvVThmvfZR3L3RfIEgcgOG7fIXSdmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZoofh7UFXmiBZJTMpNTT8F4xhyCUOJN9xQbVv9iJzCp3zVfj37bVUMT4rBrTzhRRQNDSpyAewcN1bgob2bHxFErg1z/zkY4/SU/a9ppiugy0VZHuPqrEHo4QdtQgLqa08mCc7g/vZ58VzPpmfap9+cJ32b7FkIKXzFjqKy2lh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlkyZ3ez; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlkyZ3ez"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1167694d50.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798949; cv=none;
        d=google.com; s=arc-20240605;
        b=hb1XpWjQ7a3vge7Uq3pmjYl4dmWi1mBRGvrIqaWbNI/KYqtw5b5rEnMp795fLtP4jH
         Tlp9578oH9h9SDV5AjJnHQDMlRmgUWZWSctLj06QSX311fL7/VthexIcq8ZaIwU98W1q
         zxGOXYBmlxapXq4tvPdDUMUrPteYUtUHEXYqXFj/qLgleYyK2ERXWdebFuzmCY9TbP3R
         qYaOjABbflrHVAI2MHmPBiysjHrI0xGemYUIQaVpqFhaUBijWaDNR2ZCukgrW4NWgRGM
         9hqvdndF6BHWP89yAMlo0xuARyiI4i9A8xf5Fc1URPpSLvdeasIemP9FM8t/heTaQByB
         GosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GF814YAtiEeXBHiC2MuT/drbm9cT+XUCwN1wt61uRQ8=;
        fh=yCne8v5XWeKG9Rcp8NraJNN4UeL6u+jnLiFOpSxPRx8=;
        b=GDfjY1ShBfHEl7+AzL7+/GgOV/q7Sw/7kGtMV19Z+8XjOMzgAaDaWaMD4ThakgSqNd
         nOJg8Y+lubz9KWfFyVB8cr8CwWX9yqWNhmp6KDy/gfjQeGNLkSFzZdmSDZD+/WbFyqUG
         DYG6ijbNZiTgjZ/eyDPf0qY41G25+cdIJvMsy6GLLNYUEagTniMRWPUsyC+UW84jlg1s
         UMtYBpPnV/6jqIjAc209TIJADMH/CStuwwE7gP++f0Pf/AUPiUDpiOGDwSrG4IAMP39a
         9/xaKQWiBUF4uTYqvy/kfHfyatsihLOIcDw7K5EwuP6D+TD/P2lrfqSfjMHOREqkIvaj
         BDdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798949; x=1782403749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF814YAtiEeXBHiC2MuT/drbm9cT+XUCwN1wt61uRQ8=;
        b=HlkyZ3ezh77xCfek22KardETr/a9X2ZqIR9wXpmu0M7Xz6yRhA65AgT/zII+lf2OrW
         USjHrAv8UNv6NzFjJszC3iwSyctfq8kad5rSMtlGgFAqguShP1kIwEfWXHrxS452EqPs
         N7V7WYveSOfRnyUL8IiZeNlbx97Oceky9vhIX2S7DHJKuc3XFmXX6VBE6LvBQ4p2bEmP
         9hIezHRbSCKy+rNL84luRDexHWU1eofdPrTjPEbMK3IKazwKthFKP/1xGnsNMP6rrQHU
         6vRVemxIBB7RcrsvP+Caa9tB0wKQ44+KmN7lm9pVYZJXWIfsmL0QOHsNcWtOMnthQxBS
         oFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798949; x=1782403749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GF814YAtiEeXBHiC2MuT/drbm9cT+XUCwN1wt61uRQ8=;
        b=SifmUwKSM0lTeGJVs+rlVXPtjKrxdPSied6qjUlqFG5ECbQuMvdxz1pxfD0eRP9PYC
         uoqHjiqsv/AQmQjkynQBudjad1A9WLlUepbCw+iCJGacZzdgxmC+ktaBnltr4SsXPYES
         W+ozyrDb2SeIZaUrq/9vrvjtNuBvgPJN2dvku3o/xd4WyohBjLR/0bSbj6L5xWY/4sIs
         C4rzt0Mv0QVygoE8waizcHCm+mUy3yXmYryq7pX6i/G6HVCIBYBzMasvxksszqn3vovT
         hZi1i/YGcM2G7HJn+ViknBKvqiJPx5nZNve32db1/MyhNqS2hUWGMk43dH2X6SncT1iC
         TNyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C0Wyc7TvW+bXfUV46JW/aAx3bIXoCQ41x90ylvgRjK3rMbGH1xXXaPVjSuhGTmgharYy/t35p28k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISS0NzutechD2FWdiaX0moBag2Ch36UJHwhjqiCJ3lkMnCkon
	r1R/9ngMyI3A3L26gmSRmw3wa6jkm4B3Rif/5zJx3jIszBgcmYKiG6wcNnQIZXt8w3GvRb5C4Rz
	cKqS0fZJzpD+XroGyhuM/L3rHcuKUNlw=
X-Gm-Gg: AfdE7cmT3G+NYr18BYWsH0foA2qVS1hLqNI3dhyA9ZErLDViLwKpfcBAqbIvG7JoSyA
	DKikZ83Zm+i0hwa6qcdpbKxJ+tW4w5ebJrGU8+W0bZu8yjGBkY2vlth1sDWwIwPcy82F0rTj6Ni
	/EHL4m3xoY7jNGOVN82kLrlCKW/ax1rY+Xyfk4WNs+X6EbSGKF304NLk38K8ZsBR4LulKHE1hvr
	PTT3a0zoPPtNJ0uNmc5eKd9fbqYe8/mvfl2hlTf+4ZKMQV386EDb+SXnthExoYaT6CCnGI/vvth
	WsI4qae77UZaTTIzbYV5jYwkvJAZKFlK0URmLQ==
X-Received: by 2002:a05:690e:5c7:b0:660:e5b0:12b8 with SMTP id
 956f58d0204a3-662fccc25a1mr171395d50.53.1781798948718; Thu, 18 Jun 2026
 09:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
 <CAKqfh0E2479wCvQCRq24vB7r6HP7tgy6YKEVF1U0wHF=uchVog@mail.gmail.com>
In-Reply-To: <CAKqfh0E2479wCvQCRq24vB7r6HP7tgy6YKEVF1U0wHF=uchVog@mail.gmail.com>
From: Mert Seftali <mertsftl@gmail.com>
Date: Thu, 18 Jun 2026 18:08:58 +0200
X-Gm-Features: AVVi8Cd9co5u1TVh6thT0HtX7miDCWB5v1wIeUdt8KlpTG-i7lLI-xEGz_oRXJ4
Message-ID: <CAA3Nooq9J67DvK1FQr7jmnvTk8LvYRj4m=6+ax1d+xbu1eTq2A@mail.gmail.com>
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, jelle@vdwaa.nl, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Max,

Thanks for the reply and hints. I checked Documentation/ and the
bindings and dmard09 is only in
trivial-devices.yaml, no datasheet notes or scale anywhere in tree.

Will wait for the maintainers call and If they agree on
implementation, I'll try to reach Domintech for the datasheet first so
the scale is a real number.

Mert

Am Do., 18. Juni 2026 um 17:47 Uhr schrieb Maxwell Doose <m32285159@gmail.c=
om>:
>
> Hi Mert,
>
> On Wed, Jun 17, 2026 at 11:10=E2=80=AFAM Mert Seftali <mertsftl@gmail.com=
> wrote:
> >
> > Hi,
> >
> > I've been digging into IIO to learn my way around it, and the dmard09
> > accelerometer driver caught my eye as I think its scale attribute has
> > been broken since day one, so I wanted to flag it.
> >
> > The channels advertise scale:
> >
> >     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
> >
> > which makes the core create in_accel_scale. The trouble is
> > dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
> > RAW, and SCALE drops straight into 'default: return -EINVAL'. So
> > reading the scale just errors out:
> >
> >     $ cat .../iio:deviceX/in_accel_scale
> >     cat: in_accel_scale: Invalid argument
> >
> > and userspace is left with raw counts it can't turn into m/s^2.
> >
>
> Interesting, so userspace was broken from the start.
>
> >
> > To be clear about how I found this: I don't have the hardware, I traced
> > it through the core (iio_read_channel_info() -> read_raw() with the
> > SCALE mask) rather than seeing it fail on a device. But the path looks
> > unambiguous.
> >
> > I went looking to fix it properly; add a SCALE case returning the
> > sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
> > DMARD09 datasheet anywhere. Digging through the list archives, it looks
> > like the scale was declared in the original 2016 submission but never
> > implemented, and the driver was written from a vendor source without a
> > datasheet to begin with. So I don't have a real number to use, and I'd
> > rather not make one up.
> >
>
> If you can, try contacting the vendor, they may have a datasheet to
> reference. Otherwise check Documentation/iio/ because sometimes
> dev-written datasheets will end up in there.
>
> >
> > Hence the email instead of a patch: would you prefer to just drop the
> > scale declaration so the driver stops advertising something it can't
> > deliver, or does anyone happen to have the DMARD09 sensitivity so it
> > can be done right? I'm happy to send a patch either way.
> >
>
> Perhaps the scale declaration should be dropped; I'd argue if it's
> unimplemented it's dead, and dead code removal is always a good thing
> :) Let's let the maintainer for this driver chime in first though
> because I wonder if they might just want you to implement it.
>
> --
> best regards,
> max
