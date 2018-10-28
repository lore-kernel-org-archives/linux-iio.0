Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeJ1XpP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 19:45:15 -0400
Date: Sun, 28 Oct 2018 15:00:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Colombo <victorcolombo@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] staging: iio: ad5933: Remove unnecessary space on
 casting
Message-ID: <20181028150020.72abc2cf@archlinux>
In-Reply-To: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
References: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 Oct 2018 17:40:25 -0300
Victor Colombo <victorcolombo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> WARNING: No space is necessary after a cast
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it and see if we are missing something.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 8a920f675b83..7a216ea90784 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -210,7 +210,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>  		u8 d8[4];
>  	} dat;
>  
> -	freqreg = (u64) freq * (u64) (1 << 27);
> +	freqreg = (u64)freq * (u64)(1 << 27);
>  	do_div(freqreg, st->mclk_hz / 4);
>  
>  	switch (reg) {
