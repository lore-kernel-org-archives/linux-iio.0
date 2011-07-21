Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E283295.6060606@analog.com>
Date: Thu, 21 Jul 2011 16:07:17 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: adt7310 uses two event lines.
References: <4E2808B8.90105@cam.ac.uk>
In-Reply-To: <4E2808B8.90105@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/21/2011 01:08 PM, Jonathan Cameron wrote:
> Michael,
>
> Right now there are bugs galore in the multiple event line code.
> I'm intending to rip it out for now so as to keep things simple.
> We can merge it back in when we have a use case.
>
> The only multiple line user I know of is the adt7310.  Now there
> are all sorts of other issues with this driver anyway and it
> probably shouldn't be in IIO at all (just a temperature sensor).
>
> In the meantime I propose just deleting the second interrupt line.
>
> Is that alright with you?
>
> Jonathan
>
Hi Jonathan,

In theory both interrupt lines could be wired together.
They both end up on the same handler anyways.
So feel free to remove one.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
