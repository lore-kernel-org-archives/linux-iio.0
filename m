Return-Path: <SRS0=bx8B=SC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA3C43381
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221A1218E2
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014489;
	bh=DMe+IxpvIzTS6byr2ZlLglatCO+evbuYPB7F6daDJbg=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=DAHYyIkYA34IDqtwUdz1pk7FqvH3sXvPGom3wzk6j0RmDt8yML5EGuKK6NwudVfWg
	 ZZPVgXQGP2ybpldmGJOR+n8Ca9IMh44NEh5adV7Y4e8IGl21EN9CXDSP3ASwGOesw0
	 XDJsdIswRu1PK9IMWk6SQneDaCICzjI3YjTmND8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfCaGl1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33826 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfCaGl0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Mar 2019 02:41:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so3173510pgq.1;
        Sat, 30 Mar 2019 23:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=j63nunoHhh8HAW0A0lb4wXYNoSwqxmxBZXYn6pHV3LM=;
        b=QmOBe4Lf3CWVQ3FcjPukk6IjMDbNxmPax9vuUwkTqJczgzEZOPfNYAwWvpOVlXBua2
         B954X3Ed3sm+Ud68Ve19ZwRU2o8WFZvQD0CyoKqUJcTGvCzUAX4S/Axoqzs5KmTVTMaX
         aZPYzuRoDqwTvDb7QB7XCLj0i6zpDhE/PNyiz1hSC4riGbTAU/dss9a7DGVwlRFB5OJ5
         5uNOvVNN20/lvwvpbm1AAg0qZW92EfCCQeYUJ9e19ZdMrLOOfl7ijcZ3en5ZTUTEE7rF
         JcFi5nNsGg58VUExmooEwi40s1UkhC6oDtMzT9izSILM8M3BPQxK6HnSGoIaQn4Qa0Pe
         wiuA==
X-Gm-Message-State: APjAAAWpI+RIQAB4mzJdsa9e2skbXlNqk6jaWtiUhVpoIfe6FyiCbcR0
        WLM5kR3E1zdubPUgJgc1Bg==
X-Google-Smtp-Source: APXvYqwSOumzKdXXT3GdNqNKQueJzdRfUOamOSFDE/iTXFibkn+1K+1CQDUBVCBa0jIbZ6/EfdOWiA==
X-Received: by 2002:aa7:93a5:: with SMTP id x5mr39055044pff.234.1554014485921;
        Sat, 30 Mar 2019 23:41:25 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id l184sm3959669pfc.98.2019.03.30.23.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:25 -0700 (PDT)
Message-ID: <5ca06115.1c69fb81.d5b56.b0de@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:23 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add bindings for TI ADS8344 A/DC chips
References: <20190322111108.19383-1-gregory.clement@bootlin.com> <20190322111108.19383-2-gregory.clement@bootlin.com>
In-Reply-To: <20190322111108.19383-2-gregory.clement@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 12:11:07 +0100, Gregory CLEMENT wrote:
> This adds device tree bindings for the TI ADS8344 A/DC chips.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../bindings/iio/adc/ti-ads8344.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

