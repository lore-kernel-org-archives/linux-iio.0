Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJKMxt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 08:53:49 -0400
Subject: Re: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
To: Matt Ranostay <mranostay@gmail.com>
References: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
 <5607EF50.6020102@kernel.org>
 <CAKzfze_1ArXEoyRtChEABh7EZrWa4MP9UD-xKocJT3YMbpNJmQ@mail.gmail.com>
 <4BD54C39-DF0B-4F44-9597-A62674FAA21A@jic23.retrosnub.co.uk>
 <CAKzfze_LiXDPLj=jNsT-+-9iNPUDC8tQ2HC82Q+Cihb3xPxM6g@mail.gmail.com>
 <560ACB52.8020800@kernel.org>
 <CAKzfze94uQuG9OeyP8yMsR=Zfe94tzBScHTvPJ8g0ppcKv60Lg@mail.gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A5BDB.6050401@kernel.org>
Date: Sun, 11 Oct 2015 13:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze94uQuG9OeyP8yMsR=Zfe94tzBScHTvPJ8g0ppcKv60Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/15 06:57, Matt Ranostay wrote:
> On Tue, Sep 29, 2015 at 10:33 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 29/09/15 05:19, Matt Ranostay wrote:
>>> On Mon, Sep 28, 2015 at 2:08 AM, Jonathan Cameron
>>> <jic23@jic23.retrosnub.co.uk> wrote:
>>>>
>>>>
>>>> On 27 September 2015 23:35:29 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>>>> On Sun, Sep 27, 2015 at 6:29 AM, Jonathan Cameron <jic23@kernel.org>
>>>>> wrote:
>>>>>> On 27/09/15 07:18, Matt Ranostay wrote:
>>>>>>> Previous offset wasn't applied in the correct order and invalid.
>>>>>>> This patchset fixes this issue, and also has the correct scale value
>>>>>>> applied to the offset.
>>>>>>>
>>>>>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>>>>> Oops, missed that.
>>>>>>
>>>>>> Given it's provided in the datasheet as effectively a fractional
>>>>> value
>>>>>> would val = -40000, val2 = 65536 and type = IIO_FRACTIONAL not be
>>>>> cleaner
>>>>>> and give the same answer?
>>>>>>
>>>>> Actually not because the way the datasheet states it  ((value / 2**16)
>>>>> * 165) - 40,   so the scale value needs to be applied to the -40
>>>>> offset (165/65536)
>>>> Good point.  Can't we do (-40*165)/65536 ?
>>>
>>> Nope.
>>>
>>> scale = 165<<2 / 65536
>>> offset = 40 / scale
>>>
>>> Maybe we should add a new IIO_CHAN_INFO_SCALED_OFFSET that uses the
>>> scale value and a divisor that returns an IIO_FRACTIONAL?
>> Hmm. Would get messy fast.
>>
>> Lets just go with your original fixed point option below.  If someone later figures
>> out a neater way of doing it, good for them ;)
> 
> Ok that works.
Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
>>
>> J
>>>
>>>
>>>>>
>>>>>> Speaking of which, for the scale are we loosing any precision by
>>>>> shifting
>>>>>> the bottom of the fraction right 2 rather than the top left 2 which
>>>>> would have
>>>>>> the same result?
>>>>>
>>>>> Ah possibly. But I suspect isn't anything measurable...
>>>>>
>>>>>>
>>>>>> Jonathan
>>>>>>> ---
>>>>>>>  drivers/iio/humidity/hdc100x.c | 5 +++--
>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/humidity/hdc100x.c
>>>>> b/drivers/iio/humidity/hdc100x.c
>>>>>>> index 2824578..a7f61e8 100644
>>>>>>> --- a/drivers/iio/humidity/hdc100x.c
>>>>>>> +++ b/drivers/iio/humidity/hdc100x.c
>>>>>>> @@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev
>>>>> *indio_dev,
>>>>>>>               }
>>>>>>>               break;
>>>>>>>       case IIO_CHAN_INFO_OFFSET:
>>>>>>> -             *val = -40;
>>>>>>> -             return IIO_VAL_INT;
>>>>>>> +             *val = -3971;
>>>>>>> +             *val2 = 879096;
>>>>>>> +             return IIO_VAL_INT_PLUS_MICRO;
>>>>>>>       default:
>>>>>>>               return -EINVAL;
>>>>>>>       }
>>>>>>>
>>>>>>
>>>>
>>>> --
>>>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

