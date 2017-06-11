Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbdFKOSm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:18:42 -0400
Date: Sun, 11 Jun 2017 15:18:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 0/5] iio: ADC driver for EP93xx SoC
Message-ID: <20170611151837.35fc64a4@kernel.org>
In-Reply-To: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
References: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Jun 2017 01:26:47 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> This series prepares the necessary infrastructure for ADC platform device on
> Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
> IIO subsystem.
The reason these have been reposted is because the EP93xx don't
have an actual tree as such.  They are typically handled
directly through the arm-soc tree.

As such I'm looking for a route to get this applied.
The dependencies are such that the whole series should go through
either arm-soc or iio.  I don't really mind which.
Either I need Acks for applying the patches that touch
the arch bits (we have Ryan's but I'd like a more general
arm-soc one given this will be in your area), or
I will probably ack the driver in a minute so the log can
go through arm-soc.

Anyhow, don't really mind but let's get this moving!

Jonathan
> 
> Changelog
> v5:
>   Rebased to ea094f3c830a
>   Added Ryan's ack
> v4:
>   Spelling improvements
>   sign_extend32() usage
> v3:
>   Rebased to the current master
>   sizeof(struct foo) -> sizeof(*bar)
> v2:
>   Added Documentation/iio/ep93xx_adc.txt
>   Removed extend_name
>   Added timeout to the status polling loop
>   Used iio_device_register() instead of devm_iio_device_register()
> 
> Alexander Sverdlin (5):
>   clk: ep93xx: Implement clk_get_parent()
>   clk: ep93xx: Add ADC clock
>   ep93xx: Add ADC platform device support to core
>   edb93xx: Add ADC platform device
>   iio: adc: New driver for Cirrus Logic EP93xx ADC
> 
>  Documentation/iio/ep93xx_adc.txt             |  29 +++
>  arch/arm/mach-ep93xx/clock.c                 |  14 ++
>  arch/arm/mach-ep93xx/core.c                  |  24 +++
>  arch/arm/mach-ep93xx/edb93xx.c               |   1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h |   1 +
>  arch/arm/mach-ep93xx/soc.h                   |   1 +
>  drivers/iio/adc/Kconfig                      |  11 ++
>  drivers/iio/adc/Makefile                     |   1 +
>  drivers/iio/adc/ep93xx_adc.c                 | 255 +++++++++++++++++++++++++++
>  9 files changed, 337 insertions(+)
>  create mode 100644 Documentation/iio/ep93xx_adc.txt
>  create mode 100644 drivers/iio/adc/ep93xx_adc.c
> 

