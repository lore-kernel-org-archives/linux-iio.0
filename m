Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46659 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbcKSMV6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 07:21:58 -0500
Subject: Re: [PATCH v3 4/6] ARM: configs: stm32: enable ADC driver
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux@armlinux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3f6d8fdd-31ed-06a1-22c0-ce6f06dead81@kernel.org>
Date: Sat, 19 Nov 2016 12:21:55 +0000
MIME-Version: 1.0
In-Reply-To: <1479223861-21747-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/16 15:30, Fabrice Gasnier wrote:
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
The driver is now on it's way in.  I'm assuming this and the two device tree patches
will go via the relevant route to arm-soc.

Thanks,

Jonathan
> ---
>  arch/arm/configs/stm32_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 1e5ec2a..5d241e0 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -57,6 +57,9 @@ CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_DMADEVICES=y
>  CONFIG_STM32_DMA=y
> +CONFIG_IIO=y
> +CONFIG_STM32_ADC_CORE=y
> +CONFIG_STM32_ADC=y
>  # CONFIG_FILE_LOCKING is not set
>  # CONFIG_DNOTIFY is not set
>  # CONFIG_INOTIFY_USER is not set
> 

