Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43242 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938799AbdAHKsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:48:15 -0500
Subject: Re: [PATCH 14/22] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-15-quentin.schulz@free-electrons.com>
 <20170104132107.tciklylgqvhftb6f@rob-hp-laptop>
 <3155ba16-b51a-9306-6be4-0bdf4482a679@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <4a8456e6-c6e9-73ac-0f5c-29e9faceb13c@free-electrons.com>
Date: Sun, 8 Jan 2017 11:48:09 +0100
MIME-Version: 1.0
In-Reply-To: <3155ba16-b51a-9306-6be4-0bdf4482a679@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 07/01/2017 20:33, Jonathan Cameron wrote:
> On 04/01/17 08:21, Rob Herring wrote:
>> On Mon, Jan 02, 2017 at 05:37:14PM +0100, Quentin Schulz wrote:
>>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>>
>>> This patch adds the DT binding documentation for the battery power
>>> supply which gets various data from the PMIC, such as the battery status
>>> (charging, discharging, full, dead), current max limit, current current,
>>> battery capacity (in percentage), voltage max and min limits, current
>>> voltage and battery capacity (in Ah).
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>  .../bindings/power/supply/axp20x_battery.txt       | 27 ++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>> new file mode 100644
>>> index 0000000..5489d0d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>> @@ -0,0 +1,27 @@
>>> +AXP20x and AXP22x battery power supply
>>> +
>>> +Required Properties:
>>> + - compatible, one of:
>>> +			"x-powers,axp209-battery-power-supply"
>>> +			"x-powers,axp221-battery-power-supply"
>>> + - io-channels: phandles to battery voltage, charge and discharge
>>> + currents ADC channels
>>> + - io-channel-names = "batt_v", "batt_chrg_i", "batt_dischrg_i";
>>> +
>>> +This node is a subnode of the axp20x/axp22x PMIC.
>>> +
>>> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
>>> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
>>> +ADC.
>>> +
>>> +Example:
>>> +
>>> +&axp209 {
>>> +	battery_power_supply: battery_power_supply {
>>
>> Humm, I guess you power-supply is not sufficient, so 
>> 'battery-power-supply' and similar for ac.
>>
>>> +		compatible = "x-powers,axp209-battery-power-supply";
>>> +		io-channels = <&axp209_adc 7>, <&axp209_adc 8>,
>>> +			<&axp209_adc 9>;
>>> +		io-channel-names = "batt_v", "batt_chrg_i",
>>> +			"batt_dischrg_i";
> Is this stuff fixed for the device?

If we don't mix the IIO channels order, it is. This driver only requires
batt_v, batt_chrg_i and batt_dischrg_i so we've to keep them at that
place in the list of IIO channels. Or as suggested by Rob and Chen-Yu, I
can move all this inside the driver with iio_map and don't care anymore
about the order.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
