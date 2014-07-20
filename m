Return-Path: <lars@metafoo.de>
Message-ID: <53CBA830.3020306@metafoo.de>
Date: Sun, 20 Jul 2014 13:29:52 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: accel: kxcjk-1013: Increment ref counter for
 indio_dev->trig
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/17/2014 02:42 AM, Srinivas Pandruvada wrote:
> Assigning indio_dev->trig is not a good idea, as this can result in
> wrong reference count for trigger device. If assigned, it is better to
> increment reference counter by calling iio_trigger_get.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index f5bb682..40ecf8b 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1020,6 +1020,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>   		iio_trigger_set_drvdata(trig, indio_dev);
>   		data->trig = trig;
>   		indio_dev->trig = trig;
> +		iio_trigger_get(indio_dev->trig);

Hm, we should change the signature of iio_trigger_get() to return the 
trigger, this gets it more in sync with other ..._get() APIs in the kernel. 
Then the above two lines become indio_dev->trig = iio_trigger_get(trig).

- Lars
