Return-Path: <cwolfe@google.com>
Sender: Chris Wolfe <cwolfe@google.com>
Message-ID: <4DFB8498.5000701@chromium.org>
Date: Fri, 17 Jun 2011 12:45:12 -0400
From: Chris Wolfe <cwolfe@chromium.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Chris Hudson <chudson@kionix.com>
Subject: Re: [RFC][PATCH] staging:iio:kxtf9 accelerometer minimal support
References: <1308320579-12922-1-git-send-email-cwolfe@chromium.org> <4DFB74F3.2060702@cam.ac.uk>
In-Reply-To: <4DFB74F3.2060702@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/17/11 11:38, Jonathan Cameron wrote:
> Hi Chris, looks like you've made a good start.
>
> Couple of general questions first. I've cc'd Chris as his kxtj9 driver
> is working it's way through review at the moment (over on linux-input@vger.kernel.org).
> I've no idea if these parts are even vaguely similar! I do note
> at least some registers are in the same place...
>
> See http://www.spinics.net/lists/linux-input/msg15413.html
>
> There may be some differences, but not clear if there are enough for a completely
> separate driver...

Thanks, had not noticed the KXTJ9 driver appearing. Will definitely 
coordinate with chudson, as I don't yet know how the two models relate.

> First question here is why IIO?

Well, partially because I found a directory full of accelerometers :)

The big reason this became an IIO driver is because the KXTF9 also 
reports a fair variety of events, including taps, double-taps and 
changes in orientation ("which side is up"). My impression (which may 
well be wrong) is that enabling, configuring and reporting those through 
IIO is easier than stuffing them into input.

My experimental version of this driver uses a trigger on the interrupt, 
with separate poll functions to drive the software ring buffer and 
events. That works well, but needs cleanup and updating (like the 
IIO_EVENT_SH got a no-op callback).

> As a general principal, if it's primarily for human input, then it wants
> to go into input.  If you are using it for something more 'interesting'
> and need for example software buffering then IIO may be the correct location.

I think the software ring buffer and event functionality is useful 
enough to merit staying in IIO. Am well aware this version of the driver 
doesn't use them yet, and there may be good alternatives in input that I 
just missed.

> In theory at least, mlock was intended for the major state changes for a device
> (typically firing up triggered buffer filling).  For protecting registers, a more
> fine grained local lock is probably a good idea.
 >
> The priv bit will be important as I have a set patch set under review that kills
> off the alternative (dev_data pointer).

Got my testing kernel working with an updated IIO, so am switching over 
to the new functions and applying your comments from below.

Incidentally, one of the things I liked about the IIO show was that 
scale functions could report infinite-precision constant strings. That 
seems to have gotten lost in the read_raw change, though I have yet to 
go digging for related discussion in the archives.

Thanks,
Chris
