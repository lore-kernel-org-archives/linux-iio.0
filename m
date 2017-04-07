Return-Path: <SRS0=+kNr=3P=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFSKS=O-CrzxA6RJxrMNR=Vz-dN+zn1B95d+fUbUGcghRQgAjA@mail.gmail.com>
References: <CAFSKS=O-CrzxA6RJxrMNR=Vz-dN+zn1B95d+fUbUGcghRQgAjA@mail.gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 6 Apr 2017 23:21:52 -0700
Message-ID: <CAJCx=gmDBbSnNjJgqxhaZJ=LSmENf6_C1DXvazbuHvZDj16XwA@mail.gmail.com>
Subject: Re: Digital I/O in IIO
To: George McCollister <george.mccollister@gmail.com>
Cc: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 6, 2017 at 7:24 AM, George McCollister
<george.mccollister@gmail.com> wrote:
> In many industrial applications it's common to mix digital (binary)
> and analog I/O. In many cases digital input modules have change
> buffers and sometimes event time stamping capabilities. While the gpio
> subsystem can support software timestamping and buffering it doesn't
> fit well for many industrial digital applications where the host
> process reads buffered digital samples or events from input modules.
>
> Would anyone appose or support the addition of digital channel type or
> suggest an alternative path to supporting this use case?
>
> A possible alternative is to use 1 bit for storage and use voltage for
> type. For instance a 16 channel 24V DC Input module would present 16
> input voltage channels with 1 bit of storage each. 0 would correspond
> to 0VDC and 1 to 24VDC.

I don't think IIO_VOLTAGE should be used for this since it is against
the ABI definition.
At the worse it should be reported as 0V and 24V, but I think using
the events is a better solution.

IIO_EV_DIR_RISING  -> 24V
IIO_EV_DIR_FALLING -> 0V


>
> Cheers,
> George McCollister
> Software Architect
> NovaTech LLC
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
