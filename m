Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794667515;
	b=Pi9GfBf79XoL98iZzKeJ8soRI6W6J4HtzUOiUVmYF932MSzOx3EPPY0FTxRnlFfZ29zf
	 CXlyTrkec4hGTqP6Sc7/KyPc9/xGR7T4Un8B01ZTcqkE2PTmEZiRTJs7DIHdXI7cHllkr
	 8pQ0xgvatTwKqFYzDSvWQkN1EFQ5O2diF2oRoD2FfEPyNOvxTehjalWKiFk1bItlpGg4C
	 qIrMpHtbX7AzFRd3IRFJCM4dKcq7wtjk2iIZnF2dHQsDVevetim6km3Tsv6YLMb6rkMOy
	 s7zM+dd8yeNGmUgZAjnBOWUoNAK2v20BWrkz+xuMnRRAkTGXAJ4r5gwGMr26GFsVCdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mpGxYuoYKOxkEJjh9D2Ng2/n10DyVBs0agON6KJxSRQ=;
	b=StvSSU9/uCWik/FjLBpa5ixq4qyuwxrszovt1z8GfY8QGlCHndWqbjMZRsrRQ886eRxz
	 7h9MD/au/kwRFycEN95CGudPhmGftCRJxODGIhynGuXEUj8WqODHKt4DpNopEcbSUwy8u
	 L6lEZsUrRb6+LV2kyTXtTP3wxBVEqVHrOxUgqIt9WCBcszelogyFxA6lHc6JApIup89il
	 wy8x15G28o1OmKDqZHeEBswCPmhGXLuvOb5R8q71K/tboogUXnB4CArxSbfIQzHP+hlZZ
	 yG5+0lkqHD4RwwngR6FI7wZOQYKBpSuyAKoZlDszTDSJnKNiKJMGzcBqWhie+DUjdeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWnMxepI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746F606A336
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1746F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWnMxepI
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37198ed3727so3419678eec.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 06:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794667514; cv=none;
        d=google.com; s=arc-20260327;
        b=ibufflSVamaVeoNLi7CAV7WtAFk0naTAbQDIZcglQ3cR5qt7Uo3gxSi0AVfuqacGXk
         HJ3b0ft69incbYb6ppVe+nzm70z/HIFXrK7D1wH3WNx540xKZA2+tFNN1Vds8z9+fllk
         tnwCcBmdtaZCQmG+PubBLINedWfJkxSN2FvBUhszSLOCDFs2Om/fMtiCTSQmcoa8r6Wu
         ClBKUeskAhhVEKhRf6BaR0WlwdIHDtZJMiDLQYhSnMcmANvIlxrBvYYABrINrBy2Y42S
         ITU5GWTX7Z/QpsB+CbjQ259AyJKMwH38jHZEaJpe8fmi9VWVPAt905NJvxlqeHBAEi8N
         hBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mpGxYuoYKOxkEJjh9D2Ng2/n10DyVBs0agON6KJxSRQ=;
        fh=tat8UYncRH7Z8a11ML+P8mAByBy7JVAvttaeOqFrOJw=;
        b=of/iq5R9dbCtiR15Hzs2cG987lUlfZ2nfe001D0Cx9X1Pl6ZatvcYVyei2F4wuQcLE
         h53tdf3wkG3duu3tIWYd4Le2BpS4AmGm2rUPeD8VJTvlOvIFq13F7MIaLAvSKaOvtyxS
         IDE7PG3Cv6vqry3Hy2sRkqsjITuymYHzOiVRP4ZJKgbGAOWc2xufWX5T/lUdW3Rrn3Bb
         KPG7CBBTffhZShBVR4MHsX2BvGwwckgrkVeMsazjhtbrNX7r3L+aPnEk9rfffeFhPjDe
         MW7G2RCD7bC550G9rt5NecE5V7MoUfcpEBThqzwaKJr4SKlLK4/OPg1ghptd1YB66uB9
         r3nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667514; x=1795272314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mpGxYuoYKOxkEJjh9D2Ng2/n10DyVBs0agON6KJxSRQ=;
        b=VWnMxepIxhJfUqyZ91Md3j8tCzMbWsFJYzY+qoeWDv874H54yJllbiHo3X4LcMf9bF
         a7sAuAM2r4ldJ//2C2kQxsmcMTluww2tYeWFj9F4B7Gm4Yw0TRIG/em9N8Hntyat5W9s
         6+7iXV+/P1khaxucf3UcN+XJRL2GcG6PHfmqDS6EfNRYbazxK7aAZVtfVdZjgZ/ZpxPn
         x4gpoVJepbRDfJrqLMO2Tr45fubzF/BkR7LMMUfaGqtQ2Wii6RIP/BMpGesAvo5qWo3q
         6h+ak/DvPX9WjypzcHk7vt1tkMQWOqi0Y1MieyPDEyC4RxpJvFwnt3PMDYinJRRust52
         NHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667514; x=1795272314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpGxYuoYKOxkEJjh9D2Ng2/n10DyVBs0agON6KJxSRQ=;
        b=RDRFYI4nK3cv/qAp+jz0GnRrfr2mlX8Fv0W0yIQdDqgmqUyeNJVlw0xhIVaYdHl4Gv
         Z3wbOQx5V11qKFeL63TRNOCTW/dngh1eSIvjvZua1/OfXFDMFNkdZ5CcP1ccAo4SbOvl
         HL1LidtZNExboKzQTbGQLzdbxdzmzTphfRHd81YJWQf2ZgyBzIHIi9OKXvghzdKqtSGc
         eP//7GiNFc2BLxWvfV0myXhM1cWcvkMgF57SnaomQL4NcvOsIHUucMGGEX4c2SCIWhtW
         K/lqC53K3wuqz9vRA2lPUnnpi5SvvNEdxMAXBBdqhE4C4WX5c49e/sxfHn/IgXPTtLZQ
         NAQw==
