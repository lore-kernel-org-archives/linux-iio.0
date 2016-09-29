Return-Path: <mugunthanvnm@ti.com>
Subject: Re: [PATCH 0/4] Add DMA support for ti_am335x_adc driver
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartmut
 Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        "Andrew F . Davis" <afd@ti.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Mugunthan V N <mugunthanvnm@ti.com>
Message-ID: <ff19f584-e4e5-61ff-046d-68ec37ab51c2@ti.com>
Date: Thu, 29 Sep 2016 18:31:30 +0530
MIME-Version: 1.0
In-Reply-To: <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On Sunday 25 September 2016 03:11 PM, Jonathan Cameron wrote:
> On 21/09/16 17:11, Mugunthan V N wrote:
>> > The ADC has a 64 work depth fifo length which holds the ADC data
>> > till the CPU reads. So when a user program needs a large ADC data
>> > to operate on, then it has to do multiple reads to get its
>> > buffer. Currently if the application asks for 4 samples per
>> > channel with all 8 channels are enabled, kernel can provide only
>> > 3 samples per channel when all 8 channels are enabled (logs at
>> > [1]). So with DMA support user can request for large number of
>> > samples at a time (logs at [2]).
>> > 
>> > Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
>> > patch [3] to enable ADC and pushed a branch for testing [4]
>> > 
>> > [1] - http://pastebin.ubuntu.com/23211490/
>> > [2] - http://pastebin.ubuntu.com/23211492/
>> > [3] - http://pastebin.ubuntu.com/23211494/
>> > [4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma
> Just curious.  How fast is the ADC sampling at in these?  Never that
> obvious for this driver!
> 
> I'm also curious as to whether you started to hit the limits of the
> kfifo based interface.  Might be worth considering adding alternative
> support for the dma buffers interface which is obviously much lower
> overhead.
> 
> Good to have this work prior to that as the kfifo stuff is somewhat
> easier to use.

Currently ADC clock is 3MHz, which can produce a data rate of 225KBps
per channel with no open delay and no averaging of samples. So when all
8 Channels are enables the data rate will be 1.75MBps

ADC can be operated at 24MHz, which can generate a data rate of 28MBps
with all 8 channels enabled and no open delay and averaging, but our
target is to get 800K samples per second per channel which has a data
rate of 12.5MBps

I think with this data rate, DMA will be the best option to implement
without any data loss and less cpu overload to read the ADC samples.

Regards
Mugunthan V N
