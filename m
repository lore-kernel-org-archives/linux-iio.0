Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998643901B;
	Tue,  9 Jun 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026159; cv=none; b=ZtWnXwiJuI6yxVKRVvnQxiX9Tl6AO1B/bqHA8mJcM3EO7+6J/gcdhUBJc0/YlCYLoRLExU/bNknN5rcdoNVbgvIJkKZK7jts9I1VqZcouYih317vK5MG7qN8OlBMKGU00+zpEUNhTgvGzPmzTGcuAahjQV5JYuGzwltRJzBZ1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026159; c=relaxed/simple;
	bh=QE3ecFfaSF4OJ9BLijJjzxt3jB1C2H2jr1CRSJhdv4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwKtnUJSMDi2I7twhIsO0xqbsaIJNXQvZJfL/8xLzWQ1QpIaeQcE2NLLwI+5b0LL4h2qacCGuqZ/yvW1c1uqCDT13b5rrKy0jEA0PpX89HFD1RWC3vKpTlZpViNXCzd0JzP7fpOj/0+JQi9Jp3gh/kCSjowXnucZ6sSdNrNPWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Vsp6POkA; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Vsp6POkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1781026149; x=1781285349;
	bh=6HeJhykeaboror19DirkCIOC1KIj82iSEPO/tVXnN4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vsp6POkAFvnGYUs9mPK7J8IN2X1dGZ+TiJ6toaYcPzikihEyLRjYZRB2npVe5jrNb
	 x7JMSdNeU1ihpcVlbsjhShf8yUqpSk0XDM0Em675OHKDQRuLud+A2RrdebiUOU3oDR
	 2YJcogfXv/RYl+PF21VFUuxsvePjE75qdJP45p4eTWiOMDPrX+Az+hSk0Tw5wmBpUT
	 rCzYfqi8KNTJ3yc8H9+/0DESKgQ0OiRcKhqutnccPubRwQHtXf0fxi5mtuB9+vfx7B
	 4j8VI32/gu2zIt91spG231hw2l00MwN0JNbADUJonjj6l0D3fVOiZ8FhaHzKLPxpTN
	 YRt0QOimZbN8w==
Date: Tue, 09 Jun 2026 17:29:04 +0000
To: Conor Dooley <conor@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6323 PMIC AUXADC
Message-ID: <8EwSIpbwPPOLZFrXcuriM4NGFc2O1ozFGphpfStH2hTxkSR1EWLBTNIefDK997sRukvAp2bUSkuyVYiG-N9MXIGxtokvPYWwOjtuQXLdmMQ=@protonmail.com>
In-Reply-To: <20260609-gangway-frayed-366f6d3cc867@spud>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com> <20260609-mt6323-adc-v2-1-aa93a22309f9@protonmail.com> <20260609-gangway-frayed-366f6d3cc867@spud>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 5aa3f45d931aba5644ec07b8e6c4ba287df96531
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tuesday, June 9th, 2026 at 7:01 PM, Conor Dooley <conor@kernel.org> wrot=
e:
> On Tue, Jun 09, 2026 at 04:31:58PM +0300, Roman Vivchar via B4 Relay wrot=
e:
> >  properties:
> >    compatible:
> >      enum:
> > +      - mediatek,mt6323-auxadc
>=20
> Commit message needs to explain why a fallback is not suitable.
> pw-bot: changes-requested

Ack.

>=20
> >        - mediatek,mt6357-auxadc
> >        - mediatek,mt6358-auxadc
> >        - mediatek,mt6359-auxadc
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d1cc0e12fe1f..2551c8cd9e9d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16256,6 +16256,12 @@ S:=09Maintained
> >  F:=09Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >  F:=09drivers/mmc/host/mtk-sd.c
> > =20
> > +MEDIATEK MT6323 PMIC AUXADC DRIVER
> > +M:=09Roman Vivchar <rva333@protonmail.com>
> > +L:=09linux-iio@vger.kernel.org
> > +S:=09Maintained
> > +F:=09include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
>=20
> Why is the binding not being included here?
>=20

The binding is shared across multiple PMIC ADCs and maintained by
Angelo. Since I'm only familiar with mt6323 and not others like mt6358,
I decided to not include it in the mt6323 entry.

Best regards,
Roman
