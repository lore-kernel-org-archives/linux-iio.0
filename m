Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37920 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbbKGUkw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Nov 2015 15:40:52 -0500
Date: Sat, 7 Nov 2015 23:40:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joe Perches <joe@perches.com>
Cc: Evan Hosseini <hosse005@umn.edu>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: Fix some character line limit coding style
 issues
Message-ID: <20151107204019.GQ7289@mwanda>
References: <20151107150610.GA3250@archBox.attlocal.net>
 <20151107163005.GI18797@mwanda>
 <1446919324.2701.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446919324.2701.1.camel@perches.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 07, 2015 at 10:02:04AM -0800, Joe Perches wrote:
> On Sat, 2015-11-07 at 19:30 +0300, Dan Carpenter wrote:
> > The original is easier to read, sorry.  Checkpatch is a tool not the
> > king of the world to obeyed at all times.
> 
> Completely agree.
> 
> Perhaps there could be some comment indicators added
> to tell checkpatch to ignore certain warnings like
> 80 columns.

Applying or rejecting this patch was an easy call so it doesn't cause
decision fatigue or drain my emotions.  I feel like these patches are
instructional so people learn not to trust tools.  Checkpatch.pl is fine
as-is.

regards,
dan carpenter
