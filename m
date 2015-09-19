Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33905 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbISTDi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Sep 2015 15:03:38 -0400
Received: by lbbmp1 with SMTP id mp1so37641053lbb.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2015 12:03:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
	<CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
Date: Sat, 19 Sep 2015 14:03:36 -0500
Message-ID: <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
Subject: Re: [PATCH] Asus T300CHI.
From: Mike Mestnik <cheako@mikemestnik.net>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <cheako@mikemestnik.net> wrote:
>> Hello,
>>   I'm looking to know the result of adding ACPI support for a new
>> tablet, the existing support shouldn't work because of a misplaced
>> __init that causes the function to be removed prior to being called.
>
> Are you sure about this? It seems that the existing support doesn't work
> because you have different product ids.
>
The driver worked much better prior to me adding the product ids.  The
sensors were exposed to sysfs and all the data they collected seemed
correct to me.  The big issue is that there is no software, even
iio-sensor-proxy didn't know how to access the data.

>
>> After applying this patch I feel that I've moved support for the
>> T300CHI backwards.  What should be the intended effect of using the
>> ACPI interface?
>>
>> Index: linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>> ===================================================================
>> --- linux-4.1.3.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>> +++ linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>> @@ -23,27 +23,44 @@
>>  enum inv_mpu_product_name {
>>   INV_MPU_NOT_MATCHED,
>>   INV_MPU_ASUS_T100TA,
>> + INV_MPU_ASUS_T300CHI,
>>  };
>>
>>  static enum inv_mpu_product_name matched_product_name;
>>
>> -static int __init asus_t100_matched(const struct dmi_system_id *d)
>> +static int asus_t100ta_matched(const struct dmi_system_id *d)
>>  {
>>   matched_product_name = INV_MPU_ASUS_T100TA;
>>
>>   return 0;
>>  }
>>
>> +static int asus_t300chi_matched(const struct dmi_system_id *d)
>> +{
>> + matched_product_name = INV_MPU_ASUS_T300CHI;
>> +
>> + return 0;
>> +}
>> +
>>  static const struct dmi_system_id inv_mpu_dev_list[] = {
>>   {
>> - .callback = asus_t100_matched,
>> - .ident = "Asus Transformer Book T100",
>> + .callback = asus_t100ta_matched,
>> + .ident = "Asus Transformer Book T100TA",
>>   .matches = {
>>   DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
>>   DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
>>   DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>>   },
>>   },
>> + {
>> + .callback = asus_t300chi_matched,
>> + .ident = "Asus Transformer Book T300CHI",
>> + .matches = {
>> + DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
>> + DMI_MATCH(DMI_PRODUCT_NAME, "T300CHI"),
>> + DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>> + },
>> + },
>>   /* Add more matching tables here..*/
>>   {}
>>  };
>> @@ -154,6 +171,7 @@ int inv_mpu_acpi_create_mux_client(struc
>>   dmi_check_system(inv_mpu_dev_list);
>>   switch (matched_product_name) {
>>   case INV_MPU_ASUS_T100TA:
>> + case INV_MPU_ASUS_T300CHI:
>>   ret = asus_acpi_get_sensor_info(adev, st->client,
>>   &info);
>>   break;
>
> This looks good to me. Care to send a formal patch?
>
I would if the changes do what they are intended to do.  With this
patch applied there is no longer entries for the device in sysfs and
iio-sensor-proxy is still unable to access the device.  I'm wondering
how I'd be able to know if this change worked?

> thanks,
> Daniel.
