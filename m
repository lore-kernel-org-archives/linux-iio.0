Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSW1N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 18:27:13 -0400
Date: Sun, 19 Aug 2018 20:14:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: chemical: bme680: indent #defines
 consistently
Message-ID: <20180819201439.30d318c7@archlinux>
In-Reply-To: <20180819172844.GC13175@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-4-dpfrey@gmail.com>
        <20180818110725.GD24920@himanshu-Vostro-3559>
        <20180819170215.35a6b1de@archlinux>
        <20180819172844.GC13175@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Aug 2018 22:58:44 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Aug 19, 2018 at 05:02:15PM +0100, Jonathan Cameron wrote:
> > On Sat, 18 Aug 2018 16:37:25 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > On Fri, Aug 17, 2018 at 12:03:15PM -0700, David Frey wrote:  
> > > > Signed-off-by: David Frey <dpfrey@gmail.com>    
> > > 
> > > Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > 
> > > Also, 0-day tested with build success!
> > > 
> > > Thanks
> > > 
> > >   
> > 
> > Applied,
> > 
> > There is one more suspicious bit of indenting in here
> > #define BME680_REG_CTRL_GAS_1			0x71
> > #define   BME680_RUN_GAS_MASK			BIT(4)
> > #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
> > #define     BME680_RUN_GAS_EN_BIT		BIT(4)
> > #define     BME680_NB_CONV_0_VAL		0
> > 
> > I think RUN_GAS_EN_BIT should be one level lower?  
> 
> No, its fine. It is a value and third level indent is expected.
> It should be set to 1 to initiate measurement. And
> the total mask value is
> 	0b00001000 == BME680_RUN_GAS_EN_BIT | BME680_NB_CONV_0_VAL
> 
Ah, then I'd argue it's name is wrong.  BIT elsewhere has been used
to indicate a field in the register, not a value.

Should probably just be BME680_RUN_GAS_EN?

Jonathan

> 
