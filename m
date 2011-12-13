Return-Path: <jic23@cam.ac.uk>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de> <20111213004659.GB11553@kroah.com>
In-Reply-To: <20111213004659.GB11553@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when allocating the buffer
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 13 Dec 2011 07:23:48 +0000
To: Greg KH <greg@kroah.com>,Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@suse.de>,Jonathan Cameron <jic23@kernel.org>,devel@driverdev.osuosl.org,linux-iio@vger.kernel.org
Message-ID: <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Greg KH <greg@kroah.com> wrote:

>On Mon, Dec 12, 2011 at 11:09:05AM +010=
0, Lars-Peter Clausen wrote:
>> Setup the buffer access functions in the bu=
ffer allocate function.
>There is no
>> need to let each driver handle this=
 on its own.
>
>That's nicer.
>
>So, you have different ways to have "buffe=
rs" and the driver doesn't
>know what type you have, and it's chosen at bui=
ld time?  Why are you
>making the kernel builder make such a decision?  Why=
 not just pick one,
>that you know works well, and use it?
>
>You would get=
 rid of a whole level of indirection that I really don't
>think you need at=
 all, right?

Because there is not currently a buffer that suits all use ca=
ses.
One might be possible but would involve autoswitching between differen=
t approaches a hence have this indirection anyway, be it burried. Also note=
 that some of the buffers are hardware.  Plus the pseudo buffer used for in=
 kernel push interfaces is different again. That code has only reached RFC =
state so far.

>Make a decision, don't force someone else to make it for yo=
u...
Defaults are sensible. Preventing other peoples use cases are not.  
>=

>greg k-h

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my=
 brevity.
