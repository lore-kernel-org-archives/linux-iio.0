Return-Path: <richard@nod.at>
Message-ID: <547B4464.9090300@nod.at>
Date: Sun, 30 Nov 2014 17:23:00 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: linus.walleij@linaro.org, harald@ccbib.org
CC: javier.martinez@collabora.co.uk, acourbot@nvidia.com,
 swarren@nvidia.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: iio: dht11 broken
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi!

Staring with 3.12 gpiolib refuses to set an GPIO used as IRQ into output mode.
see commit d468bf9e (gpio: add API to be strict about GPIO IRQ usage)
The dht driver does this and is therefore not functional.
As the dht11 driver got merged in 3.13 there is a high chance that it never worked.

Harald, are you aware of this issue?

Thanks,
//richard
