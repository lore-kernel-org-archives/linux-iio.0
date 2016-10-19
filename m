Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:48709 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbcJSOMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 10:12:42 -0400
Date: Wed, 19 Oct 2016 15:57:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        jic23@kernel.org
Subject: Re: [PATCH 5/7] iio: light: tsl2583: check return values from
 taos_chip_{on, off}
Message-ID: <20161019125742.GM4469@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-5-git-send-email-masneyb@onstation.org>
 <20161019112249.GH4469@mwanda>
 <20161019124832.GB6741@basecamp.onstation.org>
 <20161019125423.GL4469@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019125423.GL4469@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 03:54:23PM +0300, Dan Carpenter wrote:
> On Wed, Oct 19, 2016 at 08:48:32AM -0400, Brian Masney wrote:
> > Ok, I'll rework my patch series to stick with the direct returns. I
> > personally prefer that approach. I was using the gotos since I thought
> > that was standard convention in the kernel.
> > 
> 
> It *should* but "goto unlock;"

s/but/be/

regards,
dan carpenter

