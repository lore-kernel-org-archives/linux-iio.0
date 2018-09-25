Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbeIYTNp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Sep 2018 15:13:45 -0400
Date: Tue, 25 Sep 2018 14:05:30 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Song Qiang <songqiang1304521@gmail.com>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <preid@electromag.com.au>, <rtresidd@electromag.com.au>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: magnetometer: Add DT support for PNI RM3100
Message-ID: <20180925140530.00005fa3@huawei.com>
In-Reply-To: <20180925031724.21399-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 25 Sep 2018 11:17:23 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> composed of 3 single sensors and a processing chip with MagI2C Interface.
> PNI is not in the vendors' list, so this patch is also adding it.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Hi Song,

Please clearly mark the title of the patch with V2.
[PATCH 1/2 V2] ...

(or I'm also happy with a cover letter that does the same though other
maintainers ask for every patch to be marked v2).

This makes it easy to quickly short the versions and check we are
looking at the latest.
> ---
> Changes in v2:
>         - Remove bus specific part in compatible string.
> 
>  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> new file mode 100644
> index 000000000000..4677690fc5d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,20 @@
> +* PNI RM3100 3-axis magnetometer sensor
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100"
> +- reg : the I2C address or SPI chip select number of the sensor.
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on rising edges.
> +
> +Example:
> +
> +rm3100: rm3100@20 {
> +	compatible = "pni,rm3100";
> +	reg = <0x20>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 41f0b97eb933..5bf3395fe9ae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -288,6 +288,7 @@ pine64	Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
> +pni     PNI

A quick scan around their website suggests they are actually
"PNI Sensor Corporation"
I'm not sure how fussy we are on naming in here but probable best to be as specific
as possible.

>  portwell	Portwell Inc.
>  poslab	Poslab Technology Co., Ltd.
>  powervr	PowerVR (deprecated, use img)
