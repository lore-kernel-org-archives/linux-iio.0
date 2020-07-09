Return-Path: <SRS0=yR2k=AU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E2CC433E1
	for <linux-iio@archiver.kernel.org>; Thu,  9 Jul 2020 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D43620720
	for <linux-iio@archiver.kernel.org>; Thu,  9 Jul 2020 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594326264;
	bh=NWcNnuEMcdDMdpN5axl2F6IusAZCnE+AUvvqd3O79Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Anvvc9d+YSjcqFkUknAz4ekG1OGdtrDNSFjrYO+tJ7IayFxOHugKKoTZtY6cWqWQw
	 sUYLyLJjKFj99uH0mO50REB/h+a7WA9pD6gTQfXIGh1MQsQFnLBME95LBW0bhKD2kq
	 6PbpIvI+8VJ9VvGr0Irs+2W/YE4+8LxMHRbqfrgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIUYT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:24:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42638 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGIUYT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 16:24:19 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so3698432ioi.9;
        Thu, 09 Jul 2020 13:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsMMskfuL8YLAB/ta/FhggA+7jwoyr4hz2hZvxONSVQ=;
        b=OO7GMNoMJcyZVVynx6W0gqyGub1U88vh/WlTvbSUla91SGjCMnafIBo3NGRtqLwxrM
         YLCqKoiKVSTDpdPgXGPeYhpRxvIuD0UQlueG7V3gqFOJ6Pe1ww8pBF9Bb3Huym2l2ofj
         KrnH5EOYAMIFeYqEC+A9lixDdkBLbC91bQvWr9vfevLeWDR9U/oPjI31RRs/ctDHrsd0
         CTja/Y7+vrMJI6XXNQTVPx0iEFsD+1wjcu9dfFnlY14WbtrTBMcAkhjRSVyPLH3j3+FY
         jgbbT42L8RKy3lvxq7FrkbTBf9wfkDmnFC9i2CArVgrMC4I2v2UW4SoGM/obxvE9kqTf
         hDgA==
X-Gm-Message-State: AOAM533BsX4KZjZlFVPRIxaZS/7gnsNUD+qW1Vi6uMSrDzrzHAIrpExI
        DlNx4V2oWXtq3G00hOV5Iw==
X-Google-Smtp-Source: ABdhPJzsq5z5PbWT/UTr3AHL0+bRZdSdJGUaQYfAtt+09PtW/Oni9RMQ450wiSxJX3NcqyOiXqXDMw==
X-Received: by 2002:a6b:3ec6:: with SMTP id l189mr44176779ioa.32.1594326258182;
        Thu, 09 Jul 2020 13:24:18 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id y12sm2391718ilm.38.2020.07.09.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:24:17 -0700 (PDT)
Received: (nullmailer pid 828053 invoked by uid 1000);
        Thu, 09 Jul 2020 20:24:16 -0000
Date:   Thu, 9 Jul 2020 14:24:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 5/6] dt-bindings: iio/adc: Add touchscreen idx for
 JZ47xx SoC ADC
Message-ID: <20200709202416.GA827998@bogus>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
 <20200709152200.10039-6-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709152200.10039-6-contact@artur-rojek.eu>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 09 Jul 2020 17:21:59 +0200, Artur Rojek wrote:
> Introduce support for touchscreen channels found in JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
>  Changes:
> 
>  v2-v7: no change
> 
>  v8: add XN/YN and XD/YD channels
> 
>  include/dt-bindings/iio/adc/ingenic,adc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
