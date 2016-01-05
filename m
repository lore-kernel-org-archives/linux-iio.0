Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5651B37C.5030008@kernel.org>
References: <1447924517-8190-1-git-send-email-linus.walleij@linaro.org>
	<5651B37C.5030008@kernel.org>
Date: Tue, 5 Jan 2016 16:18:16 +0100
Message-ID: <CACRpkdZp9H7p11PUsvskhMa0BYXb3q5pw848Yw1MLE3P1k8WqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] iio: st_sensors: support active-low interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 22, 2015 at 1:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 19/11/15 09:15, Linus Walleij wrote:
>> Most ST MEMS Sensors that support interrupts can also handle sending
>> an active low interrupt, i.e. going from high to low on data ready
>> (or other interrupt) and thus triggering on a falling edge to the
>> interrupt controller.
>>
>> Set up logic to inspect the interrupt line we get for a sensor: if
>> it is triggering on rising edge, leave everything alone, but if it
>> triggers on falling edges, set up active low, and if unsupported
>> configurations appear: warn with errors and reconfigure the interrupt
>> to a rising edge, which all interrupt generating sensors support.
>>
>> Create a local header for st_sensors_core.h to share functions
>> between the sensor core and the trigger setup code.
>>
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Looks good to me.  Ideally I'd like ack from Denis.
> (it's early in the cycle so plenty of time for this one!)

Has this fallen off the table? I think this patch 1/2 is fine
to merge as-is, I guess it is too late for v4.5 now, but
please queue it for the next cycle.

Yours,
Linus Walleij
