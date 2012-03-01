Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:35454 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965538Ab2CAJqP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Mar 2012 04:46:15 -0500
Message-ID: <4F4F450D.9040509@analog.com>
Date: Thu, 1 Mar 2012 10:44:45 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 1/3] iio: core: Introduce debugfs support, add support
 for direct register access
References: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com> <4F4E8738.3080202@kernel.org>
In-Reply-To: <4F4E8738.3080202@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/29/2012 09:14 PM, Jonathan Cameron wrote:
> On 02/22/2012 12:30 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
> Looks fine. One trivial formatting quirk inline and a question
> about the recursive call (though I can't see it doing any harm!)
>
>> Changes since V1:
>>
>> debugfs:
>>
>> Exclude iio debugfs code in case CONFIG_DEBUG_FS isn't enabled.
>>        Introduce helper function iio_get_debugfs_dentry.
>>        Document additions to struct iio_dev
>>
>> iio_debugfs_read_reg:
>>        Use snprintf.
>>        Use a shorter fixed length.
>>        Introduce len instead of pointer math.
>>
>> iio_debugfs_write_reg:
>>        Fix return value use PTR_ERR.
>>        sscanf scan hex, decimal and octal.
>>        Ensure zero terminated string.
>>
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron<jic23@kernel.org>
>>   #endif /* _INDUSTRIAL_IO_H_ */
>> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
>> index e4824fe..82c9128 100644
>> --- a/drivers/staging/iio/industrialio-core.c
>> +++ b/drivers/staging/iio/industrialio-core.c
>> @@ -22,6 +22,7 @@
>>   #include<linux/cdev.h>
>>   #include<linux/slab.h>
>>   #include<linux/anon_inodes.h>
>> +#include<linux/debugfs.h>
>>   #include "iio.h"
>>   #include "iio_core.h"
>>   #include "iio_core_trigger.h"
>> @@ -39,6 +40,8 @@ struct bus_type iio_bus_type = {
>>   };
>>   EXPORT_SYMBOL(iio_bus_type);
>>
>> +static struct dentry *iio_debugfs_dentry;
>> +
>>   static const char * const iio_data_type_name[] = {
>>        [IIO_RAW] = "raw",
>>        [IIO_PROCESSED] = "input",
>> @@ -129,6 +132,8 @@ static int __init iio_init(void)
>>                goto error_unregister_bus_type;
>>        }
>>
>> +     iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
>> +
>>        return 0;
>>
>>   error_unregister_bus_type:
>> @@ -142,8 +147,129 @@ static void __exit iio_exit(void)
>>        if (iio_devt)
>>                unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
>>        bus_unregister(&iio_bus_type);
>> +     debugfs_remove_recursive(iio_debugfs_dentry);
> Not sure it matters, but shouldn't we have cleared everything other than
> the directory before this gets called?  If so why the recursive version?

Hi Jonathan,

Thanks for the review.

The recursive version doesn't harm. But right you are -
debugfs_remove() is the cleaner option.
I'll fix this up before sending on to Greg.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


