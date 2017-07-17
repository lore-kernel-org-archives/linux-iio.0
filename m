Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdGQUl2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jul 2017 16:41:28 -0400
Date: Mon, 17 Jul 2017 21:41:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Always restore device to normal
 mode after suspend-resume
Message-ID: <20170717214124.05d14865@kernel.org>
In-Reply-To: <1500321055.21514.26.camel@linux.intel.com>
References: <20170713131341.7585-1-hdegoede@redhat.com>
        <20170715123942.5d9186a0@kernel.org>
        <1500321055.21514.26.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 12:50:55 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2017-07-15 at 12:39 +0100, Jonathan Cameron wrote:
> > On Thu, 13 Jul 2017 15:13:41 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> > > 
> > > After probe we would put the device in normal mode, after a runtime
> > > suspend-resume we would put it back in normal mode. But for a
> > > regular
> > > suspend-resume we would only put it back in normal mode if triggers
> > > or events have been requested.  This is not consistent and breaks
> > > reading raw values after a suspend-resume.
> > > 
> > > This commit changes the regular resume path to also unconditionally
> > > put
> > > the device back in normal mode, fixing reading of raw values not
> > > working
> > > after a regular suspend-resume cycle.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This bit of code goes back a long way.  I've taken the view
that it should be relevant as long as it applies (so back to
the i2c / spi split)   Hence I've not added a fixes tag but
just marked it for stable.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> > Looks right to me, but I'd like to send this for stable so would
> > like a second opinion, say from Srinivas as the original author.
> > Other comments obviously welcome as well!  
> > > 
> > > ---
> > >  drivers/iio/accel/bmc150-accel-core.c | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/bmc150-accel-core.c
> > > b/drivers/iio/accel/bmc150-accel-core.c
> > > index 6b5d3be283c4..807299dd45eb 100644
> > > --- a/drivers/iio/accel/bmc150-accel-core.c
> > > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > > @@ -193,7 +193,6 @@ struct bmc150_accel_data {
> > >  	struct regmap *regmap;
> > >  	int irq;
> > >  	struct bmc150_accel_interrupt
> > > interrupts[BMC150_ACCEL_INTERRUPTS];
> > > -	atomic_t active_intr;
> > >  	struct bmc150_accel_trigger
> > > triggers[BMC150_ACCEL_TRIGGERS];
> > >  	struct mutex mutex;
> > >  	u8 fifo_mode, watermark;
> > > @@ -493,11 +492,6 @@ static int bmc150_accel_set_interrupt(struct
> > > bmc150_accel_data *data, int i,
> > >  		goto out_fix_power_state;
> > >  	}
> > >  
> > > -	if (state)
> > > -		atomic_inc(&data->active_intr);
> > > -	else
> > > -		atomic_dec(&data->active_intr);
> > > -
> > >  	return 0;
> > >  
> > >  out_fix_power_state:
> > > @@ -1710,8 +1704,7 @@ static int bmc150_accel_resume(struct device
> > > *dev)
> > >  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> > >  
> > >  	mutex_lock(&data->mutex);
> > > -	if (atomic_read(&data->active_intr))
> > > -		bmc150_accel_set_mode(data,
> > > BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> > > +	bmc150_accel_set_mode(data,
> > > BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> > >  	bmc150_accel_fifo_set_mode(data);
> > >  	mutex_unlock(&data->mutex);
> > >    

