Return-Path: <SRS0=7/Tb=3H=gmail.com=robherring2@kernel.org>
Date: Thu, 30 Mar 2017 17:47:45 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, linux-iio@vger.kernel.org, carlo@caione.org,
	khilman@baylibre.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: add a Meson8b compatible
 to the SAR ADC
Message-ID: <20170330224745.v5cgrihkoolufxzo@rob-hp-laptop>
References: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
 <20170325162938.28659-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170325162938.28659-2-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 25, 2017 at 05:29:37PM +0100, Martin Blumenstingl wrote:
> The Amlogic Meson SAR ADC driver can be used on Meson8b as well
> (probably on earlier SoC generations as well, but I don't have any
> hardware available for testing that).
> Add a separate compatible for Meson8b because it does not need any of
> the BL30 magic (unlike the GX SoCs).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)

If you respin, "dt-bindings: iio: adc: ..." for the subject. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
