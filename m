Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33123 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbbDRSIn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 14:08:43 -0400
Message-ID: <55329DA9.1050305@kernel.org>
Date: Sat, 18 Apr 2015 19:08:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 3/3] iio: magn: bmc150_magn: Add devicetree binding documentation
References: <1429267830-13681-1-git-send-email-irina.tirdea@intel.com> <1429267830-13681-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1429267830-13681-4-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/15 11:50, Irina Tirdea wrote:
> Add binding documentation for Bosch BMC150 magnetometer.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  .../bindings/iio/magnetometer/bmc150_magn.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> new file mode 100644
> index 0000000..4ed035c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> @@ -0,0 +1,20 @@
> +* Bosch BMC150 magnetometer sensor
> +
> +http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf
> +
> +Required properties:
> +
> +  - compatible : should be "bosch,bmc150_magn"
> +  - reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +  - gpios : should be device tree identifier of the magnetometer DRDY pin
Hmm. Under device tree this should be done as an interrupt.  You only
(currently) need the dubious frig with gpios for ACPI I think.
> +
> +Example:
> +
> +bmc150_magn@12 {
> +        compatible = "bosch,bmc150_magn";
> +        reg = <0x12>;
> +        interrupt-gpio = <&gpio1 0 1>;
> +};
> 

