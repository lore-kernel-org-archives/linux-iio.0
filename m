Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7BBF16.1060502@iis.fraunhofer.de>
Date: Mon, 30 Aug 2010 16:24:22 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio update documentation
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BBEE2.4070007@cam.ac.uk>
In-Reply-To: <4C7BBEE2.4070007@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------070004000605080500080200"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070004000605080500080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id QAA01117

Am 30.08.2010 16:23, schrieb Jonathan Cameron:
> On 08/30/10 15:03, Manuel Stahl wrote:
>
> Hi Manuel,
>
> Couple of comments inline.
>
> Most relate to stuff that was wrong in the original text.
> Feel free to leave these for me to clean up at a later
> date if you prefer.  If so add my signed off and send
> to Greg KH.
>> Signed-off-by: Manuel Stahl<manuel.stahl@iis.fraunhofer.de>
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>> ---
>>   drivers/staging/iio/Documentation/ring.txt        |    6 +-
>>   drivers/staging/iio/Documentation/sysfs-class-iio |   72 ++++++++++-=
---------
>>   drivers/staging/iio/Documentation/userspace.txt   |   36 ++++++-----
>>   3 files changed, 57 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/stag=
ing/iio/Documentation/ring.txt
>> index d2ca683..3696c36 100644
>> --- a/drivers/staging/iio/Documentation/ring.txt
>> +++ b/drivers/staging/iio/Documentation/ring.txt
>> @@ -47,10 +47,8 @@ request_update
>>     If parameters have changed that require reinitialization or config=
uration of
>>     the ring buffer this will trigger it.
>>
>> -get_bpd, set_bpd
>> -  Get/set the number of bytes for a given reading (single element, no=
t sample set)
>> -  The value of bps (bytes per set) is created from a combination of t=
his and the
>> -  enabled scan elements.
>> +get_bytes_per_datum, set_bytes_per_datum
>> +  Get/set the number of bytes for a complete scan. (All samples + tim=
estamp)
> Hohum. That original comment doesn't look at all accurate...
>>
>>   get_length / set_length
>>     Get/set the number of sample sets that may be held by the buffer.
>> diff --git a/drivers/staging/iio/Documentation/sysfs-class-iio b/drive=
rs/staging/iio/Documentation/sysfs-class-iio
>> index 714b4c5..c137020 100644
>> --- a/drivers/staging/iio/Documentation/sysfs-class-iio
>> +++ b/drivers/staging/iio/Documentation/sysfs-class-iio
>> @@ -158,7 +158,7 @@ Contact:	linux-iio@vger.kernel.org
>>   Description:
>>   		Magnetic field along axis x, y or z (may be arbitrarily assigned)
>>   		channel m (not present if only one magnetometer at this orientatio=
n).
>> -		Data converted by application of offset then scale to Gauss
>> +		Data converted by application of offset then scale to Gauss.
> good catch.
>>   		Has all the equivalent modifiers as per in[m].
>>
>>   What:		/sys/.../device[n]/device[n]:event[m]
>> @@ -212,39 +212,6 @@ Description:
>>   		The actual value of the threshold in raw device units obtained by
>>   		 reverse application of scale and offfset to the acceleration in m=
/s^2.
>>
>> -What:		/sys/.../device[n]/scan_elements
>> -KernelVersion:	2.6.35
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Directory containing interfaces for elements that will be captured
>> -		for a single triggered sample set in the buffer.
>> -
>> -What:		/sys/.../device[n]/scan_elements/[m]_accel_x0_en
>> -KernelVersion:	2.6.35
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Scan element control for triggered data capture. m implies the
>> -		ordering within the buffer. Next the type is specified with
>> -		modifier and channel number as per the sysfs single channel
>> -		access above.
>> -
>> -What:		/sys/.../device[n]/scan_elements/accel[_x0]_precision
>> -KernelVersion:	2.6.35
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Scan element precision within the buffer. Note that the
>> -		data alignment must restrictions must be read from within
>> -		buffer to work out full data alignment for data read
>> -		via buffer_access chrdev. _x0 dropped if shared across all
>> -		acceleration channels.
>> -
>> -What:		/sys/.../device[n]/scan_elements/accel[_x0]_shift
>> -KernelVersion:	2.6.35
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		A bit shift (to right) that must be applied prior to
>> -		extracting the bits specified by accel[_x0]_precision.
>> -
>>   What:		/sys/.../device[n]/device[n]:buffer:event/dev
>>   KernelVersion:	2.6.35
>>   Contact:	linux-iio@vger.kernel.org
>> @@ -270,8 +237,8 @@ Contact:	linux-iio@vger.kernel.org
>>   Description:
>>   		Number of scans contained by the buffer.
>>
>> -What:		/sys/.../device[n]:buffer/bps
>> -KernelVersion:	2.6.35
>> +What:		/sys/.../device[n]:buffer/bytes_per_datum
>> +KernelVersion:	2.6.37
>>   Contact:	linux-iio@vger.kernel.org
>>   Description:
>>   		Bytes per scan.  Due to alignment fun, the scan may be larger
>> @@ -292,3 +259,36 @@ Description:
>>   		to the nearest power of 2 times this.  (may not be true in weird
>>   		hardware buffers that pack data well)
>>
>> +What:		/sys/.../device[n]/buffer/scan_elements
> Is this not /sys/.../device[n]/buffer[m]/scan_elements? I think we allo=
w
> for multiple buffers per device.
>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Directory containing interfaces for elements that will be captured
>> +		for a single triggered sample set in the buffer.
>> +
>> +What:		/sys/.../device[n]/buffer/scan_elements/[m]_accel_x0_en
> This needs some brackets... [_x0]

