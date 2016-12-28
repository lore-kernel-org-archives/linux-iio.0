Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34052 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbcL1Mww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 07:52:52 -0500
Received: by mail-qt0-f178.google.com with SMTP id d45so126945978qta.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 04:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com> <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Dec 2016 13:52:44 +0100
Message-ID: <CACRpkdaSAnu6L_QMn8tuNLaFGLVoQEC6yin6DysHMi9WQpnd6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Dec 11, 2016 at 11:21 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> Some boards are equipped with simple, GPIO-driven power load switches.
> An example of such ICs is the TI tps229* series.
>
> Add device tree bindings allowing to describe them.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
(...)
>  .../bindings/power/gpio-power-switch.txt           | 25 ++++++++++++++++++++++

Scrap this and use:
Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt

Yours,
Linus Walleij
