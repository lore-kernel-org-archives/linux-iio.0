Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43502 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab3BIKqi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 05:46:38 -0500
Message-ID: <5116290A.7050505@kernel.org>
Date: Sat, 09 Feb 2013 10:46:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] iio:common: added allocate and deallocate trigger functions
 when trigger is disabled.
References: <1360230363-15553-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1360230363-15553-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/2013 09:46 AM, Denis CIOCCA wrote:
> This patch resolve a bugfix when driver is compiled without trigger.
Please remember to sign off on these. Also this is all part of what Randy
found, so he gets a reported by as well to thank him for pointing it out.

Anyhow added this one to the togreg branch of iio.git.
We also need the two patches I'll send out in a minute to fully deal with
the compile issues here.


Jonathan
> ---
>  include/linux/iio/common/st_sensors.h |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index c40fdf5..1f86a97 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -235,6 +235,16 @@ void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
>  irqreturn_t st_sensors_trigger_handler(int irq, void *p);
>  
>  int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
> +#else
> +static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> +				const struct iio_trigger_ops *trigger_ops)
> +{
> +	return 0;
> +}
> +static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
> +{
> +	return;
> +}
>  #endif
>  
>  int st_sensors_init_sensor(struct iio_dev *indio_dev);
> 
