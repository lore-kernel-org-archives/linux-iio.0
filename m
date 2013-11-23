Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55443 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab3KWLs6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 06:48:58 -0500
Message-ID: <5290A47E.5070105@kernel.org>
Date: Sat, 23 Nov 2013 12:50:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Haimovich, Yoav" <yoav.haimovich@intel.com>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Drubin, Daniel" <daniel.drubin@intel.com>
Subject: Re: IIO devices flexibility
References: <0423FED8EB79934F939F077EAF96DBD717DB65DA@HASMSX105.ger.corp.intel.com> <107c4dbf-5ad0-4a33-8307-818979ebe49f@email.android.com> <99374EB591328D43AAACEEAF87774A7E2144C41D@HASMSX103.ger.corp.intel.com>
In-Reply-To: <99374EB591328D43AAACEEAF87774A7E2144C41D@HASMSX103.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/14/13 07:50, Haimovich, Yoav wrote:
> Hi,
> 
Hi,

Firstly, sorry for the slow reply!  Been an interesting couple of weeks.

Anyhow,
> The sensors we would like to add are the ones supported by Android KitKat and are found at:
> http://source.android.com/devices/reference/sensors_8h_source.html
The bit about virtual sensors is interesting but I guess you'll do this in userspace.
Any application of transforms to the axes of the data should probably be done in userspace
so I'll just ignore that.

To make life easier for others who wish to join this thread, I'll list them all and give
my opinions on them.

Acceleration - Sensible choice to use SI units. (present in IIO)
Geomagnetic field - (present in IIO)
Orientation - Euler angles - I think, it's been a while...
		Conversion isn't horendous from quaternions which we already
              	have a proposal for.  If hardware spits out Euler angles, then we can certainly
		add an appropriate interface for them.

Gyroscope - (present in IIO)

light - (present in IIO) There definition is rather limiting as doesn't include different
        frequencies.  Lux is a measure of illuminance so I guess they care only about human
        perception of light intensity. (which makes sense)

presure (present in IIO) different units but I guess that isn't a problem?

temp (present, but deprecated)

proximity (present in IIO though I don't think we have anything yet that gives a clean
	measurement)

gravity - Not present in IIO. I haven't yet seen this implemented on a device, but easy enough
	to add if there is hardware doing this. (I know some high end IMUs do this but even
	then you often get a better result doing it in software)

rotation vector - (proposed, but not yet present).  I've been promising to propose how to handle
	this as a single 'measurement' as the individual elements have no meaning on their own).
	Keep not getting around to it  :(

relative humidity - (proposed and the first driver is just waiting for some device tree name
	changes)

ambient temperature - Hmm.  I wonder how best to provide the meta data to distinguish this
	from any other temperature sensor. Otherwise, supported.

magnetic-filed uncalibrated - just a different use of meta data found in sysfs.

game-rotation-vector - This is just a conventional drifting gyroscope (rather than the rate
	sensors that mems gyros are).  Again we may want metadata to make it clear that
	some hardware is doing this in a random basis.

gyroscope-uncalibrated - we don't have explicity way so separately outputing the drift estimate,
	but would be easy enough to add (as an additional channel).

signficant motion - IIO event.

step detector - either an IIO event, or in userspace.

step counter - interesting - would be easy to implement an event counter if this is of sufficient
	use.  I'm guessing some hardware provides this on device.  Would become an additional
	property of the event in question.



> 
> And also the sensors that are defined in the HID Sensor usage document:	
> http://www.usb.org/developers/hidpage/HUTRR39b.pdf‎
> 
For this one some stuff is obviously not within the scope of IIO.

Biometric (out of scope - or processed in userspace from an IIO device).
Electrical : Available in IIO though we have no indunctance or resistance types yet or period
(though that might be established from frequency.) I don't think we have any frequency measuring
devices yet, but we do have output ones so the interface is fairly well defined.

Wind direction, wind speed. These are just orientation and velocity sensors (possibly with
explicity meta data )

Light - present in IIO though might need an additional modifier for consumer infrared.

Location - probably not in scope.

Mechanical - likely to be userspace computed values from IIO sensor rather than directly
	provided. Not a problem to add this if desired though.

Motion - Accel, gyro covered. Speedometer not, and motion detector is likely to be an
	IIO event on a particular device.

Orientation - Compass and inclinometer covered.  Distance not yet, but easy addition when
	first device driver is proposed.

scanner - out of scope.

time - partly covered, though we could definitely improve our handling of this when it is
	a timestamp for some other data.  Direct use as rtc etc is out of scope of IIO.

Custom devices.  These exist for anything that is out of scope of the parts defined by this
spec.  THat doesn't mean they can't have a definition in IIO.  I am not really interested
in providing a 'custom' interface.  It should always be possible to identify what is being
measured and provide a real interface.  One stated use in the spec is to obfiscate
data.  As per other linux userspace interfaces, we are very much against any attempt to
pass undocumented binary streams out of the kernel to close source binaries.  Hence I'll
ignore that usage and assume it is just for stuff that no one has thought of yet!

Hence in conclusion.  If you have something that falls into the HID specs 'custom' category
then just 'make up an interface' for it and propose it as an addition to IIO. I don't see anything
in either of these documents (that lies within the vaguely defined scope of IIO) that will cause
any real trouble to add support for.

Looking forward to lots of 'interesting' drivers ;)

