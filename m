Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694569;
	b=FsMANxQflayQdBkfnJkotSYvPjNJsKv51M20akraYAwr1X9GFrZalaE8MLeA5Vzoogt1
	 ec9mJ+ILfjzT08uVu/Yl0QwCruOqSoWzWUwdroaz+AxH3620TQmPk1CPrKbosRWjTYdgj
	 0P+yQnXyiHKCmimvJYj5Q4LhgRiYueyyu0G2FJUVog3z+4upOu4t6JAz7EVuq1NTfKoqD
	 rgJjpniqgT3FdixdCvtYJ4URzFrL/6JSwlTt7MNxJqAS4Z4vGAyyI05A8SffT82px0b6I
	 fvvkFwevDW0CQK/REIyNxXQ8cl/KwB8IHR4pWtyU04P6J2ojy0iTpelbcPDNLCHekJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IDjZSVgHwAuIz39+r5A66Sm/O8aoe/1wLhdOdEPnhHY=;
	b=snAmPwDabU05HreSLfhil1SYLW1Ltvp60W9GTQnvUwshrgKPxvEA7qwDviMgjo8KQEaz
	 wZQGuDgHShJd3JCUeAnht10T3MrA/1VAc9WpqUMXxk59aLSKC1vdiQsQ+IIECrwfw0Khk
	 ozCOY7QHpAeDdYvYeK90s0Ndb4vrke0ipm+c/2b8coUQ6XVNAS3t9pjp7HTg/v/OiuLX6
	 8KHMfAbpfqhNNJsPXBUBKqufxJCo/vUubyfHjqqTZ3+OWRssyOu5Yqjfni+aszcD5tF2e
	 mvxzo/odwg0MpJArFm6xkpyJtqPEiSSAPohdH4BqqSSNhyC31L58YozNK77iEdBRqAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdyS2TkR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA6606A329;
	Sat, 14 Nov 2026 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdyS2TkR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0161C1F000C6;
	Sat, 14 Nov 2026 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694569;
	bh=IDjZSVgHwAuIz39+r5A66Sm/O8aoe/1wLhdOdEPnhHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PdyS2TkRxRUFB1AbigR8BuzeBsDPUfFp3gvfRlGbyK402/zw9q0NtFRTQwbVxWD15
	 bOFBsnVLxvZGL+LxdA77H9w06jZqOsnIcqWXMa6a43ESfyLrGgXWDCDFbKPZih5Zrf
	 RzN4rejU43FNyNcGfCBiWv/uAVNc2lrUULYEN0V8wgdkUngqHrx+ixzODj6gj3snJb
	 1KXvIhGgB2VfbvfaabPSpuHbHF448CT9z3x+alnWitCNf3YLyNHZVBD4h8yNVL0Nys
	 7u52Y6jAsHvlqSnOiMkm1t2p4OCqmbTLOoEc3MCyoPISIKY0xgmMjsLXkW1s9FN1/T
	 WuohnOztKqFsg==
Date: Sat, 14 Nov 2026 22:15:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Victor Chernyakin
 <chernyakin.victor.j@outlook.com>, andy@kernel.org, conor+dt@kernel.org,
 cwweng@nuvoton.com, devicetree@vger.kernel.org, dlechner@baylibre.com,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20261114221559.1867c183@jic23-hlaptop>
In-Reply-To: <c52e7b57-9d40-456c-a2f6-545c0bca9b46@gmail.com>
References: <20261104091136.151269-3-cwweng.linux@gmail.com>
	<SN1PR12MB2528F7F6F04801AB698A5A60A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
	<avR2DaxSJJwpnWP9@ashevche-desk.local>
	<c52e7b57-9d40-456c-a2f6-545c0bca9b46@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 09:26:00 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> Andy Shevchenko =E6=96=BC 2026/11/11 =E4=B8=8B=E5=8D=88 10:05 =E5=AF=AB=
=E9=81=93:
> > On Tue, Nov 10, 2026 at 08:08:03PM -0600, Victor Chernyakin wrote:
> >=20
> > ...
> >  =20
> >>> +	if (!num_channels)
> >>> +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
> >>> +
> >>> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
> >>> +		return dev_err_probe(dev, -ENOSPC, "too many ADC channels\n");
> >>> +
> >>> +	channels =3D devm_kcalloc(dev, size_add(num_channels, 1),
> >>> +				sizeof(*channels), GFP_KERNEL); =20
> >>
> >> Couldn't size_add() just be regular +?
> >> (Question to Andy who originally suggested it)
> >> We've just checked that num_channels is small and won't overflow. =20
> >=20
> > While that's true, the other aspect(s) of this is in play. Namely we wa=
nt to
> > have the same pattern over the kernel that makes code robust (tomorrow =
some
> > cases can be modified unnoticed with opening such an issue again) along=
 with
> > the potential of finding those patterns and update in case of mass-upda=
tes
> > of low-level API, and I have heard for the matter of fact that devm_*al=
loc*()
> > are in the plans to move to something like k*alloc_obj*() or k*alloc_fl=
ex().
> >  =20
For what is is worth we now have devm_kzalloc_objs() in tree.=20
I'd imagine a mass conversion is on the cards, similar to what
was done for the other allocation functions.=20
However, it's controversial so probably don't jump on that just yet!

https://lore.kernel.org/all/CAHk-=3DwgYBrhvo2NAG_Ja-0ovPf=3DxO20Gcopv9Yrr1u=
=3DQVxECZw@mail.gmail.com/


>=20
> Thanks Victor and Andy for the discussion.
>=20
> I'll keep size_add() for consistency and future-proofing, as Andy suggest=
ed.
>=20
> Thanks,
> Chi-Wen
>=20

