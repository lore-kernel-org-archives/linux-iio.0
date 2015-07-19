Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18864 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbGSUeJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 16:34:09 -0400
Date: Sun, 19 Jul 2015 23:33:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marek Vasut <marex@denx.de>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH V2 0/6] iio: mxs-lradc: Clean up and add datasheet names
Message-ID: <20150719203343.GF5371@mwanda>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
 <201507181738.21236.marex@denx.de>
 <55AB71B9.8070307@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AB71B9.8070307@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 19, 2015 at 10:45:29AM +0100, Jonathan Cameron wrote:
> Thanks for looking through these. 
> 
> Just to let you know, there is currently a rather extended discussion going
> on (as part of a suggested topic for the kernel summit) about when reviewed-by
> tags are appropriate.
> 
> The general feeling is they must in someway indicate some substantial work.  Here
> as a result I'd say it was appropriate for patch 6 whereas an Acked-by 
> would be more appropriate for the cleanups (where there is nothing 'interesting').
> I've left these as reviewed by for this set though!
> 
> Note to all reviewers I may also start added reviewed by tags that you haven't sent if
> I happen to feel you made a big contribution to review of a patch, but perhaps haven't
> revisited later versions.  I'll probably send out an email about this outside
> of this thread at some point to get possible wider circulation.
> 

I didn't necessarily read the thread that way, but the thread was
long...  I think of Acked-by by as "I approve." which is different from
I reviewed this carefully.  I seldom Ack anything since I'm not an
official maintainer of anything so no one cares if I approve or not.
Sometimes I really really approve something so I will Ack it even though
maybe no one cares.

I don't like the idea of someone adding my Reviewed-by tag because
that's a quite serious tag for me and if it has bugs then I will feel
responsible.

regards,
dan carpenter
