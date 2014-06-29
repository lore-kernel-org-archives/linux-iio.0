Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52646 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbaF2K6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 06:58:16 -0400
Message-ID: <53AFF1C4.1010402@kernel.org>
Date: Sun, 29 Jun 2014 12:00:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: Denis Carikli <denis@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>	<1402672899-6995-1-git-send-email-denis@eukrea.com>	<1402672899-6995-3-git-send-email-denis@eukrea.com>	<53A55BD8.7030905@kernel.org> <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
In-Reply-To: <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/14 20:55, Fabio Estevam wrote:
> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>
>> Could this not in theory fail?
>
> Yes, but devm_ioremap_resource will take care of it, so we don't need
> to check for error here.
Nothing like counter intuitive behaviour.  Ah well.

Thanks for explaining this!
>
>>
>>> +       mem = devm_ioremap_resource(dev, res);
>>> +       if (!mem)
>>> +               return -ENOMEM;

