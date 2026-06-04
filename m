Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AF43C05C
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589665; cv=pass; b=l5nP0IrPtWgpimOpTyT7uCOPD6kNQ7raNz1MWZmsPLcYRVaS/o0Nejx+URD3CYpoUyTu0SwyzLkfuZt7bZHvQtBAZ8JCBE/awibptgxBepoV07p3gdhpD4XWi8nPsvgNEV1Pz67nhhFJVFiFOk7W3TkDbkhnpfwziQjHS7dyOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589665; c=relaxed/simple;
	bh=GKwKIb/u7M7DhfWfWX/iglYL6XD0X5bxNq0DTHaMz4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiSLq47l53iE0e2QcALT2wycMv48zo0WSZK0Kmw1SNr6gRKrfejDtUlx1zQJlFcDQTDpzlNlDzXZ+ah80JkExrqtzpFAw5DI66CbMfpJzkUY+VXOnGL+mAeAzxeiD7YS55NCa7PzF1mxlnOS5BajW1tUzAWVUZXx9WTlwRxno1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ce086YNq; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ce086YNq"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cce77eb087so7750736d6.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 09:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780589663; cv=none;
        d=google.com; s=arc-20240605;
        b=WHH6dkCHoUfkx9OiAP2U3427i/Oh/alODGOIcr2JayGBS4t0AIxph5arFEudU8ezCW
         KJzF2/oMvrv1Xoa+kZ9oloFYGBwioqxlAEDAWwDrqHilc+PEQKBeiLXFm2wGql0DGT0o
         RNuddsPIH3oC6ms6gng2Fc71Qkx51fQzZ5TsphJIJXXdHtqaR8b2PyG5Do+KQcJqjZTN
         aRa0o753O22wfUn0Ss9cPf9Ahn/5zHDnFZZC9beN65G9ZOTtxJdzRemhBDDdAhETkghj
         coUw4JWU1wSvc9bct14oTTSbgSobi4hSPa5IcJY87fD6qf7N6zfsarcJ4XyzQEuTVFWG
         1uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKwKIb/u7M7DhfWfWX/iglYL6XD0X5bxNq0DTHaMz4s=;
        fh=DX9oPwGAXMNCz8b1g648i4g1dZZoIMoEv/dwhIEpHEE=;
        b=RMh2E8R2vrZWswNTKaC31SHwBvY9CRBakK/0Qq+jThA0NtjcYVmC+wJ9dXb+Sax7uq
         WMJULg5eNJLxl+F5XLoX2m2JGSfjgIF3qUJnMYFcqmymgbP6KKI4vcL+8cqpGkTGeA9W
         P0Pia8DR1ecg0SEZ2YYI3TsOFXBWkSEUza7froB/Ds5j4vhnnabL5DklyDr0eeI/Xm+V
         XndiU4uDSC+efMk6Mz1K2hstCc023uHqowzy8atAP/slaOHfvXV4ZC0FemdgPrIvZQkx
         rLXvP66P2AVEIOq+LBSQ7e5hklZgIOtdHKNN/6r9knixOk77b5pYq+C0/1/LZERaue/X
         GzxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780589663; x=1781194463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKwKIb/u7M7DhfWfWX/iglYL6XD0X5bxNq0DTHaMz4s=;
        b=ce086YNqawxIXlHUEQyR1jOT8KCcOVQ4STa2OgFfQi+SDENTWvD0QrX6rUNfumfChB
         o1vtLG3j8U2tQES7tyhiCoUwbl1/QpVISQtPIwRedrHoHRgUzQwOHoPC1jo9lStOVBb5
         P6nfVpnqmQcZHs+TpcXgoAie1bK8nJTlwgYS1tID2A+Jzm+b0jxVuRRRLRgBYgBFTLx5
         3ZRU86bnwQjFs1Vexho1r1nz0u2JB0DyoHNevYUyU+ZSWE4s7hrQ7bARiTWVnIwrrDdA
         fFm1PO1oAWHREmVNl1oSRw57Be989W2GucTvup+muLeBX9rNOh+MomypVvdppTL4QdcJ
         oTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589663; x=1781194463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKwKIb/u7M7DhfWfWX/iglYL6XD0X5bxNq0DTHaMz4s=;
        b=pepGEnXNUkgm9KHZ5mmEtJl5hpPiQjD0JIAmHVq6DtqWFQh1h5Z1yXWNBpYyyNyHhp
         DstjR3JYdJ/2yeuOUBqyyRF9bbeKalCbzWOnF0ma0wtdUh4Jl73Lr+3uVJgLvM5NBLxZ
         QSAOxwhJGRTX0DOz9DeqQmBMeedxpxvg5pYqVoTEyuAWSql8pbSAmqbu66sE51NoBvId
         ZDw77EzHpZJjk7JgdSI9/rBWZLgPg0nOZcaDpkI3zqmV9d8rh3gnD7IOb5hhSwhTo24S
         q5NuxtWK4K6eRRULbZtTahHvGzObvCfVNhdsg8qE5yD4AlBLvs6RJkeDk5ZzEKMwbAOA
         KAbg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y9nqMFUwban8f/GhGd2ad0xViAzt3KdDY1nSlNpSYkQIG6JiLfpXaQE2E3cJJSWb37hB9B9J4KcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe8EFvHVjC8iYG2yciH3HeFqxgWKvWNGCJLPYrL+4AWSQUCS9
	QMk2xEowt+9Hg/36DiNxXIft9vxbpO91PcqklkY+iI9vd1cAIudC/8QK7m5NtKXq3dN36mCqmWH
	YAIUNg42XC+4+31qMgTHL+o9hYq3HL2k1ssnPG1711A==
