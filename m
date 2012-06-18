Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41652 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab2FRHoE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:44:04 -0400
Message-ID: <4FDEDC3F.6080902@kernel.org>
Date: Mon, 18 Jun 2012 08:43:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/8] HID-Sensor: v2
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com> <4FDB34A2.8090801@kernel.org> <4FA419E87744DF4DAECD5BCE1214B7A919336273@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A919336273@ORSMSX104.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 4:31 PM, Pandruvada, Srinivas wrote:
>> Had few questions on data format for floating point. This spec uses.
>> - First of size of each field is specified in report descriptor. So it
>> is variable
> yuk. Thats annoying.  I guess we'll have to extend the scan_type bit of IIO_CHAN to include this.
>
> Currently I am setting real bits and storage bits of a channel, to specify size. Just before registering channel to IIO, setting these values.
That is fine and how it is typically done.  The bit that will need new
support is if we have true floating point (e.g. need to encode the 
exponent in
individual readings).
I don't have any real problem doing this other than annoyance based on the
fact I doubt any of the underlying hardware is floating point (though I'd
love to see a data sheet if it is!)
>
> Thanks,
> Srinivas
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Friday, June 15, 2012 6:12 AM
> To: Pandruvada, Srinivas
> Cc: linux-iio@vger.kernel.org; Jiri Kosina
> Subject: Re: [PATCH 0/8] HID-Sensor: v2
>
> On 6/10/2012 2:53 AM, srinivas pandruvada wrote:
>> Submitting v2.
>> Changes compared to version 1:
>>
>> - Replaced Ring-SW with KFiFO
>> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y
>> and Z
>> - SysFS (
>> --- Changed "polling_interval" to sampling_frequency
>> (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
>> --- Changed "sensitivity" to hyst_raw, which is already used by some
>> ADC modules
>> --- Removed "Activate". No longer need this. Using trigger state to
>> activate/deactivate
>> )
>> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in
>> read_raw. So each sensor have only channels, sampling_frequency and hyst_raw as the ABI.
>> - Additional patch to enable ST Micro sensor hub
>>
>> TBD for v3
>> - Use Lars-Peter's patch: "v2 1/9 patch: Add helper function for
>> initialize trigger buffers). Want to make sure that API is final.
>>
>> DATA Format examples:
>> Had few questions on data format for floating point. This spec uses.
>> - First of size of each field is specified in report descriptor. So it
>> is variable
> yuk. Thats annoying.  I guess we'll have to extend the scan_type bit of IIO_CHAN to include this.
>> - It uses VT_F16Ex format. For example VTF16E0 means 16 bit float with unit exponent 0.
>> Refer to Page 43 of the "HID Sensor Usage Table"
>> For example, if the size is 16 bits
>> 0xFFF4 with VTF16E14 format ->   -0.12
>> 0xFFF8 with VTF16E14 format ->   -0.08
>> 0x0067 with VTF16E14 format ->   +1.03
>>
>> I tried sensor hubs from two different makers. One use 16 bit and other uses 32 bit for accelerometer.
>> Also the unit expo is different for them. Also units are different.
> That shouldn't be a problem.
>> Possible IIO addition:
>> I wish we can add two more items for unit and unit_expo in
>> IIO_CHAN_INFO_XXXX. So that we can add them during channel definition.
>> Currently I am using offset and scale, which doesn't actually mean this.
> I am a little unclear on why they are different, ulitmately we are not have variable units for a given sensor type.
> That way just lies a whole pile of pain for userspace libraries.   They
> are offsets and scales even if framed in different terminology as far as I can see.
>
>> I think conversion should be done is user space based on the info provided.
>>
>> Srinivas pandruvada (5):
>>     HID-Sensors: Common attributes and interfaces
>>     HID-Sensors: Added accelerometer 3D
>>     HID-Sensors: Added Gyro 3D
>>     HID-Sensors: Added Compass 3D
>>     HID-Sensors: Added ALS
>>
>> srinivas pandruvada (3):
>>     HID-Sensors: Add ST Micro Sensor hub
>>     HID-Sensors: Add Intel HID sensor
>>     HID-Sensors: Sensor framework
>>
>>    drivers/hid/hid-core.c                             |    8 +
>>    drivers/hid/hid-ids.h                              |    6 +
>>    drivers/staging/Kconfig                            |    2 +
>>    drivers/staging/Makefile                           |    1 +
>>    drivers/staging/hid-sensors/Kconfig                |   19 +
>>    drivers/staging/hid-sensors/Makefile               |   16 +
>>    drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  375 ++++++++++
>>    drivers/staging/hid-sensors/hid-sensor-als.c       |  313 ++++++++
>>    .../staging/hid-sensors/hid-sensor-attributes.c    |  169 +++++
>>    .../staging/hid-sensors/hid-sensor-attributes.h    |   51 ++
>>    drivers/staging/hid-sensors/hid-sensor-buffer.c    |   98 +++
>>    .../staging/hid-sensors/hid-sensor-compass-3d.c    |  375 ++++++++++
>>    drivers/staging/hid-sensors/hid-sensor-gyro-3d.c   |  375 ++++++++++
>>    drivers/staging/hid-sensors/hid-sensor-hub.c       |  747 ++++++++++++++++++++
>>    drivers/staging/hid-sensors/hid-sensor-ids.h       |  117 +++
>>    drivers/staging/hid-sensors/hid-sensor-interface.h |   95 +++
>>    drivers/staging/hid-sensors/hid-sensor-trigger.c   |   83 +++
>>    17 files changed, 2850 insertions(+), 0 deletions(-)
>>    create mode 100644 drivers/staging/hid-sensors/Kconfig
>>    create mode 100644 drivers/staging/hid-sensors/Makefile
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-accel-3d.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-als.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-buffer.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-compass-3d.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-hub.c
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-ids.h
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-interface.h
>>    create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c
>>

