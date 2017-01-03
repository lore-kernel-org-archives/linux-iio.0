Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34092 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbdACPbO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2017 10:31:14 -0500
Date: Tue, 3 Jan 2017 09:30:37 -0600
From: Rob Herring <robh@kernel.org>
To: Allen Liu <liurenzhong@hisilicon.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, akinobu.mita@gmail.com,
        ludovic.desroches@atmel.com, krzk@kernel.org,
        vilhelm.gray@gmail.com, ksenija.stanojevic@gmail.com,
        zhiyong.tao@mediatek.com, daniel.baluta@intel.com,
        leonard.crestez@intel.com, ray.jui@broadcom.com,
        raveendra.padasalagi@broadcom.com, mranostay@gmail.com,
        amsfield22@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com
Subject: Re: [PATCH] adc: add adc driver for Hisilicon BVT SOCs
Message-ID: <20170103153037.oypo4jmt7naqheye@rob-hp-laptop>
References: <1482544497-136656-1-git-send-email-liurenzhong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482544497-136656-1-git-send-email-liurenzhong@hisilicon.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Dec 24, 2016 at 09:54:57AM +0800, Allen Liu wrote:
> Add ADC driver for the ADC controller found on HiSilicon BVT SOCs, like Hi3516CV300, etc.
> The ADC controller is primarily in charge of detecting voltage.
> 
> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Allen Liu <liurenzhong@hisilicon.com>
> ---
>  .../devicetree/bindings/iio/adc/hibvt-lsadc.txt    |  26 ++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/hibvt_lsadc.c                      | 344 +++++++++++++++++++++
>  4 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
>  create mode 100644 drivers/iio/adc/hibvt_lsadc.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> new file mode 100644
> index 0000000..63de46e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> @@ -0,0 +1,26 @@
> +Hisilicon BVT Low Speed (LS) A/D Converter bindings
> +
> +Required properties:
> +- compatible: should be "hisilicon,<name>-lsadc"
> +   - "hisilicon,hibvt-lsadc": for hi3516cv300

Use the SoC name in the compatible string.

> +
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +              depends on the interrupt controller.
> +- #io-channel-cells: Should be 1, see ../iio-bindings.txt
> +
> +Optional properties:
> +- resets: Must contain an entry for each entry in reset-names if need support
> +	  this option. See ../reset/reset.txt for details.
> +- reset-names: Must include the name "saradc-apb".
> +
> +Example:
> +	lsadc: hibvt-lsadc@120e0000 {

Just "adc@..."

> +			compatible = "hisilicon,hibvt-lsadc";
> +			reg = <0x120e0000 0x1000>;
> +			interrupts = <19>;
> +			resets = <&crg 0x7c 3>;
> +			reset-names = "lsadc-crg";
> +			status = "disabled";
> +	};
