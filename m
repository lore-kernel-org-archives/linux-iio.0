Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FAD055F.3040404@cam.ac.uk>
Date: Fri, 11 May 2012 13:26:07 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 thomas@free-electrons.com, plagnioj@jcrosoft.com,
 patrice.vilchez@atmel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <4FAB7D29.9000107@free-electrons.com> <4FAB815A.8040109@atmel.com> <201205101328.36524.arnd@arndb.de> <4FACC5B1.80601@free-electrons.com>
In-Reply-To: <4FACC5B1.80601@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/11/2012 8:54 AM, Maxime Ripard wrote:
> Hi Jonathan,
>
> Since everyone seems to have put his Acked-By (Nicolas, Arnd and you),
> are you ok to merge it in your tree ?
>
> You still had some minor comments, do you you want me to post a new
> patchset to the mailing list, or a public git branch would be enough ?
IIO is still in staging from the point of view of git trees.  Hence Greg
will actually merge the patches.  Could you send him a clean set
with all the acks etc. (cc'd on this).
>
> Thanks,
> Maxime
>
> Le 10/05/2012 15:28, Arnd Bergmann a =E9crit :
>> On Thursday 10 May 2012, Nicolas Ferre wrote:
>>> So I would really like to keep the non-DT probing. This will give the
>>> ability for users to experiment IIO/ADC with whichever kernel revisio=
n,
>>> whichever AT91 SoC they like.
>>>
>>> Arnd, we will have to agree on a way to push this work into mainline,
>>> but please consider keeping the non-DT part for this driver.
>>
>> Ok. If the non-DT part is important to you, I suggest you merge it
>> all through the IIO tree, to avoid dependency problems with the
>> platform data header file.
>>
>> Please add my Acked-by for the arch/arm patches.
>>
>> 	Arnd
>
>
