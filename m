Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50452 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeERNAs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 09:00:48 -0400
References: <cover.1524432236.git.davidjulianveenstra@gmail.com> <0aa68c6684c2b45dd0af398c166d6b36c18be1af.1524432236.git.davidjulianveenstra@gmail.com> <20180427144820.jfvypgk6tfp2syty@rob-hp-laptop> <20180428162758.2a49130c@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/9] staging: iio: ad2s1200: Add documentation for device tree binding
In-reply-to: <20180428162758.2a49130c@archlinux>
Date: Fri, 18 May 2018 15:00:44 +0200
Message-ID: <874lj5ce4j.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28, April 2018 15:27, Jonathan Cameron wrote:

> On Fri, 27 Apr 2018 09:48:20 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Mon, Apr 23, 2018 at 12:03:47AM +0200, David Veenstra wrote:
>> > Add documentation for the added device tree bindings.
>> > 
>> > Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
>> > ---
>> > Changes in v3:
>> >  - Documentation is added to Documentation/devicetree/bindings/iio/resolver
>> >    instead of staging directory.
>> >  - Add mention to ad2s1205 device.
>> > 
>> >  .../devicetree/bindings/iio/resolver/ad2s1200.txt        | 16 ++++++++++++++++
>> >  1 file changed, 16 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
>> > 
>> > diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
>> > new file mode 100644
>> > index 000000000000..46b51db38368
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
>> > @@ -0,0 +1,16 @@
>> > +Analog Devices AD2S1200 and AD2S1205 Resolver-to-Digital Converter
>> > +
>> > +Required properties:
>> > + - compatible : should be "adi,ad2s1200" or "adi,ad2s1205"
>> > + - reg : the SPI chip select number of the device
>> > + - sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
>> > + - rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200  
>> 
>> Are these gpios something that would be common to resolvers (whatever 
>> that is) or specific to this chip. For the latter, you need vendor 
>> prefixes.
>
> They are pretty chip specific I think, so prefixes needed.
>
> I'd not really registered that gpios should be vendor prefixed for some reason
> (kind of obvious now you mention it).  We have only a few from a quick grep
> of the bindings for IIO devices (there are loads elsewhere that aren't and
> are clearly very much part specific).  Ah well, will try and do better moving
> forward on this!

The vendor prefixes are new to me. I'll add it in the next version.

Best regards,
David Veenstra

>
> Jonathan
>
>
>> 
>> > +
>> > +Example:
>> > +
>> > +	resolver {  
>> 
>> Missing unit address.
>> 
>> > +		compatible = "adi,ad2s1200";
>> > +		reg = <4>;
>> > +		sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
>> > +		rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
>> > +	};
>> > -- 
>> > 2.16.2
>> >   

