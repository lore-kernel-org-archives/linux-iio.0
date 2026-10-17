Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7E303A0D;
	Sat, 17 Oct 2026 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197368; cv=none; b=l9zshz6wDV8mYen20ad7w2RB3HKkCvtrmf5fw8WvZmyYaW8OMFd+/B3NSGMtCzYdswURPvbxZiGrpAlazvgwaHE+NM4yzvtyrmtcNLT2htYuq/zwPsLSLee8IvEH9QCs68KYjqwfjdXDy8+bVlvI0dIFQBIFK+rr2J4Ie6/8m5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197368; c=relaxed/simple;
	bh=KT9mF2Y3V9O7//suWtnJcNC+HUMHPffHT1ackkPqZVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gthprhDoQPZQ7/8CyHeyCplUuaspJh6htkCutkUkZtKN0YBg44zub7VhxYpNgd0dKpTu9MDiWCHfyNGnLNSsjMUcAptqxs7X+cyKcZ4L6FmlO3pJal/oArz2ZD7+XlwDW/mefyXB94Ih+jy8g0ZUNkzhvWycbMNIdvTy90Z8Uus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFyXf1Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFyXf1Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481C1F000C4;
	Sat, 17 Oct 2026 00:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197366;
	bh=kMRxpgmv2CDHgcE18V/xAzpysWCiat+7YVUS93pYBAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KFyXf1YqIOsCvmLNtiAAebmUq4xdrIjj/weDnRlPJeh2lOMSBmT3bTJTQCb7jM4XC
	 AfsUhZeu0GtjysDEx0pgN4I20jg+cIkZz3Js8RgY86Gk3OAQqcUw0UgTXVrX/oNSbL
	 vTWL+1wZtY1iIKb3M88k9Z0OPEPdfYZ5PiPuMij6JPGhOFOTEwpzTBw7lDbwi5X+yg
	 +r4mr+F6u5BSb5b4ZVqar6tJv/x12s2RHqLcwG+ha6aR/KIVYfRNaRsfIQySbXoe3V
	 XNKwcN3r5ML/y2UkW3FqmGlFvKhnfcpCxA3/gO0kf8P8tM1FGykJBvAf+TE85fIviW
	 SLKbTZVTGPvFQ==
Date: Sat, 17 Oct 2026 01:36:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mocker-mug-unwoven@duck.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Arka Mondal <arka@arkamondal.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add AMS TCS3472 and
 TCS3400
Message-ID: <20261017013600.077fee36@jic23-hlaptop>
In-Reply-To: <af011ab8-b9ab-49d1-b9fe-4e87b3979bbd@kernel.org>
References: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
	<20261016-tcs3400-v1-1-3d79d2a7f449@duck.com>
	<af011ab8-b9ab-49d1-b9fe-4e87b3979bbd@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 16:43:42 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 16/10/2026 10:15, HuskerMinion via B4 Relay wrote:
> > From: HuskerMinion <mocker-mug-unwoven@duck.com>
> > 
> > The tcs3472 driver has no binding yet. It matches DT nodes only through
> > its I2C device ID.
> > 
> > Document the TCS3472 family and the AMS TCS3400 family, which the next
> > patch adds to the driver. Both are I2C color sensors with one threshold
> > interrupt and a VDD supply.
> > 
> > Signed-off-by: HuskerMinion <mocker-mug-unwoven@duck.com>  
> 
> Please read submitting patches how to properly attribute the work with
> your real and known identity
> 
> 
> > ---
> >  .../devicetree/bindings/iio/light/ams,tcs3472.yaml | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
> > new file mode 100644
> > index 000000000..cd4a0516e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/ams,tcs3472.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS TCS3472 and TCS3400 color light-to-digital converters
> > +
> > +maintainers:
> > +  - HuskerMinion <mocker-mug-unwoven@duck.com>
> > +
> > +description: |
> > +  Color light sensors with 16-bit clear, red, green and blue channels, an
> > +  I2C interface and a threshold interrupt.
> > +
> > +  The TCS3472 family covers the TCS34721, TCS34723, TCS34725 and TCS34727.
> > +  The TCS3400 family covers the TCS34001, TCS34003, TCS34005 and TCS34007.  
> 
> We do not take families, but actual devices. TCS3400 seems to be a real
> device, so I don't get why you call it a family.
> 
> 
> > +  The variants differ in I2C address and interface voltage.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ams,tcs3400
> > +      - ams,tcs3472  
> 
> Your driver cod suggests these are compatible, so it should be expressed.

That's only true because this driver hard rejects a whoami mismatch
which is something we shouldn't really be doing. If we do a look
up in driver and fail to match we should be using the data associated with
the ID that the fallback compatible would have had.

Our old fun of what should we do about fallback compatibles and
devices with ID registers.  Some of which (in this driver) are actually
compatible with each other and some of which are not (in the sense
that the match the WHOAMI and do different things depending on that
matching).

I still prefer that we never claim devices that need different
handling are compatible (even if detectable) because of that prevents
new drop in parts being used (as they normally have different whoami
values even as supposedly drop in replacements).

I don't mind enough to argue much about it however.
Note that before this series all the supported parts were actually
compatible and the only difference was a print on the id match. So
if this patch hadn't turned up an I'd noticed, I have simply
deleted the error return.

Jonathan


> 
> 
> Best regards,
> Krzysztof

