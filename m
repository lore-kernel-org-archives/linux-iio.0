Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47277 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdDBIww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:52:52 -0400
Subject: Re: [PATCH] iio: pressure: zpa2326: Remove unnecessary cast on void
 pointer
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401141838.GA748@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5ccc24ab-ae55-1442-0afe-68292254e0ec@kernel.org>
Date: Sun, 2 Apr 2017 09:52:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170401141838.GA748@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:18, simran singhal wrote:
> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> - (T*)
>   e
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied and pushed out as testing as normal.

Thanks for these. Good to clean them up. It's one of my pet
hates, but still the sometimes get through ;)

Jonathan
> ---
>  drivers/iio/pressure/zpa2326.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index c720c3a..e58a0ad 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -751,7 +751,7 @@ static void zpa2326_suspend(struct iio_dev *indio_dev)
>   */
>  static irqreturn_t zpa2326_handle_irq(int irq, void *data)
>  {
> -	struct iio_dev *indio_dev = (struct iio_dev *)data;
> +	struct iio_dev *indio_dev = data;
>  
>  	if (iio_buffer_enabled(indio_dev)) {
>  		/* Timestamping needed for buffered sampling only. */
> @@ -790,7 +790,7 @@ static irqreturn_t zpa2326_handle_irq(int irq, void *data)
>   */
>  static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
>  {
> -	struct iio_dev         *indio_dev = (struct iio_dev *)data;
> +	struct iio_dev         *indio_dev = data;
>  	struct zpa2326_private *priv = iio_priv(indio_dev);
>  	unsigned int            val;
>  	bool                    cont;
> 

