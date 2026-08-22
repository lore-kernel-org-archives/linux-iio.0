Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BA175A9C;
	Sat, 22 Aug 2026 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787363157; cv=none; b=jJMWMXQXR2bWlUzUbeDg2OB1iUuLr9/2Zl5X/a4Iyz0n2XRPZrNyUYGeLTD0wI+9Bs2EyqiO9XwjyMcRo61f+6xPuMCHrrKxOOr9RD5CKTvh90wkdU61pgkC2wU4acj1yryrYAMzAUZiWTi0aOXIKVasSpVUFgL3l0b1I1n/AMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787363157; c=relaxed/simple;
	bh=saY9HDmPbM5AjK3I9l+p+9tDa6BvEBwCvKttGcpSN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrDb/mpvshnhnXnGYJ0QYP9IROIG+V0Q/SusQv528ntUsSWVMoFL2MlIGLkCNMDgATCC2S5EZpn374YQpfKUvSuj/9oHm7zLA2tR1Qn+S1a9+uej8LaGSd1+c2ZpVIlorJ71/Fw7mlRYdVUl0dRFabmQmRTfkYkZYM4p/LqwnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnD7PNuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnD7PNuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59D71F000E9;
	Sat, 22 Aug 2026 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787363155;
	bh=aHl4AIXsgT0RxAd6Okv+/NzPPlDg2No0M78aNfSQzyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UnD7PNucuvv9T8OLHQyT/fm9g1zenXuOiTBWLHjhDXFjRNjaBb+79shFNEkaFL4xM
	 X0xIuL0Ocwbmd6xPCxb6CPHrySHQOKnPiuACwkoPSlrk3lwi5rjnuFuoBL/zhA+dKP
	 faVWf0SHh9tJ96fthoZsgXyga0F1K58MrX74nFBsuOSWT9cWrgW0gvlahICX3BE1fd
	 MZq23OXhQnhKuxanlY/Hrcvx6Y/n22V1gcI3+PkBoNzBoLdPUQLILA6hUpvT2En03X
	 q5KYsaEP8AX4UQk0PJUhnnOfd1Qr61bImHmk85z4WJdmgzdnd9keGNWgjo61LWgrUM
	 omycsAVWIRwRg==
Date: Sat, 22 Aug 2026 02:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Michael Walle <mwalle@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 01/14] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260822024548.5a6e1d7c@jic23-huawei>
In-Reply-To: <6f2b715e-f62b-4b6e-9605-23d6978b6cbb@gmail.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-1-cb554399ad26@analog.com>
	<20260816192409.145df670@jic23-huawei>
	<6f2b715e-f62b-4b6e-9605-23d6978b6cbb@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 10:27:26 +0200
Janani Sunil <jananisunil.dev@gmail.com> wrote:

> On 8/16/26 20:24, Jonathan Cameron wrote:
> > On Thu, 13 Aug 2026 15:56:54 +0200
> > Janani Sunil <janani.sunil@analog.com> wrote:
> >  
> >> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> >> simultaneous sampling ADCs.
> >>
> >> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> >> ---
> >>   .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 338 +++++++++++++++++++++
> >>   MAINTAINERS                                        |   7 +
> >>   2 files changed, 345 insertions(+)
> >>  
> ...
> >> +  adi,data-lines-number:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [1, 2, 4, 8]
> >> +    description:
> >> +      Number of DOUTx lines used for the high-speed data output interface
> >> +      (distinct from the SPI control interface). AD7768 supports 1, 2, or 8
> >> +      lines; AD7768-4 supports 1 or 4 lines. Defaults to the maximum number
> >> +      of lines for the selected variant if omitted.  
> > The default statement is a bit hidden and I'm not sure useful as it's not
> > an obvious default.  Maybe drop that and make this a required property?  
> 
> This property was required in v1. It was changed to optional in v2 following a suggestion to use the highest number of data lines as the default.
> 

Ah fair enough I guess.

Jonathan

