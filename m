Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcFCKTa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 06:19:30 -0400
Subject: Re: [PATCH 1/3] iio: adc: ina3221: Add DT binding details
To: Rob Herring <robh@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
 <20160603020759.GA23947@rob-hp-laptop>
Cc: corbet@lwn.net, lars@metafoo.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <433b182c-fe43-df5c-ac6a-20a024630514@kernel.org>
Date: Fri, 3 Jun 2016 11:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <20160603020759.GA23947@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 03:07, Rob Herring wrote:
> On Wed, Jun 01, 2016 at 06:04:12PM +0530, Laxman Dewangan wrote:
>> The INA3221 is a three-channel, high-side current and bus voltage monitor
>> with an I2C interface from Texas Instruments. The INA3221 monitors both
>> shunt voltage drops and bus supply voltages in addition to having
>> programmable conversion times and averaging modes for these signals.
>> The INA3221 offers both critical and warning alerts to detect multiple
>> programmable out-of-range conditions for each channel.
>>
>> Add DT binding details for INA3221 device for configuring device in
>> different modes and enable multiple functionalities from device.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>>  .../devicetree/bindings/iio/adc/ina3221.txt        | 107 +++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ina3221.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ina3221.txt b/Documentation/devicetree/bindings/iio/adc/ina3221.txt
>> new file mode 100644
>> index 0000000..9f0908d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ina3221.txt
>> @@ -0,0 +1,107 @@
>> +TI INA3221 DT binding
>> +
>> +The INA3221 is a three-channel, high-side current and bus voltage monitor
>> +with an I2C interface from Texas Instruments. The INA3221 monitors both
>> +shunt voltage drops and bus supply voltages in addition to having
>> +programmable conversion times and averaging modes for these signals.
>> +The INA3221 offers both critical and warning alerts to detect multiple
>> +programmable out-of-range conditions for each channel.
>> +
>> +Required properties:
>> +-------------------
>> +- compatible:		Must be "ti,ina3221".
>> +- reg:			I2C slave device address.
>> +- #io-channel-cells:	Should be set to 1. The value from the client node
>> +			represent the channel number.
>> +
>> +Optional properties:
>> +------------------
>> +one-shot-average-sample:	Integer, Number of sample to average before
>> +				putting in the registers in oneshot mode.
Pick a sensible default in the driver then leave this to userspace to
control.
>> +
>> +one-shot-vbus-conv-time-us:	Integer in microseconds, ADC conversion time for
>> +				bus voltage reading in oneshot mode.
Hmm. This one is a little non obvious. It's really controlling the noise
level more than anything else.  Kind of integration time I guess though
not described as such in the datasheet.

Again, I don't think this is really device tree material.
However, you could argue the right decision on this is hardware dependant
as it really depends on ripple in the voltages? Not how it's described in
the datasheet though.
>> +
>> +one-shot-shunt-conv-time-us:	Integer in microseconds, ADC conversion time for
>> +				shunt voltage reading in oneshot mode.
>> +
>> +continuous-average-sample:	Integer, Number of sample to average before
>> +				putting in the registers in continuous mode.
Classic oversampling - not device tree material as it may well want
runtime configuration.
>> +
>> +continuous-vbus-conv-time-us:	Integer in microseconds, ADC conversion time for
>> +				bus voltage reading in continuous mode.
Why should these be different from the one-shot versions?  Might be
separately controlled (though I don't think they are).  If one setting
makes sense fo the hardware in oneshot mode, surely the same setting makes
sense in continuous mode.
>> +
>> +continuous-shunt-conv-time-us:	Integer in microseconds, ADC conversion time for
>> +				shunt voltage reading in continuous mode.
> 
> These all need vendor prefix and need to state the valid range of 
> values.
> 
>> +
>> +enable-power-monitor:		Boolean, Enable power monitoring of the device.
Is this the power good stuff?  description should be more detailed.
>> +
>> +enable-continuous-mode:		Boolean. Device support oneshot and continuous
>> +				mode for the channel data conversion. Presence
>> +				of this property will enable the continuous
>> +				mode from boot.
Is the difference between driver load time and the point where usespace can
set it up significant enough to justify this?

>> +
>> +enable-warning-alert:		Boolean, Enable the alert signal when shunt
>> +				current cross the warning threshold on any of
>> +				the channel. Absence of this property will not
>> +				enable the warning alert.
>> +
>> +enable-critical-alert:		Boolean, Enable the alert signal when shunt
>> +				current cross the critical threshold on any
>> +				of the channel. Absence of this property will
>> +				not enable the critical alert.
> 
> Seems like these would be a user decision.
Absolutely.
> 
>> +
>> +Optional Subnode properties:
>> +---------------------------
>> +The channel specific properties are provided as child node of device.
>> +The fixed child node names of device node used for channel identification.
>> +
>> +Child node's name are "channel0" for channel 0, "channel1" for channel 1 and
>> +"channel2" for channel 2.
>> +
>> +Channel specific properties are provided under these child node. Following
>> +are the properties:
>> +
>> +label:					String, the name of the bus.
>> +shunt-resistor-mohm:			Integer, The shunt resistance on bus
>> +					in milli-ohm.
> 
> Use -micro-ohms
> 
>> +warning-current-limit-microamp:		Integer in microamp, warning current threshold
>> +					for the channel	to generate warning alert.
>> +critical-current-limit-microamp:	Integer in microamp, critical current threshold
>> +					for the channel to generate warning alert.
These two limits feel like they should be a userspace decision really.
If they are that critical I'd expect this chip to not be under kernel control
in the first place but rather some system management firmware or other.
>> +
>> +Example:
>> +
>> +i2c@7000c400 {
>> +	ina3221x@42 {
> 
> What's the x?
> 
>> +		compatible = "ti,ina3221";
>> +		reg = <0x42>;
>> +		one-shot-average-sample = <1>;
>> +		one-shot-vbus-conv-time-us = <140>;
>> +		one-shot-shunt-conv-time-us = <140>;
>> +		continuous-average-sample = <64>;
>> +		continuous-vbus-conv-time-us = <140>;
>> +		continuous-shunt-conv-time-us = <140>;
>> +		enable-power-monitor;
>> +
>> +		#io-channel-cells = <1>;
>> +
>> +		channel0 {
>> +			label = "VDD_MUX";
>> +			shunt-resistor-mohm = <20>;
>> +		};
>> +
>> +		channel1 {
>> +			label = "VDD_5V_IO_SYS";
>> +			shunt-resistor-mohm = <5>;
>> +			warning-current-limit-microamp = <8190000>;
>> +			critical-current-limit-microamp = <1000000>;
>> +		};
>> +
>> +		channel2 {
>> +			label = "VDD_3V3_SYS";
>> +			shunt-resistor-mohm = <10>;
>> +		};
>> +	};
>> +};
>> -- 
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

