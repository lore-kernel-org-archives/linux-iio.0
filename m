Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869736C9CC;
	Wed,  5 Aug 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948354; cv=none; b=En/to6Taxr+ZYOaFcW+kmlrLNTbzFmIk5/KDyAV+CwtujmkrhxvojZUgspt8eyuWDEwvdgWMXdFN4R/8Y7rGX3kF0IxmNXFZVBkIx5o9j+A7Xkvib+Fgndr87vYnDu/0JDJGTUVAJ7Vr3+PpDxdlOdoOktTHt0rm962hmYdqT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948354; c=relaxed/simple;
	bh=RfrmJFXn9hifuhN9U65iXd8hJ6oRlGb9FVaO7uhXM/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUoYEe6GCiJdebzEucle/YI/77CdRj2a6YA5WOqILXgelihvy0mpc1b3f7PwYuJr3m36oaSuL0PynrITMogEppj3GEi59vDFT0k87ecLAK06Qsz6qnpAo9z2vnL/zDE6cj2UKAQt2YCqIvDS3t4bZYcgGgx3K7kCbKDb8zUqkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj1peAo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj1peAo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A51F000E9;
	Wed,  5 Aug 2026 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948353;
	bh=amtVsq3g+Dw4EwN5/hpH2UXi0wrWW/HktWeH6w0iHMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bj1peAo7tA+zT9IwLwkDUq7ML97g2OF9S6Ia86PcPFXMPAinvx+43wNbzzC2mxkEg
	 heUjbKIoUW5nYt2v1TEVXNXm7dFZeTOs9CwENvZK6D31InSyPBhfMjsb9RXlcVuH70
	 QNPshHFf8ZWJkrDX06sDDjRBL65GKtiWHgemmjBAZsJDIoJJ5RRsJY9ry+CwwbCF71
	 Bwjmz3hzP7OuSTbtbB7WNeYC3MZIkFCVsMpim1ItXZ4/kXWPBN5rW0xymGXwLRaRPH
	 PzmJPJpQGj3xXVapuMTyS97mLswhNvwUffsnZZZ1MICbSDmdKHGiUanluaaeB3PCJ/
	 KO+/vQ+uL7DmA==
Date: Wed, 5 Aug 2026 17:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "Sa, Nuno" <Nuno.Sa@analog.com>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, "Marques, Jorge"
 <Jorge.Marques@analog.com>, Salih Erim <salih.erim@amd.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, linux <linux@analog.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
Message-ID: <20260805174548.4668a844@jic23-huawei>
In-Reply-To: <CY2PR03MB64993328B3E165CF124F5EF35F9BD32@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
	<20260802024406.6147807e@jic23-huawei>
	<CY2PR03MB64993328B3E165CF124F5EF35F9BD32@CY2PR03MB649933.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 11:45:37 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hi Jonathan,
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, August 2, 2026 4:44 AM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> > Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> > Shuah Khan <skhan@linuxfoundation.org>; Sabau, Radu bogdan
> > <Radu.Sabau@analog.com>; Schmitt, Marcelo
> > <Marcelo.Schmitt@analog.com>; Marques, Jorge
> > <Jorge.Marques@analog.com>; Salih Erim <salih.erim@amd.com>; Matti
> > Vaittinen <mazziesaccount@gmail.com>; Jishnu Prakash
> > <jishnu.prakash@oss.qualcomm.com>; linux-iio@vger.kernel.org; linux
> > <linux@analog.com>; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-doc@vger.kernel.org
> > Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
> > 
> > [External]
> > 
> > On Fri, 31 Jul 2026 11:29:46 +0300
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >   
> > > The ADE9078 is a polyphase energy metering device from the same family as
> > > the ADE9000 and is register compatible with it. The main differences
> > > relevant to the driver are the absence of the on-chip dip/swell detection,
> > > a lower maximum SPI clock (10 MHz), and slightly different full-scale ADC
> > > codes.  
> > 
> > This looks fine to me, but will need to sit on list until the dt maintainers
> > have gotten to it.  Sashiko did call out some possible preexisting issues
> > in the driver.  I haven't looked at them, but if you have some time, it may
> > be worth a look the power vs interrupt registration one smells plausible.
> >   
> Want me to send the fixes in a separate patch or within this series?

Separate should be fine for any preexisting issues.  I'm not going to
hold this series up waiting for them (assuming we get the dt ack - it's
listed on their patchwork as Needs Ack so no one has gotten to it yet).
https://patchwork.kernel.org/project/devicetree/patch/20260731082951.1228-3-antoniu.miclaus@analog.com/

Jonathan

> 
> > https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260731082
> > 951.1228-1-
> > antoniu.miclaus*40analog.com__;IyU!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_Pruv
> > IpxZPJggP6_ge3-ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqRTn7EkeQ$  
> > >
> > > This series adds support for the ADE9078 to the existing ade9000 driver.
> > > It first refactors the driver to move the part-specific values (device
> > > name, channel table, and full-scale codes) into a chip_info structure
> > > retrieved via device match data, then adds the new device tree compatible
> > > and the ADE9078 support itself, and finally updates the documentation.
> > >
> > > Changes in v2:
> > > - move the "respective datasheets" comment wording to avoid churn.
> > > - use a generic Kconfig title and list the supported parts.
> > > - duplicate the RMS voltage macro instead of a shared base macro.
> > >
> > > v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-  
> > iio/__;!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_PruvIpxZPJggP6_ge3-
> > ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqTALKwajg$ <FILL-IN-v1-
> > MESSAGE-ID>/  
> > >
> > > Antoniu Miclaus (4):
> > >   iio: adc: ade9000: introduce chip_info structure
> > >   dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
> > >   iio: adc: ade9000: add support for ADE9078
> > >   docs: iio: ade9000: document ADE9078 support
> > >
> > >  .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
> > >  Documentation/iio/ade9000.rst                 |  28 +--
> > >  drivers/iio/adc/Kconfig                       |  16 +-
> > >  drivers/iio/adc/ade9000.c                     | 180 ++++++++++++------
> > >  4 files changed, 175 insertions(+), 79 deletions(-)
> > >
> > >
> > > base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470  
> 

