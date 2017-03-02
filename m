Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46202 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdCBUDU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2017 15:03:20 -0500
Subject: Re: [PATCH v5 0/4] iio: accel: adxl345: Split driver into core and
 I2C then add SPI support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
References: <cover.1488248485.git.eraretuya@gmail.com>
 <CAHp75VdtqNAf_PaWBL=YPc9iz=E-0tAz2=Fk-mDYSeBvtU+KYg@mail.gmail.com>
 <20170302030221.GA4026@Socrates-UM>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2f9264bc-98a2-acfc-918a-a6cec0ad33c7@kernel.org>
Date: Thu, 2 Mar 2017 19:59:36 +0000
MIME-Version: 1.0
In-Reply-To: <20170302030221.GA4026@Socrates-UM>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/17 03:02, Eva Rachel Retuya wrote:
> On Thu, Mar 02, 2017 at 01:22:11AM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 28, 2017 at 4:37 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>>> This patchset modifies the adxl345 to use regmap. In doing so, we can
>>> easily introduce SPI support and let regmap handle the rest.
>>>
>>> Recap of basic features: read_raw for x, y and z axes, scale. After
>>> applying this series, driver now supports the SPI protocol and enumeration
>>> of device via device tree.
>>
>> If I knew you are going to send new version I would have commented on v4...
>>
> 
> Hi Andy,
> 
> Please state your comments and I will submit a new revision.
> 
> Thanks,
> Eva
Looks good to me so I'll probably pick this up over the weekend unless you want
to make a V6 with anything from Andy.  Can always send follow up patches later
for any issues highlighted.

Ideally we 'might' have devicetree ack by then, but given you have fixed
the one issue raised in the review, I may not wait for that (can add it in the
week it'll inevitably sit in my testing branch for!)

Jonathan
> 
>>>
>>> Changes from v4:
>>> [PATCH 1/4]
>>> * Update subject-prefix
>>> * Update node name from "adxl345@unit-address" to "accelerometer@unit-address"
>>> Patches 2-4
>>> * Add Andy's Reviewed-by tag
>>>
>>> Changes from v3:
>>> [PATCH 1/4]
>>> * None
>>> [PATCH 2/4]
>>> * Keep intact I2C client structure which was deleted from v3
>>> * Make use of regmap_get_device to retrieve struct device, use these for
>>>   debugging prints instead of &client->dev.
>>> [PATCH 3/4] and [PATCH 4/4]
>>> * Revert to explicit and separate I2C and SPI configuration
>>> * Add OF match table, make it enumerable in ACPI environment (Andy's suggestion)
>>>
>>> Changes from v2:
>>> * Drop PATCH 4 iio: accel: adxl345: Add ACPI support
>>> * Add OF match table on both I2C and SPI files and document them
>>>
>>> Changes from v1:
>>> [PATCH 1/4]
>>> * Move other deletions from patch 2 in here -- make it clear what got deleted
>>>   and/or modified that is hard to see previously
>>> * Introduce the driver header file "adxl345.h" here instead of doing it in the
>>>   next patch
>>> * Completely omit traces of i2c_client and let this file (adxl345.c) mirror the
>>>   core file on the next patch.
>>> * Improve debugging print about invalid device ID in probe.
>>> [PATCH 2/4]
>>> * Update Kconfig to Jonathan's preferred style
>>> * Improve similarity index from 78% to 100% (rename detection)
>>> [PATCH 4/4]
>>> * Correct acpi_device_id: ADX0345 -> ADS0345
>>>
>>> Eva Rachel Retuya (4):
>>>   dt-bindings: iio: accel: Document ADXL345 accelerometer binding
>>>   iio: accel: adxl345: Use I2C regmap instead of direct I2C access
>>>   iio: accel: adxl345: Split driver into core and I2C
>>>   iio: accel: adxl345: Add SPI support
>>>
>>>  .../devicetree/bindings/iio/accel/adxl345.txt      | 38 +++++++++
>>>  drivers/iio/accel/Kconfig                          | 26 ++++++-
>>>  drivers/iio/accel/Makefile                         |  4 +-
>>>  drivers/iio/accel/adxl345.h                        | 18 +++++
>>>  drivers/iio/accel/{adxl345.c => adxl345_core.c}    | 89 +++++++++-------------
>>>  drivers/iio/accel/adxl345_i2c.c                    | 78 +++++++++++++++++++
>>>  drivers/iio/accel/adxl345_spi.c                    | 83 ++++++++++++++++++++
>>>  7 files changed, 281 insertions(+), 55 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
>>>  create mode 100644 drivers/iio/accel/adxl345.h
>>>  rename drivers/iio/accel/{adxl345.c => adxl345_core.c} (62%)
>>>  create mode 100644 drivers/iio/accel/adxl345_i2c.c
>>>  create mode 100644 drivers/iio/accel/adxl345_spi.c
>>>
>>> --
>>> 2.7.4
>>>
>>
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

