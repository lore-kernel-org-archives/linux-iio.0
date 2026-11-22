Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371329;
	b=ZyUwiB4JXoQb65AO6KY2pGavv9JeJQ4OMFmNJ6yXFyO2klK7LIcppWokeTBwsOhSExTz
	 pAPdF1s8IHLcPqx0ea2wykTjlWWmDwhXIp133j46gFex/GBrKXlL3wdP4wHX+g0W1acfX
	 sj6dYN74jOxV4b9DZ98JZV4JWPomVdBRb/NM+HjyjN4s69VrqSKvrowGsDnwGQs+3uX8+
	 8yKxJVkj7FBc8ub8hjgQ3okUtTmQxp9cCo7gCOONjTiFXxUWnNdoBOU5EhIqC+3MoZHex
	 Z+p7m7DZ2fKODza40VjGSUxSBFKBJxCLGrunlhnB3zU8Wy71IPSCY1BL0HYfS1MhzEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7imwDZep1dEobON0aQ81I9AKr9UQW/+yihI1vaQHUcc=;
	b=aDEkSmQFAMB3p3CdMcXZHLqsrWzRsmepntzHcLHu0kTmvao7sIZLsRjaao6+4mQLXsLl
	 yXRhgoA1lf5KJy5tsX8Cp+Ngk0gMizcjFIzlaxDoNMHWx1WQM8DT7KBaxutYyv3WNpWTk
	 MeDzLCk5oqFwxGbHIuCwhk3WsjWy9JSfpN4V8GTgw+T7CeJqK28kT3HIh30cKoZ9xtRR2
	 FFGaRHNfTdw4bwhGSYucEjS5hWGttnr76LC7hbGbz+zsWyHNRjucHUYgzuDxKDCPpgsWH
	 YuWDfagjJe71eb4MnKzNuGosH2MhlUzZZrZV0Qr4FrZNLbVlO7xkvRy2dC/uxQL69tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTGaeXjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F39606A32A;
	Sun, 22 Nov 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTGaeXjk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62511F000CA;
	Sun, 22 Nov 2026 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371328;
	bh=7imwDZep1dEobON0aQ81I9AKr9UQW/+yihI1vaQHUcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MTGaeXjkB4AktJqB/0JgjiPmflQEHvTUcsVtsMHT7AjGLXcf0JJrdH5W8Ci4pSBTy
	 zH5TeUpxvE5LKEsN5uozV4m32lryVAjjP5C8loPqVBt8QQHr07IN6jmp9wUyU8YZak
	 b3mgQs3bTdrB3wKEpgAhds7gcJN8bKuVj5ptUJYmAISVKB5LP3NkQ5PYA4oyvAX3E3
	 X3mHdEzW8P9Gyx9Hi67wTRtbSuMnrW/ttX4mESdb5cBzLKSQPqUcwexcatpFPv1xDg
	 VhmU+Q0a29VwqNBUjrbShL9zISpZAuJ3eU0Btq39BhnZLMMelmp137o+zkF9B1nLWE
	 ipuspYw80iyyg==
Date: Sun, 22 Nov 2026 18:15:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Adil =?UTF-8?B?SMO8c3Jldg==?= Tepe <tadilhusrev@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Message-ID: <20261122181517.49972bd2@jic23-hlaptop>
In-Reply-To: <20261122075245.2916935-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-2-tadilhusrev@gmail.com>
	<20261121-arrogant-viridian-swift-fb8001@quoll>
	<20261122075245.2916935-1-tadilhusrev@gmail.com>
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

On Sun, 22 Nov 2026 10:52:45 +0300
Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com> wrote:

> On Sat, Nov 21, 2026 at 01:23:42PM +0100, Krzysztof Kozlowski wrote:
> > Do not attach (thread) your patchsets to some other threads (unrelated
> > or older versions). This buries them deep in the mailbox and might
> > interfere with applying entire sets. =20
>=20
> Understood, sorry. v4 will be sent with b4 as a new thread, not as a
> reply to v1.
>=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>=
 =20
>=20
> Thank you. One thing up front: Jonathan's review of the driver makes
> the vdd supply required, so in v4 vdd-supply moves into "required"
> here. Since that changes the binding, I'll leave your tag off this
> patch and say why below the ---, unless you're happy for me to keep it.

Whilst I agree it should be required in the binding make sure you fully
understand what the difference between the optional and normal
requests for regulators are.  It is not about whether they are in
the dt-binding or not!  Code can work without it being their using
either of those interfaces.

Jonathan

>=20
> Thanks,
> Adil

