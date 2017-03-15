Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35188 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdCONTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 09:19:00 -0400
Subject: Re: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
To: Lee Jones <lee.jones@linaro.org>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, liam@networkimprov.net,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        bonbons@linux-vserver.org, sre@kernel.org,
        linux-iio@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
        icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        jic23@kernel.org, linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
Date: Wed, 15 Mar 2017 14:18:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170315121450.bl5dxdjzazwsrvni@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lee,

On 15/03/2017 13:14, Lee Jones wrote:
> On Wed, 15 Mar 2017, Quentin Schulz wrote:
> 
>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
>> information and data of the various power supplies they support such as
>> ACIN, battery and VBUS. For example, they expose the current battery
>> voltage, charge or discharge, as well as ACIN and VBUS current voltages
>> and currents, internal PMIC temperature and ADC on 2 different GPIOs
>> when in the right mode (for the AXP209 only).
> 
> What are you missing from this set now?  What Acks etc?  And what's
> the plan with regards to route to Mainline?  Where are the dependencies
> etc?
> 

Basically, a consensus on how we should named the DT property I added in
patch 01 and 02 (which is used afterwards in battery driver). All other
patches have ACKs.

I added some logic to the battery driver so if anyone wants to review
that you're welcome. I already got several ACKs from the v3 though.

No dependencies except for the battery driver (and the first two
patches) which needs the battery "framework" in the Power Supply
subsystem. A v9 of this framework has been sent a little bit more than a
week ago, I need this to be merged first or the battery driver will just
not compile. I think the other patches are ready to be merged.

Thanks,
Quentin

