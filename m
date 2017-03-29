Return-Path: <SRS0=023H=3G=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e9dd2273-f051-0540-28b5-ac8e9bab6b0b@kernel.org>
References: <20170328200745.GA8033@singhal-Inspiron-5558> <6eb0038d-ac22-99be-2aee-b29284bdadf3@kernel.org>
 <CALrZqyPEoNOQvaXmLHfk7bmNAdDyosZsjCnGnXuttsAvQsAm3w@mail.gmail.com> <e9dd2273-f051-0540-28b5-ac8e9bab6b0b@kernel.org>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Thu, 30 Mar 2017 03:10:17 +0530
Message-ID: <CALrZqyOh49Boyu_oGP_ehmeb+ZnwaZ_qyBco0THMihFBw0OuUg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: constify attribute_group structures
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 30, 2017 at 3:06 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/03/17 22:28, SIMRAN SINGHAL wrote:
>> On Thu, Mar 30, 2017 at 2:43 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 28/03/17 21:07, simran singhal wrote:
>>>> Check for attribute_group structures that are only stored in the
>>>> event_attrs filed of iio_info structure. As the event_attrs field of
>>>> iio_info structures is constant, so these attribute_group structures can
>>>> also be declared constant.
>>>> Done using coccinelle:
>>>>
>>>> @r1 disable optional_qualifier @
>>>> identifier i;
>>>> position p;
>>>> @@
>>>> static struct attribute_group i@p = {...};
>>>>
>>>> @ok1@
>>>> identifier r1.i;
>>>> position p;
>>>> struct iio_info x;
>>>> @@
>>>> x.event_attrs=&i@p;
>>>>
>>>> @bad@
>>>> position p!={r1.p,ok1.p};
>>>> identifier r1.i;
>>>> @@
>>>> i@p
>>>>
>>>> @depends on !bad disable optional_qualifier@
>>>> identifier r1.i;
>>>> @@
>>>> static
>>>> +const
>>>> struct attribute_group i={...};
>>>>
>>>> @depends on !bad disable optional_qualifier@
>>>> identifier r1.i;
>>>> @@
>>>> +const
>>>> struct attribute_group i;
>>>>
>>>> File size before:
>>>>    text    data     bss     dec     hex filename
>>>>   26051     464       0   26515    6793 drivers/iio/adc/ad799x.o
>>>>
>>>> File size after:
>>>>    text          data     bss     dec     hex filename
>>>>   26115           400       0   26515    6793 drivers/iio/adc/ad799x.o
>>>>
>>>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>>> Applied to the togreg branch of iio.git and pushed out as testing
>>> for the autobuilders to play with it.
>>>
>>
>> But my tree is up-to-date and I also test it before sending.
> this is standard practice.  I build as well before pushing out, but
> I only do one or two configurations of one or two architectures.
> The autobuilders are a set of large servers that Intel run as a service
> to the kernel community.
>
> Typically they'll run a few hundred builds for dozens of processor architectures
> + a much more extensive set of static tests than most kernel developers
> are set up to run.  Here things will almost certainly be fine, but
> I've been wrong before!
>
> The only thing is I tend to push out in the evening then go to bed before
> the results come in, then might not get to it for a day or so to push out
> as togreg.  This tree I am happy to rebase - that is I can drop or fixup
> patches with issues.  The togreg branch is the one that people often
> base new work on, so if I change the tree under them all sorts of nasty
> merge issues can occur.
>
> This is why most trees that ultimately go upstream are non rebasing -
> but a lot of people now have a testing branch which is deliberately
> unofficial - people shouldn't use it to base their trees on as it
> is temporary for build test purposes.
>
> Greg has one as well (I assume this is what it is for), he just tends
> to be quicker about dealing with whatever comes up than I am so
> doesn't explicitly mention it when he takes patches.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/?h=staging-testing
>
> So it's nothing to worry about. I just put that note in so people
> don't wonder why their patch isn't immediately present in the public
> togreg branch of iio.git.
>

Thanks for the explaination.

Simran

> Jonathan
>>
>>> Thanks,
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/iio/adc/ad799x.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>>>> index 9704090..22426ae 100644
>>>> --- a/drivers/iio/adc/ad799x.c
>>>> +++ b/drivers/iio/adc/ad799x.c
>>>> @@ -520,7 +520,7 @@ static struct attribute *ad799x_event_attributes[] = {
>>>>       NULL,
>>>>  };
>>>>
>>>> -static struct attribute_group ad799x_event_attrs_group = {
>>>> +static const struct attribute_group ad799x_event_attrs_group = {
>>>>       .attrs = ad799x_event_attributes,
>>>>  };
>>>>
>>>>
>>>
>
