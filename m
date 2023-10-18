Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA49CDB482
	for <linux-iio@archiver.kernel.org>; Wed, 18 Oct 2023 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjJRUWI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjJRUWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 16:22:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98379F;
        Wed, 18 Oct 2023 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697660517; bh=QqLLrKadzWHdHgLEE5BLiKAzwuDFNkmPcq7fjUL3hpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MEesbCZvB7S/xc7ff5xM4yGXFf7vDrSBJYGspIELXaPBTUOYhy5uLWC5RaJMaQJ9D
         7yZSi+EMBiimIJe+nJeSV/KRKIkMPdFwHuYn6l7YvzUkVjFr0HeSwmXCJ+7E+IsmYV
         nG00Ud31hKqSNe+0V4FKin1rEc05MevDpkR4PGwM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
Date:   Wed, 18 Oct 2023 22:21:55 +0200
Message-ID: <3714987.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <6ac842b8-5fcb-4094-8488-4d6e250bf102@linaro.org>
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
 <20231018-nia-sm8350-for-upstream-v2-4-7b243126cb77@igalia.com>
 <6ac842b8-5fcb-4094-8488-4d6e250bf102@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mittwoch, 18. Oktober 2023 22:17:15 CEST Konrad Dybcio wrote:
> On 10/18/23 16:25, Nia Espera wrote:
> > In a similar vein to
> > https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasivam@
> > linaro.org/, the remote processors on sm8350 fail to initialize with the
> > 'correct' (i.e., specified in downstream) IRQ type. Change this to
> > EDGE_RISING.
> > 
> > Signed-off-by: Nia Espera <nespera@igalia.com>
> > ---
> 
> Hm, apparently 8250 and 7180 have the same thing.
> 
> Mani, could you elaborate on this?
> 
> Konrad

I'm also carrying something like this for my sm6350 and sc7280 trees.

I tried getting some clarification in the lkml thread linked above about what 
should be done but never got a response.

Regards
Luca


