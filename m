Return-Path: <SRS0=rmbY=LN=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: Add Xilinx AMS driver
To: Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
 mark.rutland@arm.com, michal.simek@xilinx.com, leoyang.li@nxp.com,
 sudeep.holla@arm.com, amit.kucheria@linaro.org, broonie@kernel.org,
 arnaud.pouliquen@st.com, geert@linux-m68k.org, eugen.hristev@microchip.com,
 lukas@wunner.de, freeman.liu@spreadtrum.com, vilhelm.gray@gmail.com,
 tglx@linutronix.de, baolin.wang@linaro.org, gregkh@linuxfoundation.org
Cc: sgoud@xilinx.com, anirudh@xilinx.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <378c10f8-9760-b36a-431d-4ce4339d7345@infradead.org>
Date: Thu, 30 Aug 2018 08:36:52 -0700
MIME-Version: 1.0
In-Reply-To: <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/30/2018 03:22 AM, Manish Narani wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
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
