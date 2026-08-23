Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657C15C14F;
	Sun, 23 Aug 2026 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523422; cv=none; b=aaPWbuTVSKABJttae7QmUhGis6nKVDXOQ3HdM3gd5+j8v/zu5DUVlSdmO+FuncfyLV4H0l4GbDX0Is5diKJ6pM19GhhFJGphAAoHpLrDW4WecpPwxaocPCyvd4yBYu9Fgs4ej+KHPA3OvIXIncf/ce8pBmB3XbTa8tpSG2oBumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523422; c=relaxed/simple;
	bh=gT86V4rgwFjsx2k8iOk+OTfu+wC2GjYvWjgjus6H6Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orocOrDzgOcp6KR+R7Uure0RDZ00/kFihVOAUM4jqM2ZLYt7rZYPnHQkPHaVFbwZW285iqkHX69cTDjeUEqtszouB8lb5HQzV3LwM1Qiw7Atz0cDsU/hm1VP3QZGrq+WR+8iv+dhffoOVLq+tWi+Ucu11Rq/xLzYcHavxn2F2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok8kbt8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok8kbt8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3449F1F000E9;
	Sun, 23 Aug 2026 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523421;
	bh=jJJ2+Gz5QjAkIcUUBf9XCCvJOyKr1cALXVDkrgWjuqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ok8kbt8/vFqF1DTo6U4wJzIRSMpucDhR7YV82YFNZQeScYBeFafmctipoKsIftOc4
	 L7tb2wbou0xKKOaIGFwIQigPQM2sZqaHdx1sVMWVJvoHu7ZB/cTJXFSA9vB2bQceD0
	 RUrSjSOmOkjBgMDXYHY3hTxy48AFRQTYed2iUtsBl08uPsiyuuhv8gg18CW57zH2/H
	 2iQ8HBDLp91WggLRXuWSFZ1clr7BQBCFY5i9PgXDI9Z+VcHGU28VNAR7XHZGaX9ucc
	 rCWjwopQfw0hV+ZDLQs4idEy1D0nnGrSIKI/mi3KtLl3acVg4CarG9y69w4xHf+1tM
	 L/DhHlCaQISbA==
Date: Sun, 23 Aug 2026 23:16:54 +0100
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
Message-ID: <20260823231654.7e4ad595@jic23-huawei>
In-Reply-To: <20260805174548.4668a844@jic23-huawei>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
	<20260802024406.6147807e@jic23-huawei>
	<CY2PR03MB64993328B3E165CF124F5EF35F9BD32@CY2PR03MB649933.namprd03.prod.outlook.com>
	<20260805174548.4668a844@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 17:45:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 5 Aug 2026 11:45:37 +0000
> "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
> 
> > Hi Jonathan,
> >   
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, August 2, 2026 4:44 AM
> > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> > > Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> > > Shuah Khan <skhan@linuxfoundation.org>; Sabau, Radu bogdan
> > > <Radu.Sabau@analog.com>; Schmitt, Marcelo
> > > <Marcelo.Schmitt@analog.com>; Marques, Jorge
> > > <Jorge.Marques@analog.com>; Salih Erim <salih.erim@amd.com>; Matti
> > > Vaittinen <mazziesaccount@gmail.com>; Jishnu Prakash
> > > <jishnu.prakash@oss.qualcomm.com>; linux-iio@vger.kernel.org; linux
> > > <linux@analog.com>; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-doc@vger.kernel.org
> > > Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
> > > 
> > > [External]
> > > 
> > > On Fri, 31 Jul 2026 11:29:46 +0300
> > > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > >     
> > > > The ADE9078 is a polyphase energy metering device from the same family as
> > > > the ADE9000 and is register compatible with it. The main differences
> > > > relevant to the driver are the absence of the on-chip dip/swell detection,
> > > > a lower maximum SPI clock (10 MHz), and slightly different full-scale ADC
> > > > codes.    
> > > 
> > > This looks fine to me, but will need to sit on list until the dt maintainers
> > > have gotten to it.  Sashiko did call out some possible preexisting issues
> > > in the driver.  I haven't looked at them, but if you have some time, it may
> > > be worth a look the power vs interrupt registration one smells plausible.
> > >     
> > Want me to send the fixes in a separate patch or within this series?  
> 
> Separate should be fine for any preexisting issues.  I'm not going to
> hold this series up waiting for them (assuming we get the dt ack - it's
> listed on their patchwork as Needs Ack so no one has gotten to it yet).
> https://patchwork.kernel.org/project/devicetree/patch/20260731082951.1228-3-antoniu.miclaus@analog.com/

Applied this series to the testing branch of iio.git.  Expecting to see
patches dealing with any of the Sashiko found prexisting issues on top.

Thanks,

Jonathan

> 
> Jonathan
> 
> >   
> > > https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260731082
> > > 951.1228-1-
> > > antoniu.miclaus*40analog.com__;IyU!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_Pruv
> > > IpxZPJggP6_ge3-ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqRTn7EkeQ$    
> > > >
> > > > This series adds support for the ADE9078 to the existing ade9000 driver.
> > > > It first refactors the driver to move the part-specific values (device
> > > > name, channel table, and full-scale codes) into a chip_info structure
> > > > retrieved via device match data, then adds the new device tree compatible
> > > > and the ADE9078 support itself, and finally updates the documentation.
> > > >
> > > > Changes in v2:
> > > > - move the "respective datasheets" comment wording to avoid churn.
> > > > - use a generic Kconfig title and list the supported parts.
> > > > - duplicate the RMS voltage macro instead of a shared base macro.
> > > >
> > > > v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-    
> > > iio/__;!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_PruvIpxZPJggP6_ge3-
> > > ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqTALKwajg$ <FILL-IN-v1-
> > > MESSAGE-ID>/    
> > > >
> > > > Antoniu Miclaus (4):
> > > >   iio: adc: ade9000: introduce chip_info structure
> > > >   dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
> > > >   iio: adc: ade9000: add support for ADE9078
> > > >   docs: iio: ade9000: document ADE9078 support
> > > >
> > > >  .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
> > > >  Documentation/iio/ade9000.rst                 |  28 +--
> > > >  drivers/iio/adc/Kconfig                       |  16 +-
> > > >  drivers/iio/adc/ade9000.c                     | 180 ++++++++++++------
> > > >  4 files changed, 175 insertions(+), 79 deletions(-)
> > > >
> > > >
> > > > base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470    
> >   
> 
> 

