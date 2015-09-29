Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33592 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbbI2GVL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 02:21:11 -0400
Received: by lahh2 with SMTP id h2so184627783lah.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2015 23:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKzfze_LiXDPLj=jNsT-+-9iNPUDC8tQ2HC82Q+Cihb3xPxM6g@mail.gmail.com>
References: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
	<5607EF50.6020102@kernel.org>
	<CAKzfze_1ArXEoyRtChEABh7EZrWa4MP9UD-xKocJT3YMbpNJmQ@mail.gmail.com>
	<4BD54C39-DF0B-4F44-9597-A62674FAA21A@jic23.retrosnub.co.uk>
	<CAKzfze_LiXDPLj=jNsT-+-9iNPUDC8tQ2HC82Q+Cihb3xPxM6g@mail.gmail.com>
Date: Mon, 28 Sep 2015 23:21:09 -0700
Message-ID: <CAKzfze-E4sK-HWk5TeVzjeA6A3tCMsZ98vzGPk0qzOhTm5FP3A@mail.gmail.com>
Subject: Re: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Would it just be clearer to use a IIO_CONST for the offset than using
this kinda not clear IIO_CHAN_INFO_OFFSET hacking?

On Mon, Sep 28, 2015 at 9:19 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> On Mon, Sep 28, 2015 at 2:08 AM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 27 September 2015 23:35:29 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>>On Sun, Sep 27, 2015 at 6:29 AM, Jonathan Cameron <jic23@kernel.org>
>>>wrote:
>>>> On 27/09/15 07:18, Matt Ranostay wrote:
>>>>> Previous offset wasn't applied in the correct order and invalid.
>>>>> This patchset fixes this issue, and also has the correct scale value
>>>>> applied to the offset.
>>>>>
>>>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>>> Oops, missed that.
>>>>
>>>> Given it's provided in the datasheet as effectively a fractional
>>>value
>>>> would val = -40000, val2 = 65536 and type = IIO_FRACTIONAL not be
>>>cleaner
>>>> and give the same answer?
>>>>
>>>Actually not because the way the datasheet states it  ((value / 2**16)
>>>* 165) - 40,   so the scale value needs to be applied to the -40
>>>offset (165/65536)
>> Good point.  Can't we do (-40*165)/65536 ?
>
> Nope.
>
> scale = 165<<2 / 65536
> offset = 40 / scale
>
> Maybe we should add a new IIO_CHAN_INFO_SCALED_OFFSET that uses the
> scale value and a divisor that returns an IIO_FRACTIONAL?
>
>
>>>
>>>> Speaking of which, for the scale are we loosing any precision by
>>>shifting
>>>> the bottom of the fraction right 2 rather than the top left 2 which
>>>would have
>>>> the same result?
>>>
>>>Ah possibly. But I suspect isn't anything measurable...
>>>
>>>>
>>>> Jonathan
>>>>> ---
>>>>>  drivers/iio/humidity/hdc100x.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/humidity/hdc100x.c
>>>b/drivers/iio/humidity/hdc100x.c
>>>>> index 2824578..a7f61e8 100644
>>>>> --- a/drivers/iio/humidity/hdc100x.c
>>>>> +++ b/drivers/iio/humidity/hdc100x.c
>>>>> @@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev
>>>*indio_dev,
>>>>>               }
>>>>>               break;
>>>>>       case IIO_CHAN_INFO_OFFSET:
>>>>> -             *val = -40;
>>>>> -             return IIO_VAL_INT;
>>>>> +             *val = -3971;
>>>>> +             *val2 = 879096;
>>>>> +             return IIO_VAL_INT_PLUS_MICRO;
>>>>>       default:
>>>>>               return -EINVAL;
>>>>>       }
>>>>>
>>>>
>>
>> --
>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
