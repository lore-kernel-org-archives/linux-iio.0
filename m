Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41581 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab2FRHjI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:39:08 -0400
Message-ID: <4FDEDB19.8000807@kernel.org>
Date: Mon, 18 Jun 2012 08:39:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio staging: another typo in iio_simple_dummy_buffer
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net> <1339952599-22105-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/iio_simple_dummy_buffer.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 3e43025..fa4939c 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -78,7 +78,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>   		     i++) {
>   			j = find_next_bit(buffer->scan_mask,
>   					  indio_dev->masklength, j + 1);
> -			/* random access read form the 'device' */
> +			/* random access read from the 'device' */
>   			data[i] = fakedata[j];
>   			len += 2;
>   		}

