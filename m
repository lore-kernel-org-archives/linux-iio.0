Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51306 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab3GBUcO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 16:32:14 -0400
Message-ID: <51D338C8.6000405@kernel.org>
Date: Tue, 02 Jul 2013 21:32:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net> <51C87806.5000700@metafoo.de> <alpine.DEB.2.01.1306241932420.13960@pmeerw.net> <51C8887D.4080406@metafoo.de> <51CEACD8.7070804@kernel.org> <alpine.DEB.2.01.1306291659180.5368@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1306291659180.5368@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2013 06:48 AM, Peter Meerwald wrote:
> Hello,
> 
>>> But the usecase might differ from board to board and that's when you get a
>>> problem. One user wants a clk driver another a IIO driver.
> 
> so because eventually someone might want a clk driver it is preferrable to 
> have no driver at all?
> 
>>>> the ds1077 is a small, separate chip which can generate a frequency; using 
>>>> IIO I can easily control that frequency from userspace
>>>>
>>>> clk seems to be targetted more at integrated clocksources that get 
>>>> activated automatically when needed by other components (maybe I am wrong)
> 
>>> I think there is a userspace consumer for the clk API in the making.
> 
> are you referring to this? https://patchwork.kernel.org/patch/2551831/
> I'm trying to figure out the status...
No idea on this I'm afraid, Lars?
> 
>> Just to jump on the end of this conversation, sorry Peter but this one definitely
>> looks to me like it belongs clk rather than IIO. If there wasn't a userspace
>> API in the making, I'd suggest now was the time to propose one as you
>> clearly have an application for one.
> 
> fine; so far no reasons were given
> does that mean iio frequency is deprecated?

DDS devices definitely don't fit in clk (though they are all still in staging atm).
Perhaps for these types of parts but as your driver has highlighted there is always
a blurred line between IIO and various other subsystems when deciding where to put
a driver.  Note the next bit is for less familiar readers! Mostly
it goes with the primary function of the driver, unless someone has a usecase that
requires functionality that makes no sense in the obvious host subsystem.

Hence ADC drivers directed at hardware monitoring usually go in the direction of hwmon,
but if there is a desire for very fast reading, then hwmon is inappropriate.
Note that for hwmon we of course have the bridge driver iio-hwmon which allows us
to provide hwmon functionality from an IIO driver.

For input historically Dmitry refused all accelerometers on the basis that at
the time these were not really being used for human input.  Later, he has decided
(with support from many including me) to take drivers for devices that were
very much input directed (3D accelerometers with features like double tap detection).
However, Dmitry has also been very much a driver of the (admittedly stalled) work
on iio-input with a view that these accelerometers in particular are used for other
purposes.

So as you see it is a bit fuzzy at best, and sometimes I find myself deliberating
for some time on whether to push a driver in another direction from IIO or not.
I agreed to the existing frequency drivers on the basis that they didn't fit well
elsewhere, but if there is now a userspace clock interface in the works, perhaps
it is time to revisit these.

> is there a fundamental difference between hardware supported in iio 
> frequency and the ds1077?

Not a clear one, no.  The ds1077 to my reading is a very simple example of a programable
clock but ultimately I 'think' the other two are similar if more complex beasts with
perhaps rather different target uses. Note that whether they should go in IIO has was
raised at merge time for them. Honestly I'm more than a little lost in the relevant datasheets. I can verify the code is
good without really have a clue what they are for ;)
http://marc.info/?l=linux-iio&m=132352819207242&w=2


Michael, do you think it is time to revisit whether these belong in IIO or could be
handled fully using the clk subsystem now?  I 'think' it might now be rather more
flexible than we last visited this.

Sorry for the slow response, I fully admit I was hoping someone else with clearer
views on this would jump in and give a clear argument one way or the other!

If there is a blured edge region where things don't fit in clk but do provide
functionality that does, then perhaps we need to do a similar job to iio-hwmon?
This might be true for some of the DDS parts which can be used as clocks, but
would be a very expensive way of doing that.

Jonathan
