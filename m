Return-Path: <SRS0=jnrf=A4=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH v2 3/4] platform/chrome: Add cros_ec_accel_legacy driver
To: Thierry Escande <thierry.escande@collabora.com>,
 Benson Leung <bleung@chromium.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1506529379-8941-1-git-send-email-thierry.escande@collabora.com>
 <1506529379-8941-4-git-send-email-thierry.escande@collabora.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52bc724f-a615-f334-2359-47e040cef0fb@infradead.org>
Date: Wed, 27 Sep 2017 09:30:32 -0700
MIME-Version: 1.0
In-Reply-To: <1506529379-8941-4-git-send-email-thierry.escande@collabora.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/27/17 09:22, Thierry Escande wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> new file mode 100644
> index 0000000..3fc8185
> --- /dev/null
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c

Please use proper kernel-doc notation (or don't use /** to indicate kernel-doc).

> +/**
> + * read_ec_until_not_busy - read from EC status byte until it reads not busy.
> + *
> + * @st Pointer to state information for device.
> + * @return 8-bit status if ok, -ve on error
> + */
> +static int read_ec_until_not_busy(struct cros_ec_accel_legacy_state *st)
> +{
...
> +}

> +/**
> + * read_ec_accel_data_unsafe - read acceleration data from EC shared memory.
> + *
> + * @st Pointer to state information for device.
> + * @scan_mask Bitmap of the sensor indices to scan.
> + * @data Location to store data.
> + *
> + * Note this is the unsafe function for reading the EC data. It does not
> + * guarantee that the EC will not modify the data as it is being read in.
> + */
> +static void read_ec_accel_data_unsafe(struct cros_ec_accel_legacy_state *st,
> +				      unsigned long scan_mask, s16 *data)
> +{
...
> +}
> +

> +/**
> + * read_ec_accel_data - read acceleration data from EC shared memory.
> + *
> + * @st Pointer to state information for device.
> + * @scan_mask Bitmap of the sensor indices to scan.
> + * @data Location to store data.
> + * @return 0 if ok, -ve on error
> + *
> + * Note: this is the safe function for reading the EC data. It guarantees
> + * that the data sampled was not modified by the EC while being read.
> + */
> +static int read_ec_accel_data(struct cros_ec_accel_legacy_state *st,
> +			      unsigned long scan_mask, s16 *data)
> +{
...
> +}

> +
> +/**
> + * accel_capture - the trigger handler function
> + *

This one is closer, but the function name is shortened.

> + * @irq: the interrupt number
> + * @p: private data - always a pointer to the poll func.
> + *
> + * On a trigger event occurring, if the pollfunc is attached then this
> + * handler is called as a threaded interrupt (and hence may sleep). It
> + * is responsible for grabbing data from the device and pushing it into
> + * the associated buffer.
> + */
> +static irqreturn_t cros_ec_accel_legacy_capture(int irq, void *p)
> +{


Thanks.
-- 
~Randy
