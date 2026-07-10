Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4D495E5;
	Fri, 10 Jul 2026 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643610; cv=none; b=nVRKN+cl2DforWo49HTYwkp4A2hJZZdo2bmgcK4ogQXgi0URkhLyhcckiKRqp87sgG2OxREQzopppeQiuaI0hgFStDTstiTSE0q/5vAWeIXOh+VMXCf9tac1R/nxqfsOkyy5MBmRaIbmmnDLK8F+tPZW2WvPWV0o97FSMByta1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643610; c=relaxed/simple;
	bh=VIWaWdmCTNiGUYLagvsCwLwIzAsy1g/SrJ0Hu5DDmwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgkQdHbWw5pqx8oDNtU/6rJ/ywE6DRNl70g7D59X7M5hftwRdMPkrYSwwnqPScy4iXoedhv/TLb4+kUM0Y4F6UIKCHl8XWjFjFLkDGgmXKXb31xcpblT1Mul4c+uVC5Y9/tfs1OQVBwcZDvTBPTaff4XhLDwSoDjacfcn0RTKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFvBJkWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFvBJkWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D41F000E9;
	Fri, 10 Jul 2026 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643609;
	bh=qPTn250nmvi6i01OD/7X3vu+1rxTpDsUJQ9pJQgfjxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lFvBJkWPonlED4WimT5099jDJhXo/2gqq5Zwm+6oSXaA+weoSNcyquj0MyCL/Stiv
	 qLNnDhjX2pG3ELf4pTyUUIga7j9WD1pNFK6rqxQclM+UYhnFagDSK0iVt80caKT6js
	 4i/MNqQ4VNO05lR7KE9Lnpg5/4SkTcDrc1rsjnY80OxhXOhboq703QNZabuXHPBX7l
	 w+FsdY/ejUSHy1ALcDZfS4b+W9Sz3PRQXlG1AH7lcZn/2sJcLc7gcq9F3ZHczrxeu6
	 VN2BySCV56+C3GcPJ1H8Y3w/QTZHNvXzhSQlsOw0sL9cmkVPj0EVyzu40GxQWsalQT
	 eBbC2h7rBdtpg==
Date: Fri, 10 Jul 2026 01:33:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
 jananisunil.dev@gmail.com
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260710013322.595f8ee4@jic23-huawei>
In-Reply-To: <36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
	<36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +  adi,common-mode-output:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - avdd-avss-half
> > +      - 1.65V
> > +      - 2.5V
> > +      - 2.14V
> > +    description:
> > +      Common mode voltage output selection.  
> 
> Why not using standard regulator provider bindings for this?

Interesting question.  If that was done there would need to be
a consumer which means explicit modelling of any analog circuit.
We do that in a few cases but so far (and yup this is a driver thing
in a dt-binding) I don't think we have any way to consumer data when
a backend is involved.
	
> 
> > +
> > +  adi,vcm-power-down:
> > +    type: boolean
> > +    description: Power down the common mode output buffer  
> 
> Is the buffer separate from the output? In that case I would expect
> buffer to be in the property name, otherwise this should just be
> part of the enum options above (and the default one at that).
> 
