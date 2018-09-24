Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeIYCMq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:12:46 -0400
Date: Mon, 24 Sep 2018 21:08:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ryang <decatf@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree
 binding documentation
Message-ID: <20180924210849.373f765e@archlinux>
In-Reply-To: <20180922205754.6100-1-decatf@gmail.com>
References: <20180922205754.6100-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 22 Sep 2018 16:57:53 -0400
ryang <decatf@gmail.com> wrote:

> Document device tree bindings for ROHM BH1750 ambient light sensor driver.
> 
> Signed-off-by: ryang <decatf@gmail.com>
The devicetree maintainers haven't yet had a chance to look at this
so we may well still get feedback from them.  As I'm not planning on a
pull request for a few days I'll apply this to the tree I push out
as testing for the autobuilders to play with.  The advantage if this
is that isn't a non rebasing tree so I can add acks if they come in
before I push it out as togreg ready for a pull request.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> new file mode 100644
> index 000000000000..468350cc7af6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> @@ -0,0 +1,18 @@
> +ROHM BH1750 - ALS, Ambient light sensor
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +    "rohm,bh1710"
> +    "rohm,bh1715"
> +    "rohm,bh1721"
> +    "rohm,bh1750"
> +    "rohm,bh1751"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +bh1750@23 {
> +	compatible = "rohm,bh1750";
> +	reg = <0x23>;
> +};
