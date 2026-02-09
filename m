Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455A38550A
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655390; cv=none; b=Vssfr01sKaIeVGKvoii22TE/t2LILdjmp+yuWLLZtfU3sVWlsdpoUyANjgwwlRT+0zVe7v8i9qv7Pbp+JZiXokVqj9ZjC6EhT5GXLd1dQ5mic0vCtdfEJ5VMAM6/cBefz4OjeBZRopwIux5LZT29JdVW546zToxvaICseAkRTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655390; c=relaxed/simple;
	bh=HO4NVWU1cpyt+WaP5Xl/YtJ0mNO+RC4cmc+HXwcf+h4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obFrtReeTScE1X3iLoh704SV7DsA+sEe3oiApujLloekBU+xq8Jfc19GEJLogpUa6i/ZlRnuNVAWY1KxnLsJ2BRzQVhRKIUW48Ewx1439UlIpcRg0xhRVL7g3HQZIgnPTEX5x+wjV27xVnUY5Jh4qnsMUhovElxT1CU4wCMvh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfaX8d48; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfaX8d48"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so35731375e9.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770655389; x=1771260189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HO4NVWU1cpyt+WaP5Xl/YtJ0mNO+RC4cmc+HXwcf+h4=;
        b=KfaX8d48STSV+Fv2rbb5mGVr85TCATG/q0pEWghYzNJKzkVszCFql3ik+ndQDQrAgT
         0Df363I9gM7EJiKrelanrKOGaO/17Z4pF/5IEPPzr9Ua7nNIhDb2MqaG+lQP/vbRIofH
         uxNfuc+KOFQe1S1TlN69ML91U9wDgZ8NR/w+A82+ZNQRwi8tjv8Cj5UnHFlU2Cgr10dp
         zq+kDXq7ZZm0KvaQbL9/x0FcZaF7tokRJ7W3nJs3mJO6UwsbEjceA232bdzCyX4BWbtb
         j47SZrzVmRRWUYuack+erLbHnP6XMvMU8Y0/Ifrb4TcB5DWqzYCldYWq6p63+YTC1nd0
         xqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655389; x=1771260189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO4NVWU1cpyt+WaP5Xl/YtJ0mNO+RC4cmc+HXwcf+h4=;
        b=JC+uRPIZDOn2gQzQcb+zJfrX1ltPQaNi2PnLbcOwCOd9MwyD9XqomkDN3bT+j4WVxh
         GHo6cAkGnyKTJ37XQWa17Wfv/Rt/JaD1m61T6ec67ERTanELAEo8QbPL5cqfTtvbPdXQ
         ZltZcKserucO5ZBLXBPmDVpByZxgzdbw9aFTjD+85dfz5Bie6gfWTfho/x8ErHPT9cwA
         1ptxNuWEjvilf6iVizK1LuAEu0B7//fCEMGO313X5q3O2pwcvqPR5pyIdgosYim0NeR3
         1gaOEB7f8LFaAkBqz009WkGfryFUOHKPAsSbrSNv/ZAHhOOdZCh29bleZ6NuWvAynXba
         709g==
X-Forwarded-Encrypted: i=1; AJvYcCVIEyzBpHZQrpva4cHn4U8VuHWDMSQC6KOB1JbObaqlD+D4w5Pdim6iZAZ2WevM7GW+JxzIZDirKjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EyZAXUmIv0oMieUxumaZmhPs5w3oZ+0hCx5dYIXiZ4+q2USg
	JB3l23Ujx+7uAvQ+6EEKLLQbZq8lBeb2WCiRTl1eEJbcOMP90vtEKBMd
X-Gm-Gg: AZuq6aJ9/LKrk9+Gh+gIaoskEkoSvWkMWrqoSIE1WGs2gJiD++rrmWsuoB66r8X+bZO
	ZciOs3ErKQx0aj2czE58zcftTrmN60elpsRl+X87mpzJOQjfWp5WRa4t+mAYn6oG+lGG8GV0gsh
	0s6Ff+QZUVG68mIJn/tHqZYlWv+J4dmByq/uqGAb/QKj7vKVxEX2HoQjXCQCZ8XFTZCSe/V7q9c
	nZKkfZWS2hXah1OjQrjShIBQ5lIZgcfRNK3qT2TSrKpYjz3h/nj2s8Kvcq++ArUhB+jvRM9mhyi
	DBWhT49WACxZ1QV1ZZm6gXER2dKSsjk40wSnfrPjD6giWKEzSgKr8kAQ51x9a2YBzTTSCTd/Wlu
	m4CWtp3onAKLiyqa8KqGl2YHHHHwjlwetMBMSreis5cJohBeIJcYzbCKDK7CbEcnfpihq6uusC/
	kzT+B1ANwFxTc+2KGDtoo=
X-Received: by 2002:a05:600d:640f:10b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-483201dd24dmr135515485e9.13.1770655388817;
        Mon, 09 Feb 2026 08:43:08 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm14707030f8f.37.2026.02.09.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:43:08 -0800 (PST)
Message-ID: <6b33ddfce874006bd10e223701802dec52fdddf9.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Mon, 09 Feb 2026 16:43:51 +0000
In-Reply-To: <be3808e2-ef17-4191-8c1c-5acb53114863@kernel.org>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
	 <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
	 <b3571244f058133a7a0f3b5ca6ef7dc377e3fac8.camel@gmail.com>
	 <be3808e2-ef17-4191-8c1c-5acb53114863@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-02-08 at 10:20 +0100, Krzysztof Kozlowski wrote:
> On 08/02/2026 10:16, Nuno S=C3=A1 wrote:
> > > > =C2=A0
> > > > =C2=A0=C2=A0 io-backends:
> > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > >=20
> > > Instead list the items with minItems, so the order is defined.
> > >=20
> >=20
> > Also looks like we now need 'io-backend-names'.
>=20
> No. Just define the order here.
>=20

Things are still not really defined on the code side (I know bindings don't=
 care about the driver
side) but io-backend-names is a standard property and we might actually end=
 up using it so that
we know how to map the backend to a given channel. Unless what you're sayin=
g is that in here, -names
doesn't really makes sense given that we just want n io-backends for n adc =
channels and having=C2=A0
-names as "adc1", "adc2", "adcn" is arguably useless.

- Nuno S=C3=A1
> Best regards,
> Krzysztof
