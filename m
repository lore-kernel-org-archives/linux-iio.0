Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DC1A6803
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797658; cv=pass; b=FuQsn0o1267H/Pr0YHiuJDGqU8KUAk5bjjv0j2IUoukcUskuVBY7fEb88jO96PvUaSphsdFl4WaUnHZchNP8vcf76lu4DRYgvtq63kUeMvGhTrjv2U1TGt/FtfRDVQISyS0t3Uygg6gizo8X8Lunrt+zFKcfRSot9/Ae9coIYvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797658; c=relaxed/simple;
	bh=SPY7MVaBJRsjySjuFRVsM/QDBrTInSvhYmAvybxgxJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roYDlcVswfHGjuavgr4pq4vdggzyjFqB7FA3lJn9y+wcMK3TvmNgrBufHGrF1ZgzVJO/g8BnnBk08IeyXGXObgymle56/SddMJS/G4UtCuvIIn/R3KrQMkdfeHnaQCNvmUoziIlCoK0A5DJYf26AqIWPfi/K78Ov32Suoomvjs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzNWzZjE; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzNWzZjE"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662fa4a4470so356279d50.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 08:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797656; cv=none;
        d=google.com; s=arc-20240605;
        b=kkkQtmJ6NRY1MC/UFhTZ5t6DIxJBaN7ciu85ld53ZYDPchF7Ox4BTw9u7fIl0kX6a7
         qm7uENODRu+EYKwy5nW16fAl7rLCiXSUUi7ZjVhtlOs8G0dY9KQVjJ1cFcUq1DanDRKX
         BSVBN/NcT4AS0DgRi2J3ds7+EvC2p+KuNFpdNPMfKqOgaMpypZrYM1oLc+zvJQUzfcFb
         UPMaNUXyhMTicf052YGRshmBIEY2PPTAtSzy4WE8FWkIY4JQYp1FHNYfnCOalkt6NLjN
         ddHlfYfZsebMnKZ+35kxXgEJVjhgOMhay2JLDKJnJod/NZzyfq2iQQPANiGP9N6BV5on
         kwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPu2Mgsyvt74IfoRQSMWyDEG1esi7MwAqbWgOUJ+3zA=;
        fh=GFvpluInnojtwnVL4CkxnUHLEpEyxNvPGeXRiRJQRec=;
        b=BUE/jR49O1JyiEElnz4CyJbq1ES7jZy/C03HEzPWi7rHspjtdHGhjo6kiU1znyLbEQ
         hOiHZSQnofDKLeLVe5cOWUxkfRc40d7jg/7F+2zmDihQeYABLtJXPQzV0YbXIgmbtl3+
         aJxBoExpRebAJxYEb0vMW4whS2SJHKK7Wcm4P34NGYYam6YrFncKI03AqxW6U+6ZT/nm
         qaiIPIUBaGMVxbRAvp2UUI9zsdhnLchZmSGSo7DAb0EHuykG4Lb5Kgwu9iGLw1FAYk6t
         sL6sl2ZJITSAKxuGIeiYMQFDAe9mOH1x1tpbus34t9oIu9yQ5CziDTAEYbASuDc4SlC0
         gIvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781797656; x=1782402456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPu2Mgsyvt74IfoRQSMWyDEG1esi7MwAqbWgOUJ+3zA=;
        b=TzNWzZjEa4WbUBykTijDqBrpLwWMWXfY7Kji4cp+TPUrVgqGNKYitOuENi6B8hJpGk
         qEmWRTqaNlY1DYXfC0/l00MsEbRtoNnVIqMee7jI0/jiHyx43y9sAtF2ggnjtpjzscHL
         3tnBCvyzXc1wkC5CLO3FfOAIKgkoHjffrnIjxkcIZqFudES5PK1qKOKo7yLu9LrO2FwN
         CfqYPvfOOa3L8YrEyXYEn2SZC00Xb4yypsH6FOObhKUDG0/dCfv2NUavRYdBYH80uHvO
         kZ5SRhr2ucRhurkDTK4/+ZZzxrk/iQ+pBEloCAoU028MvqYDuYGulSAhYPyJzl+A5XUb
         a9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797656; x=1782402456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPu2Mgsyvt74IfoRQSMWyDEG1esi7MwAqbWgOUJ+3zA=;
        b=bJcjmYzDwQBzyAoyjpvC5nIM+9KjaGsRtAj9S+xd/rxO9vjQcaM9NA+kvwVpHFezIx
         EOBFKMkkz988CjINLuJUmqFdpkxfu9aPSaJb1t4kjrnuQbXzH6OqGSujejDQo3ula79q
         zGaJmS+La0XwHtyjV/gE/+ez9gFvSAe1bO93Wq6UpoZyuw+dGu3pOzLvqOAI/czTkXBA
         521eaGzrHSRPYF7B0lC/LdHGPANlVsfCmdMRzDZkIkVgVTxGYFs2pAnsntjJk4si58LZ
         zSsSdyzpsB90G44Is0mz57h2ZjlNG0J6g0x3qTTO+uiIAxQjSU/XHqMf1u36xxQQCXRF
         ICfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9X9fyJmtHeaAqjrhv+72Gv7RuMmZdDYE9EDfSgLlBaN0y6YMXZl70ZBcVhqE3KKy1DG4aOcuNNwAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZGOZFO1Oj/8RrtBGwU5Df+7HBVkV70YW4/s4jnfMdjWiYIjU
	MJD3JwpxbbKRc3XsXmg4TCdFXaP2MikXbUnjVC7bhQqFk4X2XKfFQ7B94R+BdC5oKayovdY22sS
	/rpEVLEWvRArgv0tXJPqkEIhRfgjRW+iW3lPT
