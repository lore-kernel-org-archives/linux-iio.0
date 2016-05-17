Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33359 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbcEQGAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 May 2016 02:00:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so829263pfb.0
        for <linux-iio@vger.kernel.org>; Mon, 16 May 2016 23:00:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Scale and FS range information (was: Re: [PATCH v3] iio: adc: ti-ads1015: add support for ADS1115 part)
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <37F51630-B89C-45F3-B0C4-26E7959FB49C@gmail.com>
Date: Mon, 16 May 2016 23:00:41 -0700
Cc: Matt Ranostay <matt.ranostay@intel.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Message-Id: <7E0C0336-E620-4ECB-926C-290EF0034018@gmail.com>
References: <CAKi4VALcCPONTWo8zZM2Vqku+-a-pcXQDFe0PWgqtWNiEFbZhQ@mail.gmail.com> <37F51630-B89C-45F3-B0C4-26E7959FB49C@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Meant real bits not storage bits btw

> On May 16, 2016, at 22:58, Matt Ranostay <mranostay@gmail.com> wrote:
> 
> Well if the ADC channels have a .scan_type you can look at the storage size from userspace. Which I suspect all in the future will have due to hrtimer trigger.
> 
> Thanks,
> 
> Matt
> 
> Sent from my iPhone
> 
>> On May 16, 2016, at 17:37, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>> 
>> Hi Matt,
>> 
>> changing the subject to raise a question I remembered now that could
>> potentially be a problem in this driver, but isn't.
>> 
>>> On Mon, May 16, 2016 at 2:18 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>>> TI ADS1115 is a 16-bit resolution ADC that is register map
>>> compatible with the ADS1015 device.
>>> 
>>> Cc: daniel.baluta@intel.com
>>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>>> ---
>>> Changes from v2:
>>> * Add missing ads1115 data rate values
>>> * Allow support defining data rates per chip
>>> 
>>> drivers/iio/adc/ti-ads1015.c | 124 +++++++++++++++++++++++++++++++++++++------
>>> 1 file changed, 109 insertions(+), 15 deletions(-)
>>> 
>>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>>> index 73cbf0b..a835423 100644
>>> --- a/drivers/iio/adc/ti-ads1015.c
>>> +++ b/drivers/iio/adc/ti-ads1015.c
>>> @@ -55,6 +55,11 @@
>>> #define ADS1015_DEFAULT_DATA_RATE      4
>>> #define ADS1015_DEFAULT_CHAN           0
>>> 
>>> +enum {
>>> +       ADS1015,
>>> +       ADS1115,
>>> +};
>>> +
>>> enum ads1015_channels {
>>>       ADS1015_AIN0_AIN1 = 0,
>>>       ADS1015_AIN0_AIN3,
>>> @@ -71,6 +76,10 @@ static const unsigned int ads1015_data_rate[] = {
>>>       128, 250, 490, 920, 1600, 2400, 3300, 3300
>>> };
>>> 
>>> +static const unsigned int ads1115_data_rate[] = {
>>> +       8, 16, 32, 64, 128, 250, 475, 860
>>> +};
>>> +
>>> static const struct {
>>>       int scale;
>>>       int uscale;
>> 
>> I forgot to ask this some time ago. From the documentation for in_voltageY_raw:
>> 
>> Description:
>>               Raw (unscaled no bias removal etc.) voltage measurement from
>>               channel Y. In special cases where the channel does not
>>               correspond to externally available input one of the named
>>               versions may be used. The number must always be specified and
>>               unique to allow association with event codes. Units after
>>               application of scale and offset are millivolts.
>> 
>> So, taking the value and multiplying by scale.uscale gives us the
>> value in mV. However the main reason to change the scale is actually
>> to get the value you want within the FS range. It seems like IIO has
>> no information to export to tell about FS information?
>> 
>> In *this* case ADS1015 and ADS1115 do have the same FS, but they could
>> be completely different without the user ever knowing.
>> 
>> 
>> 
>> Lucas De Marchi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
