Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A93E81815
	for <linux-iio@archiver.kernel.org>; Fri, 29 Sep 2023 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjI2Vgp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 29 Sep 2023 17:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Vgo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 17:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B31AB;
        Fri, 29 Sep 2023 14:36:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E8C433C7;
        Fri, 29 Sep 2023 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696023401;
        bh=mXWRebIPnDtz7oa99tSWCEXMUJKJoTz+JHyEwZ8HvhY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bLcLk+2j9fqeZGtfvsdOlGdsg5jzp7n2RH4hFJzueX+iZhUQ38TQd1012iDUjj4ZR
         cby8FAqubnkRK8LMcR/RTt4J6TK+6wL8ROn4xtz/DC9SNqmvGwVSggLkvThPIzaPZU
         V8wDGzk5UmLC5mQvI/+y+dvr5a81rQ391ObCluQ3XW8nx4HsFZxmiMGT00ojXIHJHy
         QAjNd2MRO5O77OUt5/2xvNISr9S3s/V9QVfYQRPWD45WkIdFGP6+w7YVvQqAtiLKK/
         oW1xlv+kSlxh1d5+uKoeeHQf2c8Lwzej1KmlFC9yxSUjnQdKaAhtDrlzrgzNtYnfil
         On5cGxIeOr2Zw==
Received: (nullmailer pid 278069 invoked by uid 1000);
        Fri, 29 Sep 2023 21:36:39 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230929200844.23316-2-fr0st61te@gmail.com>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
 <20230929200844.23316-2-fr0st61te@gmail.com>
Message-Id: <169602339920.278051.17156701807857771134.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device
 tree binding document
Date:   Fri, 29 Sep 2023 16:36:39 -0500
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Fri, 29 Sep 2023 23:08:43 +0300, Ivan Mikhaylov wrote:
> The hardware binding for i2c current monitoring device with overcurrent
> control.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml: supply-vdd: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230929200844.23316-2-fr0st61te@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

