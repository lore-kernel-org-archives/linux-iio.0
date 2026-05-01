Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9B366079
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664779; cv=pass; b=pASrj9pYN5Mxb695UHJsxBQsCSt0ayLXhi8nKrgaj5LD/+IuQi04diCqMWOvRekjqX2HaAz5NItdw7EE/Ehhcqt1KfY0Pu8GIgAvLuJhPDyz+m3UqdD15Rg60HIeivSpcj4wT0Ze95nGeTrjtSve4eV58Yif2JhDEWfcwbD4Prc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664779; c=relaxed/simple;
	bh=rsK5O+MdocOK17MbKRad8O2HfK2RyRdngr25JcE4Trg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAKYAHrcZQ4giGOoEzamTdKWeopNL4lIKYlbBRm4ZcwUczMtIZawOzf1++vvwTUPDx8iNJhE1bI7hnDP+SPr9GWv2muubY0cp3bMPnv8QJVPkWruhWVCi6hrUmzxD2Nsph1ew8j0ywUQS5LdUbtBBrIgZh5+HOKZh/8pshQo3k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghLPoSHQ; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghLPoSHQ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso1871193f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 12:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777664776; cv=none;
        d=google.com; s=arc-20240605;
        b=GUfQ4u48uJVYWQ4TVEc0S2R+zz0tj0MbUXErEYZDCvYd6ZP0owZAmJBZIjNq8mtebT
         cZQtO5DD3/DWN5Eu4kgqszi1jhz6RCMJnuTND7SLvo81FyZctHeXdSW3DedyOQB5S3J1
         MDo0HibIDeMKw4/pKoo2O6K9fq6uG6x3DfMtFDM9121dgpWoiRmeOwXZP1tVLp85UfDs
         21ZYs9lo50QKavO+VPrYPvybbwc/ZxdRCWTIW81VnHY/ueX198yRMaCnLqcEQVqF2ccW
         bJdunLoV5Wzv9D/nM3YozdoOvDwFRtGpEoT/GGFeR0tztf2WeQx1glSReUVFyROao3TC
         /ttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsK5O+MdocOK17MbKRad8O2HfK2RyRdngr25JcE4Trg=;
        fh=WlB22lQtzQIb8HYFDBIMtUjIhCYaM+nbTl6T1QPdG3U=;
        b=agPVCBSLz94Fi0uY+AKhKNUKEDKQ2Vi/+16FPaatz43jhce3abEHm7EIKUQdyKE/Tk
         iGuym9MbE3KzRYWzyeehAENrTtW46B1NYtxTBmEgM1W3pDKs2JV3IDASTHEWngpxYR8/
         +EA97a5hWM1ObulNHKJ6nU2Kj/KmcM0MHAokwBZN9DkLYxo1uzlL8TcD5p0YK5JSQ8Pc
         9lV+r8wgvEk4b/9H+sOFoFeLcCHqi5Xq2O6xgChA5DeWGM3DrGSben59HZUVABxEVZmk
         OQnokOOY54JgFae8nmFSIBWhwBWzFTsLqyrWB8bpMBluSte65zaBWKFXyvixvu1km/qp
         B2pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777664776; x=1778269576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsK5O+MdocOK17MbKRad8O2HfK2RyRdngr25JcE4Trg=;
        b=ghLPoSHQ4n5aDZNsGeHfjxwq7OfIXsvBrcBeaF1+gGuCvJZ9y1yVri7FkW0Qo+2k99
         nlwAlsqsjl60P6aF6g9pwZZVHENTNPblY7iVBxfGIwCY8m0zGY0D3Y87KW1iy8yIMcPK
         qY8Gh4QkcUuL9ajMJZvXQVTbvbbr9sPbH9rHwcjCgWxBCR1C+/vBU7iUBH7eGMs0qHSp
         KFb27SbcGz00irM23NdZxJrqRUJR83NIR8a2lN9TA/vU0jvdaqos0LNfR9xz/ztWPqB7
         lMrh8tyUqkBUHZBGENKZy6LmHMuH/A/lDN4/voPkSzNo/xN/xZfGJ3DDmr7DxzA5PF2S
         AS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777664776; x=1778269576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsK5O+MdocOK17MbKRad8O2HfK2RyRdngr25JcE4Trg=;
        b=OkECRnZh8mMUz5YnvUQ86e5IZ8g8pHRsUo5fJJJia7JV7wnVB2hq43a4pIk4nymosq
         ozsYdKZ54tHiaxcyiAzl9C5zRhpAx1fY28XxVR/SuAmhdBeRGDfwSgtK9T4vqirWIAVz
         mRtDkOoJP0JVQqqCJo5ACLJPsElXRPFfEPbRF3KEvgWetCUUE1nyR96EnJ6TBqXajr17
         QeD5Hf4iZIhPyDI+F6T3Mpy+OBc3RLMOG2Y+fRE2UlAF0981Ko4+44MxjQKAABSzToeP
         G9ln2Q3yEO3rOSenbWyVb/8ilH1yMoy1bsf8YFhLLrighAr5pKcPNdi9OLjWjZiA6CFd
         Y9KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IozOU6URDcMUH5lS0VIBFZk0RoGeQOxHYEso3OOzslvAoa/z1UNo9JowaZqUYdmYLz+kdGOW7tNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ABsTEs61zAYAaZ8/8ezFiN9ubohslzTRelYspo6DM586R0Tu
	2Z/bt0jBq49zzz0werfSjhyZXjzg2ElVB53lQGtmeljoCitKzaKus9sgpkx9hCrUDewfbhFTXio
	wGvYhC4Edm8UeyAs7fmnn6JPGvtBgZ9k=
