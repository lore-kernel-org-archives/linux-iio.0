Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45023 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbaBOMc2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2014 07:32:28 -0500
Message-ID: <52FF5E7E.9010701@kernel.org>
Date: Sat, 15 Feb 2014 12:33:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: Propagate the real error code on platform_get_irq()
 failure
References: <1392348515-11420-1-git-send-email-festevam@gmail.com> <201402140922.50329.marex@denx.de>
In-Reply-To: <201402140922.50329.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 08:22, Marek Vasut wrote:
> On Friday, February 14, 2014 at 04:28:35 AM, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> No need to return a 'fake' return value on platform_get_irq() failure.
>>
>> Just return the error code itself instead.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Marek Vasut <marex@denx.de>
>
Applied to the togreg branch of iio.git

Thanks,
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

