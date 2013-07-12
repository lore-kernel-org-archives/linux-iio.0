Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58525 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab3GLTo4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2013 15:44:56 -0400
Message-ID: <51E05CB6.5010101@kernel.org>
Date: Fri, 12 Jul 2013 20:44:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <festevam@gmail.com>, jic23@cam.ac.uk,
	shawn.guo@linaro.org, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: Check the return value from stmp_reset_block()
References: <1373423775-11053-1-git-send-email-festevam@gmail.com> <201307101343.19408.marex@denx.de>
In-Reply-To: <201307101343.19408.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/10/2013 12:43 PM, Marek Vasut wrote:
> Dear Fabio Estevam,
> 
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> stmp_reset_block() may fail, so let's check its return value and propagate
>> it in the case of error.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> Acked-by: Marek Vasut <marex@denx.de>
Applied to the togreg branch of iio.git
Thanks,
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
