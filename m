Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeIPPfQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 11:35:16 -0400
Date: Sun, 16 Sep 2018 11:12:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Narani <manish.narani@xilinx.com>
Cc: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <sgoud@xilinx.com>,
        <anirudh@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
Message-ID: <20180916111242.73af71ed@archlinux>
In-Reply-To: <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
        <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 14 Sep 2018 12:48:28 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> Add documentation for xilinx-ams driver. This contains information about
> various voltages and temperatures on PS (Processing System), PL
> (Programmable Logic) and AMS Control Block.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
The more I look at this device the more I'm convinced it is very much a dedicated
hardware monitoring function, not a generic ADC sensing unit at all.

Hmm.  It is still fine to have it in IIO but you need to think in detail
about how you are going to interface this to hwmon via the iio-hwmon bridge.

Some of the interface complexity should only really be apparent when we hit
hwmon perhaps rather than having so many different custom interfaces in IIO.

Please also loop in the maintainers and lists for hwmon in the next
version so we can get their input.

Thanks,

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-xilinx-ams       | 246 +++++++++++++++++++++
>  1 file changed, 246 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams b/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
> new file mode 100644
> index 0000000..589c389
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
> @@ -0,0 +1,246 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsintlp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) LPD (Low Power Domain)
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsintfp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) FPD (Full Power Domain)
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsaux
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) Auxiliary power
> +		supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsddr
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) I/O bank 504 (DDR
> +		PHY) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio3
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) I/O bank 503
> +		(boot, config, JTAG, SRST, POR) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio0
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) I/O bank 500
> +		(MIO[0:25]) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio1
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) I/O bank 501
> +		(MIO[26:51]) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio2
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) I/O bank 502
> +		(MIO[52:77]) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psmgtravcc
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) GTR SerDes I/O
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psmgtravtt
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) GTR SerDes
> +		terminators power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccams
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PS (Processing System) SYSMON ADC circuitry
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccint
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) internal power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvrefp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) ADC positive V
> +		reference power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvrefn
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) ADC negative V
> +		reference power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplintlp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) LPD (Low Power Domain)
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplintfp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) FPD (Full Power
> +		Domain) power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplaux
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) Auxiliary power
> +		supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvpvn
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) Analog Input Pins
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vuserZ
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for PL (Programmable Logic) Fabric Analog Wires 
> +		power supply. Z is the number in range of 0 to 3.
This one superficially sounds like a general purpose input?  The vuser part
doesn't mean anything to the user.  If you care about the pin mapping use the
datasheet name fields.

> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vcc_pspll0
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) Systems PLLs
> +		power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vcc_psbatt
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) Battery power
> +		supply.

Why does this one merit a ps in it's name and the extra underscore by the vccbram
doesn't?  These need to be consistent.

> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccbram
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) Block RAM power
> +		supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccaux
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) Auxiliary power
> +		supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psddrpll
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) DDR I/O
> +		PLLs [0:5] power supply.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psintfpddr

That is not a human readable bit of naming...
What is the intf part about for example?  Perhaps use some underscores to break
up the name. Stringing acronyms into one doesn't make it easy to parse in my
head!

> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Voltage input for AMS (Analog Monitoring System) DDR controller
> +		power supply.

> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_ps_temp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Temperature input for PS (Processing System) RPU MPCore.
> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_remote_temp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Temperature input for PS (Processing System) APU MPCore.

This presumably is a separate external sensor attached to some pins?
If that's the case then perhaps it needs describing as something like...

Remote temperature sensor attached to the PS (procesisng system) APU MPCore.

For all these temperatures, do you intend to expose them as hwmon?
(which would be more conventional) via the iio-hmwon bridge/

> +
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_pl_temp
> +Date:		September 2018
> +KernelVersion:	4.19.0
> +Contact:	mnarani@xilinx.com
> +Description:
> +		Temperature input for PL (Programmable Logic) SYSMON.
