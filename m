Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47CC11F68
	for <linux-iio@archiver.kernel.org>; Fri,  2 Jul 2021 10:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C166113B
	for <linux-iio@archiver.kernel.org>; Fri,  2 Jul 2021 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhGBKL6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKL6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jul 2021 06:11:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9DC061762;
        Fri,  2 Jul 2021 03:09:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg14so15271141ejb.9;
        Fri, 02 Jul 2021 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mAcZq2qCj7fPqjewfevHu9BVjvRWMa9BAJtXnZItPUk=;
        b=ZX3wiXi2Cp7D30SK7u2b/6N3EQO/PtXDFxT8dCSUPC3l0lyGm7p/lyUMElojTsGK15
         dj5ONaXOjGOUE7MKCWKsTcXjAWs8wc797lJQFVYilN78AD3dnw5Po3uazzKWinOy6Cxz
         pN0W+I4kvPIGreZcJwNhvlzgWBD8cm85c8rvY4KmCLLaNrihCBeWI0+eFOSZZq+QwZOm
         93Q5Aw2j+CBqzk2FOjPnBqL6FYcFGZzvIVZmxlnn47gXxWuFcqyy68XXTy2FwoVz3Njj
         HlJR8bOL+/ybuPB6laBbb/56UKDmOyRyA7MIhxvpSgnSz6jKyh1h61JxqDXYbNNJbb74
         HVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mAcZq2qCj7fPqjewfevHu9BVjvRWMa9BAJtXnZItPUk=;
        b=nuvMlRHGR2X64bvTdwx1eEudwKUNxT6KYoxLs9IxTJ7LszjaJXMvnsD8SHGknQGFdZ
         +VQoQYS7KR6w8igx8KOFs6HIarTp6Z53sgmDq58bPvEedk79bljiFLEbj1/hZiXscO2G
         +FyHnDqIE1jSb6NrEmoAmGHnBTV4GkFJ6qf4wdsGJrsmrrY1R4GWUa8KZxdwIopSnyrS
         KA0R/ZapE7fLonoEEvZQOm69PPS0/1DS3wIwTsDkeuzj04/6iFfly7s/1ZG0XJgI3DQO
         j/O/J9I8d598NzetIhgQMlNlD+KzMUwpMvwvJ5hf2RtLVhbWpeCjTZYYxUrRWhwa08ZI
         pnXA==
X-Gm-Message-State: AOAM5304eAn0I90aB3h18EI/Fg5xZkdwIwq87lv1D+GuLQZSGypUEvp3
        CniCoqyUC/kbQayKlcNcOqD7f7OilrLzOQ==
X-Google-Smtp-Source: ABdhPJxzOOvV1OKjShaxRdv3KbJpaLn65+XpLwJ5OjUumZHsnLoYAn3cZ4phxDeRwx1TT6ziq25HDQ==
X-Received: by 2002:a17:906:3407:: with SMTP id c7mr4524715ejb.212.1625220563752;
        Fri, 02 Jul 2021 03:09:23 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id jx12sm871098ejb.9.2021.07.02.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 03:09:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: rockchip-saradc: add
 description for rk3568
To:     Simon Xue <xxm@rock-chips.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210702021403.146293-1-xxm@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9577a3cf-cd10-0aeb-d699-a23994c2e6e2@gmail.com>
Date:   Fri, 2 Jul 2021 12:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702021403.146293-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Simon,

The file rk3568.dtsi is now available in linux-next.
Could you make a complete package with also a patch for rk3568.dtsi?

Johan

===

rk3568.dtsi:

	saradc: saradc@fe720000 {
		compatible = "rockchip,rk3568-saradc", "rockchip,rk3399-saradc";
		reg = <0x0 0xfe720000 0x0 0x100>;
		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
		clock-names = "saradc", "apb_pclk";
		resets = <&cru SRST_P_SARADC>;
		reset-names = "saradc-apb";
		#io-channel-cells = <1>;
		status = "disabled";
	};


On 7/2/21 4:14 AM, Simon Xue wrote:
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
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
