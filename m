Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57649 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbdEGW0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:26:02 -0400
Subject: Re: [PATCH 7/9] iio: hid-sensor-accel-3d: Drop unnecessary static
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jiri Kosina <jikos@kernel.org>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-8-git-send-email-Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dfd867a9-935f-62f2-f952-6e4ddd33c8e6@kernel.org>
Date: Sun, 7 May 2017 13:57:01 +0100
MIME-Version: 1.0
In-Reply-To: <1493928654-18768-8-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/17 21:10, Julia Lawall wrote:
> Drop static on a local variable, when the variable is initialized before
> use, on every possible execution path through the function.  The static has
> no benefit, and dropping it reduces the code size.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> The change in code size is indicates by the following output from the size
> command.
> 
> before:
>    text    data     bss     dec     hex filename
>    3879     512       8    4399    112f drivers/iio/accel/hid-sensor-accel-3d.o
> 
> after:
>    text    data     bss     dec     hex filename
>    3863     512       0    4375    1117 drivers/iio/accel/hid-sensor-accel-3d.o
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 43a6cb0..2238a26 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -347,7 +347,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
>  static int hid_accel_3d_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
> -	static const char *name;
> +	const char *name;
>  	struct iio_dev *indio_dev;
>  	struct accel_3d_state *accel_state;
>  	const struct iio_chan_spec *channel_spec;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

