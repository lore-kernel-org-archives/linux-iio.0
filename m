Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbdHIXdP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 19:33:15 -0400
Date: Thu, 10 Aug 2017 00:33:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: srf08: add device tree binding for srf02 and
 srf10
Message-ID: <20170810003306.651be1a1@archlinux>
In-Reply-To: <20170802232335.GA15222@arbeit>
References: <20170802232335.GA15222@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 01:23:35 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Please remember to cc the device tree maintainers and list of bindings.
For trivial ones, sometimes it makes more sense for them to pick them
up directly as it reduces the chance of conflict on merges.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index ad10fbe61562..0e5fb016e912 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -36,7 +36,9 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
>  dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
>  dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
>  dallas,ds75		Digital Thermometer and Thermostat
> +devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
>  devantech,srf08		Devantech SRF08 ultrasonic ranger
> +devantech,srf10		Devantech SRF10 ultrasonic ranger
>  dlg,da9053		DA9053: flexible system level PMIC with multicore support
>  dlg,da9063		DA9063: system PMIC for quad-core application processors
>  domintech,dmard09	DMARD09: 3-axis Accelerometer

