Return-Path: <SRS0=53Ys=ZF=gmail.com=robherring2@kernel.org>
Date: Mon, 23 Jan 2017 14:44:32 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, khilman@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org, carlo@caione.org,
	catalin.marinas@arm.com, will.deacon@arm.com,
	narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] Documentation: dt-bindings: add the Amlogic Meson
 SAR ADC documentation
Message-ID: <20170123204432.2lkh3zlgzmwye3hj@rob-hp-laptop>
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
 <20170122181714.6259-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170122181714.6259-2-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 22, 2017 at 07:17:12PM +0100, Martin Blumenstingl wrote:
> This adds the devicetree binding documentation for the SAR ADC found in
> Amlogic Meson SoCs.
> Currently only the GXBB, GXL and GXM SoCs are supported.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../bindings/iio/adc/amlogic,meson-saradc.txt      | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt

Acked-by: Rob Herring <robh@kernel.org>
