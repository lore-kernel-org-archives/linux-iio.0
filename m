Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbeE0JaH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 May 2018 05:30:07 -0400
Date: Sun, 27 May 2018 10:30:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: 104-quad-8: Fix off-by-one error in register
 selection
Message-ID: <20180527103001.6e649cbb@archlinux>
In-Reply-To: <7c1d9be4338ab822680b9ca6ce6eb24ceba32f4e.1527193661.git.vilhelm.gray@gmail.com>
References: <cover.1527193661.git.vilhelm.gray@gmail.com>
        <7c1d9be4338ab822680b9ca6ce6eb24ceba32f4e.1527193661.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 24 May 2018 16:37:46 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The reset flags operation is selected by bit 2 in the "Reset and Load
> Signals Decoders" register, not bit 1.
> 
> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hmm.  Given timing I'm not sure on the quickest route to upstream this.

Hence I'm going to take it via the togreg tree but might move it if the
merge window opens before I push that tree out other than as testing.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks

Jonathan

> ---
>  drivers/iio/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index b56985078d8c..4be85ec54af4 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -138,7 +138,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  			outb(val >> (8 * i), base_offset);
>  
>  		/* Reset Borrow, Carry, Compare, and Sign flags */
> -		outb(0x02, base_offset + 1);
> +		outb(0x04, base_offset + 1);
>  		/* Reset Error flag */
>  		outb(0x06, base_offset + 1);
>  

