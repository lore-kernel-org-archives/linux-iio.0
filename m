Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B8C388F9
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D0A2071A
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604149653;
	bh=fFSw5wPkEHT+UNxvkfE23WDeQ639ymYvQTmi7IF6UZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rT0F8U5Eoh6SA2fR9OVJexTthyxTgptXb93M+jMGVaBcLsBoE/fjraufkNwh7EUBu
	 xEBs5ut1mAFwBeOAnP5sWT2UPwidlyA3fECbbr5beMSCtW28o/nGjm6eH2nbgvhiwA
	 f1hXfQzE8Vvy2ZtpIUFGXZSxX2YR1meRWTO9o9n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgJaNHd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgJaNHd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:07:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC432068D;
        Sat, 31 Oct 2020 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604149652;
        bh=fFSw5wPkEHT+UNxvkfE23WDeQ639ymYvQTmi7IF6UZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6t707qrX5f3Lb8pP32Lda5eJTZYsOIM1hdzQW9TBvmsfKlMes1tYli1sgzT26cH4
         JsmgxIZSQIrFVRB7s09dWUS+ZTyITPD+ptHWunUDplYEw9A+Etx2uN0QpuxLzzRGua
         9aICbE2BsD2qaupIIlEQSqM5KO8QthGvLa6y6rdQ=
Date:   Sat, 31 Oct 2020 13:07:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20201031130728.3670af74@archlinux>
In-Reply-To: <20201029155025.0f3ce545@archlinux>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-17-jic23@kernel.org>
        <20201028203140.GA24407@wunner.de>
        <20201029155025.0f3ce545@archlinux>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Oct 2020 15:50:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 28 Oct 2020 21:31:40 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > On Sun, Oct 11, 2020 at 06:07:36PM +0100, Jonathan Cameron wrote:  
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> > > @@ -0,0 +1,58 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Texas Instruments DAC082s085 and similar DACs
> > > +
> > > +description:
> > > +  A familly of Texas Instruments 8/10/12-bit 2/4-channel DACs    
> >            ^^
> > s/familly/family
> > 
> >   
> > > +  spi-cpha: true
> > > +  spi-cpol:
> > > +    description:
> > > +      Should be either spi-cpha, or spi-cpol but not both.
> > > +
> > > +  vref-supply: true    
> > [...]  
> > > +required:
> > > +  - compatible
> > > +  - reg    
> > 
> > "vref-supply" and ("spi-cpha" xor "spi-cpol") are also requird
> > per the existing txt file.  
> 
> I have no idea how to specify the spi-cpha xor spi-cpol unfortunately.
> Have a question out to Rob on that one.

I tracked down an xor example in another yaml repo that seems to work
(it's convoluted to put it lightly!) so I'll put that in the next
version but will drop Rob's reviewed-by on the basis it's a substantial
change.

Jonathan

> 
> vref-supply was a stupid mistake from me. Will fix.
> 
> > 
> >   
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        dac@0 {
> > > +            compatible = "ti,dac082s085";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <40000000>;
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            vref-supply = <&vref_2v5_reg>;
> > > +        };
> > > +    };    
> > 
> > Hm, why wasn't the "vref_2v5_reg" node carried over from the txt file?  
> 
> Showing how to supply a regulator isn't generally necessary in an example.
> I don't mind having it there though so can keep it
> (as the fixed regulator binding has been converted to yaml)
> 
> > 
> > Thanks,
> > 
> > Lukas  
> 

