Return-Path: <SRS0=stxv=L4=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
To: Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
 sudeep.holla@arm.com, amit.kucheria@linaro.org, leoyang.li@nxp.com,
 broonie@kernel.org, arnaud.pouliquen@st.com, eugen.hristev@microchip.com,
 geert@linux-m68k.org, ak@it-klinger.de, freeman.liu@spreadtrum.com,
 lukas@wunner.de, vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org
Cc: sgoud@xilinx.com, anirudh@xilinx.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f169ebb6-6c2c-6f30-d59c-e89561622ecb@infradead.org>
Date: Fri, 14 Sep 2018 14:30:11 -0700
MIME-Version: 1.0
In-Reply-To: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 9/14/18 12:18 AM, Manish Narani wrote:
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/Kconfig      |   10 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1337 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1348 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called

oops (some other driver:)
	                         built

>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS.
> +
> +	  The driver can also be build as a module. If so, the module will be called

	                         built

> +	  xilinx-ams.
> +
>  endmenu


-- 
~Randy
