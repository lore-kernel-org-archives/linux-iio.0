Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37644 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdEUODh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 10:03:37 -0400
Subject: Re: [PATCH v4 0/5] iio: ADC driver for EP93xx SoC
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <df337513-23c7-06b8-50e4-94560e75650c@kernel.org>
Date: Sun, 21 May 2017 15:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/17 18:13, Alexander Sverdlin wrote:
> This series prepares the necessary infrastructure for ADC platform device on
> Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
> IIO subsystem.
Hartley, Ryan,

How do you want to handle taking this series forward.
Clearly we have a few arch specific bits and then the driver which
is dependent on some of them.

I'm happy to take the lot through the IIO tree, but will be wanting
a few acks.

I'm interested to note how few implementations there are of clk_get_parent
in tree.  Any comments on that little bit of the code would be
particularly welcome.

Thanks,

Jonathan
> 
> Changelog
> v4:
>    Spelling improvements
>    sign_extend32() usage
> v3:
>    Rebased to the current master
>    sizeof(struct foo) -> sizeof(*bar)
> v2:
>    Added Documentation/iio/ep93xx_adc.txt
>    Removed extend_name
>    Added timeout to the status polling loop
>    Used iio_device_register() instead of devm_iio_device_register()
> 
> Alexander Sverdlin (5):
>    clk: ep93xx: Implement clk_get_parent()
>    clk: ep93xx: Add ADC clock
>    ep93xx: Add ADC platform device support to core
>    edb93xx: Add ADC platform device
>    iio: adc: New driver for Cirrus Logic EP93xx ADC
> 
>   Documentation/iio/ep93xx_adc.txt             |  29 +++
>   arch/arm/mach-ep93xx/clock.c                 |  14 ++
>   arch/arm/mach-ep93xx/core.c                  |  24 +++
>   arch/arm/mach-ep93xx/edb93xx.c               |   1 +
>   arch/arm/mach-ep93xx/include/mach/platform.h |   1 +
>   arch/arm/mach-ep93xx/soc.h                   |   1 +
>   drivers/iio/adc/Kconfig                      |  11 ++
>   drivers/iio/adc/Makefile                     |   1 +
>   drivers/iio/adc/ep93xx_adc.c                 | 255 +++++++++++++++++++++++++++
>   9 files changed, 337 insertions(+)
>   create mode 100644 Documentation/iio/ep93xx_adc.txt
>   create mode 100644 drivers/iio/adc/ep93xx_adc.c
> 

