Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36367 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbdC2V0l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:26:41 -0400
Date: Wed, 29 Mar 2017 16:26:37 -0500
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv3] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Message-ID: <20170329212637.syluvxy5cp2qub3h@rob-hp-laptop>
References: <20170324033842.12541-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170324033842.12541-1-tony@atomide.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 23, 2017 at 08:38:42PM -0700, Tony Lindgren wrote:
> On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
> has ADCs that are used for battery charging and USB PHY VBUS and ID pin
> detection.
> 
> Unfortunately the only documentation for this ADC seems to be the
> Motorola mapphone Linux kernel tree. I have tested that reading raw and
> scaled values works, but I have not used the timed sampling that the ADC
> seems to support.
> 
> Let's add a minimal support for it so we can eventually provide IIO
> channels for the related battery charging and USB PHY drivers.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v2:
> 
> - Simplify things further by using channel based indexing and
>   remove more drivers specific enumerations
> 
> Changes since v1:
> 
> - Fix numerous issues pointed out by Peter Meerwald-Stadler
>   <pmeerw@pmeerw.net> and Jonathan Cameron <jic23@kernel.org>
> 
> - Simplify things further by limiting read functions to a
>   single channel instead of a bank and got rid of the driver
>   specific cpcap_adc_conv_type in favor of IIO generic types
> 
> ---
>  .../devicetree/bindings/iio/adc/cpcap-adc.txt      |   18 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |   11 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/cpcap-adc.c                        | 1007 ++++++++++++++++++++
>  4 files changed, 1037 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
>  create mode 100644 drivers/iio/adc/cpcap-adc.c
