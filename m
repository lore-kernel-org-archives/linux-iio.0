Return-Path: <SRS0=s6gr=DB=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87609ltts4.fsf@linux.intel.com>
References: <87ineapo5w.fsf@linux.intel.com> <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
 <87shcxw5n3.fsf@linux.intel.com> <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
 <87609ltts4.fsf@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Dec 2017 12:01:56 +0100
Message-ID: <CACRpkdbSPqnOjnmCd6-0FZznw+ojzA87Qmv9n5qxAwFHnHLUOw@mail.gmail.com>
Subject: Re: [RFC] Periodic Output, Timestamped Input
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Cc: =?UTF-8?Q?Bartosz_Go=C5=82aszewski?= <bartekgola@gmail.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 5, 2017 at 10:20 AM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
> [Me]:

>> I was thinking about it already when implementing it but it fell
>> out of my mind. I'm putting in on my TODO. (CC to bartosz
>> who might be interested, he's using these ABIs quite a bit.)
>
> fair enough. In that case, it'll probably be easier to implement
> HW-based timestamping with something like below:

Indeed.

IIO has a per-device sysfs file for setting up
the POSIX timestamping named current_timestamp_clock.
This was added by Gregor Boire in commit
bc2b7dab629a

The supported timestamps are:
realtime
monotonic
monotonic_raw
realtime_coarse
monotonic_coarse
boottime
tai

I could really need some help here... :/

It feels like "monotonic" could very well be what you're
looking for but I don't know the POSIX definition of these.
Maybe we need to add one more for "device specific"?

What I want to do is factor most of that commit out into
lib/ and reuse for timestamping in GPIO so we can
have coherent timestamps across GPIO and IIO.

OK OK O need to get to it and stop talking...

I guess it should be set per-gpiochip rather than
per-gpio-desc though, but that makes most sense anyways.

Yours,
Linus Walleij
