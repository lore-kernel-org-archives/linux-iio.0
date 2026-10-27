Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098574;
	b=RQwOHuVHz3IqX+xvtK/UwltiNj9Hc2UZRBQD1ZCl5GCEfQAqy+mj/yFiYCOmgll05iTA
	 u7QXx6M03twUIy1DtYZb3IjQ80mCKDh+UTJ9aOT+9Ri4nlHLyPmIijtVeRCIio0TTFBgI
	 +vVfKXqATVkOvX+DPPKa4NSJfTEopb6OgmEqEd0GOn7SxtvjJWAf5aRug0n5D3occmKTE
	 gJqos/MAufnEGmqYsiGBOlLIegbu9cUJewl1CkhsV1Bf4aXNsESDRG0YvtYjFKwtFFGZn
	 L13Z692jpDboE8U9RQnWJfAOuvq9YyWzYkFWVwOVCjMuEyFL8SrQYzEyRe9AEIbQvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sUXQlqgovseDKztSQZpstPbPoIlLA77jlJhheOYXXt8=;
	b=KfeH5BSwkiRML/hodKI5Rwt01tA6mq5NhjscH6KIYBQbqWaTZuLNlsVkAmweUqn2tC1I
	 vgTMdY1xGnzMTV84mIbdM3VweI95qlNJEVx91piuUAimPvBmZnOH3BFCcuiceKQvO8yir
	 kNSX2KSoJftaN/2nCmUt8ulWILe76NYf9PXo/AtUmYWCRjqqaVVluegsNV0pYi1DH/yN9
	 80eVL9B/O9SH6cEpPyB9rhsKTodYqZkkoHsTypoQ/572PFpElsMOG61PauEmguf+/Xd0A
	 azFQ3msxUksMeSxYF2oZXYbt4+8X+J4qoouYKYlaerXAxRLeavZGcve5uxs6ZEI7KNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U71+2ftv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF023606A31B;
	Tue, 27 Oct 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U71+2ftv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF931F01200;
	Tue, 27 Oct 2026 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098573;
	bh=sUXQlqgovseDKztSQZpstPbPoIlLA77jlJhheOYXXt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U71+2ftvkQK1TI9RF0Q9MEJ4RtFyhwMmA7Dd71F/UNwYWnNi0beQscvuSx35tB675
	 tCq+FdF0CdyvqUd5J2lKZmv6r8oNWS+LKMhrLUAQONUiyA6DHiGO0yWkPhi81jWis7
	 tl0iOU5mM5IREvfi9gHUQ9So2L271Si2EN4Cp1rGrZUocM0fGwEZbb4rwS3jlB+LHj
	 5B7opp3Cf1fl5qhYZthrwMXDHzUjlH9crN3EF3QrXq5dScdDmwqTekv0iTJ+0Hdkvb
	 MUo+GiNua9wYDCcS7+jxTFbc5/yRxo4XXLR4C/qacTLn/t14N9jnaLoTQoI1x2Ax4K
	 7bZJyEw5vG/nw==
Date: Tue, 27 Oct 2026 11:56:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261027-grumpy-stingray-of-acceptance-43029e@quoll>
References: <20261026083631.48406-1-olivier@mgcrea.io>
 <20261026083631.48406-2-olivier@mgcrea.io>
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
Content-Disposition: inline
In-Reply-To: <20261026083631.48406-2-olivier@mgcrea.io>

On Mon, Oct 26, 2026 at 09:36:30AM +0100, Olivier Louvignes wrote:
> The X1600's SAR ADC has four auxiliary channels and none of the
> touchscreen or battery engines of the JZ47xx ADCs in ingenic,adc.yaml,
> so it gets a binding of its own.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> 

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof

