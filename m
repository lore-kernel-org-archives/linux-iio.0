Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39851 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab3HCUVy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 16:21:54 -0400
Message-ID: <51FD7479.6000402@kernel.org>
Date: Sat, 03 Aug 2013 22:22:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH] iio: Fix documentation of devm_iio_device_free()
References: <1375133710-19453-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375133710-19453-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/29/13 22:35, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Indeed, this is downright confusing ;)

Applied to the togreg branch of iio.git

Thanks.
> ---
>  include/linux/iio/iio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f1d99f6..7ae54a5 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -552,9 +552,9 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
>   * @dev:		Device this iio_dev belongs to
>   * @indio_dev: 		the iio_dev associated with the device
>   *
> - * Free indio_dev allocated with devm_iio_device_alloc().
> + * Free iio_dev allocated with devm_iio_device_alloc().
>   */
> -void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev);
> +void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
>  
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> 
