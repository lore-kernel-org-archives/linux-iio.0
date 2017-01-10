Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57586 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942651AbdAJTzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 14:55:20 -0500
Subject: Re: [PATCH] iio: accel: st_accel: handle deprecated bindings
To: Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20170105133233.24237-1-linus.walleij@linaro.org>
 <20170109181645.lntlvawt26vsp4l2@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8a89bf32-d2a2-26b9-891c-6f8c574a1fb1@kernel.org>
Date: Tue, 10 Jan 2017 19:55:15 +0000
MIME-Version: 1.0
In-Reply-To: <20170109181645.lntlvawt26vsp4l2@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/17 18:16, Rob Herring wrote:
> On Thu, Jan 05, 2017 at 02:32:33PM +0100, Linus Walleij wrote:
>> The earlier deployed LIS3LV02DL driver had already defined a few
>> DT bindings that need to be supported by the new more generic
>> driver and listed as compatible but deprecated bindings in the
>> documentation.
>>
>> After this we can start to activate the new driver with the old
>> systems where applicable.
>>
>> As part of this enablement: make us depend on the old drivers
>> not being in use so we don't get a kernel with two competing
>> drivers.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/iio/accel/lis302.txt | 2 +-
>>  Documentation/devicetree/bindings/iio/st-sensors.txt   | 2 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>
Added as I haven't pushed this out as a non rebasing branch yet.

Thanks,

Jonathan
> 
>>  drivers/iio/accel/Kconfig                              | 2 ++
>>  drivers/iio/accel/st_accel_i2c.c                       | 5 +++++
>>  drivers/iio/accel/st_accel_spi.c                       | 9 +++++++++
>>  5 files changed, 19 insertions(+), 1 deletion(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

