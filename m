Return-Path: <SRS0=H5qc=YW=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v7 03/12] mux: minimal mux subsystem and gpio-based mux
 controller
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-4-git-send-email-peda@axentia.se>
 <9e4ee54f-f781-8d3b-1c46-1549392a9f2f@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet
 <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <68e4cb7d-989d-3935-88b5-ea2c6213dc31@axentia.se>
Date: Sun, 8 Jan 2017 22:55:03 +0100
MIME-Version: 1.0
In-Reply-To: <9e4ee54f-f781-8d3b-1c46-1549392a9f2f@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-08 11:23, Jonathan Cameron wrote:
> On 04/01/17 12:16, Peter Rosin wrote:
>> Add a new minimalistic subsystem that handles multiplexer controllers.
>> When multiplexers are used in various places in the kernel, and the
>> same multiplexer controller can be used for several independent things,
>> there should be one place to implement support for said multiplexer
>> controller.
>>
>> A single multiplexer controller can also be used to control several
>> parallel multiplexers, that are in turn used by different subsystems
>> in the kernel, leading to a need to coordinate multiplexer accesses.
>> The multiplexer subsystem handles this coordination.
>>
>> This new mux controller subsystem initially comes with a single backend
>> driver that controls gpio based multiplexers. Even though not needed by
>> this initial driver, the mux controller subsystem is prepared to handle
>> chips with multiple (independent) mux controllers.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  Documentation/driver-model/devres.txt |   8 +
>>  MAINTAINERS                           |   2 +
>>  drivers/Kconfig                       |   2 +
>>  drivers/Makefile                      |   1 +
>>  drivers/mux/Kconfig                   |  33 +++
>>  drivers/mux/Makefile                  |   6 +
>>  drivers/mux/mux-core.c                | 398 ++++++++++++++++++++++++++++++++++
>>  drivers/mux/mux-gpio.c                | 120 ++++++++++
>>  include/linux/mux.h                   | 244 +++++++++++++++++++++
>>  9 files changed, 814 insertions(+)
>>  create mode 100644 drivers/mux/Kconfig
>>  create mode 100644 drivers/mux/Makefile
>>  create mode 100644 drivers/mux/mux-core.c
>>  create mode 100644 drivers/mux/mux-gpio.c
>>  create mode 100644 include/linux/mux.h
>>
>> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
>> index dc51fb024190..1e9ae701a587 100644
>> --- a/Documentation/driver-model/devres.txt
>> +++ b/Documentation/driver-model/devres.txt
>> @@ -332,6 +332,14 @@ MEM
>>  MFD
>>    devm_mfd_add_devices()
>>  
>> +MUX
>> +  devm_mux_chip_alloc()
>> +  devm_mux_chip_free()
>> +  devm_mux_chip_register()
>> +  devm_mux_chip_unregister()
>> +  devm_mux_control_get()
>> +  devm_mux_control_put()
>> +
>>  PER-CPU MEM
>>    devm_alloc_percpu()
>>    devm_free_percpu()
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 32abef2b6d05..ebe96f3e25a0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8442,6 +8442,8 @@ MULTIPLEXER SUBSYSTEM
>>  M:	Peter Rosin <peda@axentia.se>
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/mux/
>> +F:	include/linux/mux.h
>> +F:	drivers/mux/
>>  
>>  MULTISOUND SOUND DRIVER
>>  M:	Andrew Veliath <andrewtv@usa.net>
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index e1e2066cecdb..993aeb65affa 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -76,6 +76,8 @@ source "drivers/hwmon/Kconfig"
>>  
>>  source "drivers/thermal/Kconfig"
>>  
>> +source "drivers/mux/Kconfig"
>> +
> 
> Why this location in the list?  I think the convention for new subystems is
> to just go last in the list.

Oh. I'll move it to the end...

Thanks for all your acks/reviews!

Cheers,
peda
