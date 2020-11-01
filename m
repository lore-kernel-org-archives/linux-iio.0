Return-Path: <SRS0=DicA=EH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46CC2D0A3
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC3922242
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604242648;
	bh=h/d7cMHwelo6QGJjC2f9S+/eMhKZR4ElV0jqb3x2hU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FLq01lk6gzRhxO4vTikprHCGd3GV577Ty+ecJ/9alr0VpFtbSVuOrU2OfmQXEnSkl
	 H9EC9ENTpwCMKW6fELy6tAT2WI06K1Nn0UlJyvvjdNq2pHNozMe1FR/8jJACEEJOs9
	 zMWahYRClcq/u7p8Zm+ZvyCD4TXe+VCiOMtLNHiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKAO51 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Nov 2020 09:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgKAO51 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 09:57:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDBB206DC;
        Sun,  1 Nov 2020 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604242646;
        bh=h/d7cMHwelo6QGJjC2f9S+/eMhKZR4ElV0jqb3x2hU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJx2+f0os0slLh0O5y1jNqsq7w/zxrEsRMOXhDZjG68Z/3wsKTOkBG8WV4cxHlxvj
         LySyuis5GGHhcQzSKRlKNSQQMlXXpnd6OYzoJrHb7AIVErt89PDodKhaqX3uwOdD72
         Jh1rJwxdwXyNHnssOnl5tQsZ2PldNGuxjoja5DuE=
Date:   Sun, 1 Nov 2020 14:57:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 14/46] dt-bindings:iio:light:avago,apds9960: txt to yaml
 conversion
Message-ID: <20201101145717.4da9b448@archlinux>
In-Reply-To: <CAJCx=gmf_PTTGMwY174CZj56JnFmYhBW0CmfXSMp_paR06fhXg@mail.gmail.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-15-jic23@kernel.org>
        <CAJCx=gmwc=a8F5ytYajKbA_QjkVHwJxn4xpeNb==v7AuDGZb-A@mail.gmail.com>
        <CAJCx=gmf_PTTGMwY174CZj56JnFmYhBW0CmfXSMp_paR06fhXg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 14:35:56 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, Oct 31, 2020 at 2:33 PM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > On Sat, Oct 31, 2020 at 11:51 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Very simple binding that we could move into trivial-devices.yaml
> > > with a small loss of documentation.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Matt Ranostay <mranostay@gmail.com>  
> >
> > Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Actually still Acked-by but could you change my email below to my Konsulko one?
Will do.

> 
> Thanks,
> 
> Matt
> 
> > > ---
> > >  .../bindings/iio/light/apds9960.txt           | 21 ---------
> > >  .../bindings/iio/light/avago,apds9960.yaml    | 44 +++++++++++++++++++
> > >  2 files changed, 44 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
> > > deleted file mode 100644
> > > index c53ddb81c4aa..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/light/apds9960.txt
> > > +++ /dev/null
> > > @@ -1,21 +0,0 @@
> > > -* Avago APDS9960 gesture/RGB/ALS/proximity sensor
> > > -
> > > -https://www.avagotech.com/docs/AV02-4191EN
> > > -
> > > -Required properties:
> > > -
> > > -  - compatible: must be "avago,apds9960"
> > > -  - reg: the I2c address of the sensor
> > > -  - interrupts : the sole interrupt generated by the device
> > > -
> > > -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> > > -  node bindings.
> > > -
> > > -Example:
> > > -
> > > -apds9960@39 {
> > > -       compatible = "avago,apds9960";
> > > -       reg = <0x39>;
> > > -       interrupt-parent = <&gpio1>;
> > > -       interrupts = <16 1>;
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> > > new file mode 100644
> > > index 000000000000..eae8c7327c0f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
> > > +
> > > +maintainers:
> > > +  - Matt Ranostay <mranostay@gmail.com>
> > > +
> > > +description: |
> > > +  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: avago,apds9960
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        light-sensor@39 {
> > > +            compatible = "avago,apds9960";
> > > +            reg = <0x39>;
> > > +            interrupt-parent = <&gpio1>;
> > > +            interrupts = <16 1>;
> > > +        };
> > > +    };
> > > +...
> > > --
> > > 2.28.0
> > >  

