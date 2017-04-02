Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47272 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdDBIv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:51:56 -0400
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Remove unnecessary cast on void
 pointer
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401141624.GA31145@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <43c7d959-c4b6-3091-c5ad-5e712483ffc6@kernel.org>
Date: Sun, 2 Apr 2017 09:51:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170401141624.GA31145@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:16, simran singhal wrote:
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
Applied.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index e11653d..f570b48 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -364,7 +364,7 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
> -	struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
> +	struct st_lsm6dsx_hw *hw = private;
>  	struct st_lsm6dsx_sensor *sensor;
>  	int i;
>  
> @@ -388,7 +388,7 @@ static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
> -	struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
> +	struct st_lsm6dsx_hw *hw = private;
>  	int count;
>  
>  	mutex_lock(&hw->fifo_lock);
> 

