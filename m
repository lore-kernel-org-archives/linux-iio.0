Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600397;
	b=P/djltYTGsOPbtbmTaFIYKTqTfahCMu43eA3cYUg+g/sCi+r4GJXyDLxVDcwf/fso2+O
	 5KC7FweBXu8nhyL85JQm8jj8ONF/UEzQgvlskcL9zCTzOAFtxfr7OiSqS3l5K+wBew+Li
	 wmOVWZ+sLi12euMVmXdrYmwkVQaxicWaPJx5WccOBjBXi7j7h87FYdR3kquZKxTrzyIt8
	 z4nzh2zSp5nsRwVu5/KpS4JCElrvvSJZay8PRt61/Go3glv6Mtu349+Iqgcv83lXAAGvR
	 L5/XsuIE5byAHU+iJJ9n0qLO5HFiMZVzEh5Cxce5FV0vAU9ElFXXJw2FhvVzdWUSzdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600397;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=Oh4mgN4ZVfiXY+EWoWQm2pIFCmjwWGZlx97DLoJkTVk=;
	b=4kcZ7k8l5MK8CtMxwzt//9GflNkcwbYU9DNhsid3O9OhcOjSijKkDEGj8v8nn+6HZo6j
	 x/qT49fjaoaoI/be0vhTmxO5h702Q1RdmG3X6qjz1akSyhOzz2DxowQoyvunmGrXVE852
	 uIAwvaUUBljH5PRhaMOX8cq8iJ4QIIe6yjc3HM00o3DoazNEKPPGM3oHxPa7KXOhMbjYU
	 zL3I2LuWGY50OzRp5SBsbIfsYb0EO5LGBk8gmA9NeAbj5+wbw4tpOMStxN1dYeniwjebS
	 plfTiqUb2gJwCCB5KTGCzNA7gu4J/EXjGNaAxS9dgUf1wEIpxMAssa208cZs/AaeFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=nWX9jZlM;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA97606A332;
	Fri, 13 Nov 2026 20:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA97606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=nWX9jZlM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1794600387;
	bh=Oh4mgN4ZVfiXY+EWoWQm2pIFCmjwWGZlx97DLoJkTVk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=nWX9jZlM249VKOxp/2Yk88uizUaHJk2vy69lbMtCDt6I20XIi6VSqjtTX+mFdxBoP
	 6567rKBhEgktBpkF0VHz7sKxEm39CjszwP0BNnC/f3a2RKSgW3J2UqGo+zh23Ut6Mv
	 vOhe5SZQNydRBQ9MFBOlDhk5rQr6MQX3zwqezs/NXqxcAjwMQB7Rz++6esN4yn6e7e
	 0S30Mbs1B5eSNDfgA/RhPLgyPNlKh7aLzermQ411dgMJV+X8//rSch2egFKrJtwh1U
	 MPvxJ5XSwGnRoSmMtGD2NRX11qXIIrcccQRsDDKHbFRi8lK0lyVUh7GbRP3v/BqNCz
	 z/XJ/hQaVV6Nw==
