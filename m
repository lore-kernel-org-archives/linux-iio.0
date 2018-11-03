Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeKCUgn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 16:36:43 -0400
Date: Sat, 3 Nov 2018 11:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <martin@martingkelly.com>
Cc: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH] iio:st_magn: enable device after trigger
Message-ID: <20181103112538.509b475c@archlinux>
In-Reply-To: <20181029031853.11747-1-martin@martingkelly.com>
References: <20181029031853.11747-1-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 20:18:53 -0700
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Currently, we enable the device before we enable the device trigger. At
> high frequencies, this can cause interrupts that don't yet have a poll
> function associated with them and are thus treated as spurious. At high
> frequencies with level interrupts, this can even cause an interrupt storm
> of repeated spurious interrupts (~100,000 on my Beagleboard with the
> LSM9DS1 magnetometer). If these repeat too much, the interrupt will get
> disabled and the device will stop functioning.
> 
> To prevent these problems, enable the device prior to enabling the device
> trigger, and disable the divec prior to disabling the trigger. This means
> there's no window of time during which the device creates interrupts but we
> have no trigger to answer them.
> 
> Fixes: 90efe055629 ("iio: st_sensors: harden interrupt handling")
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> Tested-by: Denis Ciocca <denis.ciocca@st.com>
Added Fix to the title to make that obvious.

Applied to the fixes-togreg branch of iio.git and marked for stable
inclusion.

Thanks,

Jonathan

> ---
> Note that, during testing of this change, Denis Ciocca noticed that when we fail
> to disable the IIO buffer, we bail immediately and don't disable the sensor.
> This commit does not fix that issue, but that should be fixed in a follow-up
> commit. I will leave it to Denis, since he noticed the issue, but I'd be happy
> to send a patch for it if he doesn't.
> 
>  drivers/iio/magnetometer/st_magn_buffer.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 0a9e8fadfa9d..37ab30566464 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>  	return st_sensors_set_dataready_irq(indio_dev, state);
>  }
> 
> -static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
> -{
> -	return st_sensors_set_enable(indio_dev, true);
> -}
> -
>  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int err;
> @@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_magn_buffer_postenable_error;
> 
> -	return err;
> +	return st_sensors_set_enable(indio_dev, true);
> 
>  st_magn_buffer_postenable_error:
>  	kfree(mdata->buffer_data);
> @@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  	int err;
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
> 
> -	err = iio_triggered_buffer_predisable(indio_dev);
> +	err = st_sensors_set_enable(indio_dev, false);
>  	if (err < 0)
>  		goto st_magn_buffer_predisable_error;
> 
> -	err = st_sensors_set_enable(indio_dev, false);
> +	err = iio_triggered_buffer_predisable(indio_dev);
> 
>  st_magn_buffer_predisable_error:
>  	kfree(mdata->buffer_data);
> @@ -75,7 +70,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  }
> 
>  static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
> -	.preenable = &st_magn_buffer_preenable,
>  	.postenable = &st_magn_buffer_postenable,
>  	.predisable = &st_magn_buffer_predisable,
>  };
> --
> 2.11.0
> 
