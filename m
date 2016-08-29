Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42051 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbcH2RKw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:10:52 -0400
Subject: Re: [PATCH v1 1/1] tools:iio:iio_generic_buffer: fix trigger-less
 mode
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <1358a1746e88f7b1bbd6173f1119f39755484ec8.1471946698.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <72dabc33-f14c-88f8-eb43-819e120e53cb@kernel.org>
Date: Mon, 29 Aug 2016 18:10:47 +0100
MIME-Version: 1.0
In-Reply-To: <1358a1746e88f7b1bbd6173f1119f39755484ec8.1471946698.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/08/16 14:28, Gregor Boirie wrote:
> Passing the trigger-less mode option on the command line causes
> iio_generic_buffer to fail searching for an IIO trigger.
> Fix this by skipping trigger initialization if trigger-less mode is
> requested.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the fixes-togreg branch of iio.git
with an appropriate fixes tag.

Thanks,

Jonathan
> ---
>  tools/iio/iio_generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index ae68bf0..f39c0e9 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -456,7 +456,7 @@ int main(int argc, char **argv)
>  
>  	if (notrigger) {
>  		printf("trigger-less mode selected\n");
> -	} if (trig_num >= 0) {
> +	} else if (trig_num >= 0) {
>  		char *trig_dev_name;
>  		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
>  		if (ret < 0) {
> 

