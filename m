Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38099 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbbHaPsk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:48:40 -0400
Subject: Re: [PATCH v6 1/2] devicetree: add PulsedLight vendor + device docs
To: Matt Ranostay <mranostay@gmail.com>
References: <1439908838-6945-1-git-send-email-mranostay@gmail.com>
 <1439908838-6945-2-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E47756.1050704@kernel.org>
Date: Mon, 31 Aug 2015 16:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <1439908838-6945-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/15 15:40, Matt Ranostay wrote:
> Add pulsedlight vendor to vendor-prefixes.txt, and LIDAR device
> documentation to trivial-devices.txt
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index d77d412..cecd315 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -80,6 +80,7 @@ oki,ml86v7667		OKI ML86V7667 video decoder
>  ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
>  pericom,pt7c4338	Real-time Clock Module
>  plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
> +pulsedlight,lidar-lite-v2	Pulsedlight LIDAR range-finding sensor
>  ramtron,24c64		i2c serial eeprom  (24cxx)
>  ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>  ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 3ac71a8..c220209 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -166,6 +166,7 @@ phytec	PHYTEC Messtechnik GmbH
>  picochip	Picochip Ltd
>  plathome	Plat'Home Co., Ltd.
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> +pulsedlight	PulsedLight, Inc
>  powervr	PowerVR (deprecated, use img)
>  qca	Qualcomm Atheros, Inc.
>  qcom	Qualcomm Technologies, Inc
> 

