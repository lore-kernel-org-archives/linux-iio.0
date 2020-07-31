Return-Path: <SRS0=nmJT=BK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FEFC433E0
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 22:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67BA22B3F
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596235532;
	bh=ysIL8CUpCBDEcaRveclFzGcR6igVFzVoCMxu88QAHOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1ZRLi4Q7KnacpOtS1sqZ/hDR1Z6kDyzlpekxlplvWkqbodo1LBiJWBtpOMcICLhM
	 xhBakxcAiquHU4tl2yd9LjuZpID4D2CCLNbl9mCPm+C3DK8LfUOlbrJZyYRENdHYex
	 DW27fsfrtGW/g4CN76svIrAVJZnO4Lw15BDMmt3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGaWpb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:45:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41011 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWpb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 18:45:31 -0400
Received: by mail-il1-f195.google.com with SMTP id c16so14822603ils.8;
        Fri, 31 Jul 2020 15:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/62+2LrfLQT0Wio5oXnhSxrSTyxUtQDFhcFeyCSFH40=;
        b=GuhEaSjG2XWe8mmNKmQbnQHJU4b809tTf44rSPGDh6sciUyOSV15mX747/nDNiCiMX
         0K/Y8F+FuJuTWyT8wM8LVYvJo0mnb/pLtkYi9C3AJ8DEorN9LZwKHEO5oDULuRCdjDk9
         JxjD+tVLPn1SloZVRNA0DcyhLI7vFVTzXaZWNYip7w0cYUsrtoUKV3s53KjF2pyPclZf
         68XD+utaspqa/t5P3iw2t3NaQz5Qfk/TKa3VJvhlmXqkXXqAZ8iFAnseLjylPmUKF8hR
         4zWVFJ7vNYPeW2JqlN6o9RpL5SaNvp9VAD8XU3H1xLCQHR6LKCNgKBS98UFirvWH9bZS
         gFmQ==
X-Gm-Message-State: AOAM532FGr4a+hBWD+zWs47FUHWNm5vjtiNmP7Za6ujputvcnIDqNQiQ
        lrbW86G8afA1Zmw0E/7+mg==
X-Google-Smtp-Source: ABdhPJyGt4spjmmlW5dZt6Xs0uA12XMhIH7TYUjvbsB8G838qR7JMflgBvbuKMrex0JCOgSulkV4Dg==
X-Received: by 2002:a92:cb0a:: with SMTP id s10mr6019719ilo.22.1596235530489;
        Fri, 31 Jul 2020 15:45:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v4sm5578867ilo.44.2020.07.31.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:45:29 -0700 (PDT)
Received: (nullmailer pid 947335 invoked by uid 1000);
        Fri, 31 Jul 2020 22:45:29 -0000
Date:   Fri, 31 Jul 2020 16:45:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add AMS AS73211 support
Message-ID: <20200731224529.GA947274@bogus>
References: <20200731070114.40471-1-ceggers@arri.de>
 <20200731070114.40471-2-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731070114.40471-2-ceggers@arri.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 09:01:13 +0200, Christian Eggers wrote:
> Add DT bindings for AMS AS73211 XYZ True Color Sensor.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  .../bindings/iio/light/ams,as73211.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
