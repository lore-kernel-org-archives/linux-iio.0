Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38806 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbFMUrF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 16:47:05 -0400
Message-ID: <557C96C5.1020606@kernel.org>
Date: Sat, 13 Jun 2015 21:47:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, kernel@pengutronix.de,
	Alexandre Courbot <gnurou@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: stk3310: use flags argument of devm_gpiod_get
References: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de> <557C7125.3010606@kernel.org> <20150613191140.GX18985@pengutronix.de>
In-Reply-To: <20150613191140.GX18985@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/06/15 20:11, Uwe Kleine-König wrote:
> Hello Jonathan,
> 
> On Sat, Jun 13, 2015 at 07:06:29PM +0100, Jonathan Cameron wrote:
>> On 12/06/15 08:51, Uwe Kleine-König wrote:
>>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
>>> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
>>> parameter that allows to specify direction and initial value for output.
>>>
>>> Simplify driver accordingly. Furthermore this is one caller less that
>>> stops us making the flags argument to gpiod_get*() mandatory.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>> ---
>>> Hello,
>>>
>>> this patch applies to next and is only necessary on top of 3dd477acbdd1
>>> (iio: light: Add threshold interrupt support for STK3310) which
>>> currently sits in next.
>>>
>>> Note I plan to make the flags parameter mandatory for 4.3. So unless
>>> this change gets into 4.2, would it be ok to let it go in via the gpio
>>> tree?
>> yes, that's fine.
> that means you won't take it for 4.2, right?
> 
Indeed, too late for us this cycle.
> Best regards
> Uwe
> 

