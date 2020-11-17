Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0570CC2D0E4
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F5B2168B
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 09:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKQJtP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 04:49:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41656 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQJtP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 04:49:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id 23so22467211wrc.8;
        Tue, 17 Nov 2020 01:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WP8gt1gz+xHiJXIAB6gIFMSD97UgB4y9NAsXrhH2A1k=;
        b=CirXokaBuxz8nYMLISpIX9Zwmjw9AiJTY6dLqvU3+meWCGBho8KEiRmAvaFn9JZ1M7
         28CYzgj+GNvLAya19Mz9CXPo+3r9+6jotUZ6MgD5+6mChR929O7qI902Z9jh6vEq8rwI
         C1GbuPB74XlzvOz7yBAEoOCAzPngE+RgeXAQI9bXBMALGD7yvyrYxtL4N7Jt2MN+CWxp
         OdZ7FFvmOlKjxiZp0qu8wNbq9L5U9/QEVkgB1C7RqWKSQ+i7xG4OKp3o8mcdCzJppYQI
         7BrqkZoZs1lZTuMzPHgU9OLRWW+uwYiSq9keVzGSpNeBe70b0Jm66DDQS4JirJHUWosP
         KxFg==
X-Gm-Message-State: AOAM532BE9ZahGbMXA6Te8rQUvpqxjgtywuQTLiaaGDsRuigxk7oUkDK
        nUJFdXduci8VbukViQpDUIw=
X-Google-Smtp-Source: ABdhPJwQE5i8G/mCBPJ2kPDLTUqOiMCkwJU9yW8yVP7EDL8/Xd+UhdtP0OKPatRiiHWnr7PAzQ2HXw==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr23350825wrw.97.1605606553463;
        Tue, 17 Nov 2020 01:49:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i10sm26889284wrs.22.2020.11.17.01.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 01:49:12 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:49:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings:iio:samsung,exynos-adc: drop missuse of
 io-channel-ranges
Message-ID: <20201117094911.GA13513@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 07:29:44PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> io-channel-ranges is a property for consumers of io-channels, not
> providers.  Hence it is not relevant in this binding or the examples
> given.
> 
> Recent changes to dt-schema result int his being reported as an error

s/int his/in this/

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
