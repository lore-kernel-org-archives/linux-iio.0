Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <abe57b5d-a3f0-a81b-d08a-ecf4c431ac27@kernel.org>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org> <CACRpkdY=Y56Uz90Z2SW+=eYJaH1zd8FM6Th2tgjkXVmz6fSScA@mail.gmail.com>
 <abe57b5d-a3f0-a81b-d08a-ecf4c431ac27@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Aug 2016 14:36:38 +0200
Message-ID: <CACRpkdaOes_n2yUyyiav54QZO5AN6Af=-xBsgfjp-QCOxT9Jxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Nick Vaccaro <nvaccaro@google.com>,
	Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
	Nathan Royer <nroyer@invensense.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>, Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 29, 2016 at 7:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/08/16 13:37, Linus Walleij wrote:
>> On Sun, Aug 21, 2016 at 8:32 PM, Jonathan Cameron <jic23@kernel.org> wrote:

>> The pattern (support both native hardware trigger and
>> say HRTimer) emerge in other sensors too, including the whole
>> suite of ST MEMS sensors. Not being able to also use HRTimer
>> was reported as a bug when I was working on it so it definately
>> is a widespread problem.
>>
>> I think what I would like to do to alleviate the situation is to
>> make the IIO core aware of whether the device is using its
>> own trigger or some other trigger. So in the trigger callback
>> we can do something like
>>
>> if (iio_using_own_trigger(indio_dev))
>>   ...
>> else
>>  ...
>>
>> I can try to take a stab at it and prepend this patch with that.
>> Would that be interesting?
>
> Would be interesting to see what it gains us. I suspect you
> are right in thinking this would be very useful.

I'm trying this on top of the series as a stand-alone thing.
It also affects the already in-tree ST Sensors so might
as well keep it separate, also given that it's uncertain if it'll
go anywhere.

Yours,
Linus Walleij
