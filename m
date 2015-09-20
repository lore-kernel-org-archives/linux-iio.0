Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52078 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbbITTIj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 15:08:39 -0400
Subject: Re: [PATCH] Asus T300CHI.
To: Mike Mestnik <cheako@mikemestnik.net>,
	Daniel Baluta <daniel.baluta@gmail.com>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
 <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
 <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Bastien Nocera <hadess@hadess.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FF0433.6050900@kernel.org>
Date: Sun, 20 Sep 2015 20:08:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/09/15 20:03, Mike Mestnik wrote:
> On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>> On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <cheako@mikemestnik.net> wrote:
>>> Hello,
>>>   I'm looking to know the result of adding ACPI support for a new
>>> tablet, the existing support shouldn't work because of a misplaced
>>> __init that causes the function to be removed prior to being called.
>>
>> Are you sure about this? It seems that the existing support doesn't work
>> because you have different product ids.
>>
> The driver worked much better prior to me adding the product ids.  The
> sensors were exposed to sysfs and all the data they collected seemed
> correct to me.  The big issue is that there is no software, even
> iio-sensor-proxy didn't know how to access the data.
Cc'd Bastien Nocera.
> 
>>
>>> After applying this patch I feel that I've moved support for the
>>> T300CHI backwards.  What should be the intended effect of using the
>>> ACPI interface?
>>>
>>> Index: linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>>> ===================================================================
>>> --- linux-4.1.3.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>>> +++ linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>>> @@ -23,27 +23,44 @@
>>>  enum inv_mpu_product_name {
>>>   INV_MPU_NOT_MATCHED,
>>>   INV_MPU_ASUS_T100TA,
>>> + INV_MPU_ASUS_T300CHI,
>>>  };
>>>
>>>  static enum inv_mpu_product_name matched_product_name;
>>>
>>> -static int __init asus_t100_matched(const struct dmi_system_id *d)
>>> +static int asus_t100ta_matched(const struct dmi_system_id *d)
>>>  {
>>>   matched_product_name = INV_MPU_ASUS_T100TA;
>>>
>>>   return 0;
>>>  }
>>>
>>> +static int asus_t300chi_matched(const struct dmi_system_id *d)
>>> +{
>>> + matched_product_name = INV_MPU_ASUS_T300CHI;
>>> +
>>> + return 0;
>>> +}
>>> +
>>>  static const struct dmi_system_id inv_mpu_dev_list[] = {
>>>   {
>>> - .callback = asus_t100_matched,
>>> - .ident = "Asus Transformer Book T100",
>>> + .callback = asus_t100ta_matched,
>>> + .ident = "Asus Transformer Book T100TA",
>>>   .matches = {
>>>   DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
>>>   DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
>>>   DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>>>   },
>>>   },
>>> + {
>>> + .callback = asus_t300chi_matched,
>>> + .ident = "Asus Transformer Book T300CHI",
>>> + .matches = {
>>> + DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
>>> + DMI_MATCH(DMI_PRODUCT_NAME, "T300CHI"),
>>> + DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>>> + },
>>> + },
>>>   /* Add more matching tables here..*/
>>>   {}
>>>  };
>>> @@ -154,6 +171,7 @@ int inv_mpu_acpi_create_mux_client(struc
>>>   dmi_check_system(inv_mpu_dev_list);
>>>   switch (matched_product_name) {
>>>   case INV_MPU_ASUS_T100TA:
>>> + case INV_MPU_ASUS_T300CHI:
>>>   ret = asus_acpi_get_sensor_info(adev, st->client,
>>>   &info);
>>>   break;
>>
>> This looks good to me. Care to send a formal patch?
>>
> I would if the changes do what they are intended to do.  With this
> patch applied there is no longer entries for the device in sysfs and
> iio-sensor-proxy is still unable to access the device.  I'm wondering
> how I'd be able to know if this change worked?
> 
>> thanks,
>> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

