Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85D64;
	Sun, 20 Sep 2026 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862695; cv=none; b=rCAC4RjscNaGsIbKUc7M1rvy666EE75N6TeuYPVV7sO1NoBtYAasTakapXDOmJ0i8LLsTxVE9pVpRGLMPrfCvePxgvYguLcaML8GhQpcdPW+gblFOaJDfld23w95uFla2z6mCgEPJMvShxn+TNxzd/rLHxC42EdFUMmnhKLr190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862695; c=relaxed/simple;
	bh=n7z6gbBlz3yGy7cYYSKxrEGBOjRcjKRyckXP+KbZdzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD2r00jDhNjJdo+SUk7lrW0QMwcQEinLlofCIOy05pf3/1XLwpAdbjSTo7uA/0+2TRbotkDcFDZTsPMqPdh+7KVFQM0K3jjKTDwyfArP9FEn9zBA1zq/JgOXXSWyC9JSGDBE8+x/EwmAoHNpl4UrqwGXxCVXP+kcE8Cq8xLlMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQUzEd3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQUzEd3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228631F000FF;
	Sun, 20 Sep 2026 00:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862694;
	bh=UuX/5+k9oftQAVaOQJoj088sUG/Vlz1k5mYZo3YGnGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XQUzEd3J9w0CvYz1BFrAXMYqKORTMAPXDp5YGW9+WUQbYdVq4BgnYSL6pVX9BzKoS
	 CFmARUneXXnb+Ew8cTEqqwD8/KRaxAslksTgxMyRmaum2pU97l1ZBsdjz45Ddd6LJW
	 P6JgO/q1L17S69WTReCTFM7u0eiAcWVRAi7l0Xmyn54hq4FIHas9VKx1svwE/A7mn3
	 /7N/fs8zvRZAwHMj0dGkxc28thoZW9oM4WhTplCq0FVnwA5GbWYducOiZ8Cdf1kJas
	 zTI0w9FB4DbZsaVm6exPQ0LKYkSEten6gJ9SPnZDgA+9m85QxX77QA3+8hz4/3xJ7H
	 l0sP2gqVHtS6w==
Date: Sun, 20 Sep 2026 01:04:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260920010448.114fc597@jic23-hlaptop>
In-Reply-To: <aq3rdBcMw1XcHnkL@gmail.com>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
	<20260907210042.32552-2-marcus.yu.56@gmail.com>
	<20260908-dinner-shelve-1d61e19ee3b7@spud>
	<20260913014203.2bae2222@jic23-hlaptop>
	<20260915-gleeful-jester-c8114edf28ff@spud>
	<20260917034823.03940ac4@jic23-hlaptop>
	<aq3rdBcMw1XcHnkL@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 18:55:00 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> On Thu, Sep 17, 2026 at 03:48:23AM +0100, Jonathan Cameron wrote:
> > On Tue, 15 Sep 2026 18:11:17 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Sun, Sep 13, 2026 at 01:42:03AM +0100, Jonathan Cameron wrote:  
> > > > On Tue, 8 Sep 2026 19:13:55 +0100
> > > > Conor Dooley <conor@kernel.org> wrote:
> > > >     
> > > > > On Mon, Sep 07, 2026 at 02:00:41PM -0700, Chang Yu wrote:    
> > > > > > Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> > > > > > with i2c address of 0x39.
> > > > > > 
> > > > > > The GPIO pin is described as a generic GPIO for now. Binding design for the
> > > > > > more advanced measurement/LED synchronization use cases are deferred to
> > > > > > future patches.      
> > > > > 
> > > > > Unfortunately, you can't change what you document, so picking something
> > > > > correct now is needed - even if the driver doesn't use it yet.    
> > > > 
> > > > Definitely needs an outline of how it would be backwards compatible and
> > > > an explanation of why not now.  Sometimes a portion of the binding is
> > > > so uncertain that we do kick it back from initial version but we 'must'
> > > > be sure we can extend the binding to new configurations.  Normally this
> > > > is one of those we are fairly sure, but not entirely sure cases - or
> > > > picking between two options where consensus isn't being reached.
> > > > 
> > > > Chang Yu: This sort of things needs discussion and is one of the reasons to
> > > > go slowly.    
> > > 
> > > Ye, I note that there are 2 more versions of this since I left this
> > > comment, but you seem to be on top of that.
> > >   
> > > > > > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > > > > > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >   - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
> > > > > >   - Fix node name and unit address mismatch.
> > > > > >   - Include MAINTAINERS changes.
> > > > > > 
> > > > > >  .../bindings/iio/light/ams,as7343.yaml        | 69 +++++++++++++++++++
> > > > > >  MAINTAINERS                                   |  6 ++
> > > > > >  2 files changed, 75 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..b06d445b92b3
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > > > > > @@ -0,0 +1,69 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Chang Yu <marcus.yu.56@gmail.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> > > > > > +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - ams,as7343
> > > > > > +
> > > > > > +  reg:
> > > > > > +    description:
> > > > > > +      I2C address of the device (0x39).
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  interrupts:
> > > > > > +    description:
> > > > > > +      Open drain output active low interrupt pin.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  vdd-supply: true
> > > > > > +
> > > > > > +  ams,led-current-microamp:
> > > > > > +    description:
> > > > > > +      The driver current for the external LED connected to the LDR pin.
> > > > > > +    minimum: 4000
> > > > > > +    maximum: 258000
> > > > > > +    multipleOf: 2000
> > > > > > +    default: 12000      
> > > > > 
> > > > > Rather than a custom property, the tsl2772 uses led-max-microamp:
> > > > > tsl2772.yaml
> > > > > 46:  led-max-microamp:
> > > > > 81:                led-max-microamp = <100000>;
> > > > > 
> > > > > I wonder if the same should be done here, or if there should be an leds
> > > > > subnode? Perhaps the IIO folks can comment on that.    
> > > > 
> > > > I don't think we've ever bothered with a subnode as there only tends
> > > > to be one of them.  Given the enabling etc is all hardware controlled
> > > > I'm not sure a more generic LED binding makes sense. I don't know that
> > > > much about the led bindings though so maybe it is worth doing a subnode
> > > > just to use the leds/common.yaml definition of led-max-microamp?    
> > > 
> > > Could always just put a ref in to leds/common.yaml and not bother with a
> > > child node. I'd stick with the additionalProperties: false, since
> > > there's lots of leds properties that probably don't apply to a device
> > > like this.
> > >   
> > Sounds good to me.
> >   
> > > Cheers,
> > > Conor.  
> >   
> A quick heads up, adding a ref produces the following error when running
> dt_binding_check:
> 
> properties:led-max-microamp: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml
> 
> So it looks like we can just put led-max-microamp, and not add the $ref.

Ah. That's a bit irritating as it is assuming the ref is to get the
type rather than to make the connection to the standard definition
of what it is.  Conor, what is the best way around this? 
Maybe a comment to say where it is documented instead of a $ref?

J