Depends on what we accord for the next version, there should be a patch=20
removing the [m] and creating all the new files.

>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Scan element control for triggered data capture. m implies the
>> +		ordering within the buffer. Next the type is specified with
>> +		modifier and channel number as per the sysfs single channel
>> +		access above.
>> +
> Obviously the next two will get eaten up by your suggestion of 'type' t=
he other
> day, but best to keep the documentation matching what is actually in pl=
ace so
> I'm glad to see you updated them.
>> +What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_precision
>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Scan element precision within the buffer. Note that the
>> +		data alignment must restrictions must be read from within
>> +		buffer to work out full data alignment for data read
>> +		via buffer_access chrdev. _x0 dropped if shared across all
>> +		acceleration channels.
>> +
>> +What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_shift
>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		A bit shift (to right) that must be applied prior to
>> +		extracting the bits specified by accel[_x0]_precision.
>> +
>> diff --git a/drivers/staging/iio/Documentation/userspace.txt b/drivers=
/staging/iio/Documentation/userspace.txt
>> index 4838818..8bba2fa 100644
>> --- a/drivers/staging/iio/Documentation/userspace.txt
>> +++ b/drivers/staging/iio/Documentation/userspace.txt
>> @@ -7,17 +7,14 @@ Typical sysfs entries (pruned for clarity)
>>   /sys/class/iio
>>     device0 - iio_dev related elements
>>       name - driver specific identifier (here lis3l02dq)
>> -    accel_x - polled (or from ring) raw readout of acceleration
>> -    accel_x_gain - hardware gain (calibration)
>> -    accel_x_offset - hardware offset (calibration)
>> -    available_sampling_frequency
>> +    accel_x_raw - polled (or from ring) raw readout of acceleration
>> +    accel_x_offset - offset to be applied to the raw reading
>> +    accel_x_scale - scale to be applied to the raw reading and offset
>> +    accel_x_calibbias - hardware offset (calibration)
>> +    accel_x_calibscale - hardware gain (calibration)
> youch, Hadn't realised how out of date some of this has gotten.
>
> Actually we can probably drop most of this file.  It just replicates
> the abi documentation (and predates it). Shall I do that once
> your changes have merged, or do you want to loose everything down
> to the Udev will create line?  Perhaps add something saying the sysfs
> stuff is documented in the abi file?

Would be great if you do another docu review patch afterwards.

>
>>
>> -    available_sampling_frequency - what options are there
>> +    sampling_frequency_available - what options are there
>>       sampling_frequency - control of internal sampling frequency
>> -    scan_elements - controls which channels will be stored in the rin=
g buffer
>> -      scan_en_accel_x
>> -      scan_en_accel_y
>> -      scan_en_timestamp
>>       device - link to underlying hardware device
>>       uevent - udev related element
>>
>> @@ -30,23 +27,28 @@ Typical sysfs entries (pruned for clarity)
>>         dev - major:minor for the chrdev (note major allocation dynami=
c)
>>       trigger - consumer attachement
>>         current_trigger - name based association with a trigger
>> -    ring_buffer0 - ring buffer interface
>> -      bps - byptes per sample (read only), dependant on scan element =
selection
>> +    device0:buffer0 - ring buffer interface
>> +      bytes_per_datum - byptes per complete datum (read only),
>> +                        dependant on scan element selection
>>         length - (rw) specificy length fo software ring buffer (typica=
lly ro in hw case)
>> -      ring_enable - turn the ring on. If its the first to be enabled =
attached to this
>> -                    trigger will also enable the trigger.
>> -      ring_access0
>> +      enable - turn the ring on. If its the first to be enabled attac=
hed to this
>> +               trigger will also enable the trigger.
>> +      device0:buffer0:access0
>>           dev - major:minor for ring buffer access chrdev
>> -      ring_event_line0
>> +      device0:buffer0:event0
>>           dev - major:minor for ring buffer event chrdev
>> +      scan_elements - controls which channels will be stored in the r=
ing buffer
>> +        accel_x_en
>> +        accel_y_en
>> +        timestamp_en
>>
>>     trigger0 - data ready trigger elements
>>       name - unqiue name of trigger
>>
>>   Udev will create the following entries under /dev by default:
>>
>> -ring_access0 - ring access chrdev
>> -ring_event0 - ring event chrdev
>> +device0:buffer0:access0 - ring access chrdev
>> +device0:buffer0:event0 - ring event chrdev
>>   event_line0 - general event chrdev.
>>
>>   For the example code we assume the following rules have been used to=
 ensure
>

Regards,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------070004000605080500080200
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------070004000605080500080200--
