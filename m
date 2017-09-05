Return-Path: <SRS0=zJJz=AG=onstation.org=masneyb@kernel.org>
Date: Tue, 5 Sep 2017 17:02:55 -0400
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: Re: [PATCH] iio staging: tsl2x7x: clean up limit checks
Message-ID: <20170905210255.gcf2j523p3m2xldc@fd32499230b2>
References: <20170821101103.sysrgce7qgzn2ltx@mwanda>
 <20170903123505.13ee5a25@archlinux>
 <20170904021246.vdsnm5vxg7bgl6jt@fd32499230b2>
 <20170905143910.myrudtgydjbu7dci@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170905143910.myrudtgydjbu7dci@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 05, 2017 at 05:58:54PM +0300, Dan Carpenter wrote:
> On Sun, Sep 03, 2017 at 10:12:46PM -0400, Brian Masney wrote:
> > On Sun, Sep 03, 2017 at 12:35:05PM +0100, Jonathan Cameron wrote:
> > > On Mon, 21 Aug 2017 13:11:03 +0300
> > > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > 
> > > > The second part of this patch is probably the most interesting.  We
> > > > use "TSL2X7X_MAX_LUX_TABLE_SIZE * 3" as the limit instead of just
> > > > "TSL2X7X_MAX_LUX_TABLE_SIZE".  It creates a static checker warning that
> > > > we are going of of bounds, but in real life we always hit the break
> > > > statement on the last element so it's fine.
> > > > 
> > > > The situation is that we normally have arrays with 3 elements of struct
> > > > tsl2x7x_lux which has 3 unsigned integers.  If we load the table with
> > > > sysfs then we're allow to have 9 elements instead.
> > > > 
> > > > So the size of the default table in bytes is sizeof(int) times 3 struct
> > > > members times 3 elements.  The original code wrote it as sizeof(int)
> > > > times the number of elements in the bigger table (9).  It happens that
> > > > 9 is the same thing as 3 * 3 but expressing it that way is misleading.
> > > > 
> > > > For the second part of the patch, the original code just had an extra
> > > > "multiply by three" and now that is removed.  The last element in the
> > > > array is always zeroed memory whether this uses the default tables or it
> > > > gets loaded with sysfs so we always hit the break statement anyway.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > Looks sensible to me.
> > > 
> > > Cc'd Brian who has been working extensively on this driver recently as I'd
> > > like his input.
> > > 
> > > Jonathan
> > > > 
> > > > diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> > > > index ecae92211216..1beb8d2eb848 100644
> > > > --- a/drivers/staging/iio/light/tsl2x7x.h
> > > > +++ b/drivers/staging/iio/light/tsl2x7x.h
> > > > @@ -23,10 +23,6 @@
> > > >  #define __TSL2X7X_H
> > > >  #include <linux/pm.h>
> > > >  
> > > > -/* Max number of segments allowable in LUX table */
> > > > -#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
> > > > -#define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)
> > > > -
> > > >  struct iio_dev;
> > > >  
> > > >  struct tsl2x7x_lux {
> > > > @@ -35,6 +31,11 @@ struct tsl2x7x_lux {
> > > >  	unsigned int ch1;
> > > >  };
> > > >  
> > > > +/* Max number of segments allowable in LUX table */
> > > > +#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
> > > > +/* The default tables are all 3 elements */
> > > > +#define MAX_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * 3)
> > > > +
> > > >  /**
> > > >   * struct tsl2x7x_default_settings - power on defaults unless
> > > >   *                                   overridden by platform data.
> > > > diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> > > > index 786e93f16ce9..2db1715ff659 100644
> > > > --- a/drivers/staging/iio/light/tsl2x7x.c
> > > > +++ b/drivers/staging/iio/light/tsl2x7x.c
> > > > @@ -1113,7 +1113,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> > > >  	int i = 0;
> > > >  	int offset = 0;
> > > >  
> > > > -	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
> > > > +	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
> > > >  		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
> > > >  			chip->tsl2x7x_device_lux[i].ratio,
> > > >  			chip->tsl2x7x_device_lux[i].ch0,
> > 
> > There is a minor issue regarding the structure sizes in with both this
> > patch and the in-tree code. The following two structures define nine
> > rows in the lux table:
> > 
> > tsl2x7x.h:
> > #define TSL2X7X_MAX_LUX_TABLE_SIZE         9
> > 
> > struct tsl2X7X_platform_data {
> >   ...
> >   struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
> > }
> > 
> > tsl2x7x.c:
> > struct tsl2X7X_chip {
> >   ...
> >   struct tsl2x7x_lux tsl2x7x_device_lux[TSL2X7X_MAX_LUX_TABLE_SIZE];
> > }
> > 
> > tsl2x7x_defaults() has this code snippet:
> > 
> >   memcpy(chip->tsl2x7x_device_lux,
> >          (struct tsl2x7x_lux *)tsl2x7x_default_lux_table_group[chip->id],
> >                          MAX_DEFAULT_TABLE_BYTES);
> > 
> > With the old and new code, memcpy will only copy the first three rows of
> > the lux table. There is no security issue though with the actual
> > implementation since the four *_lux_table structures that are defined in
> > code only have three rows defined.
> 
> Agreed.
> 
> > 
> > I believe that the correct fix is to define MAX_DEFAULT_TABLE_BYTES in
> > Dan's patch as follows (and keeping his other changes):
> > 
> > #define MAX_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) *
> > 					TSL2X7X_MAX_LUX_TABLE_SIZE)
> > 
> > We may also want to shorten those #defines to keep it under 80
> > characters.
> > 
> 
> 
> That's not a good idea because we would be filling chip->tsl2x7x_device_lux
> with garbage from beyond the end of the tsl2x7x_default_lux_table_group[]
> element.  It would be harmless but ugly.  We could just add a:
> 
> 	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
> 
> to the start of the tsl2x7x_defaults() and the in_illuminance0_lux_table_store()
> functions.  But I don't really see a need...  This code will need to be
> restructured a bit if we start using different sized default tables,
> yes, but we can't really "future proof" this code without seeing what
> the future change is.

Agreed. Looking through this again, this improves the existing code and
can be applied. Jonathan, you can add my:

Acked-by: Brian Masney <masneyb@onstation.org>

I think we need a followup patch to improve this further before the
driver can be moved out of staging. Namely, if a new entry is added
to tsl2x7x_default_lux_table_group with more than 3 elements, then the
user will possibly see erroneous readings from the sensor. To make it
easier to review future changes, what do you think about removing the
MAX_DEFAULT_TABLE_BYTES #define and replacing it with a new array
below tsl2x7x_default_lux_table_group that has the size of each default
lux table? The new array will only be used by the memcpy() call above.
If it sounds acceptable, then I can add that to my queue. I'm going to
start working on this driver again this week after a few months of being
away from it.

Brian
