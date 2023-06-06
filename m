Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB2C77B7A
	for <linux-iio@archiver.kernel.org>; Tue,  6 Jun 2023 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjFFLSL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjFFLSK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 07:18:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790B9E
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 04:18:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9786c67ec32so99210266b.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Jun 2023 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686050286; x=1688642286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUO2Y7R4sryhFLipqD8QTEW4Squ9pl2T7SF+Sy0Hbbs=;
        b=IS4GBWkdVOksnu+DcLgSF7UJuWFu2/bP3irnW6SvHw0gNQNGIQKIXDeB2HDvx+4pVs
         xOz0vYD8Y2/mzYtIWGLeebFQfwv0JgdTlTays6MEaUYhU5+kmHcwrWNJCGyFqKaruZTF
         +KmfhX8veUV+ylk3tUcZMH39ebPFQFI56Q8MdPEod9wlfpVGL23ew4KgjRnPFGd4SLuE
         MkYulTvVsxmm/rPqwApl0oAXlBi4+BEPZy7rEGS/aHc8YQb6O0f3flgeI4DoW1u03KwJ
         sV9q40rIrgUR/lfU4jczwFyll/YpD3MH1fzTRFfarjjCKMxL03U2oDdZXsrHqv2g6SOD
         824Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050286; x=1688642286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUO2Y7R4sryhFLipqD8QTEW4Squ9pl2T7SF+Sy0Hbbs=;
        b=S+bVIUosyVs2El4MKNe8NaDtdEcBq4q4C2QIeGa+8IeCxr/4fi3UuEA0OOTxPZFQ1A
         xGZJ82za7Vkb9x8rfUhh2qf0DoOn9rak6kh/pCYePNUdsmL/tqJMPzmLNg2QXyfzMFwd
         c1DMq3/mDm/f/H9EkrnsjwRP0bGb+TY6+rtNVQ5ASOP6C+sDej4x7hmHnUKYcP3SwTJX
         EEQwEy4lK92jFX7u6GJSCqBgQhRu51Z3CW5ddzmPIBatJABkiLLMnuw+nuaAvW2p7x2f
         gCuktjCQ+ZShwa510lF/OE8b9ul9T5ZwXRLc+TCcaeBhrvRhf+Y1M564wCEs4/ShIfCz
         Ec/Q==
X-Gm-Message-State: AC+VfDz6wNGV1xNkUNGDuxxt4gb19JUfqiujmOxEIKWVwrj5EkrDLFNf
        HLyXt926I6C/I73cUwSzn+gZT1tPuXkIFvP5S1uh5Q==
X-Google-Smtp-Source: ACHHUZ4lDZd0RSISYwyslBv1IrIlPUzTmBIBeSlbKJLvRvmb1ZB2tAtWNMB8WLORQ6PkhRGDZoHURQ==
X-Received: by 2002:a17:907:2d92:b0:947:335f:5a0d with SMTP id gt18-20020a1709072d9200b00947335f5a0dmr2136295ejc.62.1686050286633;
        Tue, 06 Jun 2023 04:18:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906a09400b009786ae9ed50sm763390ejy.194.2023.06.06.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:18:06 -0700 (PDT)
Message-ID: <e4f78311-18af-71f7-463b-a8f7dfe67bbe@linaro.org>
Date:   Tue, 6 Jun 2023 13:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Spelling
 s/curcuit/circuit/
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/06/2023 12:03, Geert Uytterhoeven wrote:
> Fix a misspelling of "circuit".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