X-Gm-Gg: Acq92OGh04cn90SjixGuCCr6QfGcoUc9iUnTPtyJcMXYfKiUHgPrP5hRWR8zwkJ6Mjg
	yEqjGitwLakRP259XetY7lCeZM7nnmIHdTz7sgg0xPMtQURiodxM2ZMhG9cdU1YI/DVsjuHCm2S
	xY5n2j2TPjv+ddGD3T2SupH+Nb52OyLW7lLO9Si+VlSUNiq0MTjT8nc7MSpl35goGdgu9vy2MTO
	SzZ0/g6tGkckJN/TBHpM+OOj86yI9H0U+g6cjl39IZ6IqzRf5tVEhcRFPxrkJcMH4H7WvT4JL81
	qrPA2YKg5n5lSK5r76AC1L4PSweWPH5R+uVoI2TiR99oC9R9iV7HqUgw9XSn
X-Received: by 2002:a05:6214:3a0a:b0:8cc:dfd2:b929 with SMTP id
 6a1803df08f44-8cecdca7f27mr126313206d6.29.1780589662648; Thu, 04 Jun 2026
 09:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk> <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk> <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
In-Reply-To: <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 4 Jun 2026 18:14:11 +0200
X-Gm-Features: AVVi8Cc5C5vnUpUU89NhE8J2JmAWGCJNYCxHGaVbnNxZics4mAQyyj2eIiU6a4I
Message-ID: <CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading whoami
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Andreas Kempe <andreas.kempe@actia.s=
e> wrote:
>
> On Thu, Jun 04, 2026 at 04:36:40PM +0200, Lorenzo Bianconi wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> > >
> > > > Is it enough, if the shub is available, to just always run
> > > > st_lsm6dsx_set_page(, false) before checking the whoami?
> > > >
> > >
> > > I think that should be fine, yes. I only added the readout to lessen
> > > the risk of unnecessary writes to potentially unknown devices.
> >
> > I guess you just need to check the shub is supported, then it is fine t=
o
> > disable shub register access at that point (it is supposed to be that w=
ay).
> >
>
> You are thinking of gating st_lsm6dsx_set_page() on
> shub_settings.page_mux.addr like I do, but without the read? Or do you
> want to gate on something else?

How about setting the SW_RESET bit in the CTRL3_C register during
probe too to ensure the rest of the registers are in a known state?

>
> I'm willing to submit a v2 if you want it.
>
>
> Best regards,
> Andreas Kempe
>
