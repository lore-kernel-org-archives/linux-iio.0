Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35101 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbcIYJla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 05:41:30 -0400
Subject: Re: [PATCH 0/4] Add DMA support for ti_am335x_adc driver
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
Date: Sun, 25 Sep 2016 10:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <20160921161134.6951-1-mugunthanvnm@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/09/16 17:11, Mugunthan V N wrote:
> The ADC has a 64 work depth fifo length which holds the ADC data
> till the CPU reads. So when a user program needs a large ADC data
> to operate on, then it has to do multiple reads to get its
> buffer. Currently if the application asks for 4 samples per
> channel with all 8 channels are enabled, kernel can provide only
> 3 samples per channel when all 8 channels are enabled (logs at
> [1]). So with DMA support user can request for large number of
> samples at a time (logs at [2]).
> 
> Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
> patch [3] to enable ADC and pushed a branch for testing [4]
> 
> [1] - http://pastebin.ubuntu.com/23211490/
> [2] - http://pastebin.ubuntu.com/23211492/
> [3] - http://pastebin.ubuntu.com/23211494/
> [4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma
Just curious.  How fast is the ADC sampling at in these?  Never that
obvious for this driver!

I'm also curious as to whether you started to hit the limits of the
kfifo based interface.  Might be worth considering adding alternative
support for the dma buffers interface which is obviously much lower
overhead.

Good to have this work prior to that as the kfifo stuff is somewhat
easier to use.

Jonathan
> 
> Mugunthan V N (4):
>   mfd: ti_am335x_tscadc: store physical address
>   drivers: iio: ti_am335x_adc: add dma support
>   ARM: dts: am33xx: add DMA properties for tscadc
>   ARM: dts: am4372: add DMA properties for tscadc
> 
>  arch/arm/boot/dts/am33xx.dtsi        |   2 +
>  arch/arm/boot/dts/am4372.dtsi        |   2 +
>  drivers/iio/adc/ti_am335x_adc.c      | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/mfd/ti_am335x_tscadc.c       |   1 +
>  include/linux/mfd/ti_am335x_tscadc.h |   8 ++
>  5 files changed, 170 insertions(+), 3 deletions(-)
> 

