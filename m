Return-Path: <SRS0=y5uP=6D=onstation.org=masneyb@kernel.org>
Date: Fri, 30 Jun 2017 11:21:14 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
	pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 0/6] staging: iio: tsl2x7x: staging cleanups
Message-ID: <20170630152114.4biwkzt43w52lalp@basecamp>
References: <20170629170352.11264-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629170352.11264-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 29, 2017 at 01:03:46PM -0400, Brian Masney wrote:
> This begins my work to clean this driver up and eventually move it out
> of staging. Driver changes were tested using a TSL2771 hooked up to a
> Raspberry Pi 2.
> 
> Thanks to Jon Brenner at AMS/TAOS for loaning me some hardware samples
> to test my driver changes.
> 
> Brian Masney (6):
>   staging: iio: tsl2x7x: add of_match table for device tree support
>   staging: iio: tsl2x7x: remove redundant power_state sysfs attribute
>   staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
>   staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
>   staging: iio: tsl2x7x: refactor {read,write}_event_value to allow
>     handling multiple iio_event_infos
>   staging: iio: tsl2x7x: use usleep_range() instead of mdelay()
> 
>  .../devicetree/bindings/trivial-devices.txt        |  10 +
>  drivers/staging/iio/light/tsl2x7x.c                | 316 ++++++++++-----------
>  2 files changed, 153 insertions(+), 173 deletions(-)

Hi Jonathon,

Hold off on applying this series. There are several other formatting
warnings from checkpatch with this series that I need to fix. Sorry
about the noise. I'd appreciate it if you could at least look at the
functionality of my changes and I'll resubmit next week.

I held back several other changes related to the event subsystem until
I'm able to properly test my changes. I'm having trouble getting the
interrupts to work. I wired the interrupt pin on the sensor to GPIO
pin 17 on my Raspberry Pi 2 and added the following section to
arch/arm/boot/dts/bcm2836-rpi-2-b.dts for my sensor:

&i2c1 {
        tsl2771@29 {
                compatible = "amstaos,tsl2771";
                reg = <0x39>;
                interrupt-parent = <&gpio>;
                interrupts = <17 2>;
        };
};

I start up iio_event_monitor, and run these commands:

echo 1 > events/in_intensity0_thresh_rising_en
echo 256 > events/in_intensity0_thresh_rising_value

When I shine a light on the ALS sensor, and the reading goes above
256, I do not get any events back from iio_event_monitor.

I'm honestly not sure about the 2 in the 'interrupts = <17 2>;' line.
I looked at how interrupts were setup in device tree overlays in the
official Raspberry Pi kernel and tried several variations from there.
I have more reading to do. :)

Thanks,

Brian
