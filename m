Return-Path: <SRS0=DicA=EH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9EC2D0A3
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9692207BB
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604262862;
	bh=k1ujb9TTRSq3eHi1mqoeHafffTuIGP+Ipn1HYEKtC2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FhUlocTcIe9wR2tamgtI8kolgfVhZJ9iMk6yE0VNzyJW0IeyDJ9OEDmUkqX2lKIKn
	 Eicd6iBbOvlKINHKCOR2pAyVaTXu592g0qW1p3RUbbzdhDFp6gw0liDZ5V9s+93tNo
	 sUiPCvDToWmZz0KspIo+dlMKdlukzS8etqgJVyWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgKAUeW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Nov 2020 15:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAUeW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:34:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0702074B;
        Sun,  1 Nov 2020 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604262861;
        bh=k1ujb9TTRSq3eHi1mqoeHafffTuIGP+Ipn1HYEKtC2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0e7EQnPd9B3a1da7lGeVub6Vm+jxvlAqox8zf+8p74zksByQ3ePDl1kHYoAM0iSNr
         OxwRJsgYQGRh+qb6Jer7x+uxrhs/P4KXEwNzP1Dk586bBJaG0vbdernqSibaGtpcs6
         8Mw/M2hcmp8v2gcp+hpVKZr4gE05aYd6f/HGK0OY=
Date:   Sun, 1 Nov 2020 20:34:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings:iio:chemical:bosch,bme180: Move to
 trivial devices
Message-ID: <20201101203417.6d45042b@archlinux>
In-Reply-To: <CADks246mRP+4bDYc_5qUHuSPYbW=BL+h_bu5qVKcX1akNjDcBA@mail.gmail.com>
References: <20201031182922.743153-1-jic23@kernel.org>
        <20201031182922.743153-3-jic23@kernel.org>
        <CADks246mRP+4bDYc_5qUHuSPYbW=BL+h_bu5qVKcX1akNjDcBA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Nov 2020 14:54:59 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Nov 1, 2020, 12:01 AM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Very simple binding so no need to maintain a separate file.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> > Cc: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/chemical/bme680.txt       | 11 -----------
> >  .../devicetree/bindings/trivial-devices.yaml          |  2 ++
> >  2 files changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> > b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> > deleted file mode 100644
> > index 7f3827cfb2ff..000000000000
> > --- a/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > -Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
> > -
> > -Required properties:
> > -- compatible: must be "bosch,bme680"
> > -
> > -Example:
> > -
> > -bme680@76 {
> > -          compatible = "bosch,bme680";
> > -          reg = <0x76>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> > b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 642502761106..10f0afd44684 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -44,6 +44,8 @@ properties:
> >            - atmel,atsha204a
> >              # i2c h/w elliptic curve crypto module
> >            - atmel,atecc508a
> > +            # Bosch Sensortec preassure, temperature, humididty and VOC
> > sensor
> > +          - bosch,bme680
> >  
> 
> Typo here and in subject line.
> 
> Otherwise, Ack!

Yikes.  I really should have proof read this one more carefully!

> 
> 
> -Himanshu
> 
>              # CM32181: Ambient Light Sensor
> >            - capella,cm32181
> >              # CM3232: Ambient Light Sensor
> > --
> > 2.28.0
> >
> >  

