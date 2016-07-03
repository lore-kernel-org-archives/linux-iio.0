Return-Path: <jic23@kernel.org>
Subject: Re: [PATCH] iio: bmg160: add callbacks for the filter frequency
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
References: <1461235740-18710-1-git-send-email-s.trumtrar@pengutronix.de>
 <59d35d82-8ca8-646b-8629-c2bba666286b@kernel.org>
 <1461702322.14657.15.camel@linux.intel.com>
 <8AAC9055-0140-4975-AF49-A3553B81D23B@jic23.retrosnub.co.uk>
 <1461706611.14657.66.camel@linux.intel.com>
 <b13f368d-8080-6b76-a0f9-14a5cf9812dc@kernel.org>
 <a78e04db-502d-a915-1667-5bee4af15392@kernel.org>
 <20160629151329.GA28114@pengutronix.de>
 <1467214869.8970.122.camel@linux.intel.com>
 <2b14035b-3df6-0100-3fac-d7de1bfff4b1@kernel.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c329f53f-b3fe-8e58-bfac-3544ec37ef93@kernel.org>
Date: Sun, 3 Jul 2016 12:41:10 +0100
MIME-Version: 1.0
In-Reply-To: <2b14035b-3df6-0100-3fac-d7de1bfff4b1@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 03/07/16 11:37, Jonathan Cameron wrote:
> On 29/06/16 16:41, Srinivas Pandruvada wrote:
>> On Wed, 2016-06-29 at 17:13 +0200, Steffen Trumtrar wrote:
>>> On Wed, May 04, 2016 at 10:55:56AM +0100, Jonathan Cameron wrote:
>>>>
>>>> On 01/05/16 21:02, Jonathan Cameron wrote:
>>>>>
>>>>> On 26/04/16 22:36, Srinivas Pandruvada wrote:
>>>>>>
>>>>>> On Tue, 2016-04-26 at 22:15 +0100, Jonathan Cameron wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 26 April 2016 21:25:22 BST, Srinivas Pandruvada
>>>>>>> <srinivas.pandruva
>>>>>>> da@linux.intel.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, 2016-04-25 at 20:31 +0100, Jonathan Cameron wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 21/04/16 11:49, Steffen Trumtrar wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The filter frequency and sample rate have a fixed
>>>>>>>>>> relationship.
>>>>>>>>>> Only the filter frequency is unique, however.
>>>>>>>>>> Currently the driver ignores the filter settings for 32
>>>>>>>>>> Hz and
>>>>>>>>>> 64 Hz.
>>>>>>>>>>
>>>>>>>>>> This patch adds the necessary callbacks to be able to
>>>>>>>>>> configure
>>>>>>>>>> and read the filter setting from sysfs.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix
>>>>>>>>>> .de>
>>>>>>>>> cc'd Srinivas as it's his driver...  Looks superficially
>>>>>>>>> fine to
>>>>>>>>> me.
>>>>>>>>>
>>>>>>>>> Jonathan
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changing the sample rate will result in using the first
>>>>>>>>>> match
>>>>>>>>>> and therefore selecting the filter accordingly. Is this
>>>>>>>>>> a
>>>>>>>>>> misuse
>>>>>>>>>> of the ABI and should be handled differently or is this
>>>>>>>>>> okay?
>>>>>>>>>>
>>>>>>>> This is the reason they were omitted. Now you can't
>>>>>>>> uniquely set
>>>>>>>> 100Hz
>>>>>>>> sampling frequency. Depending on filter it will have
>>>>>>>> different
>>>>>>>> results.
>>>>>>>>
>>>>>>>> I think this needs some ABI level changes, where you
>>>>>>>> display
>>>>>>>> available
>>>>>>>> and allow to specify both ODR and Filter to uniquely
>>>>>>>> select.
>>>>>>> Unfortunately the moment the ABI allows for combined elements
>>>>>>> it
>>>>>>> becomes a
>>>>>>>  nightmare for complexity. In some devices a single parameter
>>>>>>> change
>>>>>>> can
>>>>>>>  change everything else. There are no simple rules
>>>>>>> unfortunately. 
>>>>>>>
>>>>>>> The way we avoid this being a problem is that we very
>>>>>>> deliberately
>>>>>>> allow any ABI element
>>>>>>> to be able to result in a change in any other.  This includes
>>>>>>> changing the
>>>>>>>  available values list as here. It might be slightly nicer to
>>>>>>> jump to
>>>>>>> the nearest
>>>>>>>  available option though.
>>>>>>>
>>>>>>> An alternative would be to have an interface to fake such
>>>>>>> changes
>>>>>>> then
>>>>>>> apply them atomically if possible. 
>>>>>>> That level of complexity just does seem warranted here and
>>>>>>> would
>>>>>>> still need userspace to check valid ranges as it
>>>>>>>  pretends to change the state. Hence no real gain....
>>>>>>>
>>>>>> I think we should add some documentation for this driver about
>>>>>> this.
>>>>>> They should rather change filer rather than sampling freq to
>>>>>> have
>>>>>> unique setting.
>>>>> whilst that would get around the problem, people are going to be
>>>>> expecting
>>>>> to have explicit control of sampling frequency if they see it is
>>>>> variable for
>>>>> the part...
>>>>>
>>>>> Tricky unfortunately.
>>>> So Srinivas, I'm in favour of the patch as it stands.  Have I
>>>> convinced you?
>>> So, any conclusion ? :-)
>> Sorry, I missed this. I am fine with this change.
> Cool.
> 
> Applied to the togreg branch of iio.git and initially pushed out as
> testing for the autobuilders to play cricket with it...
> 
> Thanks,
> 
> Jonathan
I completely failed to notice that data->dev got dropped in the meantime
fixed up and pushed out.  Please sanity check the testing branch of iio.git.

thanks,

Jonathan
>>
>> Thanks,
>> Srinivas
>>>
>>> Best regards,
>>> Steffen
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
