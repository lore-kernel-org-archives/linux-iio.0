Return-Path: <lars@metafoo.de>
Message-ID: <549304F4.5070105@metafoo.de>
Date: Thu, 18 Dec 2014 17:46:44 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: kfifo: Add resource management devm_iio_kfifo_allocate/free
References: <1418153385-18212-1-git-send-email-k.wrona@samsung.com> <1418153385-18212-3-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1418153385-18212-3-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/09/2014 08:29 PM, Karol Wrona wrote:
> iio kfifo allocate/free gained their devm_ wrappers.
>
> Change-Id: I10c19ccd7c01491caf088b3629137425ddccd29c
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Looks good to me.

[...]
> +struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
> +{
> +	struct iio_buffer **ptr, *r;
> +
> +	ptr = devres_alloc(devm_iio_kfifo_release, sizeof *ptr, GFP_KERNEL);

But this should be sizeof(*ptr) to compliant with the Linux kernel coding style.

[...]