X-Gm-Gg: AfdE7cmyM6/YLXZjeCo+FyP0aAmnue7lTrCknA2q1EWwpqA+o3X2wFyX3JwznfAwqB8
	X50LX+YatrZV0IkNTnIOmGztOy695QYy/WyESpX5RWoAnsaV8dDcKoeVoBakHrh8W2YiPbHY/ca
	HuYSEYenJgVBAp60qlBhth/6CDbLHAH/HaCrZALrEj2YHNWHqqQwH1rdGedkjEuZ1LBFj/fAroU
	EXZm6Lt0Iw2QMO1oXAzdYr549QZgcVSKEZ/Y6uJ7lx3B/PqLgQ5uKQvlJb0BXQ/iauNxw==
X-Received: by 2002:a05:690e:bcf:b0:660:877f:a5bb with SMTP id
 956f58d0204a3-662fcb7a796mr135342d50.51.1781797656413; Thu, 18 Jun 2026
 08:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
In-Reply-To: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 18 Jun 2026 10:47:24 -0500
X-Gm-Features: AVVi8CfanyOXI4B8sBv1PSYDVRsUKNvHRs67BJtokNNjVPuGSZkyb3A0gxc8NZU
Message-ID: <CAKqfh0E2479wCvQCRq24vB7r6HP7tgy6YKEVF1U0wHF=uchVog@mail.gmail.com>
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: Mert Seftali <mertsftl@gmail.com>
Cc: jic23@kernel.org, jelle@vdwaa.nl, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mert,

On Wed, Jun 17, 2026 at 11:10=E2=80=AFAM Mert Seftali <mertsftl@gmail.com> =
wrote:
>
> Hi,
>
> I've been digging into IIO to learn my way around it, and the dmard09
> accelerometer driver caught my eye as I think its scale attribute has
> been broken since day one, so I wanted to flag it.
>
> The channels advertise scale:
>
>     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
>
> which makes the core create in_accel_scale. The trouble is
> dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
> RAW, and SCALE drops straight into 'default: return -EINVAL'. So
> reading the scale just errors out:
>
>     $ cat .../iio:deviceX/in_accel_scale
>     cat: in_accel_scale: Invalid argument
>
> and userspace is left with raw counts it can't turn into m/s^2.
>

Interesting, so userspace was broken from the start.

>
> To be clear about how I found this: I don't have the hardware, I traced
> it through the core (iio_read_channel_info() -> read_raw() with the
> SCALE mask) rather than seeing it fail on a device. But the path looks
> unambiguous.
>
> I went looking to fix it properly; add a SCALE case returning the
> sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
> DMARD09 datasheet anywhere. Digging through the list archives, it looks
> like the scale was declared in the original 2016 submission but never
> implemented, and the driver was written from a vendor source without a
> datasheet to begin with. So I don't have a real number to use, and I'd
> rather not make one up.
>

If you can, try contacting the vendor, they may have a datasheet to
reference. Otherwise check Documentation/iio/ because sometimes
dev-written datasheets will end up in there.

>
> Hence the email instead of a patch: would you prefer to just drop the
> scale declaration so the driver stops advertising something it can't
> deliver, or does anyone happen to have the DMARD09 sensitivity so it
> can be done right? I'm happy to send a patch either way.
>

Perhaps the scale declaration should be dropped; I'd argue if it's
unimplemented it's dead, and dead code removal is always a good thing
:) Let's let the maintainer for this driver chime in first though
because I wonder if they might just want you to implement it.

--=20
best regards,
max
