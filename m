Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50431 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbcJDI76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2016 04:59:58 -0400
Subject: Re: [PATCH 04/18] staging:iio:accel:sca3000 Fix clearing of flag +
 setting of size of scan.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20161003192702.24361-1-jic23@kernel.org>
 <20161003192702.24361-5-jic23@kernel.org>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e6514e00-7c15-3643-83c6-79a44f98410b@metafoo.de>
Date: Tue, 4 Oct 2016 10:59:51 +0200
MIME-Version: 1.0
In-Reply-To: <20161003192702.24361-5-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/2016 09:26 PM, Jonathan Cameron wrote:
> diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
> index 36a52d02ee0e..8af7d83e658d 100644
> --- a/drivers/staging/iio/accel/sca3000.c
> +++ b/drivers/staging/iio/accel/sca3000.c
> @@ -1491,6 +1491,19 @@ error_ret:
>   **/
>  static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
>  {
> +	/*
> +	 * Set stuff to read to indicate no data present.
> +	 * Need for cases where the interrupt had fired at the
> +	 * end of a cycle, but the data was never read.
> +	 */
> +	indio_dev->buffer->stufftoread = 0;
> +	/*
> +	 * Needed to ensure the core will actually read data
> +	 * from the device rather than assuming no channels
> +	 * are enabled.
> +	 */
> +	indio_dev->buffer->bytes_per_datum = 6;
> +

Shouldn't this be dropped again when switching to kfifo for the buffer?

