Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdICL7x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 07:59:53 -0400
Date: Sun, 3 Sep 2017 12:59:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: accel: kxcjk1013: make
 sampling_frequency_avail per-type
Message-ID: <20170903125949.71dd98e6@archlinux>
In-Reply-To: <2bf4d07d81f11add906b449d76efcd04c267d1fd.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
        <2bf4d07d81f11add906b449d76efcd04c267d1fd.1503352742.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 00:03:32 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Make sampling_frequency_avail per-type - like sampling_frequency is.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Hmm. This is obviously ABI change.  However, it's pretty obscure so I very
much doubt anyone will notice.  I'd like this 'fixed' anyway so lets
go with it and deal with the fall out should there be any problems.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 11bf9afbd248..48b9a97e8a58 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -889,12 +889,13 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
>  	return sprintf(buf, "%s\n", samp_freq_avail);
>  }
>  
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
> +static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
> +		       kxcjk1013_get_samp_freq_avail, NULL, 0);
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
>  
>  static struct attribute *kxcjk1013_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_sampling_frequency_available.dev_attr.attr,
>  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>  	NULL,
>  };

