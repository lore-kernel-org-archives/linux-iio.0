Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BCC43334
	for <linux-iio@archiver.kernel.org>; Sun,  5 Jun 2022 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiFEVqv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Jun 2022 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbiFEVqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jun 2022 17:46:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC144762;
        Sun,  5 Jun 2022 14:46:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so14521485ejj.12;
        Sun, 05 Jun 2022 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEUtBzgO4NZOQwhouRlnr+KmdLlgAtaO1quMCtr8kN0=;
        b=EzNZbIqzqAxHvlOfdJQ4Q4/+Bz6oT6H3mPwe1M2NMDVkrm7+FuCtLHzzlYlpZnxF43
         7N7AwmxZEGSG+u1bGnwd4lusykPGVHLesUaxGiH1VOLojeaVTIvw8fQN4tYBtMRlis2O
         qNCjFANiUanA18+qqgGU+0ewDk8Ze/0Aw69lszx0KeGMHsccYc2L2cAE36jZINAgVxcz
         QZ9y4mAhJTVi865OgpSrPBszI8M2KdgpsIsmzEXmax4INKVJLZbRYPZqxC/CcMMvqGg+
         ImdX4Mcqo8V0Wy1x/6icRPuHqswrluFbOEX1w0FjNaEeznLR0eS1DGLlOoGPqLaZQ60x
         kktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEUtBzgO4NZOQwhouRlnr+KmdLlgAtaO1quMCtr8kN0=;
        b=a9ip7c09MOFNmBuLKDlhMKyZTP/skKMe2a9oiV+luIjg6ysbwKJt1vArCBvlmuRU6K
         QwlwgcFGEGt5adj6FZ/tFCazJKK4Vj8K46uJFfL/iZNvV+XPF4NK7cvX34GO7e+xFguj
         Qmcepa4z6CEKNP27stVp4s7m5+4OfbkLXl9ImetQlTHn/bL4K+idMsp7OC6/1QLeID6x
         ibuO4MtYjp1B5Qg1ohlUGFZFzji+k45kaKQ9C0PdQ4ucBSMXYqcGVRf1g+kWfOMx2JpL
         CGzjQ1NQ+4MvX5w4wEzJKJKnz+UitvdK2s7Blcz129JcX82mrMdyGLK2/+wDRg19RAlW
         KowA==
X-Gm-Message-State: AOAM532b0NcHEFqoTVVX9gcD3G+HC/QBRrZf5tNlHkb2t20ExcGdRODq
        i1vFsaIO1FulS2DQN+lttPTiYoBIDOu+2kJHnQs=
X-Google-Smtp-Source: ABdhPJw4MafiBKxna9+gCyvTQb5jcAjT9aT9fXw1fhtlbfQJhud3ireSbEz74FWDSxvgX3qA6LoS8DFqFY8L0qleilY=
X-Received: by 2002:a17:907:7246:b0:6ff:241f:200a with SMTP id
 ds6-20020a170907724600b006ff241f200amr18547956ejc.543.1654465608121; Sun, 05
 Jun 2022 14:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Jun 2022 23:46:37 +0200
Message-ID: <CAFBinCDe=k+4YcSUqz5dpAtJ3NTqsHe9Krt0O1pAS=L=rVKCrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] iio: adc: meson_saradc: Don't attach managed
 resource to IIO device object
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 3, 2022 at 12:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It feels wrong and actually inconsistent to attach managed resources
> to the IIO device object, which is child of the physical device object.
> The rest of the ->probe() calls do that against physical device.
>
> Resolve this by reassigning managed resources to the physical device object.
>
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I am also fine if the Fixes tag is being dropped - please keep my
Reviewed-by in that case.
