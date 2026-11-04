Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800723;
	b=iyxYSlFCNyty2DaQohX4s2nk5wJ23fP/Y9wDKo2q6Wb3DbbHgxOsnSmLF6/iIkq1oyss
	 NhS6BtPFVZjBJUD4vu6Q7NwpAjAgLdWhxiCtGGBZ2U0eWQNFAWRppaL4JjmQYzF8VuaQZ
	 FalgFalR+yFkhYwvLvdHJSJIkclZ3YHOEAFKyzTvMukmaYGTgpMDjn0PYDHmFJMvABEpw
	 w4/+Be1wnwDvnIRRi+4vsqswHRjrz7KD7wDOhWzaQjKqpdFzCEqytLqfhOvqL+i0PuKz3
	 cMfkrnVv/0tOd5mbJf1f8HKgnzp6RvSBLdQ89D2aSfX4z9ZuRPtdB9yJPKFwZbUmv3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JjM/kvU/Kv0Rdhq5AjgFZUCMPeWWTPzyVcIKg0u4/XE=;
	b=ftuwWD5fZBZ7Zx2IlPxcZ7zPLoyKysjCjSpNGc0Lu1QUjsV1WmDBdIhn2AF2nIUx+VEN
	 3CNiYSdzVOVa6WFTDRT2ICLbEdWPiSrtD0v4OKasIaeMddPI/BME63DWcDItaFyM1A3BA
	 03GDpy5Hkl4RLQuzBGnRfCId8VQwEIfs5SIVAB6DFFFbVRdpM8xJsscY6NqZT2ZfOxKhu
	 DDe2qsx0Bv4fhiGRzmJygdBKWI9cI72zyt7raD3X3LkwmnKjM6IokDgqckOtkq8FZtSkc
	 ibmrfbYQSsXMFPRsO3DYiN70Tjo6K4qi4+0yWONamEwMIsipM+HdNgnx2JEBjogAEeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/ErdDHV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8578606A326;
	Wed,  4 Nov 2026 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/ErdDHV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793800722;
	b=Qos6J1FALlHKa7eJwCMAEQWcvWDpNCSA4XAvNcxztTufIV5AryL99LwnTbb3etykQmEw
	 CZMdRMbh0bnik7O6GeWK3hU2M2CxWWPB1CCFr1Y7PzIYDMbxhClObUV7ewXa0wMWrzijG
	 Mged4kj8b1erh2DKL/BE18iBWCJS1/QYilH8S1UpdoJWjOKMzJQaRQzi/wm2zix2ihNy/
	 6ZIViU7+ryIDU93u49OREcsDxlUXG5JUC6yy/cHOeEJsF+Kpo2g/mc2BgRwUcGpHyiIHy
	 hZ9zC0xMJbLxJVOlU4S1+sK7r5VXVqznnDS5nJmnF0YF/aM6SVsRy74BZ+qCEaqr9Mg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793800722;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JjM/kvU/Kv0Rdhq5AjgFZUCMPeWWTPzyVcIKg0u4/XE=;
	b=Dpl6dXR2N9oG9RyH/1R97BTm01BGf7vCXbM7aUUMTN1Arz3Ee5CzSXT1AZHCVB5W9roX
	 gvyyuSJ9ltkd1wazvyLtWLbS0ZThUO/HD4oDwDHxIuEFLco1oIMSDZ27ugegcV5RwoQQO
	 XLC2xLmCXIMQivCuaL/t+YTadsrVsPMPshyPXirBhg2aV1STBU3YoGapnbAYMIo+ZhWaR
	 /TuOL/gkH1sNXyNN6Spi8nX+54/LPdj6m7+B/OWcksyh8G3eQ4J34WBYroiYuvfeGi+8Y
	 pw7UBmdqRsmX0cuWe5IMKddm19VfDDcbledd9/QAMJwdtMRVZRlv2YlPYlCazOIDM9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id AE2A21F00919;
	Wed,  4 Nov 2026 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800722;
	bh=JjM/kvU/Kv0Rdhq5AjgFZUCMPeWWTPzyVcIKg0u4/XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/ErdDHV26qhNVwLJR6E7k2aPqkvpLGQGyvYw++UCyR0/cKK/E8BJSUkAZLeJYcC0
	 Vz3orya83M9vLrxlj5LcDe5kHqZE+Lm5EZkoIqG/NjIEEWyOC9odbk3+Gz0N/0hshm
	 ow0Nz6dB+k8TuP7bGMF4ov3uo42Niub8jUqfsorxMkiQSE99gOvX3EJmdjdnm4ifkU
	 d3ZzYCJxQKnmXdfRwSRqi1iuDAJ1OIDoAhGCN0DQdr184KDvN/ExaLEBxOBgulTHIt
	 Q1eq8yg212eqEgq/MJlPAPAWbc466Vt4z86qB2PX4MlbKqlfTwCZqyZUQO1YZ3FW3F
	 ddOSIzgHbNIsg==
Date: Wed, 4 Nov 2026 14:58:34 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add Texas Instruments
 TLA2528
Message-ID: <20261104145834.00005914@kernel.org>
In-Reply-To: <20261104125726.1754980-2-maxime.chevallier@bootlin.com>
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
	<20261104125726.1754980-2-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 13:57:24 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

...

> +TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
> +M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
> +L:	linux-iio@vger.kernel.org

No need for a list entry since get_maintainer can find it
through the path.

> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
> +

-- 
Kind regards,
Joshua Crofts
