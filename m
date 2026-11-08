Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096425;
	b=XqSxWK1NW9cEqgUzUYeVqoyWsSFOmmX9poPZRsk2a9sU8uCauuMqgXl0OTGaNE6IbnrT
	 rIndRxRHXJbxIoN+azLKdZeuW79SBJR3Cust5KsTS+I3L4meFYyCAnejmXQec5eMNvx5R
	 Aw7Z4z9+KQSwWR8T9CTM0ap+fHUcRA0RQMMCz6IbIEtIzkLivumXfV6p1mA9lfOJPZkaB
	 Ktjq/JPQxK6iAVxnfCmfjb6xA1cvS1sYYqJApoy8PmKTykhyQownsSpsRQyMqtxsjM+1o
	 rrq1IzC3PGmzVRwvJigcuWyenmq6dg/n4dpQW/Jje9jSjEgqBn9jqxJO3gTDh3Xzj8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096425;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6qOuA7y2WP7HgDg0keAEZ736pzM0WUNauVo87oL7QDQ=;
	b=fMp0EJnUl5xWFzwRD9IZ7tfIcx9KPqOVM/jAV94Z2C+5aaRBjnS1FS87EOP4EG7zq7p5
	 XqNE1Bqhk6u7UFgkFQPKsFkAAMYehVKSNTwRwaH4HK50rdp+iw0yT+SBNgOVWOT1iDPEL
	 51CEQlvemwLLnC8523IJNq+qAUIZAFXm8g0FgeYnKpSgeKiQidKCqr2wLQ9nGY/MMPA9y
	 tHl8qBD6YOsUGgA0+/vvxHugV82+y8h6cSKS5q6g2L0zFdszXToAOzqKPwO88a/2GS8EZ
	 92kfGDJ6ZOdcX3/QVQi4UifBgswDvo476gGHYKwXhatB5xZXdlDLhTwJucIkQL8Z4+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="ExbQd9d/";
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439D606A326
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 00:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2439D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ExbQd9d/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794096421; x=1794355621;
	bh=6qOuA7y2WP7HgDg0keAEZ736pzM0WUNauVo87oL7QDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ExbQd9d/zqU4W4IqsZQ0Xpzcap+AEfhxmo42cpiflMHmazViNoxbPfV+D5MBv51Vp
	 V4tTvVjxk8nNMyZn7CKyPvQBEvz3bPZB21MEQqPNrhmyzpcqHaRlRv9Vv3YeD6E+Ki
	 LvIc8nxgqPLOa8FN8mQxFusLB3krmv3mnVcZpR7elVF7ycvi3Tc9nsjOPtQXZHeSqw
	 mV0vWl6/+584miesgzBBX5PVGSoWz7ElizDLSXHgRpR4GP4rO6e3K5QyJmMAvuMCqb
	 yueZBXqE+9HNgDNeiAuSprGlimEoOs12EYqCfXnvEdOWAga9cntKdUAqvSM44Yu3HS
	 PeEb+WywZnJ7g==
Date: Sun, 08 Nov 2026 00:06:57 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply support
Message-ID: <YGYT8qy3NVYYjUfYP3NfqDnjoQ7gdqYMw8opOaTfChdSx2z6jkaYxxJjj1Y4x6E4DMVykIDZzFjWGh_ywapgRTWmRuuCnBajjm89ZsN2JSA=@protonmail.com>
In-Reply-To: <20261107235342.40f2e45a@jic23-hlaptop>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com> <20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com> <20261107223601.0ba9ffc6@jic23-hlaptop> <geNqZOyrIjYLfmuUys8cQJU8FM53jylicArPsTGNXPnqSvHPCIc1Jad7dBOBy1GdE38RBEMSYQYDqEmaAqq2PDcglQcRBdkR0yZAjRExEUQ=@protonmail.com> <20261107235342.40f2e45a@jic23-hlaptop>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 13a2ddb5ce2211108c59898ea7f394030bbbe1ea
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, November 8th, 2026 at 1:53 AM, Jonathan Cameron <jic23@kernel.or=
g> wrote:

> On Sat, 07 Nov 2026 22:45:45 +0000
> Roman Vivchar <rva333@protonmail.com> wrote:
>=20
> > Hi Jonathan,
> >
> > On Sunday, November 8th, 2026 at 12:36 AM, Jonathan Cameron <jic23@kern=
el.org> wrote:
> >
> > > On Sun, 08 Nov 2026 00:15:03 +0200
> > > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>=
 wrote:
> > >
> > > > From: Roman Vivchar <rva333@protonmail.com>
> > > >
> > > > On some boards, the chip shares a power rail with other components.=
 If
> > > > that rail is turned off, the chip can't function.
> > > Not sure how the sharing is relevant.  Even if shared with nothing
> > > else we need to turn it on.  So just mention that on some boards it
> > > isn't always on.
> > >
> > > The only reason this would be optional in the binding is if there
> > > was internal routing in some packaging or similar that meant there
> > > was no pin to connect.
> > >
> > > Upshot, make this required in the binding. Note that doesn't mean
> > > the driver must require it - we are simply documenting that the
> > > device needs power.
> > >
> >
> > I agree this should be required, but that would break dt_binding_check
> > for existing boards. I don't have their schematic nor boards themselves
> > to verify the regulator for the power supply.
>=20
> There aren't any upstream (from a quick grep) and so not your problem
> unless you have some in a downstream tree that need fixing.

I found these (next-20261015, 7.3-rc7):
$ rg "sensortek,stk" arch/
arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts
467:=09=09compatible =3D "sensortek,stk3013", "sensortek,stk3310";

arch/arm64/boot/dts/exynos/exynos7870-a2corelte.dts
412:=09=09compatible =3D "sensortek,stk3013", "sensortek,stk3310";

arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
526:=09=09compatible =3D "sensortek,stk3311";

arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
219:=09=09compatible =3D "sensortek,stk3311";

arch/arm64/boot/dts/mediatek/mt6768-xiaomi-merlin.dts
348:=09=09compatible =3D "sensortek,stk3337", "sensortek,stk3310";

arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
206:=09=09compatible =3D "sensortek,stk3310";

arch/arm64/boot/dts/qcom/msm8916-wiko-chuppito.dts
91:=09=09compatible =3D "sensortek,stk3310";

arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
173:=09=09compatible =3D "sensortek,stk3310";

arch/arm/boot/dts/qcom/msm8926-sony-xperia-yukon-eagle.dts
169:=09=09compatible =3D "sensortek,stk3310";

> If you do then there is the option of a fixed regulator to close
> the gap.  I consider a missing supply a bug that we should fix but maybe
> others disagree.

Yeah in my tree I have added vdd-supply for my board :D

Best regards,
Roman
