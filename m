Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47926 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdLJPD5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Dec 2017 10:03:57 -0500
Date: Sun, 10 Dec 2017 15:03:51 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        <k.wrona@samsung.com>
Subject: Re: [PATCH] iio: common: ssp_sensors: use ktime_get_real_ns()
 timestamps
Message-ID: <20171210150351.2fc74af7@archlinux>
In-Reply-To: <20171202114949.2d9bf320@archlinux>
References: <20171127115158.2884398-1-arnd@arndb.de>
        <20171202114949.2d9bf320@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2 Dec 2017 11:49:49 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 27 Nov 2017 12:51:48 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > getnstimeofday() suffers from the overflow in y2038 on 32-bit
> > architectures and requires a conversion into the nanosecond format that
> > we want here.
> > 
> > This changes ssp_parse_dataframe() to use ktime_get_real_ns() directly,
> > which does not have that problem.
> > 
> > An open question is what time base should be used here. Normally
> > timestamps should use ktime_get_ns() or ktime_get_boot_ns() to read
> > monotonic time instead of "real" time, which suffers from time jumps
> > due to settimeofday() calls or leap seconds.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> +cc Karol Wrona.
> 
> Fix looks fine to me, but might be nice to address that and the
> question of using a monotonic clock all in one go.
> 
> This is probably a copy of an ancient piece of my stupidity
> where I used the wrong clock for the core IIO timestamping
> code.  We fixed that a while back by letting the user
> chose the clock.  If you are running slow enough you actually
> do want the 'real' time - probably never the case here though.
> 
> If we don't hear from Karol for a few weeks I'll pick this
> up and we can address the wrong timestamp sometime in the
> future!
> 
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> Jonathan
> 
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_spi.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> > index 704284a475ae..2ab106bb3e03 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> > @@ -277,12 +277,9 @@ static int ssp_handle_big_data(struct ssp_data *data, char *dataframe, int *idx)
> >  static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
> >  {
> >  	int idx, sd;
> > -	struct timespec ts;
> >  	struct ssp_sensor_data *spd;
> >  	struct iio_dev **indio_devs = data->sensor_devs;
> >  
> > -	getnstimeofday(&ts);
> > -
> >  	for (idx = 0; idx < len;) {
> >  		switch (dataframe[idx++]) {
> >  		case SSP_MSG2AP_INST_BYPASS_DATA:
> > @@ -329,7 +326,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
> >  	}
> >  
> >  	if (data->time_syncing)
> > -		data->timestamp = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> > +		data->timestamp = ktime_get_real_ns();
> >  
> >  	return 0;
> >  }  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

