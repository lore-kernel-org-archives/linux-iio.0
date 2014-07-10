Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53BEAB81.8080108@linux.intel.com>
Date: Thu, 10 Jul 2014 08:04:33 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
CC: Bastien Nocera <hadess@hadess.net>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Reyad Attiyat <reyad.attiyat@gmail.com>,
 linux-iio@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: User-space API for accelerometer(s)?
References: <1403100542.30918.29.camel@nuvo>	    <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>	    <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>	   <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>	  <53B59837.8080907@jic23.retrosnub.co.uk> <1404916405.10032.3.camel@nuvo>	 <alpine.DEB.2.01.1407091644570.15209@pmeerw.net> <1404944174.3519.1.camel@nuvo> <53BDEE91.80200@gmail.com>
In-Reply-To: <53BDEE91.80200@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

I suggest to look at https://01.org/android-ia/downloads. Under 
device/intel, you can see user space HAL for sensor hubs.

Thanks,
Srinivas


On 07/09/2014 06:38 PM, Peter F. Patel-Schneider wrote:
> Yes, my code derives from generic-buffer, at least in part, as I first
> had to fix problems in generic-buffer, and then get problems fixed in
> the sensor hub drivers.  For quite some time the only way to get the
> code to work at all was to do everything each time, so I just kept doing
> it that way.
>
> There appears to be lots of improvements in the drivers so a better
> solution is certainly possible now.
>
> peter
>
>
> On 07/09/2014 03:16 PM, Bastien Nocera wrote:
>> Hey Peter,
>>
>> On Wed, 2014-07-09 at 16:54 +0200, Peter Meerwald wrote:
>>> Hello Bastian,
>>>
>>>>> We did also have a uinput based approach at one point but it was
>>>>> fairly clunky.
>>>>> That took data from iio buffers and pushed it back into the kernel
>>>>> via inputs
>>>>> userspace driver support. Not particularly nice but I thought I'd
>>>>> best mention
>>>>> it!
>>>>
>>>> This is how I went in the end:
>>>> https://github.com/hadess/iio-sensor-proxy/
>>>>
>>>> It's still far too resource hungry compared to the amount of work it's
>>>> doing (1 full percent of CPU!), and the rotation is too sensitive.
>>>
>>> if I read the code correctly, prepare_output() configures the trigger,
>>> enables the buffer, then performs one read, before undoing everything
>>> FOR
>>> EACH SAMPLE
>>
>> I based that code off Peter F. Patel-Schneider, and his yoga utilities,
>> and he probably got the idea from the generic_buffer.c example. It's not
>> clear what needs to be done there.
>>
>>> this is probably not the way it should be done; I'd suggest to set up
>>> the
>>> IIO buffer and then poll() or block on /dev/iio:deviceX -- however, this
>>> uses the IIO device exclusively (might be an issue)
>>
>> I've now pushed a version that will do the setup once, and open/close
>> the iio device when needed, in the timeout.
>>   The daemon still shows up in top, but I couldn't make it register
>> enough activity to show up in sysprof, so I'm guessing that top just
>> isn't measuring the CPU usage accurately.
>>
>> I still have to fix the overeagerness to switch orientations, and I'll
>> be done for now I think.
>>
>> Cheers
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
