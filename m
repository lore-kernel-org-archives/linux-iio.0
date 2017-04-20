Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35138 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946328AbdDTOVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2017 10:21:38 -0400
Date: Thu, 20 Apr 2017 09:21:35 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] Documentation: dt-bindings: iio: adc: add Meson8 and
 Meson8b support
Message-ID: <20170420142135.4abputt7z4pkvvdx@rob-hp-laptop>
References: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
 <20170417182820.26670-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170417182820.26670-2-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 17, 2017 at 08:28:18PM +0200, Martin Blumenstingl wrote:
> The Amlogic Meson SAR ADC driver can be used on Meson8 and Meson8b
> (probably on earlier SoC generations as well, but I don't have any
> hardware available for testing that).
> Add a separate compatible for Meson8 and Meson8b because it does not
> need any of the BL30 magic (unlike the GX SoCs).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 2 ++
>  1 file changed, 2 insertions(+)

I'd prefer "Documentation: " prefix is dropped as that's implied with 
"dt-bindings". Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
