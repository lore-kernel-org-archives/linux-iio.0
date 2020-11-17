Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB46C63777
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2961224654
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 19:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgKQTqi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:46:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40258 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgKQTqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 14:46:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id d18so10854694edt.7;
        Tue, 17 Nov 2020 11:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3qkImQQ4v6dRfmLt57rzAAbkrboh3QhEXuntQsYlco=;
        b=ol9g/25hToVHcbfk5oMs95OGCTh+uhMV6WfNMzKKTRix37WLG/GO7HJKyuAb5vnaVO
         bYItTMSmiFS1wotmNDW7WFhNfrOCQ5BTAj7jW3uEr0U1GBoJv+7OBI7YyGZEtWvga1GU
         qNz3+gqPxuJlgEs01+srwlQtoxvKtfX/CVc7ftWnL2PbUjJVsckN24D0RO50Jyu7hsQf
         KU1QGW+f7Dd0aTL5BOkHs2A5cCh9QfcfjtvEeOkMWEq9vx/WyB7IB0pu2GdqrufyJLsH
         x7xnxmsPiju9T2rEwaOYfM9i+bgain44XR5LpEyXtmWPBoX7ajlGNsZzqDwZirB5rwY5
         eEug==
X-Gm-Message-State: AOAM530i49cP0w37ZAvlGrD/90ynUkhMcUXGxwEbM6bTyt74huDM53/r
        tQjilSUXx/nSrGkRovq4uqJ7fzOHF0g=
X-Google-Smtp-Source: ABdhPJyZWmZHHIFy6YsZ0ivmzju7tjVytRt7GcX3BEn43f3r2xhMIBPyNv0tbKSFK9qAlUNC8CCUIA==
X-Received: by 2002:a05:6402:755:: with SMTP id p21mr22958332edy.349.1605642395972;
        Tue, 17 Nov 2020 11:46:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n11sm12405306eds.3.2020.11.17.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:46:34 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:46:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/9] ARM: dts: s5pv210: Drop incorrect use of
 io-channel-ranges property.
Message-ID: <20201117194633.GB108045@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-6-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 07:29:47PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property is relevant to consumers of io-channels.  Here it is
> used by a provider.
> 
> dt_schema will now report and error as this property must be in the
> same node as io-channels and it is not here.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