Jonathan

> The latter document also includes a definition of the custom sensor we would like to support.
> 
> Best regards,
> Yoav Haimovich
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org] 
> Sent: Wednesday, November 06, 2013 19:27
> To: Yuniverg, Michael; Jonathan Cameron; linux-iio@vger.kernel.org
> Cc: Drubin, Daniel; Haimovich, Yoav
> Subject: Re: IIO devices flexibility
> 
> 
> 
> "Yuniverg, Michael" <michael.yuniverg@intel.com> wrote:
>> Hello Jonathan, guys
>>
>> We are using iio now for 4 standard sensors and we are rather satisfied 
>> with its execution and robustness.
>> Now implementing new sensors we came across a limitation -
>>
>> --
>> static const char * const iio_chan_type_name_spec[] = {  [IIO_VOLTAGE] 
>> = "voltage",  [IIO_CURRENT] = "current",  [IIO_POWER] = "power",  
>> [IIO_ACCEL] = "accel",  [IIO_ANGL_VEL] = "anglvel",  [IIO_MAGN] = 
>> "magn",  [IIO_LIGHT] = "illuminance",  [IIO_INTENSITY] = "intensity",  
>> [IIO_PROXIMITY] = "proximity",  [IIO_TEMP] = "temp",  [IIO_INCLI] = 
>> "incli",  [IIO_ROT] = "rot",  [IIO_ANGL] = "angl",  [IIO_TIMESTAMP] = 
>> "timestamp",  [IIO_CAPACITANCE] = "capacitance",  [IIO_ALTVOLTAGE] = 
>> "altvoltage",  [IIO_CCT] = "cct",  [IIO_PRESSURE] = "pressure",
>> --
>>
>> To our understanding, that means these are only data channels we have.
>> We need however new channels and even more - custom/generic channels 
>> including some proprietary info Does that fit your vision of IIO?
> 
> These channel types get added whenever a new device needs one.
> 
> Hence feel free to propose additions to the list above along with an example device that needs it. There are a couple more under review at the moment. One of these is particularly interesting in that it presents a quaternion which will need some additional core support.
> 
> As for proprietary info and custom/generic channels... Could you give some examples of what you have in mind?
> 
> Thanks
> 
> Jonathan
>>
>> Thanks, Michael
>> ---------------------------------------------------------------------
>> Intel Israel (74) Limited
>>
>> This e-mail and any attachments may contain confidential material for 
>> the sole use of the intended recipient(s). Any review or distribution 
>> by others is strictly prohibited. If you are not the intended 
>> recipient, please contact the sender and delete all copies.
> 
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 
