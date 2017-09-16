Return-Path: <SRS0=ZLf3=AR=oracle.com=dan.carpenter@kernel.org>
Date: Sat, 16 Sep 2017 14:37:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paolo Cretaro <melko@frugalware.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Brian Masney <masneyb@onstation.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        simran singhal <singhalsimran0@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: tsl2x7x: clean up limit checks
Message-ID: <20170916113759.3kp2kw2ev3f6ju27@mwanda>
References: <20170908105343.tk3j36sgxd7xm222@mwanda>
 <e9f6e0a4-ad54-1fd4-d02c-39b5c3fd128f@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9f6e0a4-ad54-1fd4-d02c-39b5c3fd128f@frugalware.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 16, 2017 at 01:11:29PM +0200, Paolo Cretaro wrote:
> Hi Dan,
> just minor nitpicking on the commit message:
> 
> On 08/09/2017 12:53, Dan Carpenter wrote:
> > The background of this code is that we can either use the default
> > tables or load our own table with sysfs.  The default tables are three
> > element arrays of struct tsl2x7x_lux.  If we load the table with sysfs
> > then we can have as many as nine elements.  Which ever way we do it, the
> > last element is always zeroed out.
> > 
> > The most interesting part of this patch is in the
> > in_illuminance0_lux_table_show() function.  We were using the wrong
> > limit, "TSL2X7X_MAX_LUX_TABLE_SIZE * 3", when it should have been just
> > "TSL2X7X_MAX_LUX_TABLE_SIZE".  This creates a static checker warning
> > that we are going of of bounds.  However, since the last element is
> out of bounds
> 
> Regards,
> P.
> 
> > always zeroed out, that means we hit the break statement and the code
> > works correctly despite the wrong limit check.

What?  No no.  I meant it how I wrote it.  The last element is
always zeroed out meaning it's just a series of zeroes.

regards,
dan carpenter
