Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:27296
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760170AbbA1BdY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 20:33:24 -0500
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Stefan Agner <stefan@agner.ch>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"maitysanchayan@gmail.com" <maitysanchayan@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] iio: adc: vf610: respect ADC clocking limitations
Date: Wed, 28 Jan 2015 01:33:16 +0000
Message-ID: <BLUPR03MB37366EC9DAB3A4B0A16E72BF5330@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1421769723-28677-1-git-send-email-stefan@agner.ch>
In-Reply-To: <1421769723-28677-1-git-send-email-stefan@agner.ch>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stefan Agner <stefan@agner.ch> Sent: Wednesday, January 21, 2015 12:02 AM
> To: jic23@kernel.org
> Cc: shawn.guo@linaro.org; Duan Fugang-B38611; maitysanchayan@gmail.com;
> linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; stefan@agner.ch
> Subject: [PATCH 0/3] iio: adc: vf610: respect ADC clocking limitations
> 
> Respect ADC clocking limitations which lead to bogous reading on 500MHz
> clocked Vybrid SoC's. Additionally, also implement a sysfs-property to
> configure the conversion mode available in this ADC peripherial.
> 
> Stefan Agner (3):
>   iio: adc: vf610: use ADC clock within specification
>   iio: adc: vf610: implement configurable conversion modes
>   ARM: dts: add property for maximum ADC clock frequencies
> 
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
>  arch/arm/boot/dts/vfxxx.dtsi                       |   4 +
>  drivers/iio/adc/vf610_adc.c                        | 175
> +++++++++++++++++----
>  3 files changed, 156 insertions(+), 32 deletions(-)
> 
> --
> 2.2.2

The patch set are fine for me.

Acked-by: Fugang Duan <B38611@freescale.com>

Thanks. 
Fugang
