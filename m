Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeJ1Xqe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 19:46:34 -0400
Date: Sun, 28 Oct 2018 15:01:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Colombo <victorcolombo@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/2] staging: iio: ad5933: Remove unnecessary blank line
Message-ID: <20181028150138.78754acf@archlinux>
In-Reply-To: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
References: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 Oct 2018 17:41:27 -0300
Victor Colombo <victorcolombo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> WARNING: Blank lines aren't necessary before a close brace '}'
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore it (we'll be testing the other patches I
applied today rather than this one which can't really be wrong :)

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 7a216ea90784..f9bcb8310e21 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -267,7 +267,6 @@ static void ad5933_calc_out_ranges(struct ad5933_state *st)
>  
>  	for (i = 0; i < 4; i++)
>  		st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
> -
>  }
>  
>  /*
