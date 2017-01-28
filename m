Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45297 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdA1MaY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:30:24 -0500
Subject: Re: [PATCH v4 1/3] Documentation: dt-bindings: add the Amlogic Meson
 SAR ADC documentation
To: Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
 <20170122181714.6259-2-martin.blumenstingl@googlemail.com>
 <20170123204432.2lkh3zlgzmwye3hj@rob-hp-laptop>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, carlo@caione.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4611e3bf-8e25-9f7c-7c34-6eca85ffc3d6@kernel.org>
Date: Sat, 28 Jan 2017 12:30:11 +0000
MIME-Version: 1.0
In-Reply-To: <20170123204432.2lkh3zlgzmwye3hj@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/17 20:44, Rob Herring wrote:
> On Sun, Jan 22, 2017 at 07:17:12PM +0100, Martin Blumenstingl wrote:
>> This adds the devicetree binding documentation for the SAR ADC found in
>> Amlogic Meson SoCs.
>> Currently only the GXBB, GXL and GXM SoCs are supported.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  .../bindings/iio/adc/amlogic,meson-saradc.txt      | 32 ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan

