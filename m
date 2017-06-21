Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdFUTPT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:15:19 -0400
Date: Wed, 21 Jun 2017 20:15:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mxs-lradc: Checking IS_ERR() instead of NULL
Message-ID: <20170621201512.5808cc8a@kernel.org>
In-Reply-To: <20170613083905.7aiaxvfjg2ypkfq2@mwanda>
References: <20170426210349.sjmf65ck5awfgz22@mwanda>
        <13f3bcd0-c6c8-7abc-d732-91a19618f5a5@kernel.org>
        <20170613083905.7aiaxvfjg2ypkfq2@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 11:39:05 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Apr 27, 2017 at 07:21:09AM +0100, Jonathan Cameron wrote:
> > On 26/04/17 22:03, Dan Carpenter wrote:  
> > > devm_ioremap() returns NULL on error.  It doesn't return error pointers.
> > > 
> > > Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >   
> > Hi Dan,
> > 
> > Already another patch for this under review.  Open question there is whether
> > devm_ioremap_resource is the way to go instead.
> >   
> 
> I wasn't on that other thread...  Nothing appears to have happened with
> this or the touchscreen bug either.
> 
> regards,
> dan carpenter
I think I was just being a bit lax in actually pushing it out and sending
Greg a pull request. 

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=1454e15bc28ba94aa5d6b31a83a42d5c03af2a6d

Thanks for following up on this.

Jonathan
> 
> 

