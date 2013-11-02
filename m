Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39309 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3KBWKj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Nov 2013 18:10:39 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so789725wes.15
        for <linux-iio@vger.kernel.org>; Sat, 02 Nov 2013 15:10:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net>
References: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Sat, 2 Nov 2013 23:09:58 +0100
Message-ID: <CA+TH9VkZROpEd5=OgxNXHs=4DMnb3LMtmtedX+vrYtVzb1jEhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix sign extension table in mcp3422 driver
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

You are totally right, index is 0 based and this is a bug!

Thank your for fixing!

2013/11/2 Peter Meerwald <pmeerw@pmeerw.net>:
> the index argument to sign_extend32() gives the bit position (from 0)
> to the sign bit
>
> so e.g. if the measurement has 16-bit resolution, we need to pass 15;
> a measurement of 0x8000 should be reported as -32768, not 32768
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  drivers/iio/adc/mcp3422.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 1294832..c8c1baa 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -88,10 +88,10 @@ static const int mcp3422_sample_rates[4] = {
>
>  /* sample rates to sign extension table */
>  static const int mcp3422_sign_extend[4] = {
> -       [MCP3422_SRATE_240] = 12,
> -       [MCP3422_SRATE_60] = 14,
> -       [MCP3422_SRATE_15] = 16,
> -       [MCP3422_SRATE_3] = 18 };
> +       [MCP3422_SRATE_240] = 11,
> +       [MCP3422_SRATE_60] = 13,
> +       [MCP3422_SRATE_15] = 15,
> +       [MCP3422_SRATE_3] = 17 };
>
>  /* Client data (each client gets its own) */
>  struct mcp3422 {
> --
> 1.8.4.2
>



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
