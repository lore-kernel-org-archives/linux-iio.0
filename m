Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1C4C900F;
	Wed,  1 Jul 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930563; cv=none; b=SMOBtf8CVu49D53G7RT4aSbLWNbkWQTDiQCc8bq4Shntzu6N9r3E0bdaeUmikAmHfJe3E3hevVmhmdaBHvLzLR5s3P3q5fmqWU+SDnJpp0KpKCYFZCv/9Za2DXSHd2sKOmXiK/NTrs2VA1Hzq3MgcHVtLhjrjX/I4ctPUzzavuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930563; c=relaxed/simple;
	bh=10AcviweQW51IPRh1jm20Ahl6j/+XlEi4WIy7pQmk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKhGzHhlezWs0k3Cag2NJtQ4p/kr5mKwSNCdHPCQtBtcQfufmOGvn7HBSDQMBsNqHsiFDE4EsGR32mMrEfi5g4o7uvZD43gNKauivHbOXYRBvXDC5rfQtKVqHz9t42VgrENA4qstA64k8iAFRmIELpLJbUn15Ro71Aau6UdyFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlKE8zZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlKE8zZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFE11F000E9;
	Wed,  1 Jul 2026 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930562;
	bh=ZWXuftUjtKRYXAZZSyNmzTbqBic41KIMqHiPTJZUbvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JlKE8zZZUDpylInkTkrkthFs8CCs/JwaHzG1A5scAI8qJFy2jz1UBw/xhULgb5th/
	 LSMF5FHAqI2hT4gt73wLpUSr5BK2s1v7+5mpqV1opKypgC44byz9f5ZCzTRjCsbGVG
	 Hgjz86uPsWpzsnGOwoqLgomjRzuCzkse4acRI6zRcfV/OyfFw4FViTSajxRq2F0B+V
	 SmL6IzvSDMNu5DDEUm/T3kD74XiTZbvsOT2so9MERgR6Q7/swEc9OM3SYx2UTaOwaR
	 l4zAapFjzIwxBQjiuPulSyz/3f14aCBt1bq060rLFENaefEb/TWUvycskEZ0uYyUKe
	 CTp23c7guiL/w==
Date: Wed, 1 Jul 2026 19:29:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: spi: Add spi,device-addr peripheral
 property
Message-ID: <20260701192915.2fca6b06@jic23-huawei>
In-Reply-To: <20260701-immodest-carrot-611d255656b5@spud>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
	<20260701-ad5529r-driver-v5-1-ed087900e642@analog.com>
	<20260701-immodest-carrot-611d255656b5@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 12:04:37 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jul 01, 2026 at 08:40:39AM +0200, Janani Sunil wrote:
> > Some SPI devices support sharing a single chip select across multiple
> > physical chips by encoding a device address in the SPI frame itself.
> > Add a generic spi,device-addr property to document this per-peripheral
> > address. This property belongs in channel or sub-device nodes of
> > peripherals that use this addressing scheme.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 880a9f624566..3774e8018355 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -142,6 +142,11 @@ properties:
> >      minItems: 2
> >      maxItems: 4
> >  
> > +  spi,device-addr:  
> 
> To match other generic spi properties, s/,/-/.
> 
> However, you don't actually use this as a spi peripheral's property in
> your device binding, so you've got your wires crossed here somewhere.

If we are going to make this generic (which I'm not against) I think
it should also work for the case of multiple independent devices.
So it can also be a top level device node spi property.

That kind of makes me wonder if we are better off having it always
in the top level node, but allowing multiple values to represent
sub devices under this.  That would leave figuring out mappings of which
channels are on which device to the driver. The driver must know the
mapping afterall.  For the example something like


#include <dt-bindings/gpio/gpio.h>
spi {
    #address-cells = <1>;
    #size-cells = <0>;
    dac@0 {
        compatible = "adi,ad5529r-16";
        reg = <0>;
        spi-max-frequency = <25000000>;

        spi-device-addreses = <0 3>
...

        #address-cells = <1>;
        #size-cells = <0>;

        channel@0 {
            reg = <0>;
            adi,output-range-microvolt = <0 5000000>;
        };

        channel@16 { #on second device using dev addr 3
            reg = <16>;
            adi,output-range-microvolt = <(-10000000) 10000000>;
        };
        channel@18 { #3rd channel on device using dev addr 3
            reg = <18>;
            adi,output-range-microvolt = <0 40000000>;
        };
    };
};

Where devices are truely independent then you would have separate device
nodes each with one entry in spi-device-addresses

I'm a bit dubious about putting this in the spi namespace though given
it is not part of any standard specification.  Do we have any precedence
for that sort of thing?

Jonathan

> 
> If it's a generic dac channel property (as you use it) it should be in
> dac.yaml (or adc.yaml for the other device that I asked you to add it
> for as proof of being generic), or it is a spi peripheral property and
> needs to go into the dac node itself.
> 
> pw-bot: changes-requested
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Device address used when multiple peripherals share a single chip select.
> > +
> >    st,spi-midi-ns:
> >      deprecated: true
> >      description: |
> > 
> > -- 
> > 2.43.0
> >   

