Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BD36729C;
	Fri, 21 Aug 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304614; cv=none; b=DSInWbVzHygr+i6gIUEwWLDpS1n+1KZ6rwDOAqDxAAg/cV1NS2ZIHZkCDLqB4ab/A2R4KEAEi+3i3X1oW001M7RIDCH3COiop6jfOq102yTBoPNmsSBFkRAbUczalweTfziEdVTcCNhfWGbsbee60SE7OB54Tp48eBrD9wfr0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304614; c=relaxed/simple;
	bh=2BlwCIRPj878eYNyHhUDHzHUc9xUQe10Kfy/KIZKvHQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=pgE2RagrNn6ODboqVWbIpJSdJoXQHX9fo5djz9WobtxudoO62aYO2mKr4T8LpVxjD1KSnFJX99ljCCDMAR9RJZtG1wao6SysufQq83PuWACsQIidQDFa1aVrpon+DV79leIG/tmEpdJOksjy/7Yb9APGLBkpKi5let5T6a5Dg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=m/RN7abP; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="m/RN7abP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 466D7C03D9;
	Fri, 21 Aug 2026 12:30:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1787304604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+UDivxkzUWm8jCVEzWimvw5QQQKBgJN2rUad2RA1A+g=;
	b=m/RN7abP1i3juYX1BEYCFHZNhP77sGhYzJVe8mgEF64OgNjrVjZ0IqEvVloMx/3LYZqf33
	W4K8qbuJDw/so2cdCrFwUZLx7HHFFbsD3ZimrzGHNn+qOpX4EcOTWijB6xp2vIbYA810dg
	OSu7DAgJOpLaDBZKzIm+xZDDaYreq+ztL7PEP9/3kkOJTYUp3U+l7uwgQfZqUnP34TcnoP
	ejXETsBjhFWPaYLidqzETMu4IIvEgzWj6DcvFspAPNBJ5wQpLvwqDav9tfjns/xp6rYLeu
	4ai+Mu+s0S9ctAK0wc7tVE00o5NyRPGPc3Rli3PIj0BX8PJrc+XXrOgCnLYCRQ==
From: "Vladislav Leonov" <vlad@zlab.su>
In-Reply-To: <20260821-bouncy-sticky-dalmatian-4f72c2@quoll>
Content-Type: text/plain; charset="utf-8"
References: <20260816113636.33635-1-vlad@zlab.su> <20260821-bouncy-sticky-dalmatian-4f72c2@quoll>
Date: Fri, 21 Aug 2026 12:30:00 +0300
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Andy Shevchenko" <andy@kernel.org>, "David Lechner" <dlechner@baylibre.com>, "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Rob Herring" <robh@kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?q?=D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D1=81=D0=BB=D0=B0=D0=B2_=D0=9B=D0=B5=D0=BE=D0=BD=D0=BE=D0=B2?= <vlad@zlab.su>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9425cd59-7b78-7e0e-5d7f-aaff876ce8d6@zlab.su>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?dt-bindings=3A?==?utf-8?q?_iio=3A?=
 =?utf-8?q?_adc=3A?==?utf-8?q?_rockchip-saradc=3A?= Fix RV1106 compatible
User-Agent: SOGoMail 5.12.8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Friday, August 21, 2026 10:27 MSK, Krzysztof Kozlowski <krzk@kernel.=
org> wrote:

> On Sun, Aug 16, 2026 at 02:36:36PM +0300, Vladislav Leonov wrote:
> > rockchip,rv1106-saradc was folded into the fallback enum together
> > with rockchip,rk3576-saradc, falling back to rockchip,rk3588-saradc=
.
> > The two IP blocks are not equivalent, though: per the RV1106 TRM v0=
.3,
> > chapter 20 (SAR-ADC), RV1106 only has 2 channels at 10-bit resoluti=
on,
> > versus 8 channels at 12-bit on RK3588. Documenting it as falling ba=
ck
> > to rk3588-saradc allows device trees that would bind against the wr=
ong
> > channel table and report an incorrect voltage scale.
> >=20
> > Remove rockchip,rv1106-saradc from the RK3588 fallback enum and giv=
e
> > it its own standalone compatible entry, matching the dedicated matc=
h
> > table entry added by the driver patch.
> >=20
> > Fixes: bdba14f6122c ("dt-bindings: iio: adc: rockchip-saradc: Add R=
V1106 compatible")
> > Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab=
.su
> > Signed-off-by: Vladislav Leonov <vlad@zlab.su>
> > ---
> >  .../devicetree/bindings/iio/adc/rockchip-saradc.yaml         | 5 +=
+---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-sar=
adc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.ya=
ml
> > index f0551d665916..dc56855527b8 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yam=
l
> > +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yam=
l
> > @@ -22,9 +22,7 @@ properties:
> >        - const: rockchip,rk3562-saradc
> >        - const: rockchip,rk3588-saradc
> >        - items:
> > -          - enum:
> > -              - rockchip,rk3576-saradc
> > -              - rockchip,rv1106-saradc
> > +          - const: rockchip,rk3576-saradc
> >            - const: rockchip,rk3588-saradc
> >        - items:
> >            - enum:
> > @@ -35,6 +33,7 @@ properties:
> >                - rockchip,rv1108-saradc
> >                - rockchip,rv1126-saradc
> >            - const: rockchip,rk3399-saradc
> > +      - const: rockchip,rv1106-saradc
>=20
> So this goes to an enum with all the other single-entries.
>=20
> Anyway, where is a driver binding to above compatible (see DT submitt=
ing
> patches). git grep on a week old next gave me nothing.
>=20
> Best regards,
> Krzysztof
>=20

Hi Krzysztof,

I will combine it into a single enum in v2.

The driver patch adding this compatible has been sent but is not merged=
 yet:
Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su

--=20
Regards,
Vladislav

