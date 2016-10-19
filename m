Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:44495 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935048AbcJSOR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 10:17:57 -0400
Date: Wed, 19 Oct 2016 15:51:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        jic23@kernel.org
Subject: Re: [PATCH 2/7] iio: light: tsl2583: change functions to only have a
 single exit point
Message-ID: <20161019125125.GK4469@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-2-git-send-email-masneyb@onstation.org>
 <20161019110859.GG4469@mwanda>
 <20161019123816.GA6741@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019123816.GA6741@basecamp.onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 08:38:16AM -0400, Brian Masney wrote:
> On Wed, Oct 19, 2016 at 02:08:59PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 19, 2016 at 06:32:05AM -0400, Brian Masney wrote:
> > > Change the following functions to only have a single exit point:
> > > taos_i2c_read(), taos_als_calibrate(), taos_chip_on(),
> > > taos_gain_store(), taos_gain_available_show(), taos_luxtable_store()
> > > and taos_probe().
> > > 
> > 
> > What's the point of this?  This style of code just makes things more
> > complicated and leads to "forgot the error code" bugs.  People think
> > that it future proofs the code in case we add locking but I have looked
> > into this and it has minimal if any impact at preventing locking bugs.
> 
> The reason that I did this was due to the locking that I added later in
> the patch series. Each function would only have a single call to
> mutex_unlock(). I should have mentioned that in my message.

This kind of trick does not work in real life.  I have looked at it.
In theory, it should work but in real life, empirically, it does not
and it introduces additional new bugs.

People are always looking for a magic bullet but there is no such thing.
The best approach is just to write the simplest, clearest code that you
can.

regards,
dan carpenter