X-KAS-Sym: v3:f51bdf72230551df:H+CSNaG9hrISRZOYFI15PAF2iD5BgztdFFoV5QIXh+trM
	47WHYi7lRDAxyylbxnGi3gOB9VFB9RMT/wklL3OeHs0HRKaAtO9d8AdadVAKDuUjh3Db6z5WMby
	DOKGtD71OiCU40I2n7ZIWGL8kNoN1yczmAcYCcy7bI1t9eiIVkp7CIEfTt+CX4ZYzRDQLJra5YC
	F/6pjvQk3pkBAqonoWCI+W/fNN/xHAH/QJqMBsSgbrhOol7eG+HRW7UyyJFZpOsqZAtkf69ECFi
	YFUXOnhDiJiY9MH65WtxxqcP0iN8VBdjGij+1Dn+ghgU7f0E2d63UqpgU1gRtVQQvkzpgK1Q==:
	KYBALMuc7sJ7qME51eRps+Lm6RpZIpX0KQkMlFFVlgwTmsMallL18aT7SY86fgQMSYWXsxSw+y4
	KD/IajDCcITWsevHMEMsVSC4Yn+lUDMVfTPGt3lGHSbF8nX6vn51P8YdZW6OEXK3GpfOlc4obpe
	36RyhKtdpAVk2KByg6Mkb0QwfpN7+5TYDKlupfY5n4hBSXbY4hh6YGGpdlRMhphsxMw24zY4Oc4
	hvgSGPEP+cU/pFmzcCoUGZewdCEMogicLg7LSwHGpgrFPc9VrYCBEs8cO5FWxVO3DUFfaiRAWb8
	QtBVBg8gIzBxvNODRLiKq9yFdK4H2rGsf4+a50czSp7G/uk5KuqGO6bfK91CkNH27xjqz05n5aX
	2xARvZK28FFSj5OAeMbKp7ncffFfTHSiWafgERsK9uQsncSMr8bJhiiBTEZ12KdH7rr0KOTXrz8
	ScinQ4QkJaLndx767q+HqfL2SwYheJCPmz6t7quHgTat5crNsShVKauDU3euL9QODQ63mYZQIf9
	b6nXcxmjlVvLUaEE4/DLRd4Lgxs+54h82KSJ4XZdw4Izw2j2VQDk1YKYHIa5CX7PSe5TxSYldy4
	0nskYXUDLSiKLh0C5ivZTWjTCjNZfcHwtBZ7U2CqZnBjPSJzNr92cjcNuFMokn4Q1A==
Received: from [192.168.2.174] (dslb-188-098-198-255.188.098.pools.vodafone-ip.de [188.98.198.255])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 12CF178279BD;
	Fri, 13 Nov 2026 21:06:22 +0100 (CET)
Message-ID: <182203d9-3026-4078-a9e4-71ef597e5727@tsv-stahl-riesa.de>
Date: Fri, 13 Nov 2026 21:06:21 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
 <20261106-upstream-iio-cm3217-v2-2-d97adde9171c@tsv-stahl-riesa.de>
 <avJJsIJvUVpfZXnb@ashevche-desk.local>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <avJJsIJvUVpfZXnb@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

On Tue, Nov 10, 2026 at 12:31:12AM +0200, Andy Shevchenko wrote:
> > +#define CM3217_NLUX_MS		(15ULL * NANO)
>
> Hmm... Can we use rather formula inside the definition? Also one of the
> multipliers from time.h might make sense here as MS are mentioned.
>
> 18.75 per 800 µs, or 1875 per 8 µs if I'm not mistaken. Hence
>
> 	(1875 * 8 * NSEC_PER_MSEC)

The resolution is 0.01875 lux per count at 800 ms, and the constant is
that resolution times the 800 ms, in nanolux * ms. NSEC_PER_MSEC gives
the right number, but there is no time conversion in it, so in v3 I
wrote it as the formula instead:

	#define CM3217_NLUX_MS	(18750000ULL * 800)	/* 0.01875 lux * 800 ms */

> These NANO again are misleading.

v3 has a small helper, CM3217_NLUX_TO_VAL(), so NANO only shows up where
the nanolux value is split into the integer and nano parts of
IIO_VAL_INT_PLUS_NANO.

> Have you checked with `pahole`?

Yes: 40 bytes on 32-bit ARM, with a 2-byte hole after cmd2. As ktime_t
needs 8-byte alignment, none of the orders I tried is smaller, on ARM or
on 64-bit, so I kept the fields next to the lock that protects them.

The other points (static_assert() on one line, the margin added to
conv_ms, FIELD_MODIFY(), dev_err_probe() inside scoped_guard()) are done
in v3. The scale and integration time tables come out identical to v2.

v3:
https://lore.kernel.org/r/20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de

Thanks for the review,
Patrick
