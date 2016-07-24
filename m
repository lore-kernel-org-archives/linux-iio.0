Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59272 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcGXNGx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 09:06:53 -0400
Subject: Re: [PATCH] iio: stx104: Store channel output state values as int
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <20160713144334.GA24521@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <88bcc7a2-0f30-6f45-c8a8-37e2777c8dff@kernel.org>
Date: Sun, 24 Jul 2016 14:06:49 +0100
MIME-Version: 1.0
In-Reply-To: <20160713144334.GA24521@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/07/16 15:43, William Breathitt Gray wrote:
> The val parameter has a data type of int in the read_raw and write_raw
> callbacks. The chan_out_states array should have elements of type int in
> order to match the data type of the val parameter.
> 
> This patch fixes a possible integer overflow condition when the the int
> pointer val is dereferenced to store the unsigned int chan_out_states
> element in the read_raw callback.
> 
> Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Isn't this only a problem if an out of range value was written
in the first place?  The values it'll take are only 16bits,
so a simple range check around that would fix the root problem.

J
> ---
>  drivers/iio/dac/stx104.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
> index 792a971..b22b744 100644
> --- a/drivers/iio/dac/stx104.c
> +++ b/drivers/iio/dac/stx104.c
> @@ -47,7 +47,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
>   * @base:		base port address of the IIO device
>   */
>  struct stx104_iio {
> -	unsigned chan_out_states[STX104_NUM_CHAN];
> +	int chan_out_states[STX104_NUM_CHAN];
>  	unsigned base;
>  };
>  
> 

