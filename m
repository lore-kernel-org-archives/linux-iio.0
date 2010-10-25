Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51035 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0JYKWv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2010 06:22:51 -0400
Message-ID: <4CC55BDE.70508@cam.ac.uk>
Date: Mon, 25 Oct 2010 11:28:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: Mike Frysinger <vapier@gentoo.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408 temperature
 sensors
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-12-git-send-email-vapier@gentoo.org> <4CC4B8F8.7010005@cam.ac.uk> <20101024234735.GB15616@ericsson.com>
In-Reply-To: <20101024234735.GB15616@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/10 00:47, Guenter Roeck wrote:
> On Sun, Oct 24, 2010 at 06:53:44PM -0400, Jonathan Cameron wrote:
>> On 10/23/10 21:29, Mike Frysinger wrote:
>>> From: Sonic Zhang <sonic.zhang@analog.com>
>> Here we enter new territory. This device is already
>> supported in hwmon.  Do we have a usecase that is not
>> covered by that driver?
>>
>> If this is only for hardware monitoring by Guenter (cc'd) can
>> perhaps advise on how to support everything you have here...
>>
> 
> device_id and manufactory_id (shouldn't that be manufacturer_id ?) don't provide
> much value since they are (or could be) already part of the device name.
Agreed, they'll get dropped whatever happens to this driver. It's far from
clean as it currently stands.
> 
> "capability" reflects a raw register value. I would be opposed to any attribute
> like that, since it does not mean anything beyond the driver for that specific chip.
Agreed, that's certainly not staying there as is.  The intent is to merge
this series (36 drivers in all) into staging and clean up there.  Analog have
given commitments that they will put the man power on it.
> The data it provides might make sense in the driver documentation, but what
> is anyone supposed to do with the returned hex value ? That kind of ABI really
> does not make any sense. If the reported values are really valuable enough to be
> reported, a real abi (eg tempX_accuracy and tempX_resolution) would be much better.
> 
> For "power-save" (or "power-down" ?) and "full" mode I am not sure
> why suspend/resume isn't used instead. Is that some new upcoming ABI ?
Nope, it's a dirty hack instead of using the runtime pm (which to be fair is still
in relatively early days)  It'll go in the clean up (as for that matter will
any 'mode' type attributes as they never standardize well.). 
> 
>> I'm personally not against having drivers in IIO for devices
>> supported elsewhere, but the requirements for justification
>> are rather higher. Also care is needed to ensure no issues with
>> platform data etc.
>>
>> Guenter, for your information we have a set of temp drivers coming,
>> as a small element of a larger set, from Analog's tree. Those
>> I've reviewed so far have wanted to use IIO's event infrastructure
>> (which is much more general than hwmon's handling of alarms)
>> or have been suitably high performance devices with general
>> adc's to satisfy me that they clearly have uses beyond
>> hardware monitoring.
>>
> There should be a generic part and a specific part for such generic devices.
> The generic part can be in mfd or somewhere suitable (such as iio), but
> the hwmon part should reside in hwmon.
Tricky to agree on the divide.  Note we do match your interfaces anyway
(where they exist). The only exception to this is your alarm interfaces which
are way too restrictive (as one would expect they only cover cases that make
sense for hardware monitoring!)

We have numerous devices (including accelerometers, which you are quite rightly trying to
get out of hwmon) that have a voltage supply monitor channel.  It might seem obvious
that we should add a hwmon element to this but the value is only of interest alongside
the measurements from gyroscopes etc.  Typically it will be captured and buffered at
a couple of Khz which really doesn't make it fit into the scope of hwmon.  Anyone who
uses $400 of IMU as their voltage monitor gets to deal with the consequences.
> 
> The worst thing to do would be to duplicate functionality as it is proposed here.
> That can only create chaos.
It's an interesting boundary for what should go where and as per the discussions
about accelerometers going into input, I think it has to be decided based on what
people are using the device for.
> 
> If the event mechanism in hwmon is deemed insufficient enough to cause drivers
> to move elsewhere, maybe event mechanism in hwmon should be improved instead.
This comes back to the reason IIO started in the first place.  
hwmon is for hardware monitoring and hence has a different set of requirements from
generic sensing.  Basically you want to do things slowly.  There is no earthly point
in monitoring at 1MHz.  The problem lies in chips that sit on the edge.  There are plenty
of high end ADCs running at 1Hz or less to track some battery voltage or similar. If that's
what they are used for then I agree they should be in hwmon.  If you want to do high
speed capture or fast event capture then it is a non starter.  There is a reason IIO
is a whole lot more complex than hwmon. Requirements demand it.

> Or, even better, if there is a really need for a more detailed / improved event
> mechanism, there should be a single event subsystem that works for both iio
> and hwmon.
That's the equivalent of Linus' argument that all devices should use input's event
subsystem. It's massive overkill unless you want sophisticated amalgamation and filtering
of the incoming event stream. Also input are worried about bloat in their event structures
so are very much against adding anything that isn't a true human input device.
There may be some scope for sharing at some level but I don't think the whole event
mechanism can realistically be shared.  The requirements are simply too different.
For reference the way we handle the conversion from IIO events (which are more specific
and streamlined than input ones - their events include standard data, for reasons of
overhead our data goes a different route) for the odd device that sits at the boundary
of IIO and input is a userspace loopback tool via uinput (proof of concept only at this stage).
> 
> In short, if the hwmon ABI is deemed to be insufficient to support today's devices,
> for whaever reason, it needs to get fixed. Moving hwmon drivers elsewhere to
> avoid its perceived (or real) limitations should be an absolute no.
I agree. The issue here is where we draw the divide. I am very dubious about this particular
driver going in IIO simply because it doesn't seem to need any of the stuff that we exist
for.  Others are far less clear.

Jonathan
> Guenter
> 

