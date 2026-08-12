Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC3418346;
	Wed, 12 Aug 2026 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529485; cv=none; b=iCyzjQILDF+2RA8Tf8DRy4NTlOR8WRGVRuhj4Kwp+LDQNxleGJmwzDM5goB0oux1RvlBfvYhxDt3aYz+RKXfn2qpjfF0YdaqIYYoTt9dLlFhNmzoV/DU82hD9B4jsSfq5iDW5WepVWvIo2gUgJfMHDKhNhPv2mmryOBnyOvRqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529485; c=relaxed/simple;
	bh=tK5kSu7o3Gg7D3UWu08JlgFnWMIl4xLwhV3Us3sCjIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/JwNKvHUV1aXcjcReII2C1IjPpqu/R7SwLpddFm3H3laS4A7VEVgCKkGUlsA3r2ti7qFobmKvDcUtw/yw+tTog/+YKINkmoJQMfZRkoL8MfF3P7lEs/N9l+J4btsi2mGkxJA8L7VvceLP49g17qBULbLLmj6MhwXIpRwOcNAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=6ldGws6t; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="6ldGws6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail3; t=1786529478; x=1786788678;
	bh=/GO93YHe3+dQ8Hjz3ICrJP4ZvePEoCldcJlYgsUc7As=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=6ldGws6t1EGx4sUkaOhKlXFANfBQBrFqxo/1/bBrDEpQ4lAawy0IiraY6WkCx+xaF
	 rk84UFGx/mUEESw9CV5VLA6woyd8cTOI/6CiYkk0DELm9xs6DhiWlkmwcgzv860D6k
	 RmVb8FtpUsdTruIwO8DIBDBobXsoUPFctDKkKb6idP+McDJ3JphPv7uNa8dqRJtG5t
	 jQ8DWMWPcKzt0t0XRxaApwy84P9IJ95NgYGaKfgaBSqHpC5nND9wWCNvM16WD1af6T
	 qqn+A6EKas8RvXfEQbNxtti7ptPqkFqSQoKCEj6LMXoSm3ReuYYHS+Th5yOhO4UiTS
	 3F8Z7dCip/CvQ==
Date: Wed, 12 Aug 2026 10:11:13 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Matt Ranostay <matt@ranostay.sg>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht, linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
Message-ID: <F_gQH7S7C_a2e4gmKfLMZwNzMQ2lvOoBcv-tqJsuNGsWYdJdV-KhzKRPTqo1JS4yGoBK6bn4lscAS3et1Uxm-obr7Tjw3hzePjHOllpSlc4=@ranostay.sg>
In-Reply-To: <20260812053450.2e14b074@jic23-huawei>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com> <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com> <20260812053450.2e14b074@jic23-huawei>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: c5d0def14d79898b2063cb3d33da652b80bf9c89
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Wednesday, August 12th, 2026 at 12:35, Jonathan Cameron <jic23@kernel.or=
g> wrote:

> On Mon, 10 Aug 2026 16:18:40 -0300
> Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:
>=20
> > The PulsedLight LIDAR-Lite v2 is currently described as a trivial devic=
e,
> > but it is not one: besides the I2C interface it exposes a power-enable
> > pin and a mode-control pin.
> >
> > The mode-control pin can trigger acquisitions and report the measured
> > distance through a PWM signal, entirely bypassing I2C. That usage is
> > bidirectional and non-cyclic, so it doesn't map onto any existing
> > binding for describing pin behaviour, and is intentionally left
> > undocumented here. The same pin can, however, also be used as a plain
> > status output while I2C remains the active interface, which is
> > described through the new interrupts property.
> >
> > Move the device to a dedicated binding file and document the
> > power-enable, power-supply and interrupt properties that
> > trivial-devices.yaml has no way to express.
> >
> > Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> > ---
> >  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 64 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >  2 files changed, 64 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pul=
sedlight,lidar-lite-v2.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedligh=
t,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/puls=
edlight,lidar-lite-v2.yaml
> > new file mode 100644
> > index 000000000000..e19c8d166b81
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar=
-lite-v2.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lit=
e-v2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
> > +
> > +maintainers:
> > +  - Matt Ranostay <mranostay@gmail.com>

I really don't use my gmail address anymore. Would be ideal if it was chang=
ed matt@ranostay.sg=20
Other than that don't have any issues.

Thanks,

Matt


> I'll need an Ack or Reviewed-by from Matt for this. If Matt either doesn'=
t
> reply for a while, or isn't happy to take on this much fuller binding,
> is it something you'd consider putting yourself down for?
>=20
> Otherwise LGTM
>=20
> Thanks,
>=20
> Jonathan
>=20


