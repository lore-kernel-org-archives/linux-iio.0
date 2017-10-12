Return-Path: <SRS0=YmNQ=BL=samsung.com=s.nawrocki@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-milliamp property to ina2xx
To: Maciej Purski <m.purski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck
	<linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet
	<corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim
	<kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Bartlomiej
	Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <3fc7a4e9-825d-587a-71e4-145feb8c625e@samsung.com>
Date: Thu, 12 Oct 2017 15:50:29 +0200
MIME-version: 1.0
In-reply-to: <1507814282-1486-4-git-send-email-m.purski@samsung.com>
Content-type: text/plain; charset="utf-8"
References: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
	<CGME20171012131816eucas1p292bc0e20f141cfd21fe27c40700d82fb@eucas1p2.samsung.com>
	<1507814282-1486-4-git-send-email-m.purski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

On 10/12/2017 03:18 PM, Maciej Purski wrote:
> diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> index 02af0d9..9268595 100644
> --- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> @@ -14,11 +14,13 @@ Optional properties:
>  
>  - shunt-resistor
>  	Shunt resistor value in micro-Ohm
> -
> +- ti-max-expected-current-milliamp

Normally after vendor name comma is used, so the property name 
should be "ti,max-expected-current-milliamp".
