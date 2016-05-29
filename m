Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33048 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcE2O7n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 10:59:43 -0400
Subject: Re: [RFC PATCH v1 7/9] iio:st_sensors: unexport
 st_sensors_get_buffer_element
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <467cc5525789973e7dced2d12e1e57abdee8767f.1461056711.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5cb872db-a023-b161-abd3-2333d3b3cf26@kernel.org>
Date: Sun, 29 May 2016 15:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <467cc5525789973e7dced2d12e1e57abdee8767f.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/16 10:18, Gregor Boirie wrote:
> Remove st_sensors_get_buffer_element symbol export since not explicitly
> used outside of st_sensors driver.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Good spot. It applied with a little fuzz to the togreg branch of iio.git.
Lets at least cut down on how many patches we have queued up for this driver 
by taking the simple ones ;)

Applied to the togreg branch of iio.git

Thanks,

Jonathan.

> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 3 +--
>  include/linux/iio/common/st_sensors.h             | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index a7f1ced..9343d74 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -21,7 +21,7 @@
>  
>  #include <linux/iio/common/st_sensors.h>
>  
> -int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
>  	unsigned int cid;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> @@ -45,7 +45,6 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(st_sensors_get_buffer_element);
>  
>  irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  {
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index d029ffa..78a1934 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -251,8 +251,6 @@ struct st_sensor_data {
>  
>  #ifdef CONFIG_IIO_BUFFER
>  irqreturn_t st_sensors_trigger_handler(int irq, void *p);
> -
> -int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
>  #endif
>  
>  #ifdef CONFIG_IIO_TRIGGER
> 

