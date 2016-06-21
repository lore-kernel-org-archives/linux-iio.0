Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35927 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcFUVoY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 17:44:24 -0400
Date: Tue, 21 Jun 2016 16:43:36 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: Re: [PATCH 2/3] iio: potentiometer: mcp4531: Add device tree binding
 documentation
Message-ID: <20160621214336.GB4370@rob-hp-laptop>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-3-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466492137-32683-3-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 21, 2016 at 08:55:36AM +0200, Florian Vaussard wrote:
> Add the device tree documentation for all the supported parts. Apart the
> compatible string and standard I2C binding, no other binding is currently
> needed.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  .../bindings/iio/potentiometer/mcp4531.txt         | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> new file mode 100644
> index 0000000..b052299
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> @@ -0,0 +1,84 @@
> +* Microchip MCP453X/454X/455X/456X/463X/464X/465X/466X Digital Potentiometer
> +  driver
> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +        Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the
> +			model:
> +			"microchip,mcp4531-502"

These can go in trivial-devices.txt

> +			"microchip,mcp4531-103"
> +			"microchip,mcp4531-503"
> +			"microchip,mcp4531-104"
> +			"microchip,mcp4532-502"
> +			"microchip,mcp4532-103"
> +			"microchip,mcp4532-503"
> +			"microchip,mcp4532-104"
> +			"microchip,mcp4541-502"
> +			"microchip,mcp4541-103"
> +			"microchip,mcp4541-503"
> +			"microchip,mcp4541-104"
> +			"microchip,mcp4542-502"
> +			"microchip,mcp4542-103"
> +			"microchip,mcp4542-503"
> +			"microchip,mcp4542-104"
> +			"microchip,mcp4551-502"
> +			"microchip,mcp4551-103"
> +			"microchip,mcp4551-503"
> +			"microchip,mcp4551-104"
> +			"microchip,mcp4552-502"
> +			"microchip,mcp4552-103"
> +			"microchip,mcp4552-503"
> +			"microchip,mcp4552-104"
> +			"microchip,mcp4561-502"
> +			"microchip,mcp4561-103"
> +			"microchip,mcp4561-503"
> +			"microchip,mcp4561-104"
> +			"microchip,mcp4562-502"
> +			"microchip,mcp4562-103"
> +			"microchip,mcp4562-503"
> +			"microchip,mcp4562-104"
> +			"microchip,mcp4631-502"
> +			"microchip,mcp4631-103"
> +			"microchip,mcp4631-503"
> +			"microchip,mcp4631-104"
> +			"microchip,mcp4632-502"
> +			"microchip,mcp4632-103"
> +			"microchip,mcp4632-503"
> +			"microchip,mcp4632-104"
> +			"microchip,mcp4641-502"
> +			"microchip,mcp4641-103"
> +			"microchip,mcp4641-503"
> +			"microchip,mcp4641-104"
> +			"microchip,mcp4642-502"
> +			"microchip,mcp4642-103"
> +			"microchip,mcp4642-503"
> +			"microchip,mcp4642-104"
> +			"microchip,mcp4651-502"
> +			"microchip,mcp4651-103"
> +			"microchip,mcp4651-503"
> +			"microchip,mcp4651-104"
> +			"microchip,mcp4652-502"
> +			"microchip,mcp4652-103"
> +			"microchip,mcp4652-503"
> +			"microchip,mcp4652-104"
> +			"microchip,mcp4661-502"
> +			"microchip,mcp4661-103"
> +			"microchip,mcp4661-503"
> +			"microchip,mcp4661-104"
> +			"microchip,mcp4662-502"
> +			"microchip,mcp4662-103"
> +			"microchip,mcp4662-503"
> +			"microchip,mcp4662-104"
> +	-reg: Slave I2C address of the potentiometer
> +
> +Example:
> +mcp4561: mcp4561@2e {
> +	compatible = "microchip,mcp4561-103";
> +	reg = <0x2e>;
> +};
> -- 
> 2.5.0
> 
