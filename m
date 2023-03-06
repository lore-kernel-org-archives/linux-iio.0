Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82659C6FD19
	for <linux-iio@archiver.kernel.org>; Mon,  6 Mar 2023 06:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCFGfR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 6 Mar 2023 01:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCFGfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 01:35:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559318ABF
        for <linux-iio@vger.kernel.org>; Sun,  5 Mar 2023 22:34:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x3so33949258edb.10
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2023 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678084481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XgaiCbTSbzNREOGqm3AU2OiBWwYNgFkcLJka35Y+Xg=;
        b=WT+PSIoFH6+ZzkwyHmxjrYf2TrrG5yZT/rXVstcb917pt36YqnLNZev3Cs+YzjI28N
         mpx8vHRVG60asR1c9/gW88MUfh1vtB06c9OKYkiEaRolRfKf9esQIbAKHObB6RQ9Q95n
         R2R+M2A6WIE3tdR5fuLGxKYw/IrbGlHoLCRfk/UGK3sw270nQ4lQ8TU+hossGSWERTx1
         c44B2TTsBdvls31hfAU3f832RDu/RNpsnk0FFK5+ZNQUfXzd4o0TgHCAfYnXRj1CiDF0
         HIOBpEJXGHUt4qUYo6KDNDBAygyRHJidIpxcT1KofPJ0+r4jH7vRPCLaacJcu8xe36FZ
         Bgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678084481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XgaiCbTSbzNREOGqm3AU2OiBWwYNgFkcLJka35Y+Xg=;
        b=FMLYEOrIvE7zB2FGmqgGa76sm2mQ+6aHegMhsfkBx4qZkZFPzb+i2hqG5y6KrSYOCm
         dDKW2BpdLAOZogK/cXjXnie3eo6NcGL+ucXdco1JVrWb41k0I2oY0HVUdLLYAm6yfz5w
         J4lwP/C62fxXRkAgokqNm7/aPgrO12AhSWhQv3O2TILHS0FY/7Jm3WEvKRWokB9NKumI
         KPIsoxuB/yoOtg6rqZpjQvYU0MPc/ABug0PfGZA8LUFA4s/wp6VvptXd5LOfdbEUqYKQ
         qd271RrYVDZ8t5RMgcoIlB3vDb2xXBU4bgF6vwq1JaYcoenNl7b3qxRGVYa17eNWh3Kj
         4WJg==
X-Gm-Message-State: AO0yUKXc+NkLB5tqHFu6j9US/zv+ysISPmUkKnNsJt39vYHeDiDvDp0G
        naA1JifIKqhIQO7gGxECxdlfSg==
X-Google-Smtp-Source: AK7set949dyBwtNSX7Qs623vm+vWJkAx1cFfjcFp8QFdpX7wfYoIIAreKqUlaq1XYRzBt4aJm7lSng==
X-Received: by 2002:a17:907:64c:b0:8ab:a378:5f96 with SMTP id wq12-20020a170907064c00b008aba3785f96mr13707835ejb.3.1678084481080;
        Sun, 05 Mar 2023 22:34:41 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id gw20-20020a170906f15400b008b7a9ff7dfdsm4070436ejb.162.2023.03.05.22.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:34:40 -0800 (PST)
Message-ID: <905c1664-0157-3733-a0f8-c8a7ac1e0761@linaro.org>
Date:   Mon, 6 Mar 2023 07:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter
Content-Language: en-US
To:     Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230305213604.4747-1-andrew.hepp@ahepp.dev>
 <20230305213604.4747-2-andrew.hepp@ahepp.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305213604.4747-2-andrew.hepp@ahepp.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/03/2023 22:36, Andrew Hepp wrote:
> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

