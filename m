Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39897 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHiJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2018 02:38:09 -0500
Date: Mon, 5 Nov 2018 16:16:15 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: meson-saradc: add
 temperature sensor support
Message-ID: <20181105221615.GA5718@bogus>
References: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
 <20181103231024.659-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181103231024.659-2-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Nov 2018 00:10:23 +0100, Martin Blumenstingl wrote:
> The 32-bit Meson8 SoC can use the SAR ADC to read the chip temperature.
> This requires setting the correct TSC (temperature sensor coefficient),
> which is programmed into the eFuse during the manufacturing process.
> Meson8b and Meson8m2 are not supported yet because they have a 5-bit TSC
> and only the first four bits are stored inside the SAR ADC registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
