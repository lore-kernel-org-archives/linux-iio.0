Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DBEE5A7.6030909@cam.ac.uk>
Date: Mon, 02 May 2011 18:11:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
 Drivers <Drivers@analog.com>
Subject: Re: [RFC PATCH 0/2] staging:iio: add name_extend to allow for named
 channels
References: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAF07290B@LIMKCMBX1.ad.analog.com> <4DBEBE7B.2080902@cam.ac.uk>
In-Reply-To: <4DBEBE7B.2080902@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/02/11 15:23, Jonathan Cameron wrote:
> On 05/02/11 14:05, Hennerich, Michael wrote:
>> Jonathan Cameron wrote on 2011-04-28:
>>> This is needed for the light sensors where we indicate what a given
>>> sensor is measuring. It also came up in Michael's questions in the the
>>> thread Oddities and how to handle them.  Also for that matter allows
>>> us to put back the in0_supply_raw convention that got squashed in
>>> moving to iio_chan_spec registration.
>>>
>>> What do people think?
>>
>> Looks good to me... And actually needed for the ADE7758 driver cleanup.
>> So it would be good if you could get this into your iio-onwards tree.
> Will put it right after patch that introduces iio_chan_spec.
> Need to run the interface changes in tsl2563 past the original
> submitters before pushing the tsl2563 driver out.

Hi Michael,

I'm rethinking a couple of things related to this patch.

Firstly, as Arnd warned, we have a steadily growing set of macros for defining
channels that have become nasty to maintain. I have redefined IIO_CHAN()
to do pretty much everything.  As a result I'm going to remove all the
other variants.  There may be call for cover of the case where it is only a sysfs
attribute, but we can add that later if it looks useful.

Secondly, I have added a flag to chan spec for 'modified' so it is easy
to do the name formatting in the core.  This is alongside the 'extend_name'
in this patch. Modified should almost always be what is used.  Extend name
is for convenience stuff only.    There is a 'magic' michex branch on
iio-onwards which is an extremely dirty push from the top of my local tree
so you can see what I have done.

I have shown how I would like to see all modifiers registered (including
the implicit ones we already have).

I think this works for everything we have.  May need further tweaking.
If you are happy, I'll push it into the original iio-onwards chan_spec
patch and work all the way up the tree doing the drivers as and when
they are currently converted over to chan_spec registration.

Thanks,

Jonathan.
> 
>>
>>> (this is rather rough and ready, but then it is an RFC ;)
>>>
>>> Jonathan Cameron (2):
>>>   RFC add naming to channels
>>>   Example of naming usage
>>>  drivers/staging/iio/iio.h               |   26 +++-
>>>  drivers/staging/iio/industrialio-core.c |   34 +++-
>>>  drivers/staging/iio/light/tsl2563.c     |  323 +++++++++++------------
>>>  -------- 3 files changed, 165 insertions(+), 218 deletions(-)
>>
>> Greetings,
>> Michael
>>
>> --
>> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
>>
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
