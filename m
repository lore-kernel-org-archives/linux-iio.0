Return-Path: <lars@metafoo.de>
Message-ID: <5134F251.1000909@metafoo.de>
Date: Mon, 04 Mar 2013 20:13:21 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/67 V2] IIO break info_mask into a pair of masks
References: <1362241044-3534-1-git-send-email-jic23@kernel.org> <513464DE.8040709@metafoo.de> <51346625.9050604@jic23.retrosnub.co.uk> <5134E351.9060704@kernel.org>
In-Reply-To: <5134E351.9060704@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/04/2013 07:09 PM, Jonathan Cameron wrote:
> On 03/04/2013 09:15 AM, Jonathan Cameron wrote:
>> On 04/03/13 09:09, Lars-Peter Clausen wrote:
>>> On 03/02/2013 05:16 PM, Jonathan Cameron wrote:
>>>> As Lars-Peter noticed, I was being an idiot and the original set would
>>>> never have worked.  Actually it turned out that they would have also
>>>> gotten the handling of shared and separate the wrong way around and there
>>>> were a few other minor issues elsewhere.
>>>>
>>>> Now a lot of people were kind enough to take a look at the original patches
>>>> and provide Acks on the mistaken assumption that the basic principle worked.
>>>> (given the cc list would have been huge many people probably never saw
>>>> anything other than the individual driver patches which in of themselves
>>>> appeared sane).
>>>> If people do not reply this time around I'll assume their acks are good
>>>> for this set and apply them.  (Of course if anyone want so re ack the
>>>> corrected patches that is great as well!).  Any tested-by's would also
>>>> be great as right now I've only actually tested with one driver.
>>>>
>>>> Well that was an 'interesting' way to start off this cycle :(
>>>
>>> Hi Jonathan,
>>>
>>> Looks good on a first glimpse. Can you push this to a branch on your repo?
>>> Makes testing things easier.
>> Away from my dev machine until this evening.  Will do so then.
> When it gets through from the backend these (and the extra couple in the other
> series) will be available in a branch of iio.git called info_mask_split
> 

Ok, except for that one glitch (which I'll assume you put in to see whether
I'd find it ;)) the series looks good.

Feel free to add my Acked-by: Lars-Peter Clausen <lars@metafoo.de> where you
think it is necessary.

And it seems as if you missed these three drivers:
	drivers/staging/iio/adc/spear_adc.c
	drivers/staging/iio/adc/mxs-lradc.c
	drivers/staging/iio/adc/lpc32xx_adc.c

- Lars
