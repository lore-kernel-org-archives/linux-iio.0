Return-Path: <SRS0=ayLd=AQ=onstation.org=masneyb@kernel.org>
Date: Fri, 15 Sep 2017 19:30:38 -0400
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	simran singhal <singhalsimran0@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Paolo Cretaro <melko@frugalware.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: Re: [PATCH v2] staging: iio: tsl2x7x: clean up limit checks
Message-ID: <20170915233038.la3kykos34vuktgv@22e320782916>
References: <20170905233123.vfrb4j4bnhtgcrrt@fd32499230b2>
 <20170908105343.tk3j36sgxd7xm222@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908105343.tk3j36sgxd7xm222@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 08, 2017 at 01:53:43PM +0300, Dan Carpenter wrote:
> The background of this code is that we can either use the default
> tables or load our own table with sysfs.  The default tables are three
> element arrays of struct tsl2x7x_lux.  If we load the table with sysfs
> then we can have as many as nine elements.  Which ever way we do it, the
> last element is always zeroed out.
> 
> The most interesting part of this patch is in the
> in_illuminance0_lux_table_show() function.  We were using the wrong
> limit, "TSL2X7X_MAX_LUX_TABLE_SIZE * 3", when it should have been just
> "TSL2X7X_MAX_LUX_TABLE_SIZE".  This creates a static checker warning
> that we are going of of bounds.  However, since the last element is
> always zeroed out, that means we hit the break statement and the code
> works correctly despite the wrong limit check.
> 
> I made several related readability changes.  The most notable that I
> changed the MAX_DEFAULT_TABLE_BYTES define which was:
> 
> #define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)
> 
> I renamed the define to TSL2X7X_DEFAULT_TABLE_BYTES because it's not the
> max size, it's the only size.  Also the size should really be expressed
> as sizeof(struct tsl2x7x_lux) * 3.  In other words, 12 * 3 instead of
> 4 * 9.  It's 36 bytes either way, so this doesn't change the behavior.
> 
> Finally, I created the TSL2X7X_DEF_LUX_TABLE_SZ define instead of using
> the magic number 3.  I declared the default tables using that define
> to hopefully signal to future programmers that if they want to use a
> different size they have to update all the related code.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Brian Masney <masneyb@onstation.org>

Brian
