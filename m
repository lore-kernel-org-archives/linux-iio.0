Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74F175A8B;
	Fri, 21 Aug 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354185; cv=none; b=Rsu8kE3rHu/811faT2PyfT740nbAcH79iUC6rLIQibixMU6XLsNekhaX9wu4fvTEkVgAMs6ETUfNgBjyGWSy5sgSyDXkQoEFf8vCj2jaqF7iNJJZSbcgw1bgExmaLGfBdn3RkNMVkpAoXrNZi8iIgge5yjuDt60c8xkab2k2AhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354185; c=relaxed/simple;
	bh=sokeXwDaO0KOAUIScxz0FfwExFGJCcYga1t055o7pRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvQtQlquukmGpn+22Rg5F62d2u5qFr9AgR/eKeiQ70n0VZn//r0V4eqvzBysk5iyB162SAWDIynob4HyXoFi67R7gJPrpT7W1IT5ZH/6FmnSCte0sggFGwkqqW3yVRfIXeCi2hx4TrCavWi+umfFPAPAxTNMfQfeunEPslJ1KrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL7OvAN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL7OvAN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459001F000E9;
	Fri, 21 Aug 2026 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787354183;
	bh=YmS3UunE+jU6MnNsCkySLw53zXUjpQw/+3hi1h+l+Po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SL7OvAN9c7U4bM4OleZMIzpS4DwHNk7GCGvS5U30PqFRv6ijkaNIbBqSuNu0Dar1T
	 v9FnrofaMoB4zB3Ij2brDog/j+coYttbXTCtjOwHTcT62ERPMYV2GR3MUcOePq2xam
	 mR1avt1lKyWzRVlvtIqLj9tncSJ+1P6JxBNiZBdtEj/eKX8TIPtTP1GtC2dzSHiPpt
	 gSkk95TOZn6FLALrhK3n6PEOSe2MGIWEOJWFr+glDB+Mqxl+1g7EG4uBOnsU4NoIv8
	 dMLUO8eq5RL6X+1dCj22AzoSTfGiaqZG9Mt/DYZr7/7NNoHAj9x53Ob1UwoL/PgGT7
	 Hkm2l3yZZHVaA==
Date: Sat, 22 Aug 2026 00:16:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Vladislav Leonov" <vlad@zlab.su>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Heiko Stuebner"
 <heiko@sntech.de>, "Andy Shevchenko" <andy@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Rob Herring" <robh@kernel.org>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106
 compatible
Message-ID: <20260822001617.0f94109f@jic23-huawei>
In-Reply-To: <9425cd59-7b78-7e0e-5d7f-aaff876ce8d6@zlab.su>
References: <20260816113636.33635-1-vlad@zlab.su>
	<20260821-bouncy-sticky-dalmatian-4f72c2@quoll>
	<9425cd59-7b78-7e0e-5d7f-aaff876ce8d6@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 12:30:00 +0300
"Vladislav Leonov" <vlad@zlab.su> wrote:

> On Friday, August 21, 2026 10:27 MSK, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On Sun, Aug 16, 2026 at 02:36:36PM +0300, Vladislav Leonov wrote:  
> > > rockchip,rv1106-saradc was folded into the fallback enum together
> > > with rockchip,rk3576-saradc, falling back to rockchip,rk3588-saradc.
> > > The two IP blocks are not equivalent, though: per the RV1106 TRM v0.3,
> > > chapter 20 (SAR-ADC), RV1106 only has 2 channels at 10-bit resolution,
> > > versus 8 channels at 12-bit on RK3588. Documenting it as falling back
> > > to rk3588-saradc allows device trees that would bind against the wrong
> > > channel table and report an incorrect voltage scale.
> > > 
> > > Remove rockchip,rv1106-saradc from the RK3588 fallback enum and give
> > > it its own standalone compatible entry, matching the dedicated match
> > > table entry added by the driver patch.
> > > 
> > > Fixes: bdba14f6122c ("dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible")
> > > Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su
> > > Signed-off-by: Vladislav Leonov <vlad@zlab.su>
> > > ---
> > >  .../devicetree/bindings/iio/adc/rockchip-saradc.yaml         | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > > index f0551d665916..dc56855527b8 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> > > @@ -22,9 +22,7 @@ properties:
> > >        - const: rockchip,rk3562-saradc
> > >        - const: rockchip,rk3588-saradc
> > >        - items:
> > > -          - enum:
> > > -              - rockchip,rk3576-saradc
> > > -              - rockchip,rv1106-saradc
> > > +          - const: rockchip,rk3576-saradc
> > >            - const: rockchip,rk3588-saradc
> > >        - items:
> > >            - enum:
> > > @@ -35,6 +33,7 @@ properties:
> > >                - rockchip,rv1108-saradc
> > >                - rockchip,rv1126-saradc
> > >            - const: rockchip,rk3399-saradc
> > > +      - const: rockchip,rv1106-saradc  
> > 
> > So this goes to an enum with all the other single-entries.
> > 
> > Anyway, where is a driver binding to above compatible (see DT submitting
> > patches). git grep on a week old next gave me nothing.
> > 
> > Best regards,
> > Krzysztof
> >   
> 
> Hi Krzysztof,
> 
> I will combine it into a single enum in v2.
> 
> The driver patch adding this compatible has been sent but is not merged yet:
> Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su
> 

Please combine the 2 patches into a small series as a v2. 

We aren't in a hurry at this point in the cycle and will make it easier
for everyone to see what is going on.

Thanks

Jonathan
