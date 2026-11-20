Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795175225;
	b=FzQdMTdgjrkxRkRNWRhmVcDK0dAJkyUHuEMp32jj115pC4gPMLrZVPvncPQxLgRctKLR
	 4/t7wAFaOWyac2HKXtNs9zonZwVKBgz6ePnQ/086N+rB/Ft27fArYA24bxG3+XsQSiqO+
	 gczSI/HD7A1fbLbRRXp7BZGq8kODMfDicNegDM1X+PLTB01fuC8YTqMVKNNPtlPvlGl+P
	 xQeF/0yggytMtTjAOKLVbLuPRM1o5RDbRqDH0/yLzc5AtcTlC/1qHZehy+h/Cp8rxc1wP
	 kf6MSCC4JPPs2p6TsT1PIwveUPmSZjQ0HSmPIh31h06O0s6Y7dAPqBjcnC94oc/8nMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rboqm42kfeMlnWRH6brT6vQGjohJTnVO8gYOYrF0z6E=;
	b=i37p6IO4juCI130/meIF/6ar3n4N9jJ+wG70/W2740YipQdl49qmCNqiQsDgHFGMvjUh
	 hntQlrMfHYRVu7dxde1PtONFdZvroFqb8G8ip3yzYvFbcqT3a6r2Y7NZgx3kAcgfVurO+
	 zx8i3OmCNzg2mQF8QMas/l6mtTn2Svxp/stETQ+ejSqR9833xGJEREkN1BGCAVQkD/mWu
	 2AeOSV0a9KaKpoal7pHbi/NtbREqYLDHPxz8Y67S423OFDiA2a2q0IJ+79UhWn5YXcEjE
	 faBKhk6SFkArxwQ70dT1dpVE2DKlrlxN0y8js29smNL9FAoCATQvjeQvzUJH4nljTAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8XHcKwO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15D606A33A
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 11:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC15D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8XHcKwO
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso185221766b.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 03:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795175223; cv=none;
        d=google.com; s=arc-20260327;
        b=PX/US8qBgXfGGLmSWzTk53bg/A5ZFqtTi12CQqHEbmGC158GR0F1SnMFr+4CEwGZcP
         DNE6Kt9LIMAW15gbE03xqIk+eFy2qHxnyRZmj0yS8Emt4Jnwsl/r4cuM/vQRk1Kg3PS8
         lO0nUmaBa0tBk2nEiL+quQz5u5OznImW2cdhaD7cwHdj+RLbgjDX0QKJwcWwml8Zigwx
         SabD/IHhsXZoKhffPq2jiN+Gy+Y5HZuTC92bQzZ9JnFgrdgnVZds5vHbv5wDSLAm3mvh
         JGnmOH6uNWz3gZV0At0vt5fkq5Y28hWUBvOhTcnklSJXwcQEZ86CKoW1RsGuUAMFYrSm
         JFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rboqm42kfeMlnWRH6brT6vQGjohJTnVO8gYOYrF0z6E=;
        fh=vt+Ly1J8Y+VIXRSV795pDU+4nRu7Q8IYDg+UfwP9JOs=;
        b=oZqnAC26PY6/uF5wuSRFmDCQ1rBhzISYh6WK6d42Dsx+IBXmvQtS20wusoeAn8lGos
         AQx0FAWY0Jvrqh09UHJL3IRbttREsG6/ei3Jjp09/CpRd8H23vB/SxA+I3bFrl92t0Jr
         6kN1XApvSMl8CPWyzeoKDcy8W/ReEgs4QBaQmCwFue1WLEj+gOQLwy+hSRoirdW+l0U2
         C5rTqzkCBmo6xJre/fq7x/GIVe/wp6QKqf3gPygk/yLRM6u7IPMSbgIWXlhvPOTqQpsp
         oxSmchklAwBvmKxFq8hA2aBrkAnQqh3mlT5DisAxptlpmpRkCMJHvEGyez5TJ+xEt+CO
         vFlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795175223; x=1795780023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rboqm42kfeMlnWRH6brT6vQGjohJTnVO8gYOYrF0z6E=;
        b=h8XHcKwO3F4PD3G/dNgWJoDK7w+p01JurVHWm6TsDO61jAell/PyYWi/Lkp4JK+q+d
         oB7p5pMdy2OWl8rcS9TpNSq/Dbx/TySYfI25oOPYY54YssBRxOGtTzYn1v2PpNUs6V7m
         D2aJgG5LdoF+ollwM6570vbjZ11O41a8ORPQXv2gbPHKg1CVRc6acVPLMjaozqazPzZ+
         SPdxFgkhvENYOT0TNfDXXeNNzZ4RUjhlUiyljzvwkV3CFe+tvRaNW1XNdWD3oMg5i4or
         2kvtcIQChUa6lRthcdY5xmXCMVibFDSg4uIHigtREW0FK/T6GRMB3pOUKOdQ0Cr9yV43
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175223; x=1795780023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rboqm42kfeMlnWRH6brT6vQGjohJTnVO8gYOYrF0z6E=;
        b=pqSNU6dvKnbee1Q4BPdItK0DmMVaPDqSCKyZ4P6hLz0bF1EvOwHgomZb7EG+zoueGN
         b+eMALEtMwmrwI4onypGD8McngX1Nv9BFalmFKq0ifpTgf/UHZBXOd9aLzqFGhSkAiGl
         ar4b08FdIqSGUqZyLiZWypiGmPXBRo1GwG5saQ6AEHwKy4jrT2PzOJNpIXEw9u+Ckc76
         qXAAcR8gLy+dtLl/ty9c4oCnzKQVCsEmXG2VhnGL5odyTvj76ekIHVy4QYmy00t0ifK+
         QxBg8KgcP+l8h2likShru9YgvSLjJFfI8dJt16CtAKicRYR6MLaVxnwTx9PBBpVKxfQB
         W+OA==
