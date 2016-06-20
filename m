Return-Path: <robherring2@gmail.com>
Date: Mon, 20 Jun 2016 11:46:45 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: pressure: bmp280: augment DT bindings
Message-ID: <20160620164645.GA3191@rob-hp-laptop>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 17, 2016 at 05:12:18PM +0200, Linus Walleij wrote:
> This adds standard device tree bindings for a reset GPIO line, and
> the VDDD and VDDA power regulators.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> index d7a6deb6b21e..06ad5feaea28 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> @@ -1,7 +1,7 @@
> -BMP085/BMP18x digital pressure sensors
> +BMP085/BMP18x/BMP28x digital pressure sensors
>  
>  Required properties:
> -- compatible: bosch,bmp085
> +- compatible: "bosch,bmp085" or "bosch,bmp180" or "bosch,bmp280"

One per line is preferred, but I wouldn't respin just for that.

Acked-by: Rob Herring <robh@kernel.org>
