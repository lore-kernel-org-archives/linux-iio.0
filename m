Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:41356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeKZXzc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Nov 2018 18:55:32 -0500
Date: Mon, 26 Nov 2018 16:00:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
Message-ID: <20181126130032.GJ3088@unbuntlaptop>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  attr.name  are not safe if not checked. On error
> ad7280_attr_init() returns a negative return so -ENOMEM should be
> OK here (passed on as return value of the probe function).
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> unreadable in this case the  (var  == NULL)  variant was used. Not
                                   ^^
Why two spaces?

> sure if there are objections against this (checkpatch.pl issues
> a CHECK on this).
> 

You should just follow checkpatch rules here.  If you don't, someone
else will just send a patch to make it checkpatch compliant.  One thing
you could do is at the start of the loop do:

	struct iio_dev_attr *attr = &st->iio_attr[cnt];

Then it becomes:

	if (!attr->dev_attr.attr.name)

It's slightly more readable that way.  Keep in mind that we increment
cnt++ in the middle of the loop so you'll have to update attr as well.

regards,
dan carpenter
