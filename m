Return-Path: <SRS0=THUK=QG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882A1C282D7
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892920989
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867446;
	bh=TsHgd3TEZ/zzpYsndZkkMYr1fE6Cv46ECBjhH7sK6AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MuS0bYSkyn0K3RJnLu+DSvxc9zdFe0+MkhwVAy2QfKcYHcmhKEH5ufSY+UbMjOm3X
	 i5j73UdQQqUV+pig3t0pZzUYN+A/F/M6pL4AX/5u+XmVcH/btFMacvLxwFotA/wRb/
	 JOPgMjdy5wwclvYte4399mdLVMW6/upX/l3+EvqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfA3Q50 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:57:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44764 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbfA3Q5Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2019 11:57:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id g16so161664otg.11;
        Wed, 30 Jan 2019 08:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJZ1vSHvK02QZmdly0RfVEdlMBUUJlucgNbtDzmdGyk=;
        b=cmv7J9ilLAzR0hcrIGsIhrSlusJcb488yta4+tiU5G48n/AkXXrvvBwz/238RzYTtI
         bqQZo6hVffdzkmcIgjqmvPE+yJA8wj2LCrFcAFX4F4kMwxnI0gUD3ZkeFOH1cvp2rnkG
         LoJsMz7rq8rPT4x6wX/sJtknc0QWZaJiFKAOCRLSmJCg9HsrjVLCnTX+a+9r/ulNVsn5
         9wiovq0uqYdCRnHTkYsdmVMr/brEof3SWvURDJOSFt6weBFxVUaMglcfPqt+/NEu+Vzb
         BmrRlXGlTp8TVPfmWhbbsHKAnzfta5KfLdvwtjLo/L6QbPEXnCKcdfCs8dfAB2weYzBN
         1aIA==
X-Gm-Message-State: AJcUukesiZbtG4SEOfPREqWgEGZYIMSIfhTX7p3BawUugjt8dds+lqKc
        HqePWVFz+YlHgMifL5UpjA==
X-Google-Smtp-Source: ALg8bN5vKvK1h3fHsuzUlx127JFbmPaidDRtyIU4+Qh36/VQ8+pngvmJIlJNA0Qxyhl0hYgnCHUzmQ==
X-Received: by 2002:a9d:1b0b:: with SMTP id l11mr24641566otl.162.1548867444993;
        Wed, 30 Jan 2019 08:57:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k130sm845866oia.47.2019.01.30.08.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:57:24 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:57:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: document open-drain property
Message-ID: <20190130165723.GA22934@bogus>
References: <20190127203911.8696-1-martin@martingkelly.com>
 <20190127203911.8696-5-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127203911.8696-5-martin@martingkelly.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 27, 2019 at 12:39:09PM -0800, Martin Kelly wrote:
> From: Martin Kelly <martin@martingkelly.com>
> 
> We have added an optional boolean property for configuring a BMI160
> interrupt pin as open-drain, as opposed to the default push-pull, so
> document this.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> index 1aec19997fb5..7eb4b6016404 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - interrupts : interrupt mapping for IRQ
>   - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
>     input, set to "INT2" if INT2 pin should be used instead
> +- bmi160,open-drain : set if the specified interrupt pin should be configured as
> +  open drain. If not set, defaults to push-pull.

Use 'drive-open-drain' like others.

>  
>  Examples:
>  
> -- 
> 2.11.0
> 
