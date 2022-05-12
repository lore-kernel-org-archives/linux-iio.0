Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E1AC433F5
	for <linux-iio@archiver.kernel.org>; Thu, 12 May 2022 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359051AbiELWIv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 12 May 2022 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbiELWIu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2022 18:08:50 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F02802F3
        for <linux-iio@vger.kernel.org>; Thu, 12 May 2022 15:08:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i38so12198565ybj.13
        for <linux-iio@vger.kernel.org>; Thu, 12 May 2022 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENAsumtp6OGU/Vug/XpwG/rbitHxydRn73MCEtTfkZs=;
        b=Ql0RcrPblv788CUAtSC5+F+OQJQVrhRnNX9umrOVq0Kq/6mUxdkTqXVB25d7NPXlC2
         Z4qFwqoOkXQ4c0pYExqyLQmokTyE3pnvDP4sY4aP/GDsDdREfYdLtmMclyqaSO9rmAN0
         y0CX+1HA4Ctjt+goQCTAamfmuYNeFxAcla2xBf2wsmgz9va3RPYLfDZnO9GOaJcVptJY
         8B0Jkuy+U3FTTAS4klKQg3y9Kg1Hmfvzp5J4QvnxNwqys9Xv92agkhm1m2qLvDbzM5YH
         3T1eKGprBXXCfx1KiyD5kJi3kEiy68+cp+uxrZrd7FLAnQsE/1uEIbXSKTAQqiU+KNms
         h/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENAsumtp6OGU/Vug/XpwG/rbitHxydRn73MCEtTfkZs=;
        b=wdkRPoyI/P3rskg5rvDHAGValbpA0oWFLmK76oNSRvQ6sF0USyLc4R/zk4ZY2zGelB
         R1A+JdAWYFbnuR3hO+jQfjUp2lCguOSAIZkPHUvJ3+qndm6brtmUCPkfjtOEwnm6rUa7
         pkDOXwc2UgykululyqNsIGpc84Z548L06LSTMjbCpGECHsIyaDHOSpEhRur7xOcv0LJu
         Z4BC0MbUeRM/WslbjLtFvxBxxAqBg1EdZGU/LS7IHzA2Uz5uXMPGyQmV9rpPwhi9d+hX
         g7j76dMojj61L2GApvxa4G6lCD+QHf3S00GL7Khp+w63MfSp1NNSxrajpJTTB25pXPUD
         RdjA==
X-Gm-Message-State: AOAM531ghTtydThpVhOWgVjNGSanJrQXEeRUIS6Nkl/M4rE2o3f6W94M
        mkeHAEhn3ENZwmKf0bk0HcQfApG9IbR7PXOVU0FOPA==
X-Google-Smtp-Source: ABdhPJzodHeYzbszr3DFjh1Zj2LBxR/BnorEwi0nfOZ3V8s9q+sve6acBoLWHexymRm46bryLrwNdmqVGTHFwJa2nX8=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr1850295ybi.626.1652393328584; Thu, 12
 May 2022 15:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220510092431.1711284-1-zheyuma97@gmail.com>
In-Reply-To: <20220510092431.1711284-1-zheyuma97@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 00:08:37 +0200
Message-ID: <CACRpkda9Gbo9R15qRm35nwdjba0t79H=68+LuPL-HFbFgrONrw@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 10, 2022 at 11:24 AM Zheyu Ma <zheyuma97@gmail.com> wrote:

> The driver should disable regulators when fails at regmap_update_bits().
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours.
Linus Walleij
