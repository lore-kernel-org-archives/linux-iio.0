Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41123 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbJKMv4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 08:51:56 -0400
Subject: Re: [PATCH v2] iio: mxs-lradc: Fix temperature offset
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1444216254-19668-1-git-send-email-alexandre.belloni@free-electrons.com>
 <56153538.5060706@i2se.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>,
	Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A5B68.8070200@kernel.org>
Date: Sun, 11 Oct 2015 13:51:52 +0100
MIME-Version: 1.0
In-Reply-To: <56153538.5060706@i2se.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/10/15 16:07, Stefan Wahren wrote:
> Am 07.10.2015 um 13:10 schrieb Alexandre Belloni:
>> 0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
>> Also improve the comment explaining the calculation.
>>
>> Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Applied to the fixes-togreg branch of iio.git and
marked for stable.

Thanks,

Jonathan
> 
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

