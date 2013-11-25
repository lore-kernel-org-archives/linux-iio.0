Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56091 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3KYRXH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 12:23:07 -0500
In-Reply-To: <1385372071-5108-1-git-send-email-B38611@freescale.com>
References: <1385372071-5108-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v1 0/3] *** iio:adc:imx: Add Freescale Vybrid/IMX ADC driver support ***
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 25 Nov 2013 17:23:01 +0000
To: Fugang Duan <B38611@freescale.com>, sachin.kamat@linaro.org
CC: shawn.guo@linaro.org, b20596@freescale.com,
	linux-iio@vger.kernel.org, marex@denx.de
Message-ID: <f427f209-0557-4894-b607-5d5f6c6b82ae@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Fugang Duan <B38611@freescale.com> wrote:
>The patch set is to enable Vybrid VF610 ADC driver. It is the init
>version.
>
>Please see the Reference Manual of the ADC:
>http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=1&WT_TYPE=
>Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
>
>Feature:
>* Enable Vybrid vf610 board ADC0 in dts file.
>* ADC driver only support software trigger for the init version.
>* ADC configuration support dts set.
>
>Note: Since the ADC IP is used for Freescale Vybrid VF610, i.MX6SLX,
>i.MX7 serial sillicons,
>      we name the driver name to "imx_adc".
>
It will be a little while before I have a chance to give this a thorough review but in the meantime...

The naming is probably too generic. We already have another I.MX ADC driver. Mxs-lradc which is on the I.MX23 and I.mx28

I would go for naming it after one part then rely on kconfig help and grep to ensure people work out what the driver covers.
Compatible strings in DT also help of course 

>Test:
>* Vybrid vf610-twr board connect ADC0 SE5 pin to one sliding rheostat
>for ADC test, so
>  after kernel up, get the voltage from sys interface:
>	cat /sys/bus/iio/devices/iio\:device0/in_voltage5_raw
>	cat /sys/bus/iio/devices/iio\:device0/in_voltage_scale
>
>	The current voltage = in_voltage5_raw * in_voltage_scale (uV).
>
>
>Fugang Duan (3):
>  ARM: dts: vf610-twr: Add ADC support
>  iio:adc:imx: add Freescale Vybrid board adc driver
>  Documentation: add the binding file for Freescale (Vybrid/IMX) ADC
>    driver
>
> .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++
> arch/arm/boot/dts/vf610-twr.dts                    |   14 +
> arch/arm/boot/dts/vf610.dtsi                       |   26 +
> drivers/iio/adc/Kconfig                            |   10 +
> drivers/iio/adc/Makefile                           |    1 +
>drivers/iio/adc/imx_adc.c                          |  748
>++++++++++++++++++++
> 6 files changed, 856 insertions(+), 0 deletions(-)
>create mode 100644
>Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> create mode 100644 drivers/iio/adc/imx_adc.c

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
