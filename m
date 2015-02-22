Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38439 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbBVJoq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Feb 2015 04:44:46 -0500
Message-ID: <54E9A508.9070202@kernel.org>
Date: Sun, 22 Feb 2015 09:44:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: Mark Brown <broonie@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <acourbot@nvidia.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3] iio: improve usage of gpiod API
References: <1424263631-18876-1-git-send-email-u.kleine-koenig@pengutronix.de> <CAEnQRZCgEqfc01AHL4E2YTPebAsrCtSAPeWnwE1quUL2F2U8Pg@mail.gmail.com> <20150218160640.GK19388@pengutronix.de>
In-Reply-To: <20150218160640.GK19388@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/15 16:06, Uwe Kleine-König wrote:
> Hello Daniel,
> 
> On Wed, Feb 18, 2015 at 03:48:12PM +0200, Daniel Baluta wrote:
>> On Wed, Feb 18, 2015 at 2:47 PM, Uwe Kleine-König
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
>>> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
>>> parameter that allows to specify direction and initial value for
>>> outputs.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> Thanks.
Applied to the togreg branch of iio.git. Will initially be pushed out as
testing for the autobuilders to play.

Thanks,

Jonathan
> 
>> I can take care of gpiod_to_irq error code checking.
> Great.
> 
> Best regards
> Uwe
> 

