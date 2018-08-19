Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeHSTRd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:17:33 -0400
Date: Sun, 19 Aug 2018 17:05:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: chemical: bme680: change MSK->MASK in
 #defines
Message-ID: <20180819170534.6b05817f@archlinux>
In-Reply-To: <20180818110918.GE24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-5-dpfrey@gmail.com>
        <20180818110918.GE24920@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 16:39:18 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 17, 2018 at 12:03:16PM -0700, David Frey wrote:
> > Convert all defines to use "MASK" instead of a mix of "MSK" and "MASK"
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
> 
> > -	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> > +	                (tmp_lsb & BME680_BIT_H1_DATA_MASK);  
> 
> Its here again so, perhaps better to send a new version instead.
> 
Applied and fixed up.  Thanks,

Jonathan
