Return-Path: <SRS0=PMvU=DT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DAC433DF
	for <linux-iio@archiver.kernel.org>; Mon, 12 Oct 2020 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997B220776
	for <linux-iio@archiver.kernel.org>; Mon, 12 Oct 2020 14:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgJLObJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 12 Oct 2020 10:31:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2971 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgJLObJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 10:31:09 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 177F58375D39B8E17966;
        Mon, 12 Oct 2020 15:31:08 +0100 (IST)
Received: from localhost (10.52.126.145) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 15:31:07 +0100
Date:   Mon, 12 Oct 2020 15:29:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Harald Geyer <harald@ccbib.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 04/29] dt-bindings:iio:humidity:dht11 yaml conversion
Message-ID: <20201012142921.00007a4d@Huawei.com>
In-Reply-To: <20e7bc0e3f7e55587e431ad97dcca4b5@ccbib.org>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-5-jic23@kernel.org>
        <20e7bc0e3f7e55587e431ad97dcca4b5@ccbib.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.145]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 18:52:48 +0100
Harald Geyer <harald@ccbib.org> wrote:

> On 11.10.2020 18:07, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The conversion is straight forward, but leaves an open question.
> > The compatible for this device has never had a vendor. I suspect
> > this because it is non-obvious who actually makes the module. It is
> > resold by numerous vendors and it may be that there is no single 
> > vendor
> > of the parts they are using.  If anyone has any more info on the
> > vendor, please let me know and we can add a more informative
> > compatible.  
> 
> I think these parts come from Aosong: http://www.aosong.com/en/
> 
> The DHT11 uses a custom protocol, so I don't think other vendors
> would be using this. Even Aosong started using i2c by now.
> 
> On the other hand DHT11 seems to be more of a trade name then a
> part identifier. The latter probably would be something like
> aosong,am2302 (trade name DHT22).
> 
> However the matching between identifiers and trade names is
> confusing for the older products. I'm not sure if it is worth
> digging into this. Probably only the people at aosong could
> clear this up.

Probably worth adding a note to the binding doc so I'll do that
whilst applying or for a v2 if needed.  Thanks for the info!

> 
> Anyway, you have my:
> Acked-By: Harald Geyer <harald@ccbib.org>
> 
> Thanks,
> Harald
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Harald Geyer <harald@ccbib.org>
> > ---
> >  .../bindings/iio/humidity/dht11.txt           | 14 -------
> >  .../bindings/iio/humidity/dht11.yaml          | 41 
> > +++++++++++++++++++
> >  2 files changed, 41 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> > b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> > deleted file mode 100644
> > index ecc24c199fd6..000000000000
> > --- a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -* DHT11 humidity/temperature sensor (and compatibles like DHT22)
> > -
> > -Required properties:
> > -  - compatible: Should be "dht11"
> > -  - gpios: Should specify the GPIO connected to the sensor's data
> > -    line, see "gpios property" in
> > -    Documentation/devicetree/bindings/gpio/gpio.txt.
> > -
> > -Example:
> > -
> > -humidity_sensor {
> > -	compatible = "dht11";
> > -	gpios = <&gpio0 6 0>;
> > -}
> > diff --git
> > a/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> > b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> > new file mode 100644
> > index 000000000000..38ec4c302760
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/humidity/dht11.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DHT11 humidity + temperature sensor
> > +
> > +maintainers:
> > +  - Harald Geyer <harald@ccbib.org>
> > +
> > +description: |
> > +   A simple and low cost module providing a non standard single GPIO 
> > based
> > +   interface.  Whilst commonly available it is not easy to establish
> > if there
> > +   is a single manufacturer for this part.
> > +
> > +properties:
> > +  compatible:
> > +    const: dht11
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpios:
> > +    maxItems: 1
> > +    description:
> > +      Single, interrupt capable, GPIO used to communicate with the 
> > device.
> > +
> > +required:
> > +  - compatible
> > +  - gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    humidity_sensor {
> > +        compatible = "dht11";
> > +        gpios = <&gpio0 6 0>;
> > +    };
> > +...  
> 