X-Forwarded-Encrypted: i=1; AL+hErENkmHSaqe7QtISHMTjFufn0isf5cyqbTgFXgXeWdUFjGX2jHvp8ujbRcx5xsctrKKoS9UFZk9nWAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CEraSq2otLfnRKW7mU0bpw5/+4fg87fWCzq3PhWKygNc7f07G
	OkGXRSj3fHfypYSeFAF1Wg3uU6KZG3FZdgffRunnM4vULzcxbG8KDmihKlPgMe+OsNrtXMabvv1
	D7lcPP8Bd+ZLnuHGhspf6iG4IgvNb+QI=
X-Gm-Gg: AYBFou2e9gk8dYsn3xR9qczf1OPL4gvlsLfGxzq6eP5ZNFyctyceb7QB174nZImqIEV
	tvGhOYemVmswd5PVOgVEv46g824mFw0OIqz4H3EVgX3GJwk10J6yRx7LWpyXmnt4reTjhuQ4M+6
	7cdtk2Q/r9pk1cPJ5PquyT8cFwgOvehowMRi72sM4dTF9vmJTnHoryzXYvomEGCKsxPWEky0JAu
	neL308HQ9Agg3kCsR3TommSrPpPXvkTYD6FWQcn3XsmXvc+1NIP5omQ7dx6wwaFMTkU4E7fYdh6
	YYD8aC3i9iYIY1CZ9rj7IKHQP0iYJBKjgRUQSIucbZMN12yE3LjbPXeO5ErgTEGknEp4a57jjR9
	ItYm2lT+zzd1vkCqBhf8NCU6tpo1R6TCPjblXe0qn1DboKUu6oi0A
X-Received: by 2002:a17:907:6d26:b0:c51:50c9:741c with SMTP id
 a640c23a62f3a-c5150c98208mr51413566b.10.1795175222825; Fri, 20 Nov 2026
 03:47:02 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
 <20261120074417.33563-1-aleszlucero@gmail.com> <awAZnuq2XAGo5De-@ashevche-desk.local>
 <93a78ecd-d6c5-40a6-8236-d7d380f8ae54@kernel.org>
In-Reply-To: <93a78ecd-d6c5-40a6-8236-d7d380f8ae54@kernel.org>
From: Alejandro Lucero <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 05:46:50 -0600
X-Gm-Features: Aa3M54ovYQUrLVPp60AyS3yYJr3Oqe0LpVmpu5wd0Lpr3r7__84Uamlq1W8wR8s
Message-ID: <CAHDi9tpuEUpfFn8mETJi-_84Rg+GMdmLgYQnzg6JKTmy8yHbVA@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: Close attribute streams on parse errors
To: Joshua Crofts <crofts@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, zhujun2@cmss.chinamobile.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	knaack.h@gmx.de, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Good point, just calling fclose() without perror() (or using
fprintf(stderr, ...)) is cleaner here, especially since filename is
already freed at those points.

Regards,
Alejandro

El vie, 20 nov 2026 a la(s) 4:40=E2=80=AFa.m., Joshua Crofts
(crofts@kernel.org) escribi=C3=B3:
>
> On 20/11/2026 10:57, Andy Shevchenko wrote:
> > On Fri, Nov 20, 2026 at 01:42:39AM -0600, Oscar Alejandro S=C3=A1nchez =
Lucero wrote:
> >>
> >> I checked both paths in build_channel_array() and find_type_by_name(),
> >> and confirmed that neither cleanup label owns or closes the open FILE
> >> stream on fscanf() failure. Closing them before jumping to cleanup whi=
le
> >> preserving the original error code looks right :)
> >
> > But the change has flows when errno =3D=3D 0 after the system call.
> >
>
> Interesting how suddenly there are now two patches fixing IIO tools.
> tools/iio usually doesn't see much activity...
>
> --
> Kind regards,
> Joshua Crofts
>
