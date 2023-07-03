Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832FC001B0
	for <linux-iio@archiver.kernel.org>; Mon,  3 Jul 2023 16:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCQSe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 3 Jul 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjGCQSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2023 12:18:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847BE42
        for <linux-iio@vger.kernel.org>; Mon,  3 Jul 2023 09:18:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so5873635a12.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jul 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688401110; x=1690993110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Undn9q3Iza4d1j1OfuGt9fYLyawc34JKl91GRe7lFM=;
        b=K+Ak5V3DRYOc+tLZwILEOOrDY+6YV45Xw/faa97BlLdWG3LvyR6c4Tpmz9dL9loJ0X
         oXVutl2+tLOAG4kibqG3vNoeM3TnfSjxNspIA5C31XVYqFKG4IId+JVW02f+vktATWuV
         cM02DzoyZ0KlkBbPqz8Ms8SZnx0I1f+9ljDT18+eG6d1TmRVudGV4dOsy+Y/V0ziad75
         2x/UnroNh4BuDdDMaYZ3amPCx1BIwryQSw7fTyK06sx8tvgX2vFVAsD7548fIhgdhOhu
         Gp1GJEug7e955sF64edY2khs+SpemJxpvNCmn/2PzI37J9pfXCawTeeqgLyCl3/mbYRY
         UIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688401110; x=1690993110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Undn9q3Iza4d1j1OfuGt9fYLyawc34JKl91GRe7lFM=;
        b=S0jaj7bO9zzOQwfXGTshG2Fsj9/lhqGiGhyFmFxV8MDInVjPOYClxl6WVudztsH36g
         +Uds9US4DMHyANs6PViNZ+nio1faoQmfZFmseIF4+kkdNs8JIjGMykqISo+Znd2Wb0hW
         sro3VuXsdq/SC4sglDEWA/mu10831oLUFWL7OTWecQqaqHKAC6xgThboTP8AszSxF9Mg
         dKOp3KsZ3kiBoaPxvFhRHVaxhVe95y8WrQ2wLiJLHY2WEvZAwL7wbmVRpVraSKfPSVC9
         O3J/Qlbp34jnwtsv4nolKha05zOu/dapQtKXJTIimVUy7lZVUa83bGIR85uC8Qmk+N2G
         MI6Q==
X-Gm-Message-State: ABy/qLaTGnAAGmVh6ziOxReKSzzgSWEm89At5JlVONtJWmTglKSfrbxa
        kVenPcwxJ/Q6lW0rN5VFemhr4A==
X-Google-Smtp-Source: APBJJlElWFB5UM0st0ektnpHJMmKTSk5hRm8AQK1B9HsWmZ9B3ROBcIHxUm2VpUmGs23KGUUjDgKZg==
X-Received: by 2002:a17:906:edd2:b0:993:16b4:d5a5 with SMTP id sb18-20020a170906edd200b0099316b4d5a5mr6403577ejb.16.1688401110678;
        Mon, 03 Jul 2023 09:18:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jo19-20020a170906f6d300b00992d70f8078sm5026207ejb.106.2023.07.03.09.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:18:30 -0700 (PDT)
Message-ID: <5e2f841a-9afe-a057-613b-e5263eb126cb@linaro.org>
Date:   Mon, 3 Jul 2023 18:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max value
 and meaning
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alazar@startmail.com, daniel.baluta@nxp.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621160857.3400747-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/06/2023 18:08, Marco Felsch wrote:
> Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> allowed for all devices but only for the ADS1115 devices a value of 7
> does make a difference.
> 
> While on it fix the description of the datarate for ADS1115 devices as
> well.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

