Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118833;
	b=WFhaQ3brZ59kLfYtu4pMQfF/1JXUlctT+gsQSGno0x3M3tQZFPMVMEHiAiRDAur7Cki7
	 1kW9ea3YuFDoexPmixxmTzgb3QD/dg8izBUst/MIVJyP1JsMnMICC9qOdhSp1PaXCrmSu
	 bXD9WJj4oXgpjRhPia1brXLu9ZW1H6wIn8PttjLrTasKcNyKI41gUpNm/cto9h/LHdJaL
	 MroxSlSq8Pu3adWlxybkhc/H0qxAvsRY8jUtRf9Ztc7Cz3KXNoJPigtUoLDrcUvQXzAsA
	 e+Q4RSTgnFL+r/1F08V1KM0aIOppb2Py2dT5OiPNswDZlMrHK64MKJW9Zs0xHH1uLig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118833;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=d+NMMeRc5VymOpLC4VvRBvdVqtzY/qDnezwtonjIhNw=;
	b=DnNrd6yqqxP29X+80p4nuwvBLLQXOYodAITyh0bkdzO6DoZpRL8EcKq2HUPMMvKsQ4je
	 JHNXc8jsqdRa9D54UViUUQh9bqYKr5BGvKVl91nrAPVOahjjAi73MdG0+2WFdexBK18vC
	 iow5AfYmQTTIPf2rLzDVKQT41RkajvbmA3Y8xxdMbmWIp7EjMWqj6MJ2zZ1m0WJTUm+oN
	 xk1/gBS5nD/Fczb9aJOhzFDxBEAk93Ano98G1/Gn/cSVAN6iAycjnNa5f8HfWnCpSC0mM
	 oI3hngmVQREsFqdlwAR1xgLj0FWhaFF5Mt56Ump+1ZribilUza5ba1I4KOY2oUgXIVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Gyuglxij;
	arc=none smtp.remote-ip=95.215.58.154
Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F59606A320
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 20:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Gyuglxij
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A0NjPQlB3Q4vVg+2rsx+25MqNBWdek7Wdl5lBh8qzpg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795118829; v=1; x=1795723629;
 b=GyuglxijOgbutJFF9AIVaWNPHDOrgcxjr/W7sxlydCIkRHb8KfQjcNDSnaMZ+HST+8DDzh6e
 ZHuEM3/OrjIXgkZgDLrjg+CXil4I+pcsRvca1Ucb493n/6DuTK1mpr8eD2T7zmQ+9vWVODmJyxV
 Lc6w+x2OLN/PXBdFZJDn044s=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a57961858fafb747;
	Thu, 19 Nov 2026 20:07:09 +0000
X-Mizu-Trace-ID: a57961858fafb747
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 20:07:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <bf25bbccedc468157202546d01734f38e201eaa4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 1/1] iio: dac: ad5766: Convert GENMASK() to use static
 parameters
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, "=?utf-8?B?TnVubyBTw6E=?="
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>
In-Reply-To: <av9RtQDXoR7phgga@ashevche-desk.local>
References: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
 <1a261f19fff18b074ed3e004c4896f2cf586b611.camel@linux.dev>
 <av9RtQDXoR7phgga@ashevche-desk.local>

November 20, 2026 at 1:44 AM, "Andy Shevchenko" <andriy.shevchenko@linux.=
intel.com> wrote:

>
...
> >  -#define AD5766_DITHER_SCALE_MASK(x) AD5766_DITHER_SOURCE_MASK(x)
> >  +#define AD5766_DITHER_SCALE_MASK(ch) (GENMASK(1, 0) << ((ch) * 2))
> >  This could have remained unchanged?
> >=20
>=20Yes i could, but does it really show the tightness between two semant=
ically?
> I believe it's not, that's why I explicitly put the numbers instead of
> indirection.
Thats fair.

Reviewed-by: Siratul Islam <siratul.islam@linux.dev>

Best regards,
Sirat
