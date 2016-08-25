Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org> <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Aug 2016 14:44:23 +0200
Message-ID: <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Nick Vaccaro <nvaccaro@google.com>,
	Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
	Nathan Royer <nroyer@invensense.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 23, 2016 at 10:37 AM, Peter Rosin <peda@axentia.se> wrote:

> Specifically patch 3/8 is relevant
>
> [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate' subnode
> https://lkml.org/lkml/2016/8/15/270

Yup the gate is what I'm using.

> The above is not in next (yet). I don't know how this situation is
> best handled?

I can put these patches into my development branch to get
a working driver using the gate. But I'd prefer them be in -next
when I pick them.

Then the rest is merge mechanics, dunno the best there,
Jonathan can decide.

Yours,
Linus Walleij
