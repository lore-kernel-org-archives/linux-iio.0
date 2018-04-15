Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbeDOTwL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 15:52:11 -0400
Date: Sun, 15 Apr 2018 20:52:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] staging: iio: Remove ad7746 from staging
Message-ID: <20180415205205.71c87189@archlinux>
In-Reply-To: <e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
        <20180415164351.2666a114@archlinux>
        <e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 15 Apr 2018 12:24:23 -0700
Joe Perches <joe@perches.com> wrote:

> On Sun, 2018-04-15 at 16:43 +0100, Jonathan Cameron wrote:
> > On Fri, 13 Apr 2018 13:36:51 -0300
> > Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> >   
> > > Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>  
> > 
> > Please have a single patch (with move detection turned off) for this and the
> > previous.  
> 
> > Allows easy review by showing us the code but doesn't lead to a stage in which
> > two different versions will build and hence probably break bisectiblity.  
> 
> Moving both files in a single patch is fine but
> move detection off is much harder to review.
> 
Not in this one case.   Here we want explicitly to review the code,
not the move.   The point is to put the whole driver code in front
of people as part of the proposal to move it out of staging.  If we
leave move detection on then there is a barrier to review as only
someone who has actually applied all the patches will be able to
see what state the driver is in.

Sure, side effect is we loose the check on whether it is a 'pure'
move or not, but that is easy to check when I finally apply the patches.

I haven't come up with a better way of reviewing a staging driver
on the mailing lists in a fashion similar to how we would review
a newly submitted driver.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

