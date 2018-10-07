Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeJGXuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 19:50:09 -0400
Date: Sun, 7 Oct 2018 17:42:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: fix 'assignment operator' style
 checks
Message-ID: <20181007174214.2ecf61ee@archlinux>
In-Reply-To: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
References: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 5 Oct 2018 22:24:26 -0300
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c by checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

Good change, but unfortunately your email client as converted
tabs into spaces so it cannot be applied.   Try git am 
with this email and you'll see what I mean.
See Documentation/process/email-clients.rst for some hints on this.

Looking forward to V2 with that fixed!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c
> b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..d4b1c2c010f2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>              "ad2s1210: write control register fail\n");
>          goto error_ret;
>      }
> -    st->resolution
> -        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +    st->resolution =
> +        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>      if (st->pdata->gpioin) {
>          data = ad2s1210_read_resolution_pin(st);
>          if (data != st->resolution)
> @@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>          dev_err(dev, "ad2s1210: setting resolution fail\n");
>          goto error_ret;
>      }
> -    st->resolution
> -        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +    st->resolution =
> +        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>      if (st->pdata->gpioin) {
>          data = ad2s1210_read_resolution_pin(st);
>          if (data != st->resolution)
