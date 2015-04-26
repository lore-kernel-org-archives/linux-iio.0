Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41858 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbDZRUr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 13:20:47 -0400
Message-ID: <553D1E6D.9040508@kernel.org>
Date: Sun, 26 Apr 2015 18:20:45 +0100
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
Subject: Re: [PATCH v2 2/4] iio: magn: bmc150_magn: Add devicetree binding
 documentation
References: <1429814048-22808-1-git-send-email-irina.tirdea@intel.com> <1429814048-22808-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1429814048-22808-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/04/15 19:34, Irina Tirdea wrote:
> Add binding documentation for Bosch BMC150 magnetometer.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
This is trivial enough that I'll happily take it once the 3 weeks from first
posting are up (I'm guessing that still applies to device tree bindings).
> ---
>  .../bindings/iio/magnetometer/bmc150_magn.txt      | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> new file mode 100644
> index 0000000..9f263b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> @@ -0,0 +1,22 @@
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
> +  - interrupt-parent : phandle to the parent interrupt controller
> +  - interrupts : interrupt mapping for GPIO IRQ
> +
> +Example:
> +
> +bmc150_magn@12 {
> +        compatible = "bosch,bmc150_magn";
> +        reg = <0x12>;
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <0 1>;
> +};
> 

