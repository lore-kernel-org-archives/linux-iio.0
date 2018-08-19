Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeHSTTZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:19:25 -0400
Date: Sun, 19 Aug 2018 17:07:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: chemical: bme680: use GENMASK macro
Message-ID: <20180819170726.7c4a43d5@archlinux>
In-Reply-To: <20180818110951.GF24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-6-dpfrey@gmail.com>
        <20180818110951.GF24920@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 16:39:51 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 17, 2018 at 12:03:17PM -0700, David Frey wrote:
> > Replace hardcoded bit masks with GENMASK macro
> > 
> > Signed-off-by: David Frey <dpfrey@gmail.com>  
> 
> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> Also, 0-day tested with build success!
> 
> Thanks
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
