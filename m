Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4f1a2f3f-fea0-8d14-dcea-ff2bd51dca63@kernel.org>
References: <1464572270-29154-1-git-send-email-mranostay@gmail.com>
 <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org> <77a1a974-2636-878b-742c-d624cc5fdc58@kernel.org>
 <576A45FA.4020708@metafoo.de> <4f1a2f3f-fea0-8d14-dcea-ff2bd51dca63@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Mon, 27 Jun 2016 00:09:30 -0700
Message-ID: <CAKzfze_FTjQbO9Y5zxaU4pBKpUHL5Dx+=4=Cx=+En0mgT5ac8w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: temperature: add support for Maxim thermocouple chips
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 26, 2016 at 8:13 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 22/06/16 09:02, Lars-Peter Clausen wrote:
>> On 06/11/2016 06:48 PM, Jonathan Cameron wrote:
>>> On 03/06/16 13:33, Jonathan Cameron wrote:
>>>> On 30/05/16 02:37, Matt Ranostay wrote:
>>>>> Add initial driver support for MAX6675, and MAX31885 thermocouple chips.
>>>>>
>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>> Cc: Matt Porter <mporter@konsulko.com>
>>>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>>> I'm going to let this sit for a sort while as I'd like some discussion
>>>> of the invalidate buffer bit.
>>>>
>>>> Cc'd a few more people for views.
>>> Hmm. Deadly silence.
>>>
>>> Daniel, Lars, Peter - this is a fairly fundamental abi question.
>>>
>>> What do we do to signify an 'invalid reading' in the buffer.
>>>
>>> Here the part is driven by a software trigger - and if we skip
>>> a reading we are obviously out of sync.
>>>
>>> Old and nasty trick we used in some (possibly only one)
>>> early driver was to set an invalid state for these cases.
>>>
>>> Anyone have a better idea?
>>
>> Ideally the driver would leave the data including the status bit intact and
>> not replace it with a magic constant that way an application that is aware
>> of the way the chip behaves could handle that.
>
> In response to what I'd misunderstood this as:
>
> It's tricky as the status bit is not in general in the same register as the
> value.  We would need to add a meta data element to the buffer to handle this.
>
> I'm inclined to go with the magic value as the best 'general purpose' option
> we have right now...  I don't like it, but adding meta data is also somewhat
> hideous as most usecases and devices wouldn't use it.
>
> Lets keep in mind that we might want to 'clean' this up at some point.
>
> I'll let this sit a few more days for other inputs.
>
> And what is actually going on :
> Actually reading the datasheets on this I think I'd missunderstood.
>
> These are low not if a conversion is in progress, but rather if
> the thermocouple is physically open (i.e. open circuit).
> This should be reported out of band to my mind rather than in the buffer at all...

Could do an event or refuse to allow the buffer to be enabled..
However the former just defers the reporting from buffer to an iio
event, and latter only prevents it being enabled if the thermocouple
is open on starting but not if disconnected during a data capture.

>
> The buffer can have whatever rubbish in it as long as there is an easy way
> of detecting the thermocouple is broken...
>
> How to report broken hardware is always unclear in kernel, but
> here I think a simple count of observed instances of it being open
> would do the job nicely.
>
> What do you think?
>
> Jonathan
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
