Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF2265621
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787020904; cv=none; b=lYjLVBqPe3+5x2R6HvUQs9zZ6haCVSshObS00JONlBUeO2L5+vc3+pLJnZDwoV2lnt1H1ZfOJ82+jCysjzih6ghYiuJ2JYWe3hf2e0C/nmPcqbUdnlIfck9o0KnLKBkDUHo7qIwqPs6glVoltBY4hAqAp8CVS9FUHTouiJjKTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787020904; c=relaxed/simple;
	bh=8KtP6MZfh9BmV9Z/8G6CkfAYK/HYS45s+4jpp9LCIE4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEvpjJBCF63Rag6IkV6sA91iEtuZL5DmndxpEdXEXgAn56L06K0SMn0PoJ2a6HLMcsXgzmRpaH0ToghuHCG/lj6yhM+FEsnT4cLrPznQ4Ek5JD558HILgbsGKBTqJ9Bznk1PDlmi1NIveRHKomelT9x0DVaJe+JF3X06ia1O+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=ulQOhmMK; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="ulQOhmMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail3; t=1787020890; x=1787280090;
	bh=egdhIi9I7tZ+Gjv3F8W3Ypj73jo4q/hsQiTQMJP6rCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ulQOhmMK4z2C2D+7Z1faDIVxAii0oUQuTsRW/IbWflcN+UOm3e+WLaqnZTS9IJ4Fr
	 aloFOmxmS0Jarv5S465FbAw8xjwn8flsnD3NeW20RUQO2UNLPbgYaFXMX7NssEqSm3
	 T2Rn6JiI5V5fnjF7EXv9ksiNlzHYci+DtDFCdt5TKSC1T1BqJkeReIc0azwf3LblFK
	 73Y9tDT5lRECjIkEcVAyqJ/8kBPy9iULixOKgyMuZqQLavpoVoqK1PvtHi9gjzWxon
	 95XUgnnZqd/fgYrsJfknVfqfxGEQammnldcnqrNAhGl4fcvaNyUmSPMLgdM+0WYBOS
	 qRWi+74VSMCnw==
Date: Tue, 18 Aug 2026 02:41:25 +0000
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
From: Matt Ranostay <matt@ranostay.sg>
Cc: Matt Ranostay <matt@ranostay.sg>, Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht, linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
Message-ID: <3h4b84qK2Ofz9bDH_p2vEOM9ijsJmb1xtbpzncN9dOr-LPia1cZq4ddhYzcc2nmDhC3ivZCzd21aIYeoNvWYpOdHefqPJIfQiOjsTkAy8-Q=@ranostay.sg>
In-Reply-To: <9f0a6334-f40c-4e19-928f-57b709bbcea9@gmail.com>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com> <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com> <20260812053450.2e14b074@jic23-huawei> <F_gQH7S7C_a2e4gmKfLMZwNzMQ2lvOoBcv-tqJsuNGsWYdJdV-KhzKRPTqo1JS4yGoBK6bn4lscAS3et1Uxm-obr7Tjw3hzePjHOllpSlc4=@ranostay.sg> <9f0a6334-f40c-4e19-928f-57b709bbcea9@gmail.com>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: 4531e669db158d64827297f58118bebf13691a09
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Tuesday, 18 August 2026 at 05:29, Rodrigo Gobbi <rodrigo.gobbi.7@gmail.c=
om> wrote:

> On 8/12/26 07:11, Matt Ranostay wrote:
>=20
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedl=
ight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/p=
ulsedlight,lidar-lite-v2.yaml
> >> > new file mode 100644
> >> > index 000000000000..e19c8d166b81
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,li=
dar-lite-v2.yaml
> >> > @@ -0,0 +1,64 @@
> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-=
lite-v2.yaml#
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > +
> >> > +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
> >> > +
> >> > +maintainers:
> >> > +  - Matt Ranostay <mranostay@gmail.com>
> >
> > I really don't use my gmail address anymore. Would be ideal if it was c=
hanged matt@ranostay.sg
> > Other than that don't have any issues.
> >
> > Thanks,
> >
> > Matt
>=20
> Thanks Matt, I will send a v6 fixing the e-mail. Since you're fine with i=
t, would you
> mind sending a formal Reviewed-by/Acked-by?

Sure. Provide email change then LGTM.

Acked-by: Matt Ranostay <matt@ranostay.sg>

>=20
> >
> >
> >> I'll need an Ack or Reviewed-by from Matt for this. If Matt either doe=
sn't
> >> reply for a while, or isn't happy to take on this much fuller binding,
> >> is it something you'd consider putting yourself down for?
> >>
> >> Otherwise LGTM
> >>
> >> Thanks,
> >>
> >> Jonathan
>=20
> I'm happy to be added as a second maintainer for this binding,
> (I can add myself at v6) but I'd rather defer to Matt as the
> primary one for now.
> Thanks!
> Rodrigo.
>=20


