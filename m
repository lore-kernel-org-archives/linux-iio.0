Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987378;
	b=agO0V44EJ/spB0j1piMCiw2tJ8H88GN+jzEg6JSSIb79ntA/hJCsUvFCEVyOvKUcECns
	 pRqbc4w3AvsxEIraOyXn4V6NYbuh52wSXRZLOl4WkAVJCvgCreY6W1/IALV4jAsG7YNOc
	 xOfQXZXNYOiHBgTN/us+1cQksJbNfceHyVOosXuqdBrAiTcNwEaUbqJp1PpR5jG6XY1vr
	 QJQL2tLkqRz+gZDaMRi4HZjMI5xIv/kT3WAxWeHuJUqWriwo+E2C+tpcvLWO3FL44exOx
	 Xzlq79fX3TUkOMUrjqBqNxBzfu78H6tZZlZTBZzpelI+nZ+U/GnnQ6+4e+gGrD46yzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987378;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tlHhRAfzkWbwkJr+SuFjHMNnba6hLyqJvRyg5XvaArs=;
	b=cpTv3buxZXrpwMHaavTtPr1koROxpnfUt1x1lwHPtGxTXha+ZW0jivOLJxQ0Jwoo1HUn
	 DI90InxfbclTe9SPd/rr8/nB5jnXdifCPk2vOM3vO7oawU4jkoyeJkf31AmuT3Lbt5lhH
	 Gn9Xj6BPHEto3Ac3IoKpWFrDnPPnp5AaGNjVhiz+R3ZnQff+gXlfBoyRt5jXXkwUVzE5u
	 etRuU3/1UiBs1wl7Qk8GAREN0evY1LeojkqhD2Z3ENcFQetMA8OxtdxrK77DK+detPWEx
	 I2F8Q0d7QXqFa9COHeAqHGbMsZ3jR5IoPOe9Fw/kDBe1GucEwH9QicTqDArbbef7CKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3p+Yyw4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938ED606A31C;
	Wed, 18 Nov 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3p+Yyw4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794987378;
	b=WV3i1Kb9lfRSesp3ScJsW7d/Qjt+jl1MnZRbgJBe1teNdfEhGubmbFMmrKxSahK+Bu7M
	 gy8s6Iwahh/tcmiI6SI/8O350mljyo2/1JGtfk/U2ilnH/vcRBt4SK90WSP0D+cLcnEhF
	 dom6bJgEXBsRx4b5KOIzMYCL6i+hByHL1jOEpp7YVlmY14tbQBoEYvPFzfQaJWhRJcpqk
	 Cu11JFwXMl4cxEYtKnm5OXZu4iSRluPM+pJWAjat8NSkBZO60yQZD2uzqpr8BHVZN5wDB
	 Pe9vkqMmbPQv/BQ9OOQMgO1NdeBHg3ZmHYzwZfy2vnDaFGvfy985sE1+fxwmUvfA4Ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794987378;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tlHhRAfzkWbwkJr+SuFjHMNnba6hLyqJvRyg5XvaArs=;
	b=ymx4wS/Jb2Dbu81D8beWlsC7y4feDWQ8WebPfRpR44wjnKNeesYyopF0NJLtCMX5L0QF
	 WKTmchl2F+jU/Bg2dB3epFpfJuzCqMRMsSriu5iOMNQAK26srFuc9gALxTDJTCdIfyUCM
	 8u/YfP4K63YtIi0wJ1FENWoirVV0S+/G2I4UX43WZ+fB8OsyI3tb0fXeRrNPdUQYfD+fU
	 NvJF0hSSzQ5aux4dJN1PImzfgSZYIu2WAiVPiDb4qVIi9jFha7ufn/UdCkyQNaerGdpM1
	 zyPiMpx9y5zC1ZeKymYrP9dXbJlcx/rqae1qyVLz1JxMP6uBOobTBrfD/orjADxT5Pw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id D37151F000C5;
	Wed, 18 Nov 2026 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794987378;
	bh=tlHhRAfzkWbwkJr+SuFjHMNnba6hLyqJvRyg5XvaArs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g3p+Yyw4BO4hgQnDf/Iqdi9hznw9UcvRq6jIRxry5dgUXhfEyHuI3NAmghbECsbv6
	 AGCjvZx2jlTr84mzJibGW0PsVA1MM6xSdjUuoufa7EbsXY+9vaYh3c9i58on4P5hZJ
	 pLbawHy2vAB/Gio28knyDSQwEahDpR9EihRgGq3KVt5XWmXMKMMnnJkwVuOrOELe+r
	 k0Ua+dim1gv6/9uaLgSqFXhF03Rfkdd0xMWWp6Xc0YOZTtvOuUSbq61u/iejCP6L3q
	 mA/XG01UrsCCy27Peavtez5bhH0+73Cmwe+uphWVib0xRlaGVirAAYYUo6s1pTlBgG
	 Gq2uLgMoLEa2w==
Date: Wed, 18 Nov 2026 08:36:06 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Daniel Campello
 <campello@chromium.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Semtech SX9xxx: add a reviewer entry and binding
 maintainer
Message-ID: <20261118083606.00005f7e@kernel.org>
In-Reply-To: <avyoLGkkCkxu11TA@ashevche-desk.local>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
	<avyoLGkkCkxu11TA@ashevche-desk.local>
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

On Tue, 17 Nov 2026 21:17:00 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 17, 2026 at 10:56:07PM +0530, Arnav Kapoor wrote:
> > Add a MAINTAINERS reviewer entry for the Semtech SX9310, SX9324, SX9360
> > and SX9500 proximity drivers, and add myself to the maintainers of their
> > DT bindings.
> > 
> > Jonathan agreed to a reviewer-only entry here:
> > https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
> > 
> > Changes in v3:
> > - Patch 2: replace the Link: tag and the reference to it with a
> >   Suggested-by: tag (Andy)
> > - Patch 2: drop the L: line, the IIO subsystem entry already provides
> >   linux-iio for these files (Andy)  
> 
> > - Patch 2: drop the DT binding F: lines, patch 1 already lists me in
> >   the maintainers: field of the bindings (Andy)  
> 
> I was expressing my opinion, it was not an AR, it was rather the start for
> the discussion. I'm not DT maintainer, I don't know what the rules for the
> maintainer records there, OTOH I don't know if DT parts belong to the
> MAINTAINERS records that have only R: lines (and no M:).

Not sure if R: makes a difference, nevertheless better to have the
dt-binding files under the MAINTAINERS entry as well (i.e. grep -b5a5 SX9*
MAINTAINERS if I'm looking for a specific sx9xxx binding file).

-- 
Kind regards,
Joshua Crofts
