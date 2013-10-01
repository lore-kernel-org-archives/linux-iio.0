Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58454 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab3JAPQn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 11:16:43 -0400
Message-ID: <524AF585.1090801@kernel.org>
Date: Tue, 01 Oct 2013 17:17:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk
CC: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 07/14] iio: st_accel: Add event subsystem to st_accel
 driver
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com> <1380299538-22047-8-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1380299538-22047-8-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/13 17:32, Lukasz Czerwinski wrote:
> This patch adds event support for iio st_accel driver.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
One bug introduced...

There is no need to have a dataready interrupt to make use of triggers
(i.e. to have a buffer). It is obviously needed to provide a trigger, but
there are plenty of others available (sysfs, soon to be high resolution timer,
general interrupt - usually gpio, and lots of driver provided ones).

Here the buffer is created whatever, but it is only freed if there is a
dataready interrupt.  Clearly that doesn't make sense.

I'm guessing this might be a merge issue rather than being deliberate!
...
> @@ -511,10 +595,10 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> +	if (adata->get_irq_data_ready(indio_dev) > 0) {
>  		st_sensors_deallocate_trigger(indio_dev);
> -
> -	st_accel_deallocate_ring(indio_dev);
> +		st_accel_deallocate_ring(indio_dev);
deallocating the ring is not dependent on the data_ready irq.
> +	}
>  }
>  EXPORT_SYMBOL(st_accel_common_remove);
>  
> 
