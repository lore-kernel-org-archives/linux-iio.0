Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F8C07E96
	for <linux-iio@archiver.kernel.org>; Sun, 11 Jul 2021 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FB2613C3
	for <linux-iio@archiver.kernel.org>; Sun, 11 Jul 2021 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhGKNj6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Jul 2021 09:39:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52942 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhGKNjx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 09:39:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m2Zdi-0007UL-I0; Sun, 11 Jul 2021 15:36:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonathan Cameron <jic23@kernel.org>, Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: rockchip-saradc: add description for rk3568
Date:   Sun, 11 Jul 2021 15:36:57 +0200
Message-ID: <3093085.U7Z2iKR65Z@diego>
In-Reply-To: <20210705012526.3731-1-xxm@rock-chips.com>
References: <20210705012526.3731-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Simon,

Am Montag, 5. Juli 2021, 03:25:26 CEST schrieb Simon Xue:

I think it is customary to provide at least a single line to describe
the change, even if it's essentially the same as the subject ;-)

> Signed-off-by: Simon Xue <xxm@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index 1bb76197787b..e512a14e41b4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -20,6 +20,7 @@ properties:
>                - rockchip,px30-saradc
>                - rockchip,rk3308-saradc
>                - rockchip,rk3328-saradc
> +              - rockchip,rk3568-saradc
>                - rockchip,rv1108-saradc
>            - const: rockchip,rk3399-saradc
>  
> 




