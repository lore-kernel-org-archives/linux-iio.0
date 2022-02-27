Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53865C433EF
	for <linux-iio@archiver.kernel.org>; Sun, 27 Feb 2022 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiB0WiY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Feb 2022 17:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0WiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 17:38:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF91EC6E
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 14:37:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so15069130edd.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=mz/hAR5podt2gfJfleTEATFdKy86NFGG80O6Ivni8CM=;
        b=B0i0t8HVVxBe+DyYRHcbMcgRX8xWqymaQMmdDwXlGZ5Sxskw+QDDI3/F3T4XsRYJS5
         7YyldQHkf1rGhqQKqWZHvt0hnvWFryPEI8bD+Iev5Dd7WvA5whMkPnMwPGpIeM9ddvYI
         MSdtYt0fhmGTt7TNaugb3aquVH62zWtWTljxKagnO/O/bYwAwP9AVZn1200QQ4AEhhtA
         5TVpeCBs7Wm1fCO/mA/TaDBvAfflFcvrijCDIA1s2qd0MnhmLvOVsSnQ7o+sd30fRouf
         4ZM/iu88kkCNLFXDoU8wzrcq01Fer18dOODyl2PAgtxWRuNRXyNvdx5CwNg+ViQFmuVy
         akeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=mz/hAR5podt2gfJfleTEATFdKy86NFGG80O6Ivni8CM=;
        b=jHcxJqpPiByKBmrFBroTLicyfQMqq3zgGzsK6D31de77Z12vx5dai6WVLqehxlat3d
         r1P1lkxgGhIA2UaFq3SIt5W8pHX6ZNYrbSsWc4/2AZKyLnEG/b0VsNpM/2+umOji4opR
         Vv+Vri4+EN41Tj+Ho1TAik0rA1WuvSwZjTCTq2dtsTZUgSSJ/btNtzaZ+0972rKlaf8r
         n3jp45CpqfkDDsKqiv7n9jDY7lJpRAyPxhQkO985LWTIImWMaRtqDEPr2ZG2jZEqgqqo
         2/SUT0Ox4Ltza4WZRa6hBRgnXI1HqcRlKy0sQe4S9pSEk3LmY3SOhcGuxXE54BKMfF09
         XyfA==
X-Gm-Message-State: AOAM5309yUOFg2xCR2luxbpDm3Wdgnj3T1df6uxUK5tKtvGfOmvIFthe
        XoilAAg/995hmkIbv6AW198=
X-Google-Smtp-Source: ABdhPJypgZtljBEPJSSiboA9St+nk6iSmqIXSEPyhRK485YL0mmgHJajRaTsoppP5DUGVxWX6K+Lfg==
X-Received: by 2002:a50:d086:0:b0:413:38a6:24a7 with SMTP id v6-20020a50d086000000b0041338a624a7mr16558770edd.183.1646001464008;
        Sun, 27 Feb 2022 14:37:44 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id co19-20020a0564020c1300b00412879e4645sm5161820edb.55.2022.02.27.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:37:43 -0800 (PST)
Date:   Mon, 28 Feb 2022 00:37:39 +0200
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] dt-bindings: iio: st,st-sensors add LIS302DL
Message-ID: <Yhv9M/aXptQSKQju@tp440p.steeds.sam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update st,st-sensors bindings for STMicroelectronics LIS302DL variant

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71de5631ebae..321fd16b6ea7 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -29,6 +29,7 @@ properties:
           - st,lis2dw12
           - st,lis2hh12
           - st,lis2dh12-accel
+          - st,lis302dl
           - st,lis331dl-accel
           - st,lis331dlh-accel
           - st,lis3de
-- 
2.35.1

