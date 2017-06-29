Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33758 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdF2Lqe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2017 07:46:34 -0400
Received: by mail-io0-f176.google.com with SMTP id h64so5340769iod.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2017 04:46:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAA2SeNJ5yPqMiW2tVSc9ZSC5Rt=Q+CRoMibzigjvPyw05Qsr5Q@mail.gmail.com>
References: <20170621192129.10226-1-lorenzo.bianconi@st.com>
 <20170621192129.10226-2-lorenzo.bianconi@st.com> <20170624210835.56ffdd1c@kernel.org>
 <CAA2SeNJ5yPqMiW2tVSc9ZSC5Rt=Q+CRoMibzigjvPyw05Qsr5Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Jun 2017 13:46:32 +0200
Message-ID: <CACRpkdYLbHrNehFeJZDAHoOfegBJqqTesJUrXSALNqGLPT_SPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: support open drain mode
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 25, 2017 at 11:34 AM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

>> In common with the mpu3050 which was the first driver in IIO to do open drain,

I think I implemented it on the ST sensors first actually.

>> I think you need to think about precedence as we allow for IRQF_RISING
>> and IRQF_FALLING already.  Open drain only allows for shared interrupts
>> if IRQF_FALLING (I think)
>>>       err = devm_request_threaded_irq(hw->dev, hw->irq,
>>>                                       st_lsm6dsx_handler_irq,
>>>                                       st_lsm6dsx_handler_thread,
>
> I have not got the difference between IRQF_RISING and IRQF_FALLING
> when the irq line
> is marked as shared (when open drain is enabled).
> Looking at the code, mpu3050 gyro sensor does not support shared interrupts
> with IRQF_RISING and IRQF_TRIGGER_HIGH. Is it a hw limitation?

It seems like I have inverted the logic in the MPU3050 driver.
I'll send a patch.

> Speaking with digital designer, lsm6dsx series allows open drain mode
> even if the requested irq line
> is IRQF_TRIGGER_HIGH or IRQF_RISING, we need to add a pull-down resistor.
> Moreover ST framework already supports open drain if the requested
> interrupt is IRQF_RISING.

This seems correct.

Yours,
Linus Walleij
