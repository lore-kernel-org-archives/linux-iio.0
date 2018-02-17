Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeBQMQJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 07:16:09 -0500
Date: Sat, 17 Feb 2018 12:16:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, 21cnbao@gmail.com,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments
 and add suitable suffix
Message-ID: <20180217121603.1551e27b@archlinux>
In-Reply-To: <20180212145731.kws25sjinzqq6ax6@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
        <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
        <20180212125312.cjo76spuu6agjawc@mwanda>
        <20180212143522.GA12142@himanshu-Vostro-3559>
        <20180212145731.kws25sjinzqq6ax6@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Feb 2018 17:57:31 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> > But these should be done when we have *more* instances.
> > 
> > For eg: 
> > I added a tab space in function static int adis16201_read_raw() argument
> > to match open parentheses in this patch. But I also added tabs while
> > removing and adding suitable suffix to the macros. So, should it also be
> > done in a separate patch ?  
> 
> If you're changing a line of code and you fix a white space issue on
> that same line, then that's fine.  If it's just in the same function,
> then do it in a separate patch.  In other words, adding tabs when you're
> moving around macros is fine, but adding it to the arguments is
> unrelated.
> 
> This patch was honestly pretty tricky to review.
> 
> Jonathan assumes reviewers have the datasheet in front of them and I
> assume that that they don't.  He's probably right...  But especially
> comments like this:

Actually I don't.  I like the code to be very clear without the datasheet.

That is one of the reasons I always advocate making it very clear what
is a register and what is a field. The _REG postfix is useful to my mind
for that reason.

What I really don't like is needing comments to tell you what a register
is for when the name of the define should make it clear.  Obviously
there are sometimes places you can't do this because the meaning cannot
be explained in a short enough name but they are fairly rare.

I agree it is a trade off on whether the naming is sufficiently clear
or not and your example of the power supply one is a classic.
That register has a stupid name on the datasheet given how easy
it would have been to make it clear in the name choice that it was
measuring the power supply.

The naming things _OUT on this datasheet is particularly nasty as
it adds nothing other than confusion.  However, the question arises
on whether it makes sense to get rid of that in the driver and
make it harder to read with the datasheet.


> 
> 		*val2 = 220000; /* 1.22 mV */
> 
> They seem really helpful to me.
This isn't about the data sheet, it is about knowledge of IIO.

That one is perhaps debatable as the base units for voltage are
less than ideal (I really wish I had been a stickler for SI units
throughout from the first - this came about through trying to maintain
compatibility with hwmon which with hind sight was a bad idea).

> 
> regards,
> dan carpenter
> 

