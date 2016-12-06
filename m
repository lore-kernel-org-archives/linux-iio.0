Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18730 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbcLFKUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 05:20:25 -0500
Date: Tue, 6 Dec 2016 13:19:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 12/19] staging: iio: isl29028: fix comparison between
 signed and unsigned integers
Message-ID: <20161206101945.GE8244@mwanda>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-13-git-send-email-masneyb@onstation.org>
 <20161205205339.GC31243@mwanda>
 <20161206001045.GA29358@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161206001045.GA29358@basecamp.onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 05, 2016 at 07:10:45PM -0500, Brian Masney wrote:
> On Mon, Dec 05, 2016 at 11:53:39PM +0300, Dan Carpenter wrote:
> > On Sat, Dec 03, 2016 at 09:19:36PM -0500, Brian Masney wrote:
> > > Fixed warning found by make W=2 to reduce the amount of build noise:
> > > 
> > > warning: comparison between signed and unsigned integer expressions
> > > [-Wsign-compare]
> > 
> > Ugh...  Please don't do work arounds for nonsense warnings.  W=2 is so
> > stupid.  Better to just grep -v this warning instead of trying to please
> > a broken static analysis.  Warnings like this are why it's disabled by
> > default.
> 
> Hi Dan,
>    I would normally agree, however there could be a case where this
> warning flags a legitimate issue. It is obviously not an issue in this
> case. Since I'm already working on cleaning up this driver to move it
> out of staging, I figured that I would make sure that it builds cleanly
> with W=2. This was the only warning found in that driver. The
> change is harmless in my opinion and it may eliminate a nonsense warning
> for someone else down the road when doing security audits.

Iterators should be int unless there is a specific reason for a fancier
data type.  Using complicated types just makes the code more complicated
and tiring to read.

Smatch or other similar static analysis tools know that "sel" is in the
0-7 range and that ARRAY_SIZE(prox_period) is 8.  GCC almost certainly
knows this as well.  The warning messages is just printed because the
devs are lazy.  It's totally pointless.

Don't work around lazy static analysis.  It sends the wrong message to
do pointless things.

regards,
dan carpenter
