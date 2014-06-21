Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53A55BD8.7030905@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
	<1402672899-6995-1-git-send-email-denis@eukrea.com>
	<1402672899-6995-3-git-send-email-denis@eukrea.com>
	<53A55BD8.7030905@kernel.org>
Date: Sat, 21 Jun 2014 16:55:52 -0300
Message-ID: <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
From: Fabio Estevam <festevam@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Carikli <denis@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> Could this not in theory fail?

Yes, but devm_ioremap_resource will take care of it, so we don't need
to check for error here.

>
>> +       mem = devm_ioremap_resource(dev, res);
>> +       if (!mem)
>> +               return -ENOMEM;
