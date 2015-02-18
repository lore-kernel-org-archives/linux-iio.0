Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59553 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbBRHPc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 02:15:32 -0500
Date: Wed, 18 Feb 2015 08:15:23 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	kernel@pengutronix.de, Mark Brown <broonie@linaro.org>
Subject: Re: [PATCH] iio: improve usage of gpiod API
Message-ID: <20150218071523.GH19388@pengutronix.de>
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <54E3E61A.3040006@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <54E3E61A.3040006@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 18, 2015 at 10:08:42AM +0900, Alexandre Courbot wrote:
> On 02/17/2015 06:21 PM, Uwe Kleine-König wrote:
> >Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> >which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> >parameter that allows to specify direction and initial value for
> >outputs.
> >
> >Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Nice, thanks for taking the time to do this!
I have some more, just didn't come around to wrap in commits and send
out:

	http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=1783b17ba922f92d043bad650c0209de1c201080;hp=e36f014edff70fc02b3d3d79cead1d58f289332e

I will do one patch a day ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
