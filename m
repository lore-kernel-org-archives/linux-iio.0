Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48188 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbcDPMoC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:44:02 -0400
Subject: Re: [PATCH 2/5] staging:iio:adis16201: Set self_test_no_autoclear
 flag
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1460732382-6840-1-git-send-email-lars@metafoo.de>
 <1460732382-6840-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57123390.6030306@kernel.org>
Date: Sat, 16 Apr 2016 13:44:00 +0100
MIME-Version: 1.0
In-Reply-To: <1460732382-6840-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 15:59, Lars-Peter Clausen wrote:
> The ADIS16201 does not automatically clear the self test flag bit the self
> test has been, so clear it manually. Otherwise we'll see a offset caused by
> the self-test bias on the output values during normal operation.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/staging/iio/accel/adis16201_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 06c0b75..6f3f8ff 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -167,6 +167,7 @@ static const struct adis_data adis16201_data = {
>  	.diag_stat_reg = ADIS16201_DIAG_STAT,
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
>  	.startup_delay = ADIS16201_STARTUP_DELAY,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
> 

