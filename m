Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BD54C39-DF0B-4F44-9597-A62674FAA21A@jic23.retrosnub.co.uk>
References: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
	<5607EF50.6020102@kernel.org>
	<CAKzfze_1ArXEoyRtChEABh7EZrWa4MP9UD-xKocJT3YMbpNJmQ@mail.gmail.com>
	<4BD54C39-DF0B-4F44-9597-A62674FAA21A@jic23.retrosnub.co.uk>
Date: Mon, 28 Sep 2015 21:19:40 -0700
Message-ID: <CAKzfze_LiXDPLj=jNsT-+-9iNPUDC8tQ2HC82Q+Cihb3xPxM6g@mail.gmail.com>
Subject: Re: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 28, 2015 at 2:08 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 27 September 2015 23:35:29 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>On Sun, Sep 27, 2015 at 6:29 AM, Jonathan Cameron <jic23@kernel.org>
>>wrote:
>>> On 27/09/15 07:18, Matt Ranostay wrote:
>>>> Previous offset wasn't applied in the correct order and invalid.
>>>> This patchset fixes this issue, and also has the correct scale value
>>>> applied to the offset.
>>>>
>>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> Oops, missed that.
>>>
>>> Given it's provided in the datasheet as effectively a fractional
>>value
>>> would val = -40000, val2 = 65536 and type = IIO_FRACTIONAL not be
>>cleaner
>>> and give the same answer?
>>>
>>Actually not because the way the datasheet states it  ((value / 2**16)
>>* 165) - 40,   so the scale value needs to be applied to the -40
>>offset (165/65536)
> Good point.  Can't we do (-40*165)/65536 ?

Nope.

scale = 165<<2 / 65536
offset = 40 / scale

Maybe we should add a new IIO_CHAN_INFO_SCALED_OFFSET that uses the
scale value and a divisor that returns an IIO_FRACTIONAL?


>>
>>> Speaking of which, for the scale are we loosing any precision by
>>shifting
>>> the bottom of the fraction right 2 rather than the top left 2 which
>>would have
>>> the same result?
>>
>>Ah possibly. But I suspect isn't anything measurable...
>>
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/iio/humidity/hdc100x.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/humidity/hdc100x.c
>>b/drivers/iio/humidity/hdc100x.c
>>>> index 2824578..a7f61e8 100644
>>>> --- a/drivers/iio/humidity/hdc100x.c
>>>> +++ b/drivers/iio/humidity/hdc100x.c
>>>> @@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev
>>*indio_dev,
>>>>               }
>>>>               break;
>>>>       case IIO_CHAN_INFO_OFFSET:
>>>> -             *val = -40;
>>>> -             return IIO_VAL_INT;
>>>> +             *val = -3971;
>>>> +             *val2 = 879096;
>>>> +             return IIO_VAL_INT_PLUS_MICRO;
>>>>       default:
>>>>               return -EINVAL;
>>>>       }
>>>>
>>>
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
