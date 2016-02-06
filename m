Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41951 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcBFWCE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 17:02:04 -0500
Subject: Re: [PATCH 2/2] drivers: iio: adc: xilinx-xadc-events: Fixed a coding
 style warning.
To: Rakhi Sharma <rakhish1994@gmail.com>
References: <1454788835-11707-1-git-send-email-rakhish1994@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, michal.simek@xilinx.com,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B66D5A.1010609@kernel.org>
Date: Sat, 6 Feb 2016 22:02:02 +0000
MIME-Version: 1.0
In-Reply-To: <1454788835-11707-1-git-send-email-rakhish1994@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/16 20:00, Rakhi Sharma wrote:
> Fixed a warning.
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Rakhi Sharma <rakhish1994@gmail.com>
A worthwhile aim, though sometimes such an else statement can reflect
a 'balance' in the code acting as a simple two element case statement.

However...
Please think through the results of your patches.  You've just removed
and open bracket without finding and removing the close bracket.
Also an open bracket removal means that the code indentation of the next
block is now wrong.

So, please revisit this patch, but next time make sure to at compile
test it before posting the patch - you would have had both errors
and warnings about the indenting from the result of this patch.

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index edcf3aa..61309b3 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -92,7 +92,7 @@ static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
>  {
>  	if (chan->type == IIO_TEMP) {
>  		return XADC_ALARM_OT_MASK;
> -	} else {
> +	}
>  		switch (chan->channel) {
>  		case 0:
>  			return XADC_ALARM_VCCINT_MASK;
> 

