Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Patrick Titiano <ptitiano@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
Date: Tue, 29 Nov 2016 16:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/29/2016 04:22 PM, Bartosz Golaszewski wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
> new file mode 100644
> index 0000000..147458f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
> @@ -0,0 +1,18 @@
> +Industrial IO regulator device driver
> +-------------------------------------
> +
> +This document describes the bindings for the iio-regulator - a dummy device
> +driver representing a physical regulator within the iio framework.

No bindings for drivers, only for hardware. So this wont work.
