Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60110 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932705AbbD0OuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Apr 2015 10:50:10 -0400
Message-ID: <553E4C78.8000100@ti.com>
Date: Mon, 27 Apr 2015 09:49:28 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com> <1429720331-1900-3-git-send-email-dmurphy@ti.com> <553D20CA.7090107@kernel.org>
In-Reply-To: <553D20CA.7090107@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jpnathan

On 04/26/2015 12:30 PM, Jonathan Cameron wrote:
> On 22/04/15 17:32, Dan Murphy wrote:
>> Add the TI afe4403 heart monitor device tree
>> binding documentation.  heart_monitors directory
>> created under iio.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  .../bindings/iio/heart_monitor/ti_afe4403.txt      | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
>> new file mode 100644
>> index 0000000..b196b17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
>> @@ -0,0 +1,26 @@
>> +* Texas Instruments - AFE4403 Heart rate and Pulse Oximeter
>> +
>> +The device consists of a low-noise receiver channel
>> +with an integrated analog-to-digital converter (ADC),
>> +an LED transmit section, and diagnostics for sensor and LED fault detection.
>> +
>> +Required properties:
>> +  - compatible: Must contain "ti,afe4403".
>> +  - ste-gpio: GPIO for the spi control line
> This gpio needs more info here.  From description it sounds like a chip select
> and those obviously don't need to be specified at driver level.

It is a chip select line.  There was an issue with this from the device side.
I will need to dig this up again and remember why I did this.

Maybe I can remove it.

Dan


>> +  - data-ready-gpio: GPIO interrupt when the afe4403 has data
>> +  - led-supply: Chip supply to the device
>> +
>> +Optional properties:
>> +  - reset-gpio: GPIO used to reset the device via HW
>> +
>> +Example:
>> +
>> +&heart_rate {
>> +	compatible = "ti,afe4403";
>> +	ste-gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
>> +	data-ready-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	led-supply = <&vbat>;
>> +};
>> +
>> +Technical Datasheet:
>> +http://www.ti.com/product/AFE4403/datasheet
>>


-- 
------------------
Dan Murphy

