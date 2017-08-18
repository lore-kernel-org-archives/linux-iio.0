Return-Path: <SRS0=hjKJ=7U=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 18 Aug 2017 23:42:53 +0200
Message-ID: <CACRpkdbcdxmL2QiNZzqaDNTkfsvgqb1Bw_nqc1ipW-fxmq6NLA@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: magnetometer: ak8974: support AMI306
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Aug 17, 2017 at 3:56 PM, Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:

> This series adds support for AMI306 magnetometer. The device is very
> similar to already supported AMI305.

All four patches:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Very clear and to the point. Nice to see some wider use of this :)

> Calibration data is not used
> yet as I still need to figure out what it means.

Does your datasheet tell you how to convert to ISO units? Right now
the sensor only suppport raw data and it would be nice to support
IIO_CHAN_INFO_SCALE like e.g. ak8975.c does.

I bet the same scaling applies as to the other variants.

Yours,
Linus Walleij
