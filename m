Return-Path: <lars@metafoo.de>
Message-ID: <555230B0.3050700@metafoo.de>
Date: Tue, 12 May 2015 18:56:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Robert Dolca <robert.dolca@intel.com>,
 linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH RFC 1/3] iio: Add symlink to triggers in the device's
 trigger folder
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com> <1429174868-11953-2-git-send-email-robert.dolca@intel.com> <554CD236.4000404@kernel.org>
In-Reply-To: <554CD236.4000404@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/08/2015 05:11 PM, Jonathan Cameron wrote:
> On 16/04/15 05:01, Robert Dolca wrote:
>> This patch adds a new function called iio_trigger_register_with_dev
>> which is a wrapper for iio_trigger_register. Besides the iio_trigger
>> struct this function requires iio_dev struct. It adds the trigger in
>> the device's trigger list and saves a reference to the device in the
>> trigger's struct.
>>
>> When the device is registered, in the trigger folder of the device
>> (where current_trigger file resides) a symlink is being created for
>> each trigger that was registered width iio_trigger_register_with_dev.
>>
>>   # ls -l /sys/bus/iio/devices/iio:device0/trigger/
>> total 0
>> -rw-r--r--    1 root     root          4096 Apr 16 08:33 current_trigger
>> lrwxrwxrwx    1 root     root             0 Apr 16 08:33 trigger0 -> ../../trigg
>> er0
>>
>> This should be used for device specific triggers. Doing this the user space
>> applications can figure out what if the trigger registered by a specific device
>> and what should they write in the current_trigger file. Currently some
>> applications rely on the trigger name and this does not always work.
>>
>> This implementation assumes that the trigger is registered before the device is
>> registered. If the order is not this the symlink will not be created but
>> everything else will work as before.
>>
>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> I was rather hoping we'd get a few more comments on this.
> In principle I like the idea, but it's new ABI and does make life
> a tiny bit more complex, so what do people think?
>
> Few trivial code comments inline.

I don't think it adds more information. Both the trigger and the device get 
registered for the same parent device, so you can already easily find the 
trigger for a device by going to the parent device and taking a look at the 
triggers registered by the parent device.
