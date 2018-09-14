Return-Path: <SRS0=SnZD=L4=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 14 Sep 2018 17:29:28 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Manish Narani <manish.narani@xilinx.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
	sudeep.holla@arm.com, amit.kucheria@linaro.org, leoyang.li@nxp.com,
	broonie@kernel.org, arnaud.pouliquen@st.com,
	eugen.hristev@microchip.com, rdunlap@infradead.org,
	geert@linux-m68k.org, ak@it-klinger.de, freeman.liu@spreadtrum.com,
	lukas@wunner.de, vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
	kstewart@linuxfoundation.org, sgoud@xilinx.com, anirudh@xilinx.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	gustavo@embeddedor.com
Subject: Re: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20180914115928.GA6465@himanshu-Vostro-3559>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Manish,

On Fri, Sep 14, 2018 at 12:48:29PM +0530, Manish Narani wrote:
> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from external master. Out of these interface currently only DRP is
> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
[]
> +// SPDX-License-Identifier: GPL-2.0

License Identifier seems inconsistent as below you
mentioned "GPL" and not "GPLv2".


Please check once.
Documentation/process/license-rules.rst


> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->address) {
> +			case AMS_SUPPLY1:
			/* fall through */
> +			case AMS_SUPPLY2:
			/* fall through */


Similarly to others as well.
There is a plan to enable "-Wimplicit-fallthrough" gcc flag
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

Also, Gustavo nearly cleaned all the cases and would save
his effort of doing it again :)
https://lore.kernel.org/lkml/20180903183618.GA6905@embeddedor.com/

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Xilinx, Inc.");


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
