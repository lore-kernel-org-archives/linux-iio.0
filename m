Return-Path: <SRS0=KK58=WZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4CEC3A59F
	for <linux-iio@archiver.kernel.org>; Thu, 29 Aug 2019 23:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE02173E
	for <linux-iio@archiver.kernel.org>; Thu, 29 Aug 2019 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567119730;
	bh=Rc73ImGJrZbQ8p4FYVqb9kmi6juKORAbcOOb538mMYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JuSH3zEtDU9dQ38EsJznBnM+h6aYAhrnxBaNK+QWRKLHBtwhqXzXPtnE/hXhCUVnw
	 8yKRrGkIHSzUITJwywVisICpieFexOkZR3wSS/BwPmmXcW4mJoq1Li3wehZnhXJmwa
	 oGR0FMYRas7l+Wog59t/mmO3WKEQ0X1woJmjIy0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH2XCJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:02:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43146 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH2XCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 19:02:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so3897850oih.10;
        Thu, 29 Aug 2019 16:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+wLX63KmQQGA6eNHlBHxnMiFYhXz6CWHU+XfuDAmR1A=;
        b=O9XHpOVBo5l497ROZSc+5uBd1V8dld/YUasucEIhA6a41EP3qQpDtecjXh8MFDy6JR
         A4WQpmU7MQqajlEdzHFASsp0pxU/K3nJi+nK7aRyLTJGOjfAkEnu/9vYKKC/c6dFwgTi
         cRc9OACcKra/ZFk0WmYd3Qn5AUH5slO9iM8dbLh0evVXBn+Eld7hFKapTcBIHRXlI/5c
         hyyuwj60iyhp5l+IaLiz9aK0ZTtsh/EgTAOgEjJDwj4RJbzPwSBKM2l2cbJDuMwGcvZG
         d8jJCYslIrf/VRf2+nbmrpz47lje29kwVab6GH1GqvQxvD/Qv9hud0Vay5QypU5e1RjI
         tMCg==
X-Gm-Message-State: APjAAAUlYkA+UCOMKABivDHxG5DWEISvpx1ygiNzjgwPD6BFbkjD41sM
        4TMqmZs1+hT6L4C4S8+HUg==
X-Google-Smtp-Source: APXvYqzenukKjnA9OruFceNb810CAvl5PuQeAnN2PYUcx5TQNwpfz8W98rZCHbW/adolsZajKegCzQ==
X-Received: by 2002:aca:1a02:: with SMTP id a2mr7820165oia.32.1567119728376;
        Thu, 29 Aug 2019 16:02:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm1031496oid.26.2019.08.29.16.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:02:07 -0700 (PDT)
Date:   Thu, 29 Aug 2019 18:02:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Phil Reid <preid@electromag.com.au>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
Message-ID: <20190829230207.GA22979@bogus>
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
 <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 28, 2019 at 08:09:19AM +0200, Michal Simek wrote:
> On 27. 08. 19 5:35, Phil Reid wrote:
> > This optional property defines a symbolic name for the device.
> > 
> > Signed-off-by: Phil Reid <preid@electromag.com.au>
> > ---
> >  Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > index 68d6f8ce063b..ffeae5aad8b5 100644
> > --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -18,12 +18,17 @@ Required properties:
> >  		   with a single IIO output and 1 for nodes with multiple
> >  		   IIO outputs.
> >  
> > +Optional properties:
> > +label:		   A symbolic name for the device.
> > +
> > +
> >  Example for a simple configuration with no trigger:
> >  
> >  	adc: voltage-sensor@35 {
> >  		compatible = "maxim,max1139";
> >  		reg = <0x35>;
> >  		#io-channel-cells = <1>;
> > +		label = "adc_voltage_sensor";
> >  	};
> >  
> >  Example for a configuration with trigger:
> > 
> 
> Just for the record. This patch has been created based on initial
> discussion about label property. And Rob had not problem with using
> label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213

I didn't, but based on the name here I'm less convinced. 'label' is 
supposed to be for needing to distinguish between more than 1 of 
something. A name like 'adc_voltage_sensor' doesn't really.

Rob
