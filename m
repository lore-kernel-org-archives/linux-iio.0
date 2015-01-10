Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1062 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbAJLKg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 06:10:36 -0500
Message-ID: <54B108A9.7080307@metafoo.de>
Date: Sat, 10 Jan 2015 12:10:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH 1/2] iio: Add no-triggered buffer helper functions
References: <1420735227-21091-1-git-send-email-k.wrona@samsung.com> <1420735227-21091-2-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1420735227-21091-2-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/2015 05:40 PM, Karol Wrona wrote:
> These ones helps to create and manage iio_kfifo buffer when
> no-triggered buffer is used.
[...]
> +int iio_notriggered_buffer_setup(struct iio_dev *indio_dev,
> +				 const struct iio_buffer_setup_ops *setup_ops)
> +
> +{
> +	int ret;
> +	struct iio_buffer *buffer;
> +
> +	buffer = iio_kfifo_allocate();
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
> +	indio_dev->setup_ops = setup_ops;
> +
> +	ret = iio_buffer_register(indio_dev, indio_dev->channels,
> +				  indio_dev->num_channels);
> +	if (ret)
> +		iio_kfifo_free(buffer);
> +

We recently got rid of having to manually call iio_buffer_register() and 
iio_buffer_unregister(). This is now done by the IIO core. See 
http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=3e1b6c95b990c93f4aa3b17e9f66221e2fa44bee

I don't think we actually need these non-triggered helper functions anymore. 
It basically just boils down to iio_kfifo_allocate() and 
iio_device_attach_buffer().

- Lars
