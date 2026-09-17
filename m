Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD793A254B;
	Thu, 17 Sep 2026 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613330; cv=none; b=KGCH/LaEoKZJk3Jch9MAtKRBnbMV2mt9dCXwbo5Bg/OJl+hTOf7m7uOOK6fKEuAh1SBKC+imUDsqM6RHcImQtv1CU6186D8BpGVlLnEvcq7D6D6SYOD9jLmwIDWZSuO7Bo5xMHlNqQp8DkyltUmICOTSPT8DunidknClChE14NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613330; c=relaxed/simple;
	bh=qWSNGS9pPFL7xFTEy2HcAJx/FZa1qI52mW2AVp8/ZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbtAjEs27YJ8zrk4Kv9tJZ+SQOWkC+H0W3eTDAPjkB2UPy54nFlD1+a+KvBP3LkATYvpWSD11n9ZkFJ1oXuAuZYReQfUwUlezHJcbuoaWqDqUFmVqw2PmaJIisyOzyA15xFAx8bNksfaEDyu9L+PuMbVAOqyXxLQNOlc3LEzvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTpvHynK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTpvHynK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750D31F000FF;
	Thu, 17 Sep 2026 02:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613310;
	bh=xxfNvR0QRrW759Cop4lKa4JjEDFebmB4r0lDUyI+0xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RTpvHynKWrrwy4ls3Abk1vTEyAtXYIdGgdCNX1XrOFeDuHge2cMWBzNWi8J8pj3F5
	 4+iQfyPuWR58PPDRRKDiSkMtpqcf0r7cRiaR1StyjKQX1SRCD+YNWTL1qESGidSDKt
	 B+DHWEC+0yWICKYmw7ijn+IdsuAYgQVVKxBPVepzPDLqGEyCAPcw8cwYZhQtykvXrs
	 duEeFp0rSbNUPlmHlbS6PqalDsLvzF8QhY0LgT3HDLgnI1mzpsL5sg3BcNMNlzdNpc
	 FgSBoHvoiW/z/lV9TObR/PlJcNWOBc6G4x3Cvrwb/dD6xNCRjJFAy6vfyIiwipU1b9
	 zz2pRr82NGMfA==
Date: Thu, 17 Sep 2026 03:48:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260917034823.03940ac4@jic23-hlaptop>
In-Reply-To: <20260915-gleeful-jester-c8114edf28ff@spud>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
	<20260907210042.32552-2-marcus.yu.56@gmail.com>
	<20260908-dinner-shelve-1d61e19ee3b7@spud>
	<20260913014203.2bae2222@jic23-hlaptop>
	<20260915-gleeful-jester-c8114edf28ff@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 18:11:17 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Sep 13, 2026 at 01:42:03AM +0100, Jonathan Cameron wrote:
> > On Tue, 8 Sep 2026 19:13:55 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Mon, Sep 07, 2026 at 02:00:41PM -0700, Chang Yu wrote:  
> > > > Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> > > > with i2c address of 0x39.
> > > > 
> > > > The GPIO pin is described as a generic GPIO for now. Binding design for the
> > > > more advanced measurement/LED synchronization use cases are deferred to
> > > > future patches.    
> > > 
> > > Unfortunately, you can't change what you document, so picking something
> > > correct now is needed - even if the driver doesn't use it yet.  
> > 
> > Definitely needs an outline of how it would be backwards compatible and
> > an explanation of why not now.  Sometimes a portion of the binding is
> > so uncertain that we do kick it back from initial version but we 'must'
> > be sure we can extend the binding to new configurations.  Normally this
> > is one of those we are fairly sure, but not entirely sure cases - or
> > picking between two options where consensus isn't being reached.
> > 
> > Chang Yu: This sort of things needs discussion and is one of the reasons to
> > go slowly.  
> 
> Ye, I note that there are 2 more versions of this since I left this
> comment, but you seem to be on top of that.
> 
> > > > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > > > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
> > > >   - Fix node name and unit address mismatch.
> > > >   - Include MAINTAINERS changes.
> > > > 
> > > >  .../bindings/iio/light/ams,as7343.yaml        | 69 +++++++++++++++++++
> > > >  MAINTAINERS                                   |  6 ++
> > > >  2 files changed, 75 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > new file mode 100644
> > > > index 000000000000..b06d445b92b3
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > @@ -0,0 +1,69 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> > > > +
> > > > +maintainers:
> > > > +  - Chang Yu <marcus.yu.56@gmail.com>
> > > > +
> > > > +description: |
> > > > +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> > > > +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - ams,as7343
> > > > +
> > > > +  reg:
> > > > +    description:
> > > > +      I2C address of the device (0x39).
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    description:
> > > > +      Open drain output active low interrupt pin.
> > > > +    maxItems: 1
> > > > +
> > > > +  vdd-supply: true
> > > > +
> > > > +  ams,led-current-microamp:
> > > > +    description:
> > > > +      The driver current for the external LED connected to the LDR pin.
> > > > +    minimum: 4000
> > > > +    maximum: 258000
> > > > +    multipleOf: 2000
> > > > +    default: 12000    
> > > 
> > > Rather than a custom property, the tsl2772 uses led-max-microamp:
> > > tsl2772.yaml
> > > 46:  led-max-microamp:
> > > 81:                led-max-microamp = <100000>;
> > > 
> > > I wonder if the same should be done here, or if there should be an leds
> > > subnode? Perhaps the IIO folks can comment on that.  
> > 
> > I don't think we've ever bothered with a subnode as there only tends
> > to be one of them.  Given the enabling etc is all hardware controlled
> > I'm not sure a more generic LED binding makes sense. I don't know that
> > much about the led bindings though so maybe it is worth doing a subnode
> > just to use the leds/common.yaml definition of led-max-microamp?  
> 
> Could always just put a ref in to leds/common.yaml and not bother with a
> child node. I'd stick with the additionalProperties: false, since
> there's lots of leds properties that probably don't apply to a device
> like this.
> 
Sounds good to me.

> Cheers,
> Conor.

