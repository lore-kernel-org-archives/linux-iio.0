Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98753CAA41
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140691; cv=pass; b=nZ9xsqG4j/1lKon4Okza8Ifqbc40WhEBgSRhZ7PX6rp9mPgLW4N0gscJu1QTWoo2PJQEZ64RnxYH0ued//U+vlycX4b/2V+8OmnCDYeg4jvqh1/RDq50UXEmeNTlgP05v59kNPVo6hBib94WOGpn/dHoEYPAIE/B4Qv8rPLZ0iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140691; c=relaxed/simple;
	bh=fkQtSqlmS9bP4148tvn2U0aV7x97yBRmtgLuyiKo4kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLQx6t+07LTQ8tSTWmDDlTKrk/W27yNZyoRWhifA2kFmatCg5nRP7GhDyotHJlCMgPXbof2OQ5fuVxBkeZh4p/C8NL+NjUUwJ2qAnXPFyctjtyiuyuL6bZpWkwpxptgUJHs03zF9RAG5id43SlmBEy8pz7KooXLSBS3S38AKGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu7N5Fkw; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu7N5Fkw"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1732439a12.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140689; cv=none;
        d=google.com; s=arc-20260327;
        b=OHgAawtVMBGpbULufWaTM+W/q2tC2TpH0ry/0iNPqSVB9K0Bfk5dodehUpsJPTR5L2
         2mSIgl143Lv26lm86+2QXxq0OidHFTbS+N2k1oL0C+PfnifD7RjW6/LZe7lA1MOU8HXI
         +X8jWMLQcMyBWB7qdT0cUEWOncfBabrpvA7SI8BTzmJGB+Zjxvkp/rYVHdRYpQkYyUcD
         B/Raq0siZu4pAfXY9jbr++jHB39DjuRtAlM49NIY/UVRlLu8GZ0xanjfPC2Qo6pQBnQY
         qMBdaWgXfDSYaDeb2LLNxtM9AxzPU9CDWqwVDclPPyz9aXzQsrH9oQGQf/v1Sr8LaWAU
         H7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        fh=XUTW+UGrxVLNjSh9dFfGZxsQ5/0z0UlpYbv/cy3KJU8=;
        b=c16RmmiJ1tVgAmwEw8An3G4g/yQ2TtVo4ZEJ/aewGPXNkbqGfMOVp0HaBo8GZabGnJ
         FhJvuPCMBH0pz2qwq9LcRWXPQ9UI7LfuiIJ/XLPHGQj1ScLt9Z/4uLuVqkLrnExsTyx8
         PJmY6K4qFoq0x/av9bb8/uV4OMdtJxwDuSrpm6zNBD2KzXLL5JLDaZ7aGWls9h9Y2vfc
         wvh+yNNYjtjL8kN4YPqv+VUJ9MIdEEZWtMAGt8nfGZOAoDZyExkYvhsUP86oMwiUUeBv
         O8vpF56CU9gFPuGPiUjFCwVJINUoCutWdQcKVZbLsgCPXjUvei7AvixtSjAJo9VAbKoR
         dK7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140689; x=1785745489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        b=lu7N5Fkwr8FCMNgMaaxNdwucjP31CfVDYVlf/pQZMo+eVdn1FBl6kpF5hpR94lshhe
         A8S4sYp3ZJ/sDaX8ltGAX5YkPKMYoB+SQRE3rrLftwE/hhZq/YX35j3z2xqVJBsJMO0I
         bjJMJTNTAVmqWGrdQKmLfsrTKPbnY18aNSfClHxuMdTJ9vvP5PGN+Yw4PWNatKgg3Tkl
         +7AZqQzU3JNXDp37qbMcIHq1W2BSX55SZs2vQvR27KQiFN/4ZTT2vuoqNc/K9v/dHDtX
         Yub8gUqCA5nl1rQq/ybRTGVfK1pHh6XqpvywyF/0SMfOc/iRhSqzTWhHdh99lBp1kDn8
         YL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140689; x=1785745489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        b=ab+pAvppLkFA8tBDBdgMbZ6i+JRLoopjz9KlmtHCySbFGrLizJY5CC55NeRk4KHN8P
         zu75waIe9xXZ/wxdw6NAUziFe1ZAWyFvfkeQmPTXoRTn/ixxReK6oYXQi5cRsrgocjWO
         jhnAn0pgq3bdHBv846e97PMzj/7X20tMoRtNgQCfUQKr64dBXdAK/qG2aO1p3Qdv5cmC
         Xtq9bC4RzuS1uAI9738921Crnbafndo+zbztPQ+lb0lpzGSkBntfkv161sZzSjidaOvq
         FNchx5+vDHYo3drtzFSVQMCeYyxS8F0T/J+3sw8KcV9+Nv1geBdmi156aFSIVCFVB216
         sV1w==
