Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752911AbeDUOex (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 10:34:53 -0400
Date: Sat, 21 Apr 2018 15:34:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
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
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt
 and voltage-divider
Message-ID: <20180421153452.6499e151@archlinux>
In-Reply-To: <f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
        <20180410152802.30958-2-peda@axentia.se>
        <f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Apr 2018 16:00:44 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-10 17:28, Peter Rosin wrote:
> > +Example:
> > +The system voltage is circa 12V, but divided down with a 22/200
> > +voltage divider to adjust it to the ADC range.
> > +
> > +SYSV        ADC       GND
> > +  +          +         +
> > +  |  .-----. | .----.  |
> > +  '--| 200 |-+-| 22 |--'
> > +     '-----'   '----'
> > +
> > +sysv {
> > +	compatible = "voltage-divider";
> > +	io-channels = <&maxadc 1>;
> > +
> > +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
> > +	numerator = <222>; /* 200 + 22 */
> > +	denominator = <22>;
> > +};  
> 
> While I already got a reviewed-by from Rob, and maybe I shouldn't be
> stirring the pot, but I had an umpteenth look and I now think this
> one looks a bit odd. It shows a bit that it originates from when the
> compatible was the very generic "io-channel-unit-converter" in v1
> of the series. What I mean is that a voltage divider presumable always
> gets you a lower voltage. Therefore, one would assume that the
> denominator should be larger than the numerator. The fact that this
> translates into the inverted fraction when calculating backwards
> through the voltage divider should probably not affect the binding.
> 
> So, in the above example, I think it would make more sense to have
> 
> 	numerator = <22>;
> 	denominator = <222>; /* 200 + 22 */
> 
> (and then, naturally, adjust the driver to invert the fraction)
> 
> Comments?
Agreed - it is odd as we currently have it.  I wouldn't have
a particular problem with renaming this compatible as voltage
scaler (voltage multiplier has a specific meaning we should avoid
stepping on!)  Anyhow, either way is fine with me, but I agree
the current version is odd.

Jonathan

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