X-Gm-Gg: AeBDiesY39pfGxVv7LeuQsu3Li3BZhbXvrO83Mg9tdtK5G27K6doKZxvdoIXrZhzKcg
	3iN/xJdPL4Ut8FverF/xGlL017Rdd9vZQd73AX9ohzVa0Kovi0ynTohXq58DvkoL/85+xRqZ7vZ
	8vF48kyDcI8UEUjVZOuDWOxhP6H32HUh+5z3a2tgRoDCmktQwUgvTwio3O7vL6eSIR09qP9hQCb
	xj9YBoLmMahrGKmny6b9ZNMkTXx5HmUikIeOVonVAlhpdZeoUNWLS67QH+WGi8XvEmr/KHULYjf
	js77RF6nlFR/9WRYcPSDNhR26aOk9/jaUE6mO0+tIH4ZDjoDlWkZOTzgHjiIEUyIUMozUkPJSkE
	wahEWwat+o5Zd5z0AEanS82tCx2XCE8TV0HeEFtBKF7pA6kzwJC1P1BZaM49QwkYH3OMSVZe1VO
	lp1mB3mbT9BjY57w==
X-Received: by 2002:a05:6000:1841:b0:43d:7854:32e7 with SMTP id
 ffacd0b85a97d-44bb4af908emr1169782f8f.15.1777664776125; Fri, 01 May 2026
 12:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
 <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com>
 <CALoEA-xP8PUpLFWwGrohHPUSC45jJhNuD2db-kFFo0AoH8SX5w@mail.gmail.com>
 <CAHp75VcVmhO0WwFwUL=hfXsNd=_LaXMBQS+zTx4UpC8RvKytQQ@mail.gmail.com> <CAKqfh0GrkjGOYz=yH0M+ez+9Mze56_t_Xy+p1+mzmWdU6y3YFQ@mail.gmail.com>
In-Reply-To: <CAKqfh0GrkjGOYz=yH0M+ez+9Mze56_t_Xy+p1+mzmWdU6y3YFQ@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 21:46:04 +0200
X-Gm-Features: AVHnY4KBBiouhUvi9t6DE2EpPG5jhojzbplrhoacWhg-XvfqPiHMZ9fwzJp5W9I
Message-ID: <CALoEA-y87d2HZ+4h6=GVTDgJ93ra31S5yEFDOtSL5WWLzb5oRQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Guilherme Dias <guilhermeabreu200105@usp.br>, 
	lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 May 2026 at 21:04, Maxwell Doose <m32285159@gmail.com> wrote:
>
> On Fri, May 1, 2026 at 1:49=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, May 1, 2026 at 9:37=E2=80=AFPM Joshua Crofts <joshua.crofts1@gm=
ail.com> wrote:
> > >
> > > On Fri, 1 May 2026 at 20:15, Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Apr 30, 2026 at 11:05=E2=80=AFPM Guilherme Dias
> > > > <guilhermeabreu200105@usp.br> wrote:
> > > > >
> > > > > Use guard(mutex) to automatically release the lock on scope exit,
> > > > > simplifying the error handling path and removing the need for
> > > > > explicit unlock and goto-based cleanup.
> > > >
> > > > LGTM,
> > > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > >
> > > The code is still missing a <linux/cleanup.h> include.
> > > How does this even compile? (kernel.h does not contain it)
> >
> > Ah, a good point. Yeah, if that header is missing I dunno how it might
> > be compiled.
> >
>
> Doesn't device.h include cleanup.h?
>
> Regardless, cleanup.h should be included directly.

Perhaps an issue for another patch, however relying on device.h isn't
really best practice - similar to kernel.h, it's a catch-all header. We're =
still
relying on transient dependencies.

--=20
Kind regards

CJD
