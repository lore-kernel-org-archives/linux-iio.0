Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUnt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 16:43:49 -0400
Date: Sun, 19 Aug 2018 18:31:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de, eraretuya@gmail.com,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] iio: adxl345: move null check for i2c id at start of
 probe
Message-ID: <20180819183132.4f785935@archlinux>
In-Reply-To: <20180811101833.GA5243@himanshu-Vostro-3559>
References: <20180807140605.19156-1-alexandru.ardelean@analog.com>
        <20180811101833.GA5243@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 15:48:33 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 05:06:05PM +0300, Alexandru Ardelean wrote:
> > Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").
> > 
> > This was found via static checker.
> > After looking into the code a bit, it's unlikely that there will be a NULL
> > dereference if the `id` object in that specific code path.
> > However, it's safe to add a NULL (paranoid) check just to make sure and
> > remove any uncertainties.  
> 
> I would like to know when would that case happen actually ?
> 
> Because probe will only be called only when a match occurs either
> through DT or id matching. Isn't it ?
> 
Yes. Alternative would have just not been to check it, but this is fine
so applied. I'm not going to rush this through stable though given
I don't think it can actually happen.

Jonathan
