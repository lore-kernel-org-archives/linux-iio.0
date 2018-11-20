Return-Path: <SRS0=nzvy=N7=martingkelly.com=martin@kernel.org>
Subject: Re: [PATCH 1/2] iio: bmi160: snap timestamp closer to event
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: linux-iio <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
References: <20181119005347.747-1-martin@martingkelly.com>
 <CAEnQRZDYRnQc3Ja5+Jp4TCLZWShx-jC4V8MOoKnk1dA_1qV46w@mail.gmail.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <beadeda6-99b8-4b27-3cfa-5a1f6b063e0d@martingkelly.com>
Date: Mon, 19 Nov 2018 19:45:55 -0800
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDYRnQc3Ja5+Jp4TCLZWShx-jC4V8MOoKnk1dA_1qV46w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/19/18 12:45 AM, Daniel Baluta wrote:
> On Mon, Nov 19, 2018 at 2:54 AM Martin Kelly <martin@martingkelly.com> wrote:
>>
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Currently, we snap the timestamp after reading from the buffer and
>> processing the event. Technically, we can get a slightly more accurate
>> timestamp by snapping it prior to reading the data, since the data was
>> already generated prior to entering the trigger handler. This is not going
>> to make a huge difference, but we might as well improve slightly.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> 
> Makes sense to me.
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Would be nice to see some datapoints and compare the differences.
> 

I agree. I'm a bit short of time this week because of Thanksgiving, but
I'll try to do a bit of timing testing before and after the patch next week.
