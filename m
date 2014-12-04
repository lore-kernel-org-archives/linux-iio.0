Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Richard Weinberger <richard@nod.at>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
    pmeerw@pmeerw.net, sanjeev_sharma@mentor.com,
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: dht11 Updates
In-reply-to: <547F7092.8080001@nod.at>
References: <1417563176-31972-1-git-send-email-richard@nod.at> <E1Xw8sp-0001B6-Ul@stardust.g4.wien.funkfeuer.at> <547F7092.8080001@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 04 Dec 2014 17:08:02 +0100
Message-Id: <E1XwYwk-00019x-LZ@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-iio@vger.kernel.org>

Richard Weinberger writes:
> Harald,
> 
> Am 03.12.2014 um 13:18 schrieb Harald Geyer:
> > Hi Richard,
> > 
> > thanks for all the work you put into this!
> > 
> > Richard Weinberger writes:
> >> Please see my current patches for your driver.
> >> As discussed in an earlier mail I'm testing with the DHT22 sensor only.
> >> With the IRQ changes I see 84 edges.
> > 
> > This still surprises me. With the IRQ changes I would expect the
> > preamble to be 2 edges only. I must be missing something. Can you
> > explain this to me?
> 
> Did some more tests.
> With my IRQ changes applied I get as stated 84 edges,
> without I get 85. So we're only losing one edge.

Ok, finally had time to look into this and it's a simple off-by-one
issue (no bug) that confused me:
Without your patch the full number of edges per data transmission
is 86. But since the last edge is not significant, we only store
85 edges. - There should be a comment about this in the source...

With your patch the preamble is shortened by two edges as expected,
but since there is a workaround for sensors where the preamble wasn't
properly recorded, nobody notices unless they are looking closely at
the number of edges recorded. The next thing to do is check on DHT11
if the workaround is still needed.

Note that the old behaviour was nice for debugging wiring problems:
With my standard setup (3.3V, pin drive strenght 4 mA) I got the
following:
supply not connected: 0 edges (sensor always pulls the data line low)
data not connected: 2 edges (we only see the signal we generate ourselves)
gnd not connected: random amount of edges

With the new behaviour we will get 0 edges in both of the first two
cases. So we are really losing a tiny bit of functionality... :-(

HTH,
Harald
