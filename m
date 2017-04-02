Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47269 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdDBIvX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:51:23 -0400
Subject: Re: [PATCH] iio: humidity: hts221_buffer: Remove unnecessary cast on
 void pointer
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401141415.GA29239@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f982f9c3-78a3-be61-30a2-1000f4e681d7@kernel.org>
Date: Sun, 2 Apr 2017 09:51:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170401141415.GA29239@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:14, simran singhal wrote:
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
I made a miinor change to the title to drop the _buffer.
That's naming the exact file, whereas keeping it to the driver
is fine (so just hts221).

Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hts221_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 72ddcda..7d19a3d 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -41,7 +41,7 @@ static const struct iio_trigger_ops hts221_trigger_ops = {
>  
>  static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  {
> -	struct hts221_hw *hw = (struct hts221_hw *)private;
> +	struct hts221_hw *hw = private;
>  	u8 status;
>  	int err;
>  
> 

