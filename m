Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33576 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbBRQGo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 11:06:44 -0500
Date: Wed, 18 Feb 2015 17:06:40 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Mark Brown <broonie@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <acourbot@nvidia.com>, kernel@pengutronix.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3] iio: improve usage of gpiod API
Message-ID: <20150218160640.GK19388@pengutronix.de>
References: <1424263631-18876-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAEnQRZCgEqfc01AHL4E2YTPebAsrCtSAPeWnwE1quUL2F2U8Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAEnQRZCgEqfc01AHL4E2YTPebAsrCtSAPeWnwE1quUL2F2U8Pg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Daniel,

On Wed, Feb 18, 2015 at 03:48:12PM +0200, Daniel Baluta wrote:
> On Wed, Feb 18, 2015 at 2:47 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> > which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> > parameter that allows to specify direction and initial value for
> > outputs.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Thanks.

> I can take care of gpiod_to_irq error code checking.
Great.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