X-Forwarded-Encrypted: i=1; AL+hErEnzAMEEC871Bh1xqTAsWjBILOlq+EYlVuCO5+6TrNE6ur7s8+9Y7rSxDlGlICSQvAJtAU/Q0grhB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bZyFIM1118E5Z1xL0Uz4n336Odoe8XaGB+geVroxXODBaDxx/
	uu1a0di0hoQy7mZDFGbyfhvrzvzrmmD+MVl++o6Ifhd24yir37vwfevprH1NX6t4fy0E5NJ0UMX
	/XTDljPXvKPlRlljWo//y5hpj5Ec9cug=
X-Gm-Gg: AYBFou27vbBAoeBsVuoA+6PqLSDtpIsRvDVPH032Pn3uGFCNF83GEkAkcG+/ml3hx4b
	/5uWXtbFcqbIbX8fCrnRkLFSpElstZKUk07UgGXTHYL0VlOMI/cJpaRrrl+BMkdFJMraMnav8ui
	+gczL2Fpiy6RlaU97CPsV8szOaKZHViDc0SLL0kiKQKXb82Ka5Yho1bOs8c711akOnYRG7HZ2yy
	E6gA22Fxhj0iR9nxSoc0I+n8I118HyM+/3vn2MhxI2+iC6aUBtkCRolfwGQFXbc2ySr1tqmxdjp
	fGTO5G4pgnIIeO/IsnydzcEgi4H7T8ndhuM9QzJ/W6OC8UUCAXRabNGL3TzU/8F2wOm1aJ/zfU5
	4q+UrA1xyMLm+Ws2uadIM0n26n74tv4excjHEjd38mg22OfA7ncG6j8RP6F8xHpCcYEJ7aybRIN
	0nxsdcYvz/7HOlwiSUdmxWphcH8C8fbw==
X-Received: by 2002:a05:693c:8115:b0:36d:bcd7:2347 with SMTP id
 5a478bee46e88-377e093db88mr8125743eec.4.1794667514069; Sat, 14 Nov 2026
 06:45:14 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108094253.83899-5-clamor95@gmail.com> <202611090518.mm6yt2nO-lkp@intel.com>
 <avInQ08dVrsc-Rbo@ashevche-desk.local> <CAPVz0n1FqXV-XXyBJpnp1ivd+uk6+zGvngobQZfUXMNBBPyORA@mail.gmail.com>
In-Reply-To: <CAPVz0n1FqXV-XXyBJpnp1ivd+uk6+zGvngobQZfUXMNBBPyORA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 14 Nov 2026 16:45:02 +0200
X-Gm-Features: AclHuK9Q2MT7WzTqFgmyb8uGWfov9bVv3FDtVPr7EAhs0HUduJChL9YtHwu65_c
Message-ID: <CAPVz0n1UG6L8divtcXgg7mfS7C3bO9tKv9d-Xh6VbyayG7p8-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: kernel test robot <lkp@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Pan Chuang <panchuang@vivo.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>, 
	oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:07=
 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:=
04 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Nov 09, 2026 at 05:48:09AM +0800, kernel test robot wrote:
> > >
> > > kernel test robot noticed the following build errors:
> >
> > ...
> >
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > WARNING: modpost: vmlinux: section mismatch in reference: trace_initc=
all_level+0x28 (section: .text.unlikely) -> initcall_level_names (section: =
.init.data)
> > > WARNING: modpost: vmlinux: section mismatch in reference: __arch_xpro=
d_64+0xac (section: .text.unlikely) -> initcall_level_names (section: .init=
.data)
> > > >> ERROR: modpost: drivers/iio/light/ltr501.ko: symbol 'iio_find_chan=
nel_from_si' undefined!
> >
> > Forgot to import namespace?
> >
>
> It is not exported in the core
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
drivers/iio/industrialio-core.c?h=3Dnext-20261109#n319
>

Should I export it? Do you have any suggestions?

> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
