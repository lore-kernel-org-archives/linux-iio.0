Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1EC38145
	for <linux-iio@archiver.kernel.org>; Thu,  8 Sep 2022 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiIHIQ3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 8 Sep 2022 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIHIQ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Sep 2022 04:16:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96562AA4C2;
        Thu,  8 Sep 2022 01:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F49B82050;
        Thu,  8 Sep 2022 08:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FAAC433C1;
        Thu,  8 Sep 2022 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662624984;
        bh=CZ+yncuAqJvVKnJLnhHlWLzhvVqLsLtlQMV5b4jIfSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS4dDaQ9d5+6NKxy1iB1bqWl+0NTbyRFI4lbD6rat9+aBjbqFWtydVfkHzA21xgRn
         cX5kauvdGPssdIN6l+4ysc/Z7KHcN6h55Jh2voDz5p3UvjNNGW3IfOeUnp3tQJj2Tx
         8AzhiWT8geQWgvqfvZnoH+6GufauTx05R3CS739BhHPh/wBCv3bPIKp6HXJVwkaWPq
         yKQJAsU5OLkDAcPpCtqBY8tTHiKr6fPQ1BY2lh2xU7mlDggdjSZ4czc/OFoLtfY1aX
         czCUATb26Vgh19PKxDhCUkyeIKzs0GxD6KRdcKXnGqgq7VQfD178DNJLiBp/O8mqfE
         igrfc7+OFOnOw==
Date:   Thu, 8 Sep 2022 09:16:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 2/5] mfd: qcom-spmi-pmic: add support for PMP8074
Message-ID: <Yxmk0sdWOAjY65Nn@google.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
 <20220818221815.346233-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818221815.346233-2-robimarko@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Aug 2022, Robert Marko wrote:

> Add support for PMP8074 PMIC which is a companion PMIC for the Qualcomm
> IPQ8074 SoC-s.
> 
> It shares the same subtype identifier as PM8901.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
