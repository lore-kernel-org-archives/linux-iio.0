Return-Path: <SRS0=x/KN=AT=gmail.com=himshijain.hj@kernel.org>
MIME-Version: 1.0
In-Reply-To: <A955BE73-0C63-4316-943D-DF9181CE7AC5@jic23.retrosnub.co.uk>
References: <cover.1505291907.git.himshijain.hj@gmail.com> <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>
 <20170913180310.27cbf1b1@archlinux> <20170913185805.GB26390@kroah.com>
 <5e43ea4d-eab8-c4be-c5dc-2f862578d011@metafoo.de> <A955BE73-0C63-4316-943D-DF9181CE7AC5@jic23.retrosnub.co.uk>
From: Himanshi Jain <himshijain.hj@gmail.com>
Date: Mon, 18 Sep 2017 16:19:07 +0530
Message-ID: <CAKJRnmMwfxz-98qGnR+cMRC=70rE8CUncE3rR=d3=KQkyoTGRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] include: linux: sysfs: Add __ATTR_NAMED macro
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>, driverdev <devel@driverdev.osuosl.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nick Desaulniers <nick.desaulniers@gmail.com>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 14, 2017 at 2:20 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 13 September 2017 12:23:31 GMT-07:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>On 09/13/2017 08:58 PM, Greg KH wrote:
>>> On Wed, Sep 13, 2017 at 06:03:10PM +0100, Jonathan Cameron wrote:
>>>> On Wed, 13 Sep 2017 14:14:07 +0530
>>>> Himanshi Jain <himshijain.hj@gmail.com> wrote:
>>>>
>>>>> Add __ATTR_NAMED macro similar to __ATTR but taking name as a
>>>>> string instead of implicit conversion of argument to string using
>>>>> the macro _stringify(_name).
>>>>>
>>>>> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
>>>>> ---
>>>>>  include/linux/sysfs.h | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>>>>> index aa02c32..20321cf 100644
>>>>> --- a/include/linux/sysfs.h
>>>>> +++ b/include/linux/sysfs.h
>>>>> @@ -104,6 +104,13 @@ struct attribute_group {
>>>>>    .store  = _store,                                               \
>>>>>  }
>>>>>
>>>>> +#define __ATTR_NAMED(_name, _mode, _show, _store) {                       \
>>>>
>>>> I'm not sure about the naming here.  The normal __ATTR macro is also
>>>> 'named'.  Maybe something as awful as
>>>>
>>>> __ATTR_STRING_NAME ?
>>>>
>>>> Greg what do you think?
>>>
>>> ick ick ick.
>>>
>>>> This is all to allow us to have names with operators in them without
>>>> checkpatch complaining about them... A worthwhile aim just to stop
>>>> more people wasting time trying to 'fix' those cases by adding
>>spaces.
>>>
>>> Yeah, but this really seems "heavy" for just a crazy sysfs name in a
>>> macro.  Adding a whole new "core" define for that is a hard sell...
>>>
>>> I also want to get rid of the "generic" __ATTR type macros, and force
>>> people to use the proper _RW and friends instead.  I don't want to
>>add
>>> another new one that people will start to use that I later have to
>>> change...
>>>
>>> So no, I don't like this, how about just changing your macros
>>instead?
>>> No one else has this problem :)
>>
>>Nobody else realized they have this problem yet. E.g. there are a few
>>users
>>of __ATTR in block/genhd.c that have the same issue and are likely to
>>generate the same false positives from static checkers.
>
> For IIO there is the option of moving these over to the core generated available callbacks, but
> that won't work in every case and is a more major change.  I need to shift a few more drivers
> over to the available callbacks and see how well it works out.  Might find time to do one in a
>  gap between interesting talks this afternoon...

Can I help you in this? It is about exploring options as far as I can
make out, although can't really understand what options are those for
now.

Or do you want me to put comments to not to fix this checkpatch
warning as you suggested earlier?

>
> If I am feeling really keen I might write this missing docs I promised a while back on that stuff. Jet lag dependant...
>
> Jonathan
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
