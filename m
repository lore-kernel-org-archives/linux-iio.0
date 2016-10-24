Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41216 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938647AbcJXJgJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2016 05:36:09 -0400
Date: Mon, 24 Oct 2016 12:35:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Brian Masney <masneyb@onstation.org>, devel@driverdev.osuosl.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 6/7] iio: light: tsl2583: add locking to sysfs *_store()
 functions
Message-ID: <20161024093530.GV4469@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-6-git-send-email-masneyb@onstation.org>
 <20161019113345.GJ4469@mwanda>
 <20161019113731.GF4418@mwanda>
 <f6a017a4-0fd6-9706-472b-7174a6bd4769@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6a017a4-0fd6-9706-472b-7174a6bd4769@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 22, 2016 at 06:29:55PM +0100, Jonathan Cameron wrote:
> On 19/10/16 12:37, Dan Carpenter wrote:
> > I appologize for laughing, but I am still secretly amused in my heart.
> > 
> > regards,
> > dan carpenter
> > 
> Fewer beers or less caffeine for Dan!

;)

> 
> Key take away here is keep things simple.  The gotos in my mind
> would actually have made sense, but I wouldn't do the refactoring until
> you need it. i.e. when you introduce the locking in this patch.

Yeah, I totally agree do it when you need it.  I like gotos if they're
needed.

regards,
dan carpenter

