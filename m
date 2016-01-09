Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54508 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbcAIQxY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 9 Jan 2016 11:53:24 -0500
Message-ID: <1452358275.4044.9.camel@linux.intel.com>
Subject: Re: [PATCH v4.4-rc8] iio: magnetometer: ak8975: Silence 'may be
 used uninitialized' warning
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, tim.gardner@canonical.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Date: Sat, 09 Jan 2016 08:51:15 -0800
In-Reply-To: <5691346D.2090307@kernel.org>
References: <1452298661-3636-1-git-send-email-tim.gardner@canonical.com>
	 <56912EB1.7040107@kernel.org> <1452356229.4044.4.camel@linux.intel.com>
	 <5691346D.2090307@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2016-01-09 at 16:25 +0000, Jonathan Cameron wrote:
> 
On 09/01/16 16:17, Srinivas Pandruvada wrote:
> > On Sat, 2016-01-09 at 16:00 +0000, Jonathan Cameron wrote:
> > > On 09/01/16 00:17, tim.gardner@canonical.com wrote:
> > > > From: Tim Gardner <tim.gardner@canonical.com>
> > > > 
> > > > drivers/iio/magnetometer/ak8975.c: In function 'ak8975_probe':
> > > > drivers/iio/magnetometer/ak8975.c:788:14: warning: 'chipset'
> > > > may be
> > > > used uninitialized in this function [-Wmaybe-uninitialized]
> > > >   data->def = &ak_def_array[chipset];
> > > > 
> > > > gcc version 5.3.1 20151219 (Ubuntu 5.3.1-4ubuntu1)
> > > > 
> > > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> > > Doesn't look to be an actual bug as we either end up with chipset
> > > being filled
> > > based on the traditional match table in which case it'll be
> > > assigned
> > > or based on the acpi match, which should succeed seeing as we've
> > > already
> > > had to have matched one or the other for the probe to match in
> > > the
> > > first place.
> > > 
> > > So probably worth the change to make it easier to tell that it
> > > should
> > > be fine
> > > and suppress the warning.  However, whilst we are here, I note
> > > that
> > > *match_acpi_table has a path which returns NULL as the name and
> > > doesn't assign
> > > the chipset.  We should be therefore checking if (!name) return 
> > > -ENOSYS;
> > > Though maybe another error code would be more appropriate.
> > > 
> > 
> > Since in this case we are enumerated by ACPI using our match table,
> > so
> > name can't be null. The "name" we provided in 
> > static const struct acpi_device_id ak_acpi_match[] = {..}
> > Same with the *chipset. Other than suppress warnings, I don't think
> > it
> > will cause any real issue.
> True enough, in which case why are we checking the name?

We can remove this check for !id
  id = acpi_match_device(dev->driver->acpi_match_table, dev);
- if (!id)
-	return NULL;
  *chipset = (int)id->driver_data;

Thanks,
Srinivas


> I'd be included to drop that check and add a comment.
> I haven't chased every path, but I think that might deal with the
> above
> warning at it's root.
> > Thanks,
> > Srinivas 
> > 
> > > Not sure that error path can actually happen either, but if we
> > > are
> > > going to
> > > bother having the error path out of match_acpi_table then we
> > > ought to
> > > actually
> > > handle it!
> > > 
> > > Don't suppose you'd mind fixing that one as well whilst here?
> > > 
> > > Jonathan 
> > > > ---
> > > > 
> > > > This seems like a legitimate warning, though gcc should have
> > > > complained
> > > > about an earlier use of chipset on line 782.
> > > > 
> > > >  drivers/iio/magnetometer/ak8975.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/magnetometer/ak8975.c
> > > > b/drivers/iio/magnetometer/ak8975.c
> > > > index b13936d..80ec0ce 100644
> > > > --- a/drivers/iio/magnetometer/ak8975.c
> > > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > > @@ -732,7 +732,7 @@ static int ak8975_probe(struct i2c_client
> > > > *client,
> > > >  	int eoc_gpio;
> > > >  	int err;
> > > >  	const char *name = NULL;
> > > > -	enum asahi_compass_chipset chipset;
> > > > +	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
> > > >  
> > > >  	/* Grab and set up the supplied GPIO. */
> > > >  	if (client->dev.platform_data)
> > > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux
> > -iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
