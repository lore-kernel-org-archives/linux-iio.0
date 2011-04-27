Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55357 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1D0OkY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2011 10:40:24 -0400
Message-ID: <4DB82B5C.5070900@cam.ac.uk>
Date: Wed, 27 Apr 2011 15:42:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk> <4DB7FEE8.3080004@analog.com>
In-Reply-To: <4DB7FEE8.3080004@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/27/11 12:32, Michael Hennerich wrote:
> On 04/26/2011 06:13 PM, Jonathan Cameron wrote:
>> Hi Michael,
>>
>> I'm trying to squash the remaining drivers that don't build after
>> all the changes in iio-onwards.  A couple of odd cases have come
>> up.
>>
>> ad7291 - has two similar concurrent event measurements on the same temperature channel.
>> One is almost a windowed average, but not quite. The other based on raw value.
>> I'm not sure what event code we should generate for them to differentiate between
>> them.  So for now I just have both producing a generic temperature threshold event.
>> (filtering on data isn't covered by our abi's yet, let alone on event detectors!)
>>
>> ad7745 - slow capacitance adc.  This one actually makes a possibly valid use of the
>> buffer event codes.  It is slow enough that it may make sense to notify userspace
>> that a new reading is available (90Hz).  I'd prefer to see this happen by just allowing
>> polling on the sysfs attributes though. I have no means to testing this one, and such
>> a change is a little more invasive than I like to make without hardware!
>>   
> The /RDY interrupt in this driver should be a data available interrupt,
> used by a buffer to trigger the readout.
> Implementing it as an event is pointless.
Definitely pointless as an event, but as the device is so slow, I can see some merit
in allowing poll on the sysfs attributes rather than insisting on a full buffer implementation.
> 
>> adt7310 - should be in hwmon as far as I can see.... + it's abusing our interfaces
>> so I don't like it ;)  For now I've squashed the events into basic temp events.
>> adt7410 - the same.
>>
>> adt7316 - The fault condition on the external temperature sensor isn't an event that
>> one should ever see unless something is horribly wrong.  I'd be inclined to copy the
>> hwmon interface for this and do it as an alarm sysfs attribute... I don't think it
>> belongs in out main event path...  For now I've removed it's ability to be reported at all.
>>
>>   
> Fixing these so that they build is fine for now.
> There are a few more oddities with these drivers.
> I have ordered hardware and there are some open tasks to test and
> cleanup those drivers.
Cool
>>  
>> ade7758 - Complex driver I'm not that keen on touching without a lot of testing support.
>> Don't suppose you want to take this one Michael? (*looks hopeful*)  At lease blugeoning
>> it into more or less current interfaces would be a great help. I can do it, but then I
>> suspect I'll break it in a few exciting ways :(
>>   
> I can fix building on this one. However I currently don't have enough
> time to fix and document the API.
That's fine.  We won't be pushing any of the energy meter drivers out of staging
for a while yet anyway!
> The buffer scan attribute naming is a bit complicated on this one. Do
> you think we can stick with wform?
> There is some interaction with the WAVEFORM MODE Register. Ideally we
> have enable files for all possible waveform selection possibilities,
> which are numerous, 3 sources (phases)  * 5 measurement options
> (Current, Voltage, Active Power, Reactive Power and VA). Only one
> combination can be enabled at a given time, since they are exclusive or.
That sounds right.  One _en attribute per combination.  Probably need to clarify
the documentation to say that any of these attributes can effect any other and
userspace should check all values after it has configured what it wants.
Thanks

Jonathan