X-Forwarded-Encrypted: i=1; AHgh+RqTWRhPqh3irfwoTQOgfutQ/71YMc/QAStUhlOUrhEwW1eg27hBVrKa2x47ZixBBYViZtvHbIdFX68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMbKlE2V4e1Y/iHgfi9IdEPrGkjhMcxKGkuzl/UnTxLQYnqXt
	xnJE/Qsqaow4dg5AW7gjpgHpOltpmK2FbbKg+zhi6e8AarAPXAun1ZIFPWzt/HwVdhwJsIeH/Q3
	8zVFteiMSGi2B+7MYjVTjOSOtfOdOTrI=
X-Gm-Gg: AR+sD10B+I85T20MMJMxz2htJn+cHUdnPJdpbhvJaNicrP/KNQvG9VB5Fp5CdzsugWP
	4Aa6mk/E66FhIgjxL4QyOdGS/aPCDLWe+8ogiOGmsievEOP/daIeCPwkkRS0addt2y6TDZiRYRD
	lAe7SMln3hqGR9wXYU3Ze4ZRgVFnD9M3YX6nEqx+xLTE/EXnH09Nb6OO8Bca7twf1MaZi0mDHSQ
	sWk1PZ8ivEFAunt20s8DUDHqR0VBX4U+J5tPlxERlIPrpUANUCOyn6MmCbuiIxTreGdQm2kz+tu
	AvAwvNmpbYnzZzeReCs=
X-Received: by 2002:a05:6a21:7002:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c67dae969dmr7046276637.13.1785140689346; Mon, 27 Jul 2026
 01:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-9-clamor95@gmail.com>
 <akeXAOpb13hupUGM@hovoldconsulting.com> <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
 <20260722023037.776f4bcb@jic23-huawei>
In-Reply-To: <20260722023037.776f4bcb@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Jul 2026 11:24:36 +0300
X-Gm-Features: AUfX_mx8whI7gSCba0GgBVBHpAVLRZADgHNcCPlSfBxfKQKn1EgxosjjezqzeSY
Message-ID: <CAPVz0n1dnoe=Xw2V-nZtm3ggD5KLO6PVrhXOAoPnqvJn+C3L-A@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 22 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:30 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 14 Jul 2026 16:57:01 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 J=
ohan Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote:
> > > > Since there are no users of this driver via platform data, remove t=
he
> > > > platform data support and switch to using Device Tree bindings.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for b=
acklight
> > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> > >
> > > Why are you reparenting the iio device here?
> > >
> >
> > Because every cell has its own binding now and using phandle to parent
> > when device has its own node is not a good practice.
>
> It is however a good point.  So should at very least the ABI break should
> be called out in the patch description with a brief mention of what the
> path change actually is.
>

Ok, this is a good idea to add chapter into commit description.

> >
> > > That's an ABI break.
> > >
> >
> > This driver does not have any active users in the kernel and no
> > activity for more then 2 years.
>
> ...
>
> > > > +     u32 count =3D 0, reg, nchilds;
> > >
> > > Don't mix multiple declarations with initialisation like this.
> > >
> >
> > Checkpatch does not complain on style issue, hence this is not prohibit=
ed.
>
> Prohibition vs taste.  I fully agree with John on this one!  Those mixes =
are
> messy and hard to read.
>
> Checkpatch is a helpful tool but there are both rules and preferred style=
 things
> it does not catch.
>

Ok, fine.

> Jonathan
>
> >
> > > >       int ret;
> > > >
