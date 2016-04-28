Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:5577 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbcD1Kjr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Apr 2016 06:39:47 -0400
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
References: <5b1937140558514b3e43ed2c21ee860ecbac61ec.1461172603.git.leonard.crestez@intel.com>
 <a978ad85-8191-7506-8090-809f89d0b2e2@kernel.org>
 <6ab228db-9695-ac22-9c65-fd15c4837c45@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <5721E871.8010003@intel.com>
Date: Thu, 28 Apr 2016 13:39:45 +0300
MIME-Version: 1.0
In-Reply-To: <6ab228db-9695-ac22-9c65-fd15c4837c45@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/27/2016 11:39 AM, Peter Rosin wrote:
> On 2016-04-23 23:32, Jonathan Cameron wrote:
>> On 20/04/16 18:17, Crestez Dan Leonard wrote:
>>> The MPU has an auxiliary I2C bus for connecting external
>>> sensors. This bus has two operating modes:
>>> * pass-through, which connects the primary and auxiliary busses
>>> together. This is already supported via an i2c mux.
>>> * I2C master mode, where the mpu60x0 acts as a master to any external
>>> connected sensors. This is implemented by this patch.
>>>
>>> This I2C master mode also works when the MPU itself is connected via
>>> SPI.
>>>
>>> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
>>> mode while slave 4 is different. This patch implements an i2c adapter
>>> using slave 4 because it has a cleaner interface and it has an
>>> interrupt that signals when data from slave to master arrived.
>>>
>>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>> This one needs acks from:
>>
>> Device tree maintainer (odd binding ;)
>> Peter Rosin (odd binding interacting with the mux support)
>> Wolfram (it has a whole i2c master driver in here).
>>
>> (just thought I'd list these for the avoidance of doubt).
> 
> I spot some overlap with the questions in "[RFC] i2c: device-tree:
> Handling child nodes which are not i2c devices"
> http://marc.info/?l=linux-i2c&m=146073452819116&w=2
> 
> And I think I agree with Stephen Warren that an intermediate placeholder
> node would make sense. I.e.
> 
>     mpu6050@68 {
>         compatible = "...";
>         reg = <0x68>;
>         ...
>         i2c-aux-mux {
>             i2c@0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0>;
> 
>                 foo@44 {
>                     compatible = "bar";
>                     reg = <0x44>;
>                     ...
>                 }
>             }
>         }
>     }
> 
> Or
> 
>     mpu6050@68 {
>         compatible = "...";
>         reg = <0x68>;
>         ...
>         i2c-aux-master {
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             gazonk@44 {
>                 compatible = "baz";
>                 reg = <0x44>;
>                 ...
>             }
>         }
>     }
> 
> depending on if you want an aux-mux or an aux-master.
> 
> But I don't know if that intermediate i2c-aux-mux node causes any
> problems?

It's not clear how that would be implemented. It seems to me that right
now i2c_add_mux_adapter assumes that the parent device is a dedicated
mux device and all it's children are mux branches. Would this require
introducing a new "struct device" for the i2c-aux-master node?

It might make sense to make the automatic processing of the parents
node's of_node optional and let the caller assign the of_node describing
the attached devices.

I think the most natural solution would be to require child nodes named
i2c-aux-mux and i2c-aux-master to describe aux devices. For backwards
compatibility it would be easiest to go with i2c@0/i2c@1 (identified by
reg=0/1).

But I don't know much about devicetree and I'd rather accept an external
suggestion.

Regards,
Leonard