>> The ACIN power supply driver is added by this patch. The AXP20X and
>> AXP22X can both read the status and the "usability" of the power supply
>> but only the AXP209 will be able to tell the current current and voltage
>> of the power supply by reading ADC channels. It is simply not supported
>> by the AXP22X PMICs.
>>
>> The battery power supply driver is also added by this patch. The AXP20X
>> and AXP22X share most of their behaviour but have slight variations. The
>> allowed target voltages for battery charging are not the same, the
>> AXP22X PMIC are able to tell if the battery percentage computed by the
>> PMIC is trustworthy and they have different formulas for computing max
>> current for battery power supply. The driver is able to give the current
>> voltage and current of the battery (be it charging or discharging), the
>> maximal and minimal voltage and maximal current allowed for the battery,
>> whether the battery is present and usable and its capacity. It will get
>> the battery current current and voltage by reading the ADC channels. The
>> PMIC allows maximal voltages (4.36V for AXP20X and 4.22V and 4.24V for
>> AXP22X) that should not be used with Lithium-based batteries and since
>> this PMIC is supposed to be used with Lithium-based batteries, they have
>> been disabled. The values returned by the ADC driver are multipled by
>> 1000 to scale from the mV returned by the ADC to the uV expected by the
>> power supply framework.
>>
>> This series of patch adds DT bindings for ACIN power supply, ADC and
>> battery power supply drivers for AXP20X and AXP22X PMICs and their
>> documentation. It also enables the supported power supplies for the
>> Nextthing Co. CHIP and Sinlinx SinA33 boards.
>>
>> The different drivers are also added to the MFD cells of the AXP20X and
>> AXP22X cells and the writeable and volatile regs updated to work with
>> the newly added drivers.
>>
>> This series of patch is based on a previous upstreaming attempt done by
>> Bruno Prémont few months ago. It differs in three points: the ADC
>> driver does not tell the battery temperature (TS_IN) as I do not have a
>> board to test it with, it does not tell the instantaneous battery power
>> as it returns crazy values for me and finally no support for OCV curves
>> for the battery.
>>
>> You can test these patches from this repo and branch:
>> https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v4
>>
>> v4:
>>  - added the ability to set maximum constant charge current from sysfs,
>>  - added a warning when setting a higher than current maximum constant charge
>>  current,
>>  - set default to minimum possible value for current and maximum constant charge
>>  current when no battery DT is present or invalid battery DT,
>>  - fixed a forgotten custom formula to compute maximum constant charge current
>>  for AXP22X,
>>  - automatically lower the current constant charge current when it is higher
>>  than the maximum constant charge current about to be set,
>>
>> v3:
>>  - Removed DT property for constant charge current in favor of the WIP
>>  battery framework as requested by Sebastian Reichel,
>>  - Using a simple if condition instead of a switch in the ADC driver,
>>  - Fixed error handling in ADC driver's probe,
>>  - Fixed missing call to iio_map_array_unregister in the ADC driver's
>>  remove,
>>  - Removed ADC driver's DT node and documentation,
>>  - Merged IIO channel mapping patches into the original ADC driver
>>  patch,
>>  - Removed `adding V-OFF to writeable reg' patch as it's already in
>>  writeable reg range,
>>
>> v2:
>>  - Some registers' name have been changed to better reflect their
>>  purpose,
>>  - Make VBUS power supply driver use IIO channels when AXP ADC driver is
>>  enabled, but fall back on previous behavior when disabled. This is made
>>  to avoid the ADC driver overwritting registers for VBUS power supply
>>  ADC when removed,
>>  - Removed useless adding of data registers to volatile registers,
>>  - Reordered IIO channels, now grouped by same part of the PMIC (e.g.
>>  voltage and current of the battery have the same index in different
>>  IIO types),
>>  - Added structures for specific data instead of matching on IDs,
>>  - Switched from DT IIO channels mapping to iio_map structures IIO
>>  channels mapping,
>>
>> Quentin
>>
>> Quentin Schulz (18):
>>   dt-bindings: power: battery: add constant-charge-current property
>>   power: supply: power_supply_core: add constant-charge-current optional
>>     property
>>   mfd: axp20x: correct name of temperature data ADC registers
>>   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
>>   mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
>>   mfd: axp20x: add AC power supply cells for AXP22X PMICs
>>   ARM: dtsi: axp209: add AC power supply subnode
>>   ARM: dtsi: axp22x: add AC power supply subnode
>>   ARM: dts: sun8i: sina33: enable ACIN power supply subnode
>>   ARM: sun5i: chip: enable ACIN power supply subnode
>>   dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
>>   mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs for AXP20X/AXP22X
>>   power: supply: add battery driver for AXP20X and AXP22X PMICs
>>   mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
>>   ARM: dtsi: axp209: add battery power supply subnode
>>   ARM: dtsi: axp22x: add battery power supply subnode
>>   ARM: dts: sun8i: sina33: enable battery power supply subnode
>>   ARM: sun5i: chip: enable battery power supply subnode
>>
>>  .../bindings/power/supply/axp20x_battery.txt       |  30 +
>>  .../devicetree/bindings/power/supply/battery.txt   |   2 +
>>  arch/arm/boot/dts/axp209.dtsi                      |  10 +
>>  arch/arm/boot/dts/axp22x.dtsi                      |  10 +
>>  arch/arm/boot/dts/sun5i-r8-chip.dts                |   8 +
>>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
>>  drivers/iio/adc/Kconfig                            |  10 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/axp20x_adc.c                       | 617 +++++++++++++++++++++
>>  drivers/mfd/axp20x.c                               |  29 +-
>>  drivers/power/supply/Kconfig                       |  12 +
>>  drivers/power/supply/Makefile                      |   1 +
>>  drivers/power/supply/axp20x_battery.c              | 565 +++++++++++++++++++
>>  drivers/power/supply/power_supply_core.c           |   3 +
>>  include/linux/mfd/axp20x.h                         |   4 +-
>>  include/linux/power_supply.h                       |   1 +
>>  16 files changed, 1308 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>  create mode 100644 drivers/iio/adc/axp20x_adc.c
>>  create mode 100644 drivers/power/supply/axp20x_battery.c
>>
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
