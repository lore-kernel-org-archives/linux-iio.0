Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33133C7EE2E
	for <linux-iio@archiver.kernel.org>; Tue, 13 Jun 2023 06:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjFMGSS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjFMGSR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 02:18:17 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117501BC;
        Mon, 12 Jun 2023 23:18:14 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-777a4926555so185713339f.0;
        Mon, 12 Jun 2023 23:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686637093; x=1689229093;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyce8rGZccXhK0R20pukPepOXx31K864wU3MTFrBaB8=;
        b=GfX2gWj4nAhIQW9zUnudX2NBGgADzUfSpECeQJWi895Zy4qFzM+lbCtkBIP4hes5kX
         kxiRnxUprs2hiNVKNJD8nTr9zspyisMB0L4MIt3oSPO1jgt84Vpn/4ZwtoN5brTllJUO
         JgPDFEWH4rc8pfQlBW2j6nsFrAEC+QUL6J8VxMICCP6MFgYKWjA6IHfqDrJbJjoxfBGi
         a0gCWt4RwbNJ7pQ/SFAypYsuZZAEO9ipLa2USsv30VJETsSvsfgZ6DP3RTUtRyfLYlHF
         Szt6hvRWlAzfEx8MDuKv3vfXrjmJUw6NtHdUGl2NQFEzgOV8l68OoL9dGu/y40ObaMcr
         ZQwg==
X-Gm-Message-State: AC+VfDxMZILXeJl0hlrE40yLYM0XXjOhBt6zEbDzWyuU67zYlsI3fcPJ
        HAK7Tg4Wkl1v0Zno1Gezwnj4VKRiwQ==
X-Google-Smtp-Source: ACHHUZ72PbgeeORrLa1U4IyxinFuDAGdiEM4DKA0OTmvTPoYs7A354aIQuY1gWBkbcP+ik/APBcSjA==
X-Received: by 2002:a05:6602:1224:b0:77a:cc6c:b7e3 with SMTP id z4-20020a056602122400b0077acc6cb7e3mr8752694iot.0.1686637093231;
        Mon, 12 Jun 2023 23:18:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cc8e000000b00422c577c560sm400945jap.153.2023.06.12.23.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 23:18:12 -0700 (PDT)
Received: (nullmailer pid 652716 invoked by uid 1000);
        Tue, 13 Jun 2023 06:18:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-iio@vger.kernel.org
In-Reply-To: <20230613054601.31566-1-kimseer.paller@analog.com>
References: <20230613054601.31566-1-kimseer.paller@analog.com>
Message-Id: <168663709022.652608.11756645774505315189.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings:iio:adc: add max14001
Date:   Tue, 13 Jun 2023 00:18:10 -0600
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Tue, 13 Jun 2023 13:46:00 +0800, Kim Seer Paller wrote:
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> V3 -> V4: Added space between prefixes in commit description.
> 
>  .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/iio/dac/adi,max14001.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230613054601.31566-1-kimseer.paller@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

