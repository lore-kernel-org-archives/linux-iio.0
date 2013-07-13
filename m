Return-Path: <jic23@kernel.org>
Message-ID: <51E15654.5080708@kernel.org>
Date: Sat, 13 Jul 2013 14:29:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: Alexander Holler <holler@ahsoftware.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 0/4] iio: hid-sensor: add module alias for autoload
References: <1373445120-5407-1-git-send-email-holler@ahsoftware.de> <51DD7D78.2020506@linux.intel.com> <51DD848E.4050206@ahsoftware.de> <51DEEAFE.506@linux.intel.com> <51DFAE85.9060508@ahsoftware.de> <51E04E99.9060105@kernel.org> <4FA419E87744DF4DAECD5BCE1214B7A92FBDB758@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A92FBDB758@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Thanks,

All 4 applied to the togreg branch of iio.git

Jonathan

On 07/12/2013 10:46 PM, Pandruvada, Srinivas wrote:
> Tested and ready to go.
> 
> Thanks,
> Srinivas
> 
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org] 
> Sent: Friday, July 12, 2013 11:45 AM
> To: Alexander Holler
> Cc: Srinivas Pandruvada; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Jonathan Cameron; Pandruvada, Srinivas
> Subject: Re: [PATCH 0/4] iio: hid-sensor: add module alias for autoload
> 
> On 07/12/2013 08:21 AM, Alexander Holler wrote:
>> Am 11.07.2013 19:27, schrieb Srinivas Pandruvada:
>>>
>>>
>>> On 07/10/2013 08:58 AM, Alexander Holler wrote:
>>>> Am 10.07.2013 17:27, schrieb Srinivas Pandruvada:
>>>>> Hi,
>>>>>
>>>>> There was no intention to prevent auto loading. Did you get chance 
>>>>> to test these changes?
>>>>
>>>> Sure, I always test patches before I send them out.
>>>>
>>>> Ok, I haven't tested the changes with the iio HID drivers (I don't 
>>>> have any commercial HID sensor hub, so I've just compile tested 
>>>> these patches here, double reading them), but I've tested the 
>>>> similiar changes with a patch for rtc-hid-sensor-time I've send out yesterday.
>>>> (sorry, no link, lkml.org seems dead, just search for
>>>> "rtc-hid-sensor-time: add module alias")
>>>>
>>>> It works just fine. An example output is now
>>>>
>>>> Jul  9 19:27:21 dockstar3 kernel: [    5.124444] rtc_hid_sensor_time
>>>> HID-SENSOR-2000a0.0: milliseconds supported
>>>> Jul  9 19:27:21 dockstar3 kernel: [    5.132864] rtc_hid_sensor_time
>>>> HID-SENSOR-2000a0.0: rtc core: setting system clock to 2013-07-09
>>>> 17:26:51:328000 UTC (1373390811)
>>>> Jul  9 19:27:21 dockstar3 kernel: [    5.146105] rtc_hid_sensor_time
>>>> HID-SENSOR-2000a0.0: rtc core: registered hid-sensor-time as rtc0
>>>>
>>>> Before the output was e.g.
>>>>
>>>> HID-SENSOR-2000a0 HID-SENSOR-2000a0.0: rtc core: registered 
>>>> hid-sensor-time as rtc0
>>>>
>>>> instead of the above with the descriptive rtc_hid_sensor_time.
>>> <Agreed. This is better. >
>>>> Automatic loading of modules works too and it works on ARM, Intel 
>>>> and AMD as module or static linked. ;)
>>
>> Do you have tested the patches with a real device? I assume you have 
>> one. ;)
>>
>> Regards,
>>
>> Alexander Holler
> 
> Just so you two know. Given this discussion, I'll be lazy about these and wait for an Ack from Srinivas before taking these.  Look fine to me, but nice to have confirmation as you say with the actual hardware!
> 
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
