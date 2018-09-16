Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbeIPPQM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 11:16:12 -0400
Date: Sun, 16 Sep 2018 10:53:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion
 warning
Message-ID: <20180916105351.1bf859ee@archlinux>
In-Reply-To: <20180915052511.2243-1-natechancellor@gmail.com>
References: <20180915052511.2243-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 14 Sep 2018 22:25:11 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns when an enumerated type is implicitly converted to another.
> 
> drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> enumeration type 'enum max9611_conf_ids' to different enumeration type
> 'enum max9611_csa_gain' [-Wenum-conversion]
>                         *csa_gain = gain_selectors[i];
>                                   ~ ^~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Change the type of the variable 'gain_selectors' to int so that Clang
> understands this is expected behavior.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
How does this interact with the patch that Stefan Agner sent for
the same issue last week?

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 0538ff8c4ac1..3c358b16a8fa 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>  				    u16 *adc_raw,
>  				    enum max9611_csa_gain *csa_gain)
>  {
> -	enum max9611_conf_ids gain_selectors[] = {
> +	int gain_selectors[] = {
>  		CONF_SENSE_1x,
>  		CONF_SENSE_4x,
>  		CONF_SENSE_8x
