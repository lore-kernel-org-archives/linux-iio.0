Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B94C43334
	for <linux-iio@archiver.kernel.org>; Wed, 15 Jun 2022 21:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiFOVkl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFOVkl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 17:40:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8F3A5C1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:40:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d129so12548356pgc.9
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E9ERFJfmycetiewLsnmPEUf5XGwsEH0WUvIwEqLk+7s=;
        b=ttJN/MGyhYY6DGazXaoQqpX+PSl81iONtGWiRVGGyQJycYL5aAU4x+kKpmRyu0Hsjp
         fcUFQA9DPiXWusNHCI5SwF7dtfoq27GhyKYZVRwPUVp0xl9q2wR7jB5Y5OhdoBwYwmVg
         s2pkhk/gEkd1GpbOqbgtWYk1Y6TGaibyIW9ZhgaDSO0cHHwqTQbYZkQpPxW756AFy3Y+
         7Px/hNO31Ei4BRE9FubcBHP9lSEuAUgIkR83rVGTvBbF/pB/TUng+UFCC5DxawNkXYP2
         /U2tvrhwk6VncuD77fjMrRKzkv2Yv5n9YnSw3j/nKRVKCCo9yCyqJoyc4A7yFKm1wR5z
         kmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E9ERFJfmycetiewLsnmPEUf5XGwsEH0WUvIwEqLk+7s=;
        b=kVrsYvLf4r+ENIwh8NUoAh4ncr+l2wEEpjPlf+0l1bEqGpy9AWFAPPnyoSPbFivSUs
         zqMdb56BsjOtYL3s53STAb143cK0B59IyjF4zKdra0x12W7eCrMOiiqYCtGhpz0FH8yc
         6lmHhurrPD9StfSHU9YegGT81R93HSAgbTkffdUQ6FogxIiNiuha+MR85Ah375pDwzGk
         WQIFivQ48yypGBHpGr+GOzGkFZJsXGdze00Tuk07UgAYbxcgtDB8aUVj7FKO7k2mOwLo
         7417v2lhN4RkNOKf1UcH/R1fVoNPvTE1gDSAyuVvN6WOLFs7R9dQSS035gLxB9PlNX7I
         GeKQ==
X-Gm-Message-State: AJIora+C3zmLKZoDp/2iJK14e6xHswh/8QE9rgZXd9gEP6WI/xeT/6mb
        XHo5Y9Kx8HwfBonkr0UyGatRkQ==
X-Google-Smtp-Source: AGRyM1sMKXkKuZQnP6khsj5hB3YYQDGwcOOc6pFBBPKzk2thLFoH4KcLdt7LufAaCkTq/ji06lSuFw==
X-Received: by 2002:a63:fe49:0:b0:408:9928:44da with SMTP id x9-20020a63fe49000000b00408992844damr1516490pgj.373.1655329239625;
        Wed, 15 Jun 2022 14:40:39 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b001e0d4169365sm2330350pji.17.2022.06.15.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:40:38 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:40:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v14 03/10] mfd: qcom-spmi-pmic: read fab id on supported
 PMICs
Message-ID: <YqpR1FmubmQPHzXV@google.com>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-4-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429220904.137297-4-caleb.connolly@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Apr 2022, Caleb Connolly wrote:

> The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
> the RRADC to calibrate ADC values.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
>  include/soc/qcom/qcom-spmi-pmic.h | 1 +
>  2 files changed, 8 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
