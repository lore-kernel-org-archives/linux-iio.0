Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752703AbdI3UCC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:02:02 -0400
Date: Sat, 30 Sep 2017 21:01:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 4/8] iio: accel: kxcjk1013: make
 sysfs/sampling_frequency_avail dynamic
Message-ID: <20170930210158.295bb3a4@archlinux>
In-Reply-To: <081710b9deaff7273ba1c736e9a3db42dc0d1c93.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
        <081710b9deaff7273ba1c736e9a3db42dc0d1c93.1505660069.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:01:03 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> In preparation for KXTF9 support, make sampling_frequency_avail
> attribute dynamic.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 3022bc951dc2..9b4f953c5782 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -155,6 +155,9 @@ static const struct kx_odr_map samp_freq_table[] = {
>  	{ 1600, 0, 0x07, 0x06 },
>  };
>  
> +static const char *const kxcjk1013_samp_freq_avail =
> +	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
> +
>  /* Refer to section 4 of the specification */
>  static const struct {
>  	int odr_bits;
> @@ -879,13 +882,19 @@ static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
>  	return kxcjk1013_set_power_state(data, false);
>  }
>  
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> -	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600");
> +static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	return sprintf(buf, "%s\n", kxcjk1013_samp_freq_avail);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
>  
>  static struct attribute *kxcjk1013_attributes[] = {
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>  	NULL,
>  };

