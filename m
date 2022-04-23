Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE6CC433F5
	for <linux-iio@archiver.kernel.org>; Sat, 23 Apr 2022 12:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiDWMNF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 23 Apr 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiDWMNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2022 08:13:04 -0400
X-Greylist: delayed 77 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 05:10:05 PDT
Received: from smtpo62.interia.pl (smtpo62.interia.pl [217.74.67.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C2229ECC
        for <linux-iio@vger.kernel.org>; Sat, 23 Apr 2022 05:10:05 -0700 (PDT)
Received: from t480s.localdomain (unknown [80.68.225.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Sat, 23 Apr 2022 14:08:44 +0200 (CEST)
Date:   Sat, 23 Apr 2022 14:08:42 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in
 examples
Message-ID: <YmPsSkfrQ2uoDKVF@t480s.localdomain>
References: <20220422192039.2590548-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422192039.2590548-1-robh@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1650715725;
        bh=nFHWdq01dNlYJ4w6Jai1iL/p5w3CH+WbSq5a82Dxp5I=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:X-Interia-Antivirus;
        b=bw2ZelMFSJ1uhC80xZ5WURtvySQ2HshIaQXHz0bk1CUvGO5psO68PWZro1AZfdtbA
         OgSUqQKLpHoj36e6AeT/CUrPwpXeyd00v4y7weK4Pm3QMVrI6iIJXuhb5baSDUriUD
         1fB+Z+g8uAOlwxYQibpT7YIqSKQRqtpCCqx58w+8=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On kwi 22, 2022 14:20, Rob Herring wrote:
> Fix a couple of examples using incorrect compatible strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml     | 2 +-
>  .../bindings/iio/potentiometer/microchip,mcp4131.yaml           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

-- 
Slawomir Stepien
