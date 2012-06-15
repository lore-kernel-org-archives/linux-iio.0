Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Jiri Kosina <jkosina@suse.cz>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH 0/8] HID-Sensor: v2
Date: Fri, 15 Jun 2012 15:27:48 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A919335248@ORSMSX104.amr.corp.intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
 <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz>
 <4FD9E33E.8070000@cam.ac.uk>
 <alpine.LNX.2.00.1206141516350.8644@pobox.suse.cz>
 <4FD9E999.4010103@cam.ac.uk>
 <4FA419E87744DF4DAECD5BCE1214B7A91932B625@ORSMSX104.amr.corp.intel.com>
 <4FDB2F94.2020106@cam.ac.uk>
In-Reply-To: <4FDB2F94.2020106@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

HI Jonathan,

It is better to hold off till I submit a version using mfd framework.

Thanks,
Srinivas

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
Sent: Friday, June 15, 2012 5:50 AM
To: Pandruvada, Srinivas
Cc: Jiri Kosina; linux-iio@vger.kernel.org; Jonathan Cameron
Subject: Re: [PATCH 0/8] HID-Sensor: v2

Srinivas,

shall I hold off reviewing until your next version?

Might be a little while longer before I get to it either way!
>
> I am in process of implementing as mfd device. In this case I can keep th=
e core HID stuff in driver/hid and move sensor implantation using IIO to dr=
ivers/iio/hid-sensors.
> In this way if some driver if just want to use HID sensor but want to use=
 some other mechanism to communicate with user mode, they can do in their r=
espective drivers.
>
> What do you think about this approach?
>
> Thanks,
> Srinivas
>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Thursday, June 14, 2012 6:40 AM
> To: Jiri Kosina
> Cc: Pandruvada, Srinivas; linux-iio@vger.kernel.org; Jonathan Cameron
> Subject: Re: [PATCH 0/8] HID-Sensor: v2
>
> On 6/14/2012 2:25 PM, Jiri Kosina wrote:
>> On Thu, 14 Jun 2012, Jonathan Cameron wrote:
>>
>>>> As this is however a staging driver (and depends on IIO, which is a=20
>>>> staging infrastructure), I suggest you resend the patch to staging=20
>>>> maintainers so that it gets applied and we can work on polishing=20
>>>> the driver there.
>>>
>>>> Also, what are the plans regarding moving IIO out of staging, please?
>>> The core is out of staging as of the current cycle.
>>
>> Ah, you are right, I missed that this has already happened.
>>
>>> Drivers are moving out whenever someone has time to take a look at=20
>>> each one and clean up any loose ends.  A couple went with the last=20
>>> merge window, lots more a queued up for the next one.
>>>
>>> Generally any new drivers shouldn't go into staging but directly=20
>>> into drivers/iio.
>>
>> For hid sensors I'd probably prefer drivers/hid though.
> There's some pretty strong moves to clasify drivers by function not by=20
> 'bus' (which is kind of what hid is I guess?)
>
> I do wonder if this driver would work better as an mfd type device with t=
he sensor specific bits each having their own module?
>
> Honestly I've never been much of a stickler for where things are as long =
as someone is happy to look after them.
>>
>>> Sorry for my lack of responses on this revised version, been a busy=20
>>> week and it's a fairly big review to do.
>>
>> Thanks,
>>
>
