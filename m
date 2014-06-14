Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42979 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591AbaFNN7r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 09:59:47 -0400
Message-ID: <539C55C5.7080001@kernel.org>
Date: Sat, 14 Jun 2014 15:01:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>,
	Robert Hodaszi <robert.hodaszi@digi.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, alexandre.belloni@free-electrons.com,
	jbe@pengutronix.de, hector.palacios@digi.com,
	fabio.estevam@freescale.com, lars@metafoo.de
Subject: Re: [PATCH 1/2] iio: mxs-lradc: fix divider
References: <1402407695-2984-1-git-send-email-robert.hodaszi@digi.com> <1402407695-2984-2-git-send-email-robert.hodaszi@digi.com> <201406110047.59372.marex@denx.de>
In-Reply-To: <201406110047.59372.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/14 23:47, Marek Vasut wrote:
> On Tuesday, June 10, 2014 at 03:41:34 PM, Robert Hodaszi wrote:
>> All channels' single measurement are happening on CH 0. So enabling /
>> disabling the divider once is not enough, because it has impact on all
>> channels.
>>
>> Set only a flag, then check this on each measurement, and enable / disable
>> the divider as required.
>>
>> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
>
> Acked-by: Marek Vasut <marex@denx.de>
Applied to the fixes-togreg branch of iio.git
Also marked for stable.
>
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

