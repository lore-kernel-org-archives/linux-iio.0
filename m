Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47563 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbaAKMOQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 07:14:16 -0500
Message-ID: <52D135A1.1050305@kernel.org>
Date: Sat, 11 Jan 2014 12:14:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio:magnetometer:mag3110: Fix output of decimal digits
 in show_int_plus_micros()
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net> <1389391163-9622-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/14 21:59, Peter Meerwald wrote:
> need to print leading zeros, hence "%d.%06d"
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-for-3.14new branch of iio.git

Thanks,
> ---
>   drivers/iio/magnetometer/mag3110.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index b88cb44..f66955f 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -106,7 +106,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
>
>   	while (n-- > 0)
>   		len += scnprintf(buf + len, PAGE_SIZE - len,
> -			"%d.%d ", vals[n][0], vals[n][1]);
> +			"%d.%06d ", vals[n][0], vals[n][1]);
>
>   	/* replace trailing space by newline */
>   	buf[len - 1] = '\n';
>
