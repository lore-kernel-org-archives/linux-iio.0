Return-Path: <jic23@cam.ac.uk>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com> <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz> <4FD9E33E.8070000@cam.ac.uk> <alpine.LNX.2.00.1206141516350.8644@pobox.suse.cz> <4FD9E999.4010103@cam.ac.uk> <4FA419E87744DF4DAECD5BCE1214B7A91932B625@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91932B625@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH 0/8] HID-Sensor: v2
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 14 Jun 2012 17:04:51 +0100
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,Jiri Kosina <jkosina@suse.cz>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Jonathan Cameron <jic23@kernel.org>
Message-ID: <fa30cbdd-0aba-400e-a367-1e14ac82e57f@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> wrote:

>Hi Jonath=
an and Jiri,
>
>I am in process of implementing as mfd device. In this case=
 I can keep
>the core HID stuff in driver/hid and move sensor implantation =
using IIO
>to drivers/iio/hid-sensors.
>In this way if some driver if just =
want to use HID sensor but want to
>use some other mechanism to communicate=
 with user mode, they can do in
>their respective drivers.
>
>What do you t=
hink about this approach?
Sounds like a sensible plan.  I would put the ind=
ividual drivers in iio/accel and similar though. 
>
>Thanks,
>Srinivas
>
>
=
>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@cam.ac.uk=
] 
>Sent: Thursday, June 14, 2012 6:40 AM
>To: Jiri Kosina
>Cc: Pandruvada,=
 Srinivas; linux-iio@vger.kernel.org; Jonathan Cameron
>Subject: Re: [PATCH=
 0/8] HID-Sensor: v2
>
>On 6/14/2012 2:25 PM, Jiri Kosina wrote:
>> On Thu,=
 14 Jun 2012, Jonathan Cameron wrote:
>>
>>>> As this is however a staging =
driver (and depends on IIO, which is a
>
>>>> staging infrastructure), I su=
ggest you resend the patch to staging 
>>>> maintainers so that it gets app=
lied and we can work on polishing
>the 
>>>> driver there.
>>>
>>>> Also, w=
hat are the plans regarding moving IIO out of staging,
>please?
>>> The cor=
e is out of staging as of the current cycle.
>>
>> Ah, you are right, I mis=
sed that this has already happened.
>>
>>> Drivers are moving out whenever =
someone has time to take a look at 
>>> each one and clean up any loose end=
s.  A couple went with the last 
>>> merge window, lots more a queued up fo=
r the next one.
>>>
>>> Generally any new drivers shouldn't go into staging=
 but directly
>into 
>>> drivers/iio.
>>
>> For hid sensors I'd probably pr=
efer drivers/hid though.
>There's some pretty strong moves to clasify drive=
rs by function not by
>'bus' (which is kind of what hid is I guess?)
>
>I d=
o wonder if this driver would work better as an mfd type device with
>the s=
ensor specific bits each having their own module?
>
>Honestly I've never be=
en much of a stickler for where things are as
>long as someone is happy to =
look after them.
>>
>>> Sorry for my lack of responses on this revised vers=
ion, been a busy 
>>> week and it's a fairly big review to do.
>>
>> Thanks=
,
>>

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevit=
y.
