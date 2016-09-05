Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57983 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbcIEUDa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 16:03:30 -0400
Subject: Re: [PATCH] iio: ensure ret is initialized to zero before entering do
 loop
To: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20160905143906.13579-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <59ac3528-2245-ea61-f7e7-847bc5fe90b9@kernel.org>
Date: Mon, 5 Sep 2016 21:03:26 +0100
MIME-Version: 1.0
In-Reply-To: <20160905143906.13579-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/16 15:39, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent fix to iio_buffer_read_first_n_outer removed ret from being set by
> a return from wait_event_interruptible and also added a continue in a loop
> which causes the variable ret to not be set when it reaches the end of the
> loop.  Fix this by initializing ret to zero.
> 
> Also remove extraneous white space at the end of the loop.
> 
> Fixes: fcf68f3c0bb2a5 ("fix sched WARNING "do not call blocking ops when !TASK_RUNNING")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Good find.  Strange that got through 0-day without a warning...

Cc'd Brian as author of the fix this is fixing.
Brian can you sanity check this patch as well.

Applied to the fixes-togreg branch of iio.git and marked for stable.
Ah well, another one for the statistics on stable patches that introduce bugs while
fixing other bugs.

Pretty unlikely this will be hit I think, but in theory you never know.

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 49bf9c5..158aaf4 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -110,7 +110,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	size_t datum_size;
>  	size_t to_wait;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!indio_dev->info)
>  		return -ENODEV;
> @@ -153,7 +153,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  		ret = rb->access->read_first_n(rb, n, buf);
>  		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>  			ret = -EAGAIN;
> -	 } while (ret == 0);
> +	} while (ret == 0);
>  	remove_wait_queue(&rb->pollq, &wait);
>  
>  	return ret;
> 

