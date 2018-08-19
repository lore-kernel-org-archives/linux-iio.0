Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbeHSS7C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 14:59:02 -0400
Date: Sun, 19 Aug 2018 16:47:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: chemical: bme680: use clamp macro
Message-ID: <20180819164706.4eab1634@archlinux>
In-Reply-To: <20180818110323.GB24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-2-dpfrey@gmail.com>
        <20180818110323.GB24920@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 16:33:23 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 17, 2018 at 12:03:13PM -0700, David Frey wrote:
> > Signed-off-by: David Frey <dpfrey@gmail.com>  
> 
> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Also, 0-day tested with build success!
> 
> Thanks
