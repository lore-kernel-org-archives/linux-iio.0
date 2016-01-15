Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1048 "EHLO
	smtp-out-067.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752226AbcAOUP6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 15:15:58 -0500
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
To: Bhumika Goyal <bhumirks@gmail.com>, jic23@kernel.org
References: <cover.1452878721.git.bhumirks@gmail.com>
 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
Cc: Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	pmeerw@pmeerw.net, devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56995378.1010204@metafoo.de>
Date: Fri, 15 Jan 2016 21:15:52 +0100
MIME-Version: 1.0
In-Reply-To: <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/15/2016 08:42 PM, Bhumika Goyal wrote:
> This patch adds apace around '-' operator.Found using checkpatch.pl
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index f45ebed..0c73bce 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -744,14 +744,14 @@ out:
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> +		in_voltage - voltage_thresh_low_value,

Hi,

Thanks for patch. But when sending cleanup patches like this please make
sure that you a) understand what the code does and how your change affects
it and b) as a bare minimum of testing perform a compile test, if possible
also do functional testing.

The patch as it is, is neither semantically nor syntactically correct. As an
exercise please make sure you understand why.

Same for the second patch.

- Lars
