Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32833 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbEITK7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 May 2015 15:10:59 -0400
MIME-Version: 1.0
In-Reply-To: <3944907.nCjd7S3rrz@xps13>
References: <1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com>
	<3944907.nCjd7S3rrz@xps13>
Date: Sat, 9 May 2015 22:10:57 +0300
Message-ID: <CAEnQRZCAniJ6O=FD=0T-iOZmv4ZJ8RSKRE2PFRKqQe6SeUSWGg@mail.gmail.com>
Subject: Re: [PATCH v9] iio: acpi: Add support for ACPI0008 Ambient Light Sensor
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	rui.zhang@intel.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 9, 2015 at 9:45 PM, Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
> On Saturday 02 May 2015 14:30:57 Gabriele Mazzotta wrote:
>> This driver adds the initial support for the ACPI Ambient Light Sensor
>> as defined in Section 9.2 of the ACPI specification (Revision 5.0) [1].
>>
>> Sensors complying with the standard are exposed as ACPI devices with
>> ACPI0008 as hardware ID and provide standard methods by which the OS
>> can query properties of the ambient light environment the system is
>> currently operating in.
>>
>> This driver currently allows only to get the current ambient light
>> illuminance reading through the _ALI method, but is ready to be
>> extended extended to handle _ALC, _ALT and _ALP as well.
>>
>> [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
>>
>> Signed-off-by: Martin Liska <marxin.liska@gmail.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> ---
>> Changes since v8:
>>  - Set realbits to 32
>>  - Fix license mismatch (using GPL v2 or later)
>>  - Drop iio_device_unregister() in favor of devm_iio_device_register()
>>
>>  drivers/iio/light/Kconfig    |  12 +++
>>  drivers/iio/light/Makefile   |   1 +
>>  drivers/iio/light/acpi-als.c | 232 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 245 insertions(+)
>>  create mode 100644 drivers/iio/light/acpi-als.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index 01a1a16..898b2b5 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -5,6 +5,18 @@
>>
>>  menu "Light sensors"
>>
>> +config ACPI_ALS
>> +     tristate "ACPI Ambient Light Sensor"
>> +     depends on ACPI
>
> I'm sorry, but I've just noticed that here there should also be
>
>         select IIO_BUFFER
>
> I hope it's not too late and I can resend this patch if needed.

You can send a patch on top of the previous one. Eventually, Jonathan
will squash them.

Daniel.
