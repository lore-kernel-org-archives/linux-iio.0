Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdI3RSr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 13:18:47 -0400
Date: Sat, 30 Sep 2017 18:18:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ismail H. Kose" <Ismail.Kose@maximintegrated.com>
Cc: ihkose@gmail.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Peter Rosin <peda@axentia.se>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio:dac: Add DT binding documentation for ds4424
Message-ID: <20170930181841.63b07a12@archlinux>
In-Reply-To: <20170922201226.23721-2-Ismail.Kose@maximintegrated.com>
References: <20170922201226.23721-1-Ismail.Kose@maximintegrated.com>
        <20170922201226.23721-2-Ismail.Kose@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 22 Sep 2017 13:12:09 -0700
"Ismail H. Kose" <Ismail.Kose@maximintegrated.com> wrote:

> Signed-off-by: Ismail H. Kose <ihkose@gmail.com>
> Signed-off-by: Ismail H. Kose <Ismail.Kose@maximintegrated.com>

Direct at Rob Herring...

Rob, this is now a very standard binding so I'm going to
take it into my testing tree.  If you have a chance to take a last
look at it though that would be great.

For everyone else: 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> v6:
> 	* Removed reference resistors property
> 	* Fixed regulator property
> v3:
> 	* Removed iio-map
> v2:
> 	* Removed min/max rfs, ifs-scale, etc values
> 
>  Documentation/devicetree/bindings/iio/dac/ds4424.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> new file mode 100644
> index 000000000000..eaebbf8dab40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> @@ -0,0 +1,20 @@
> +Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device Driver
> +
> +Datasheet publicly available at:
> +https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
> +
> +Required properties:
> +	- compatible: Should be one of
> +		maxim,ds4422
> +		maxim,ds4424
> +	- reg: Should contain the DAC I2C address
> +
> +Optional properties:
> +	- vcc-supply: Power supply is optional. If not defined, driver will ignore it.
> +
> +Example:
> +	ds4224@10 {
> +		compatible = "maxim,ds4424";
> +		reg = <0x10>; /* When A0, A1 pins are ground */
> +		vcc-supply = <&vcc_3v3>;
> +	};

