Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-am1on0130.outbound.protection.outlook.com ([157.56.112.130]:11711
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751438AbcFZWLc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 26 Jun 2016 18:11:32 -0400
Subject: Re: [PATCH v2 2/4] iio: potentiometer: mcp4531: Add device tree
 binding documentation
To: Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
References: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466972567-9580-3-git-send-email-florian.vaussard@heig-vd.ch>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	"Joachim Eastwood" <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	"Cristina Moraru" <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Peter Rosin <peda@axentia.se>
Message-ID: <32d8162f-bb62-2c90-d194-0023320be392@axentia.se>
Date: Sun, 26 Jun 2016 23:38:35 +0200
MIME-Version: 1.0
In-Reply-To: <1466972567-9580-3-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-06-26 22:22, Florian Vaussard wrote:
> Add the device tree documentation for all the supported parts. Apart the
> compatible string and standard I2C binding, no other binding is currently
> needed.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 53987449..4ffe9a9 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -56,6 +56,70 @@ maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
>  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
>  mc,rv3029c2		Real Time Clock Module with I2C-Bus
> +microchip,mcp4531-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
                                          ^
You have mixed up 7/8-bit, here and below.

Cheers,
Peter

> +microchip,mcp4531-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
> +microchip,mcp4531-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
> +microchip,mcp4531-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
> +microchip,mcp4532-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
> +microchip,mcp4532-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
> +microchip,mcp4532-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
> +microchip,mcp4532-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
> +microchip,mcp4541-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4541-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4541-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4541-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4542-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4542-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4542-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4542-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4551-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
> +microchip,mcp4551-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
> +microchip,mcp4551-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
> +microchip,mcp4551-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
> +microchip,mcp4552-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
> +microchip,mcp4552-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
> +microchip,mcp4552-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
> +microchip,mcp4552-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
> +microchip,mcp4561-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4561-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4561-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4561-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4562-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4562-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4562-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4562-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4631-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
> +microchip,mcp4631-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
> +microchip,mcp4631-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
> +microchip,mcp4631-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
> +microchip,mcp4632-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
> +microchip,mcp4632-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
> +microchip,mcp4632-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
> +microchip,mcp4632-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
> +microchip,mcp4641-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4641-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4641-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4641-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4642-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4642-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4642-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4642-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4651-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
> +microchip,mcp4651-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
> +microchip,mcp4651-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
> +microchip,mcp4651-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
> +microchip,mcp4652-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
> +microchip,mcp4652-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
> +microchip,mcp4652-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
> +microchip,mcp4652-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
> +microchip,mcp4661-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4661-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4661-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4661-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +microchip,mcp4662-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
> +microchip,mcp4662-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
> +microchip,mcp4662-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
> +microchip,mcp4662-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
>  national,lm63		Temperature sensor with integrated fan control
>  national,lm75		I2C TEMP SENSOR
>  national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
> 

