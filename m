Return-Path: <SRS0=jlvN=CY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6271C43461
	for <linux-iio@archiver.kernel.org>; Tue, 15 Sep 2020 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C7220756
	for <linux-iio@archiver.kernel.org>; Tue, 15 Sep 2020 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600196486;
	bh=GGkO9sEkvrRKDFYe6DZYwSuRT9xCDLguFgk/HeRQ6uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LjUw5K6fjrZM+KirAqYfide/ZkWXaccULai6NKKuu3Lrx+DhEk/mOGU/u7pNV7vD1
	 wE+B0eX7Kp7MH7FuTFzfb/izUl1L1fVHoTEzULLeKW+3KBXW/rOdxUey0dsF5+OQWC
	 hrSpiEJ2r48hlML1L/htcT/o8PM0XUdf9gHApb3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIOTAd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:00:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35153 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgIOTAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:00:22 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so5344323ioa.2;
        Tue, 15 Sep 2020 12:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwoaUlq5NpEGvhJdzwFyRJKq3+Cx8o1N40O4sESvSfs=;
        b=VMkP7EUUuehoOngAxS3sK9HCrapgM5bvnF55MNBg8tLTgTCqdWDP1jwN1q5/gJCVcw
         2QZ/kCtCqQXr0Jeaxr//Hc7PZl7hkD3JVdI4gBys/UvIFUkEQvrkDH+d30fvIb92w6Te
         s014WVeg9qe111gZQz+vT6kbXVZO6p0+KkFSuNFZlIIs4Kp7zjD2S2rMZ7ycQ08ZFejT
         ByPnPmXKR5ZY5fg3QgV2U2lenYSbg/fuLdZnpPAnYHQjkJcYrt5vyLl7ECyZWiTxprbC
         ZcJwTc2nMjyvJxb0l2PPjWM0Qd6nwPJEiIBjV56F1G60ajwZqFayvfAzL0LRfcPhqYur
         WRkg==
X-Gm-Message-State: AOAM532fnRrMVmnbL48M2rHjYUUSZHUJREZMDcPmKoXB8PoLX8Fa3dRN
        HOW/RATbAp3BDaRa7ic6pg==
X-Google-Smtp-Source: ABdhPJx9hRnwyKNaVO8i3jU86RCRrRRV80SoSLjaI0RCLdJazgu5srQFmm2mu98FUim5XSBDArR8KQ==
X-Received: by 2002:a6b:197:: with SMTP id 145mr16158129iob.100.1600196421633;
        Tue, 15 Sep 2020 12:00:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w22sm7986353iob.32.2020.09.15.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:00:21 -0700 (PDT)
Received: (nullmailer pid 2311911 invoked by uid 1000);
        Tue, 15 Sep 2020 19:00:18 -0000
Date:   Tue, 15 Sep 2020 13:00:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fugang Duan <B38611@freescale.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to
 yaml.
Message-ID: <20200915190018.GA2311858@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:27 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A simple conversion of this freescale ADC binding from txt to yaml.
> For maintainer I went with Fugang Duan as the original author of the
> binding. Would be great to have confirmation of this.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fugang Duan <B38611@freescale.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
>  2 files changed, 81 insertions(+), 36 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
