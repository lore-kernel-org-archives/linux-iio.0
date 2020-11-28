Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C681C83A9B
	for <linux-iio@archiver.kernel.org>; Sat, 28 Nov 2020 22:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0A422370
	for <linux-iio@archiver.kernel.org>; Sat, 28 Nov 2020 22:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADzdIi6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgK1VtZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbgK1Sl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:41:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BB4246AB;
        Sat, 28 Nov 2020 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606577707;
        bh=dI+UiI6qYNNByDAsfPe3uvTzxrA2PiQV2r4/yD08zSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ADzdIi6KCnNxc/6/AAeKSF7o8wKC9qOv+zY72kThkRoyTx0oFEGXWdxus+P/k3wLs
         nu7SG+b53ZcqDjX9Sw3WikmNsXm08repoTG7RzAGuQzpkzviGI8Lq7sC/Mk+SCBrmS
         t2mAVL0Xhz7GvchQUGzvzyYBnDwEIe4UHqGRrv9U=
Date:   Sat, 28 Nov 2020 15:35:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings:iio:samsung,exynos-adc: drop missuse of
 io-channel-ranges
Message-ID: <20201128153503.12abb0a8@archlinux>
In-Reply-To: <20201117094911.GA13513@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-3-jic23@kernel.org>
        <20201117094911.GA13513@kozik-lap>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 10:49:11 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sun, Nov 15, 2020 at 07:29:44PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > io-channel-ranges is a property for consumers of io-channels, not
> > providers.  Hence it is not relevant in this binding or the examples
> > given.
> > 
> > Recent changes to dt-schema result int his being reported as an error  
> 
> s/int his/in this/
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Thanks + applied.

Jonathan

> 
> Best regards,
> Krzysztof

