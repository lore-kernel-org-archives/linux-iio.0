Return-Path: <SRS0=ku43=LD=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 20 Aug 2018 11:45:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        eraretuya@gmail.com
Subject: Re: [PATCH] iio: adxl345: move null check for i2c id at start of
 probe
Message-ID: <20180820084522.zln43vvzfcw4jslz@mwanda>
References: <20180807140605.19156-1-alexandru.ardelean@analog.com>
 <20180811101833.GA5243@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180811101833.GA5243@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Aug 11, 2018 at 03:48:33PM +0530, Himanshu Jha wrote:
> On Tue, Aug 07, 2018 at 05:06:05PM +0300, Alexandru Ardelean wrote:
> > Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").
> > 
> > This was found via static checker.
> > After looking into the code a bit, it's unlikely that there will be a NULL
> > dereference if the `id` object in that specific code path.
> > However, it's safe to add a NULL (paranoid) check just to make sure and
> > remove any uncertainties.
> 
> I would like to know when would that case happen actually ?
> 
> Because probe will only be called only when a match occurs either
> through DT or id matching. Isn't it ?
> 

Btw, normally Smatch doesn't warn about inconsistent NULL checking if
it's clear that the NULL check is not required.  In this case, the
adxl345 is not in my allmodconfig so I didn't build the cross function
DB for it so I didn't have the caller information.  And also:

drivers/i2c/i2c-core-base.c
   391          /*
   392           * When there are no more users of probe(),
   393           * rename probe_new to probe.
   394           */
   395          if (driver->probe_new)
   396                  status = driver->probe_new(client);
   397          else if (driver->probe)
   398                  status = driver->probe(client,
   399                                         i2c_match_id(driver->id_table, client));
   400          else
   401                  status = -EINVAL;
   402  

Smatch isn't smart enough to know that i2c_match_id() doesn't return a
NULL.  I did look at the code before sending the bug report but it
wasn't immediately clear to me either whether it was possible or not.

regards,
dan carpenter
