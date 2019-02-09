Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838BC282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB47221919
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549725442;
	bh=6sMz0hH/7axO6Zhq35ioqYszxAUL1dkhbGutkRYEQcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eMZIx/B+6sDu+DeI701gdU/ogcPmr7BcpUvMzTlSdIXjG0f1dMoWHmE9Y8qBlXPCu
	 B+MMNdmn592/D2KNwwOvwb2QxQIxlJOTAvSY3cXWM5ZcqCpc53QPfiebdc4UPLj6Sl
	 RYOnJAaF/tK8l3S5ksXm8nXBeuwqgn7WZHwg48VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIPRW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBIPRW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 10:17:22 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A52218D2;
        Sat,  9 Feb 2019 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549725441;
        bh=6sMz0hH/7axO6Zhq35ioqYszxAUL1dkhbGutkRYEQcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zGlxK8ADyBtIWCniy3jMTXeKYg6kOaeWaU6rPOBrQRjfLpSgPgIDujgCY+qIGjk1A
         AHPAFa2fUXTHckmsBPal/EYkHxUuOzy/7VRrDsykTw+uxn+x290oBcl7Dl2UfiZY2b
         aEtkjBcyk0VIsBYRN9HAtmd7c5RYCX86Xu+Mjs2M=
Date:   Sat, 9 Feb 2019 15:17:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: fix incorrect bmi160 IRQ note
Message-ID: <20190209151715.676fc7df@archlinux>
In-Reply-To: <20190202215601.20275-4-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
        <20190202215601.20275-4-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Feb 2019 13:55:58 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> The bmi160 bindings say that the BMI160 requires level-triggered,
> active-low interrupts, but it actually supports all interrupt types, so fix
> the note to reflect that.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
I'm not sure why you changed the example, but it does no hard.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> index 0c1c105fb503..1aec19997fb5 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -9,7 +9,7 @@ Required properties:
>   - spi-max-frequency : set maximum clock frequency (only for SPI)
> 
>  Optional properties:
> - - interrupts : interrupt mapping for IRQ, must be IRQ_TYPE_LEVEL_LOW
> + - interrupts : interrupt mapping for IRQ
>   - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
>     input, set to "INT2" if INT2 pin should be used instead
> 
> @@ -20,7 +20,7 @@ bmi160@68 {
>  	reg = <0x68>;
> 
>  	interrupt-parent = <&gpio4>;
> -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
>  	interrupt-names = "INT1";
>  };
> 
> --
> 2.11.0
> 

