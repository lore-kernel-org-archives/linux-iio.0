Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mike.atx.name ([185.8.165.10]:33662 "EHLO mike.atx.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753163AbdASQUu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Jan 2017 11:20:50 -0500
Mime-Version: 1.0
Date: Thu, 19 Jan 2017 16:19:56 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <8239ef005dee8acc9caf4b979424de52@mail.atx.name>
From: atx@atx.name
Subject: Re: [PATCH v2] iio: light: acpi-als: Properly enable on ASUS
 Zenbooks
To: "Marek Vasut" <marex@denx.de>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maitysanchayan@gmail.com,
        gregor.boirie@parrot.com, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, marxin.liska@gmail.com
In-Reply-To: <7b7f6d47-a0cc-8af5-c68f-da4350d793aa@denx.de>
References: <7b7f6d47-a0cc-8af5-c68f-da4350d793aa@denx.de>
 <20170119114816.GA12918@rick.lan>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

January 19 2017 4:49 PM, "Marek Vasut" <marex@denx.de> wrote:
> On 01/19/2017 12:48 PM, Josef Gajdusek wrote:
> 
>> ASUS Zenbooks need several special ACPI calls to enable the ALS peripheral.
>> Otherwise, reads just return 0.
>> 
>> Signed-off-by: Josef Gajdusek <atx@atx.name>
>> ---
>> drivers/iio/light/acpi-als.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>> 
>> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
>> index f0b47c5..ccd5787 100644
>> --- a/drivers/iio/light/acpi-als.c
>> +++ b/drivers/iio/light/acpi-als.c
>> @@ -39,6 +39,9 @@
>> #define ACPI_ALS_DEVICE_NAME "acpi-als"
>> #define ACPI_ALS_NOTIFY_ILLUMINANCE 0x80
>> 
>> +#define ACPI_ALS_ASUS_TALS "\\_SB.PCI0.LPCB.EC0.TALS"
>> +#define ACPI_ALS_ASUS_ALSC "\\_SB.ATKD.ALSC"
>> +
>> ACPI_MODULE_NAME("acpi-als");
>> 
>> /*
>> @@ -170,6 +173,16 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
>> return IIO_VAL_INT;
>> }
>> 
>> +static void acpi_als_quirk_asus(struct acpi_als *als)
>> +{
>> + acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_TALS, 1);
>> + acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_ALSC, 1);
> 
> This will run on ALL systems, right ? Also, error checking disappeared ?
> 

Yes, that's intended. Should I add some DMI checks to only run on
ASUS/ASUS Zenbooks?

As for error checking, this code behaves exactly like v1, except
that the xor warning is removed, which means that it is not needed
to explicitly get the handles. The acpi_exceute_simple_method call just
fails if it can't find the object.

Distinguishing between the "object not found" and "failed to call method" scenarios
seemed a bit overly verbose to me especially as it would probably be overkill to abort
the driver initialization because of that.

>> +}
>> +
>> +static void (*acpi_als_quirks[])(struct acpi_als *als) = {
>> + acpi_als_quirk_asus,
>> +};
>> +
>> static const struct iio_info acpi_als_info = {
>> .driver_module = THIS_MODULE,
>> .read_raw = acpi_als_read_raw,
>> @@ -180,6 +193,7 @@ static int acpi_als_add(struct acpi_device *device)
>> struct acpi_als *als;
>> struct iio_dev *indio_dev;
>> struct iio_buffer *buffer;
>> + int i;
>> 
>> indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>> if (!indio_dev)
>> @@ -191,6 +205,9 @@ static int acpi_als_add(struct acpi_device *device)
>> als->device = device;
>> mutex_init(&als->lock);
>> 
>> + for (i = 0; i < ARRAY_SIZE(acpi_als_quirks); i++)
>> + acpi_als_quirks[i](als);
>> +
>> indio_dev->name = ACPI_ALS_DEVICE_NAME;
>> indio_dev->dev.parent = &device->dev;
>> indio_dev->info = &acpi_als_info;
> 
> --
> Best regards,
> Marek Vasut
