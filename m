Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42270 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754688AbcH2RuA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:50:00 -0400
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Linus Walleij <linus.walleij@linaro.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
 <CACRpkdaAW2=taAED53kE9bQ3XSFXRaBAKye9msmtqa-rDZGkGA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Peter Rosin <peda@axentia.se>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5206f683-6aa0-8525-7a01-7c0dd6fdfbaf@kernel.org>
Date: Mon, 29 Aug 2016 18:49:58 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaAW2=taAED53kE9bQ3XSFXRaBAKye9msmtqa-rDZGkGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 14:13, Linus Walleij wrote:
> On Thu, Aug 25, 2016 at 2:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>>>> I suspect some of the stuff I've done here should be carried
>>>> over to the MPU-6050 driver in drivers/iio/imu/inv_mpu6050/*
>>>
>>> Which bits in particular?
>>
>> - Fetch and handle regulators for vdd and vddio (currently
>>   totally missing).
>>
>> - Runtime PM, including getting rid of the horrible homebrewn
>>   reference count in inv_mpu6050_set_power_itg()
>>
>> - Oh mpu6050 doesn't even seem to power the device down
>>   on .remove() I think it's a bug actually
> 
> Oh and when it comes to the trigger interrupts in
> drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> 
> - No active low handling (bit 7 reg 0x37)
> 
> - No open drain handling (bit 6 reg 0x37)
> 
> - No level interrupt support (bit 5 reg 0x37)
> 
> - No check of status register to return IRQ_NONE
>   i.e. spurious IRQ handling is non-existent.
> 
> - Timestamping should preferably happen in top
>   half.
> 
> All of this should probably happen more like it happens
> in this MPU-3050 driver. Instead it assumes that the
> interrupt assigned will be an edge, low-to-high transition,
> and nothing else is supported.
Thanks.  We may want to wait for Leonard to revisit
his last series on that driver, before it changes too much.
But would indeed be good to get this stuff sorted at somepoint!

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

