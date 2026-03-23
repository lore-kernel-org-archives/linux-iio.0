Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5181DD0D4
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272704; cv=none; b=ObxmgGVksVRaRBYUS+a3LKeTxgNlnunDAFqgD1UXoIQ6iVBv1NDhVx8uJohE6s+Vh2ttiP6LV2kSqGtrlnfGFbeRniPQXgEWhpTZTHJZwLjAIZ8el6/ygwjuVbKR9StVZELh9QnfrlqPxAe3EjbwXGDDvx7M2vfgDLD6Mg3u5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272704; c=relaxed/simple;
	bh=kNmTTrYjByOMzpg68PhBXByP+zmN2Fvtyn6F/3UNESY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdaVDAim3F5VAU2wZuv8WRErQ4M0QdAcpo+AzC0ssMFEJ9mF0Npg9w4HJTJN2K6Kf395QiTaOqmjJaafEJN8mkOAPrrcqJn1inDtPEfHkl1xamgLmLYS+KI2aYokpE3hA82IeCZHeZXhaZFzHFofFwd6h9MVISKUbj6DPFwhWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cruZhiVy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cruZhiVy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so1532185e9.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774272701; x=1774877501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guTmxpVu1G0axBh/5OR9i2kXvhmBwdLlWA3HNxxLfLs=;
        b=cruZhiVycnsyYIoG2IGxmmUojuVejuYDdy+aZuWERd3xQCUlPdBLMgqnWLB98cHWDY
         +uethRWZ3wVXw6Wyw2HDz83nJLa5UOKrA8zkRR76/Icj2+QmLWlLLXJLP8I3oDjWMcfm
         12Yr+Zggf7ftSvzlk1+MsWOUv4NIoTu2rOX9dZY1xWspwtAkNBn5nIBm2uO1jVhgUG6z
         6THu4Dd8t9PF5YOJ/twmNEC1YI23aYBR1G0PS5OYE8dnln5TD8DUSffgP7Xrp1VbQVd2
         TBC5VlPEbb9/AiKyLpQrJnOl8d6B+7ABCEGxrkmRdHDTuMier7z7bSlRHqg/zEwZGMok
         igYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774272701; x=1774877501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guTmxpVu1G0axBh/5OR9i2kXvhmBwdLlWA3HNxxLfLs=;
        b=FWXLNtW729u/1/IGta1GR7L0mCjGKX9w37gXmI7cdmad3jcSZLRQKyiuLKOEzat3vD
         W10dYcCfgr33vrEkoRMS1V7n8HiQa9cJfZE0Oo8kn/nZiYGypBeS0UB/FstSPo6PgnHb
         pEmcTlPLniR+6B69JePnI1mxobAycn1ZiV3qEb08wJTY0T0pqQDW/l9zyH/1Q6p8c0cY
         4d71pJUqnrgBO5yJDHeX38+TBId9DSyngTiwIM0ZQNACNYvleL/jI7eMxvzcJxKuPifP
         HR0svYXWmuQnrjbizPUOtIdEsZw7fIeWlam0L53N9VMobJVKGdxmckzvOlIp+wsaRsaM
         o1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCo8Pvy9oO4gfqoF9LDbhs/YXfSzLecY22oShqeCTaDsf86FaRYWljCxzn0LfDldw+FEgxT103r5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLce5vlzuq4VrEvZvZ9okjTSIYKcdBwnKQpMnjeHdVUoZ5dXZ
	wIe+0Xaro+fz1um+Pi4SK78Mj/GibZ75HeTbR54xJTqbr1J6sE7pPH5K
X-Gm-Gg: ATEYQzwu3meSzgDR0pnaMzJXifwmN7QrEhBVMDoldvd0dkQCvF9Jtfa+LUsMyCsu0a5
	J8JHEirknQQwECnqzvlm0iXKgq58MAbj5q/ntJtTHvfxTmEoIHKUq9Ch0dCnvmzwuLDunxvLhGf
	iMLJORMjN6SAjpeZ13Bdg+tS4N+s05ntRqoO1Dd5SHPOgE3DtREgf49xLMD48ER0tp/kCB2PefK
	FsnwwzAekevXrNrRZpfIHZhxJhYRUR5bonO3HrcABK38eu9Cjz9PtFIBK5vQvczUDRCsji2ugT4
	fKFM3thYJd53HAj1UEGxmOBBilS8NAlyLQcptcj5/QOE0aYjuRphCLVVTHoeVQVjGmVBBE/K/Xl
	KclUGXF4HcEEfC5SkaTKZXfDbYsecsQ6KdIZns+khDSwPE7PK7qpPEAZ/KIvhvuHxJ2eKw+ABom
	ayfzVgs/c1NTxpzeC0nStFWmLCJgSCcQ3se0oot3czzed3K+FJMwHIL94ZxSzzhTwj
X-Received: by 2002:a05:600c:47ca:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-4870169a1eemr88718715e9.12.1774272701146;
        Mon, 23 Mar 2026 06:31:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm582451115e9.9.2026.03.23.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:31:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:31:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Neel Bullywon
 <neelb2403@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with
 fls_long()
Message-ID: <20260323133139.6ba140c4@pumpkin>
In-Reply-To: <920aba2275ff1da033214293a603ef1e215d3dcb.camel@gmail.com>
References: <20260311020115.56321-1-neelb2403@gmail.com>
	<20260314172006.69744-1-neelb2403@gmail.com>
	<20260316135151.309207ae@pumpkin>
	<abgOuRDBt73Wv2N6@ashevche-desk.local>
	<920aba2275ff1da033214293a603ef1e215d3dcb.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2026 11:08:15 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2026-03-16 at 16:07 +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 01:51:51PM +0000, David Laight wrote: =20
> > > On Sat, 14 Mar 2026 13:20:06 -0400
> > > Neel Bullywon <neelb2403@gmail.com> wrote:
> > >  =20
> > > > Address the TODO in adf4350_set_freq() by replacing the iterative
> > > > power-of-2 shift loop with a constant-time bitwise calculation.
> > > >=20
> > > > By comparing the highest set bits of the target constant and freq
> > > > using fls_long(), we can calculate the required RF divider selection
> > > > in a single step without relying on expensive 64-bit division. =20
> > >=20
> > > Where is the 64bit division?
> > > (apart from in v1)
> > > Indeed where are the 64bit values at all.
> > > If this code is used on 32bit it has to work with a 32bit long.
> > > Which makes be think that the 'freq' variable should be u32 (or possi=
bly u64
> > > if frequencies above 4GHz are likely - which I doubt). =20
> >=20
> > I don't know about _this_ device, but before looking into datasheet I w=
ouldn't
> > put a low probability on the frequencies higher than 4.3GHz. We have (o=
r going
> > to have) devices that work with up to 26GHz frequencies in this folder.=
 =20
>=20
> Yes, it goes up to 4.4GHz.

In which case all the 'long' need to be u64.

	David

>=20
> - Nuno S=C3=A1
>=20
> >  =20
> > > In any case this looks like initialisation code and the existing loop
> > > has the advantage of being 'obviously correct' and small. =20

