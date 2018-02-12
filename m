Return-Path: <SRS0=CFMa=FG=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 12 Feb 2018 17:45:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        21cnbao@gmail.com, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212144542.qievoq76rvjigwm4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <20180212131826.ebazvmp6iv7i5fav@mwanda>
 <20180212144157.GC12142@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212144157.GC12142@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 08:11:57PM +0530, Himanshu Jha wrote:
> On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:
> > I think -M is prefered for these types of diffs?  Not sure.
> 
> I wrote about that in the cover letter if you missed. :)
> 

Yeah.  I seldom read cover letters.

> > > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > > +	if (ret)
> > > +		return ret;
> > 
> > We should clean up the IRQ which we enabled in adis_init() instead of
> > returning directly.
> 
> I'm not sure about how to do that.
> 

I believe in you that you can figure it out.  :)

regards,
dan carpenter
