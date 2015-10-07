Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57160 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbbJGPHn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2015 11:07:43 -0400
Subject: Re: [PATCH v2] iio: mxs-lradc: Fix temperature offset
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>
References: <1444216254-19668-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>,
	Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <56153538.5060706@i2se.com>
Date: Wed, 7 Oct 2015 17:07:36 +0200
MIME-Version: 1.0
In-Reply-To: <1444216254-19668-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 07.10.2015 um 13:10 schrieb Alexandre Belloni:
> 0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
> Also improve the comment explaining the calculation.
>
> Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
