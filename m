Return-Path: <SRS0=70H6=4J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C4C35640
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56799222C4
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582279465;
	bh=gIRnGOsuqmY14jjFPSkmlspi6zf1wl5xnVR/YigaeDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lpMA1Ze/D4jeQHSyOXsl/C6oKcJ7qCAZBuzSs78j23yWWSKMUlCPu/cpI/UC/uKIY
	 +0XEE1Dy7Dg1LlrApWtko1XE7HnwASSY+RENpeMbtM2b7CeNqt4qhGv+sgtUTfV0bq
	 HBRJ16A3nLDKhIgsb/JJY1L211OeN1m7jAdKZko4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBUKEY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbgBUKEY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 05:04:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29F1207FD;
        Fri, 21 Feb 2020 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582279463;
        bh=gIRnGOsuqmY14jjFPSkmlspi6zf1wl5xnVR/YigaeDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWdXrZIPtsnUs//sRLW2Lv2YXcEd/vBPHbnEbeRufppB6CLTw2uOxBWS4YD6sTTOw
         A/xXL+GkXyVXV6czbFchqmcVDHSNFpnU256uw3KrALn/7OHJVigXETggnq0yFKEQwX
         bp4P71PZo1vzPayUhWZh8pG8KEjeoWEPWdlK4FxE=
Date:   Fri, 21 Feb 2020 10:04:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: max1363 etc i2c ADC binding
 conversion
Message-ID: <20200221100419.79900070@archlinux>
In-Reply-To: <20200219221005.GA22158@bogus>
References: <20200208172312.467454-1-jic23@kernel.org>
        <20200219221005.GA22158@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 16:10:05 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Feb 08, 2020 at 05:23:12PM +0000, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Split the binding in two to reflect the threshold monitor capabilities
> > and hence interrupts vs the more straight forward parts that
> > don't have this facility.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../devicetree/bindings/iio/adc/max1363.txt   | 63 ---------------
> >  .../bindings/iio/adc/maxim,max1238.yaml       | 76 +++++++++++++++++++
> >  .../bindings/iio/adc/maxim,max1363.yaml       | 50 ++++++++++++
> >  3 files changed, 126 insertions(+), 63 deletions(-)  
> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max1361,  
> 
> Dangling comma.
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Fixed up and applied.  Thanks Rob

Jonathan

> 
> > +      - maxim,max1362
> > +      - maxim,max1363
> > +      - maxim,max1364  
> 

