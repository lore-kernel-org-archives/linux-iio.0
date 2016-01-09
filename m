Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37368 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbcAIQAy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2016 11:00:54 -0500
Subject: Re: [PATCH v4.4-rc8] iio: magnetometer: ak8975: Silence 'may be used
 uninitialized' warning
To: tim.gardner@canonical.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1452298661-3636-1-git-send-email-tim.gardner@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56912EB1.7040107@kernel.org>
Date: Sat, 9 Jan 2016 16:00:49 +0000
MIME-Version: 1.0
In-Reply-To: <1452298661-3636-1-git-send-email-tim.gardner@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/16 00:17, tim.gardner@canonical.com wrote:
> From: Tim Gardner <tim.gardner@canonical.com>
> 
> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_probe':
> drivers/iio/magnetometer/ak8975.c:788:14: warning: 'chipset' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   data->def = &ak_def_array[chipset];
> 
> gcc version 5.3.1 20151219 (Ubuntu 5.3.1-4ubuntu1)
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Doesn't look to be an actual bug as we either end up with chipset being filled
based on the traditional match table in which case it'll be assigned
or based on the acpi match, which should succeed seeing as we've already
had to have matched one or the other for the probe to match in the first place.

So probably worth the change to make it easier to tell that it should be fine
and suppress the warning.  However, whilst we are here, I note that
*match_acpi_table has a path which returns NULL as the name and doesn't assign
the chipset.  We should be therefore checking if (!name) return -ENOSYS;
Though maybe another error code would be more appropriate.

Not sure that error path can actually happen either, but if we are going to
bother having the error path out of match_acpi_table then we ought to actually
handle it!

Don't suppose you'd mind fixing that one as well whilst here?

Jonathan 
> ---
> 
> This seems like a legitimate warning, though gcc should have complained
> about an earlier use of chipset on line 782.
> 
>  drivers/iio/magnetometer/ak8975.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b13936d..80ec0ce 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -732,7 +732,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	int eoc_gpio;
>  	int err;
>  	const char *name = NULL;
> -	enum asahi_compass_chipset chipset;
> +	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
>  
>  	/* Grab and set up the supplied GPIO. */
>  	if (client->dev.platform_data)
> 

