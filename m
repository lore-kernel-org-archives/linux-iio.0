Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD9E33E.8070000@cam.ac.uk>
Date: Thu, 14 Jun 2012 14:12:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: srinivas pandruvada <srinivas.pandruvada@intel.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/8] HID-Sensor: v2
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com> <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/14/2012 2:08 PM, Jiri Kosina wrote:
> On Sat, 9 Jun 2012, srinivas pandruvada wrote:
>
>> Submitting v2.
>> Changes compared to version 1:
>>
>> - Replaced Ring-SW with KFiFO
>> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
>> - SysFS (
>> --- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
>> --- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
>> --- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
>> )
>> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
>> sensor have only channels, sampling_frequency and hyst_raw as the ABI.
>> - Additional patch to enable ST Micro sensor hub
>>
>> TBD for v3
>> - Use Lars-Peter's patch: "v2 1/9 patch: Add helper function for initialize trigger buffers). Want to make sure
>> that API is final.
>>
>> DATA Format examples:
>> Had few questions on data format for floating point. This spec uses.
>> - First of size of each field is specified in report descriptor. So it is variable
>> - It uses VT_F16Ex format. For example VTF16E0 means 16 bit float with unit exponent 0.
>> Refer to Page 43 of the "HID Sensor Usage Table"
>> For example, if the size is 16 bits
>> 0xFFF4 with VTF16E14 format ->  -0.12
>> 0xFFF8 with VTF16E14 format ->  -0.08
>> 0x0067 with VTF16E14 format ->  +1.03
>>
>> I tried sensor hubs from two different makers. One use 16 bit and other uses 32 bit for accelerometer.
>> Also the unit expo is different for them. Also units are different.
>>
>> Possible IIO addition:
>> I wish we can add two more items for unit and unit_expo in IIO_CHAN_INFO_XXXX. So that we can add
>> them during channel definition. Currently I am using offset and scale, which doesn't actually mean
>> this. I think conversion should be done is user space based on the info provided.
>
> Thanks for your work on this.
>
> As this is however a staging driver (and depends on IIO, which is a
> staging infrastructure), I suggest you resend the patch to staging
> maintainers so that it gets applied and we can work on polishing the
> driver there.

> Also, what are the plans regarding moving IIO out of staging, please?
The core is out of staging as of the current cycle.  Drivers are moving 
out whenever someone has time to take a look at each one and clean
up any loose ends.  A couple went with the last merge window, lots
more a queued up for the next one.

Generally any new drivers shouldn't go into staging but directly
into drivers/iio.

Sorry for my lack of responses on this revised version, been a busy
week and it's a fairly big review to do.
