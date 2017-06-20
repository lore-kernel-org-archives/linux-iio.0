Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdFTQqO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:46:14 -0400
Date: Tue, 20 Jun 2017 17:46:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: humidity: add bindings for
 HDC100x sensors
Message-ID: <20170620174607.01db6525@kernel.org>
In-Reply-To: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
References: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 19 Jun 2017 11:01:04 -0500
Michael Stecklein <m-stecklein@ti.com> wrote:

> Add the bindings for the family of HDC100x sensors.
> 
> Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
Ideally a brief note below the --- would have said what was different
from v1.

Given you have fixed the stuff Rob mentioned, I'll assume he will
be fine with the result.  Will be possible to change it for a few
days anyway as pushed out as testing which I'm willing to rebase.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/humidity/hdc100x.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> new file mode 100644
> index 0000000..c52333b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> @@ -0,0 +1,17 @@
> +* HDC100x temperature + humidity sensors
> +
> +Required properties:
> +  - compatible: Should contain one of the following:
> +	ti,hdc1000
> +	ti,hdc1008
> +	ti,hdc1010
> +	ti,hdc1050
> +	ti,hdc1080
> +  - reg: i2c address of the sensor
> +
> +Example:
> +
> +hdc100x@40 {
> +	compatible = "ti,hdc1000";
> +	reg = <0x40>;
> +};

