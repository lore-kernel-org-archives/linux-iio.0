Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37677 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcAIQzh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2016 11:55:37 -0500
Subject: Re: [PATCH 1/2 v3] iio: st_sensors: support active-low interrupts
To: Linus Walleij <linus.walleij@linaro.org>
References: <1447924517-8190-1-git-send-email-linus.walleij@linaro.org>
 <5651B37C.5030008@kernel.org>
 <CACRpkdZp9H7p11PUsvskhMa0BYXb3q5pw848Yw1MLE3P1k8WqQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56913B86.5040700@kernel.org>
Date: Sat, 9 Jan 2016 16:55:34 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdZp9H7p11PUsvskhMa0BYXb3q5pw848Yw1MLE3P1k8WqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/16 15:18, Linus Walleij wrote:
> On Sun, Nov 22, 2015 at 1:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 19/11/15 09:15, Linus Walleij wrote:
>>> Most ST MEMS Sensors that support interrupts can also handle sending
>>> an active low interrupt, i.e. going from high to low on data ready
>>> (or other interrupt) and thus triggering on a falling edge to the
>>> interrupt controller.
>>>
>>> Set up logic to inspect the interrupt line we get for a sensor: if
>>> it is triggering on rising edge, leave everything alone, but if it
>>> triggers on falling edges, set up active low, and if unsupported
>>> configurations appear: warn with errors and reconfigure the interrupt
>>> to a rising edge, which all interrupt generating sensors support.
>>>
>>> Create a local header for st_sensors_core.h to share functions
>>> between the sensor core and the trigger setup code.
>>>
>>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>>> Cc: Denis Ciocca <denis.ciocca@st.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Looks good to me.  Ideally I'd like ack from Denis.
>> (it's early in the cycle so plenty of time for this one!)
> 
> Has this fallen off the table?
oops. Yes it has indeed.  I still had it marked as outstanding
but it had drifted too many pages up in my patch list to get
noticed.  Good thing you are keeping track!
> I think this patch 1/2 is fine
> to merge as-is, I guess it is too late for v4.5 now, but
> please queue it for the next cycle.
It was a little interesting to apply so could you take
a look at my testing branch and check I didn't mess it up.
Needed a fair bit of hand resolution though I think it was
all just fuzz really.

Applied to the togreg branch of iio.git - initially pushed out
as testing.

Jonathan
> 
> Yours,
> Linus Walleij
> 

