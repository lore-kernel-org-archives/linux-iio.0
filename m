Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0A34F25C;
	Fri,  8 May 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245706; cv=none; b=lJdEC9nB5CCchbTLuhqpHLc7oDiMfz7Qt224fxna7fKoLDRhlvEZRLpDmZZRPbN04qsPPSDw3XKmPw5vbf4it6sV/hYK0egTYxy0/GGqwXKIhCOxwE/uBm48x8DJzC7fzKd1kIW+fnvmq+fwlwuFW/d2Bio7SGLMAeo/Vf6l9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245706; c=relaxed/simple;
	bh=bFhsQUUgbH4CR1FXDxZX6IdtumKmj/CzQUkHgqKyqoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQQ76pPp+S1ajlmBSndYfDwN+D6c0mg97vEOXDHELdjUIt8hwA32zNqurVADGuIPSdvm/cWEOYwdq1ixyzGaXLnbCKCcqeog7mf1WEkKm5KI2065Ff9AOahdVC2C6Rv3pZKlNzK1X6g0uM1i9il80BXqiNIdg/+srm07TT5tAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2xbvvRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2xbvvRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7282AC2BCB0;
	Fri,  8 May 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778245706;
	bh=bFhsQUUgbH4CR1FXDxZX6IdtumKmj/CzQUkHgqKyqoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2xbvvRzwgTBTG2ae30TeZeSoNFqlATe8KpcHeaei5ULg2iokFXE9xPZHgl5CJBCJ
	 MxLJxLAZQ392k+zPSvyyc6n3gCuCEV8+C1DoO/8fFtGFT0HN9fQ1qcQYzEqVbIGSK7
	 HLMV/ruczRcjxkg49I9pCd4zctvxFPHXAx6bO6lmdqP21aAJKJGkWo8GmqgwHgUQ0b
	 fgy1kUPCPK3tYqmN4OOAHRxnzoKnMMyZfqSWr+1eKMPux+QM2//UzphBpvCqTcQXvp
	 xYzWmeGYZjaatSDLjP/Ve1EG4VpY9pS7yfqsV+60rgdNowuBu5MGezk5R1nkHyQwhP
	 AGx8+/PwviAUQ==
Date: Fri, 8 May 2026 14:08:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 rodrigo.alencar@analog.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260508140814.67800e4a@jic23-huawei>
In-Reply-To: <20260508134843.7646c4f5@jic23-huawei>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
	<20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
	<20260508134843.7646c4f5@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 13:48:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 8 May 2026 13:55:47 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> > buffered voltage output digital-to-analog converter (DAC) with an
> > integrated precision reference.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 96 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  7 ++
> >  2 files changed, 103 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> > new file mode 100644
> > index 000000000000..f531b4865b01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC  
> 
> How is one device bother 12 and 16-bit? That sometimes happens for
> ADCs where it is really reflecting oversampling or for device with hardware
> FIFOs where storage space is saved by using lower bit rate. I'm not sure either
> applies here.

Having read the driver I now understand. This is supporting two parts and
doing device ID based detection.  In an unusual step for Analog they have
the same base part number with a post fix.  Whilst this approach works today
it fundamentally breaks fallback dt-compatibles being used in future (the
driver fails for any non match of WHOAMI value as it needs them to look
up device specific data)  As such I think you need to have separate
compatibles for the 12 and 16 bit versions.
