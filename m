Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36099 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbcHYNNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 09:13:19 -0400
Received: by mail-oi0-f43.google.com with SMTP id f189so65570262oig.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2016 06:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org> <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Aug 2016 15:13:17 +0200
Message-ID: <CACRpkdaAW2=taAED53kE9bQ3XSFXRaBAKye9msmtqa-rDZGkGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Jonathan Cameron <jic23@kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 25, 2016 at 2:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>>> I suspect some of the stuff I've done here should be carried
>>> over to the MPU-6050 driver in drivers/iio/imu/inv_mpu6050/*
>>
>> Which bits in particular?
>
> - Fetch and handle regulators for vdd and vddio (currently
>   totally missing).
>
> - Runtime PM, including getting rid of the horrible homebrewn
>   reference count in inv_mpu6050_set_power_itg()
>
> - Oh mpu6050 doesn't even seem to power the device down
>   on .remove() I think it's a bug actually

Oh and when it comes to the trigger interrupts in
drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c

- No active low handling (bit 7 reg 0x37)

- No open drain handling (bit 6 reg 0x37)

- No level interrupt support (bit 5 reg 0x37)

- No check of status register to return IRQ_NONE
  i.e. spurious IRQ handling is non-existent.

- Timestamping should preferably happen in top
  half.

All of this should probably happen more like it happens
in this MPU-3050 driver. Instead it assumes that the
interrupt assigned will be an edge, low-to-high transition,
and nothing else is supported.

Yours,
Linus Walleij
