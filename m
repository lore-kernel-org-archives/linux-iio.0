Return-Path: <SRS0=U73b=EO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47796C4742C
	for <linux-iio@archiver.kernel.org>; Sun,  8 Nov 2020 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB76208B6
	for <linux-iio@archiver.kernel.org>; Sun,  8 Nov 2020 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604853297;
	bh=fgwfsiFENOgIQeuGUpxQJqdzLYSCjbAvdrmOqR1DqfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qscAp/COsfo8RnaY0wavoXZg5gWkfPv9lUOZ3Eb+xyM13ZdskaCNegM5N4Ljzj75V
	 SiwWvAKO+qNTR64rFceS2Q0bJt/IgHqYuYfhaODLMInCt0aLevDMaEo2GiLtWC/FGg
	 quAG6b2Z/MUZWpdxvYSHWU7aSu8qs9spmQVr/big=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKHQe4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 8 Nov 2020 11:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgKHQe4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 11:34:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE7E206ED;
        Sun,  8 Nov 2020 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604853295;
        bh=fgwfsiFENOgIQeuGUpxQJqdzLYSCjbAvdrmOqR1DqfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z0xOs/XDJ+uJVdZ6xt82+nqa9UQ6ZBmB3v/PYl++bHON3rqxaxDYVfGEc7m0fPboy
         MRXZF8WQRDOJh8zmXHAbHonVVPhfNJy8+dhCbxyJV+ntc9jXhZHNJojtJwEPwzDa4f
         pMmjsuygcG5cakXf7HRRiIDO9DeyLMakUhJ6vAI0=
Date:   Sun, 8 Nov 2020 16:34:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml
 conversion
Message-ID: <20201108163451.7946b776@archlinux>
In-Reply-To: <20201103022108.GA674527@bogus>
References: <20201031134110.724233-1-jic23@kernel.org>
        <20201031134110.724233-17-jic23@kernel.org>
        <20201103022108.GA674527@bogus>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 20:21:08 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 01:40:57PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fairly simple conversion with the exception of the XOR between
> > spi-cpha and spi-cpol.
> > 
> > Is there a better way to specify that?
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > ---
> > v2:
> > * Family typo
> > * Put back the reference regulator in example.
> > * Added checking of XOR of spi-cpha and spi-cpol
> >   (dropped Rob Herrings Reviewed-by due to this change)
> >   
> >  .../bindings/iio/dac/ti,dac082s085.yaml       | 79 +++++++++++++++++++
> >  .../bindings/iio/dac/ti-dac082s085.txt        | 34 --------
> >  2 files changed, 79 insertions(+), 34 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> > new file mode 100644
> > index 000000000000..192b314c99d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments DAC082s085 and similar DACs
> > +
> > +description:
> > +  A family of Texas Instruments 8/10/12-bit 2/4-channel DACs
> > +
> > +maintainers:
> > +  - Lukas Wunner <lukas@wunner.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,dac082s085
> > +      - ti,dac102s085
> > +      - ti,dac122s085
> > +      - ti,dac084s085
> > +      - ti,dac104s085
> > +      - ti,dac124s085
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +  spi-cpol:
> > +    description:
> > +      Should be either spi-cpha, or spi-cpol but not both.
> > +
> > +  vref-supply:
> > +    description: Needed to provide output scaling.
> > +
> > +  spi-max-frequency: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: '#/definitions/cpolXORcpha'
> > +
> > +definitions:
> > +  cpolXORcpha:  
> 
> No need for a definition. Just put the below in the allOf entry.

I can't figure out the syntax to do that.
If I put it directly there I get, 

... iio/dac/ti,dac082s085.yaml: allOf:0: 'not' is not one of ['$ref', 'if', 'then', 'else']

The use of $ref was the only way I could find to get around this.
What other option is there?  My Yaml is still largely cut and paste
based so not sure I fully understand the restrictions that are applied.

Thanks,

Jonathan



> 
> > +    not:
> > +      required: [spi-cpha, spi-cpol]
> > +    oneOf:
> > +      - required:
> > +          - spi-cpha
> > +      - required:
> > +          - spi-cpol
> > +
> > +examples:
> > +  - |
> > +    vref_2v5_reg: regulator-vref {
> > +        compatible = "regulator-fixed";
> > +        regulator-name = "2v5";
> > +        regulator-min-microvolt = <2500000>;
> > +        regulator-max-microvolt = <2500000>;
> > +        regulator-always-on;
> > +    };
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            compatible = "ti,dac082s085";
> > +            reg = <0>;
> > +            spi-max-frequency = <40000000>;
> > +            spi-cpol;
> > +            vref-supply = <&vref_2v5_reg>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> > deleted file mode 100644
> > index 9cb0e10df704..000000000000
> > --- a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> > +++ /dev/null
> > @@ -1,34 +0,0 @@
> > -Texas Instruments 8/10/12-bit 2/4-channel DAC driver
> > -
> > -Required properties:
> > - - compatible:		Must be one of:
> > -			"ti,dac082s085"
> > -			"ti,dac102s085"
> > -			"ti,dac122s085"
> > -			"ti,dac084s085"
> > -			"ti,dac104s085"
> > -			"ti,dac124s085"
> > - - reg: 		Chip select number.
> > - - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
> > -			either spi-cpha or spi-cpol (but not both).
> > - - vref-supply: 	Phandle to the external reference voltage supply.
> > -
> > -For other required and optional properties of SPI slave nodes please refer to
> > -../../spi/spi-bus.txt.
> > -
> > -Example:
> > -	vref_2v5_reg: regulator-vref {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "2v5";
> > -		regulator-min-microvolt = <2500000>;
> > -		regulator-max-microvolt = <2500000>;
> > -		regulator-always-on;
> > -	};
> > -
> > -	dac@0 {
> > -		compatible = "ti,dac082s085";
> > -		reg = <0>;
> > -		spi-max-frequency = <40000000>;
> > -		spi-cpol;
> > -		vref-supply = <&vref_2v5_reg>;
> > -	};
> > -- 
> > 2.28.0
> >   

