Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:22867
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755108AbeDPOAw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Apr 2018 10:00:52 -0400
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt and
 voltage-divider
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180410152802.30958-2-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Message-ID: <f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
Date: Mon, 16 Apr 2018 16:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180410152802.30958-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-04-10 17:28, Peter Rosin wrote:
> +Example:
> +The system voltage is circa 12V, but divided down with a 22/200
> +voltage divider to adjust it to the ADC range.
> +
> +SYSV        ADC       GND
> +  +          +         +
> +  |  .-----. | .----.  |
> +  '--| 200 |-+-| 22 |--'
> +     '-----'   '----'
> +
> +sysv {
> +	compatible = "voltage-divider";
> +	io-channels = <&maxadc 1>;
> +
> +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
> +	numerator = <222>; /* 200 + 22 */
> +	denominator = <22>;
> +};

While I already got a reviewed-by from Rob, and maybe I shouldn't be
stirring the pot, but I had an umpteenth look and I now think this
one looks a bit odd. It shows a bit that it originates from when the
compatible was the very generic "io-channel-unit-converter" in v1
of the series. What I mean is that a voltage divider presumable always
gets you a lower voltage. Therefore, one would assume that the
denominator should be larger than the numerator. The fact that this
translates into the inverted fraction when calculating backwards
through the voltage divider should probably not affect the binding.

So, in the above example, I think it would make more sense to have

	numerator = <22>;
	denominator = <222>; /* 200 + 22 */

(and then, naturally, adjust the driver to invert the fraction)

Comments?

Cheers,
Peter
