Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46422 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdA1Qjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 11:39:36 -0500
Subject: Re: [PATCH v4 1/3] iio: distance: srf08: add trivial DT binding
To: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
References: <20170125190648.GA9260@andreas>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f26e31b7-11ad-c902-65ae-2a0b4a5fabb5@kernel.org>
Date: Sat, 28 Jan 2017 16:39:04 +0000
MIME-Version: 1.0
In-Reply-To: <20170125190648.GA9260@andreas>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/01/17 19:06, Andreas Klinger wrote:
>  - Add DT binding for devantech,srf08
>  - Add vendor devantech to vendor list
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.  Will be first
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 539874490492..86c6930c3c91 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -36,6 +36,7 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
>  dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
>  dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
>  dallas,ds75		Digital Thermometer and Thermostat
> +devantech,srf08		Devantech SRF08 ultrasonic ranger
>  dlg,da9053		DA9053: flexible system level PMIC with multicore support
>  dlg,da9063		DA9063: system PMIC for quad-core application processors
>  epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4696bb5c2198..80325e602403 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -65,6 +65,7 @@ dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom	DAVICOM Semiconductor, Inc.
>  delta	Delta Electronics, Inc.
>  denx	Denx Software Engineering
> +devantech	Devantech, Ltd.
>  digi	Digi International Inc.
>  digilent	Diglent, Inc.
>  dlg	Dialog Semiconductor
> 

