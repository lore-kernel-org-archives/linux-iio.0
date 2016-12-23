Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53886 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbcLWLlA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2016 06:41:00 -0500
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power
 switches
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
 <20161213192712.gbaw4t4awayybnta@rob-hp-laptop>
 <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
 <CAL_JsqLwS51MhOJQb-Lmo=osHiYKcAcCJaxKJFdSvZBpafz7Gw@mail.gmail.com>
 <CAMuHMdWfAwPE2N-_0WhW5+EEK3bqWoo9HpQZTgLzRRutCg++qg@mail.gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <505b7c02-e7dd-b0a5-8009-dca9101b0dd4@metafoo.de>
Date: Fri, 23 Dec 2016 12:40:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWfAwPE2N-_0WhW5+EEK3bqWoo9HpQZTgLzRRutCg++qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/23/2016 10:07 AM, Geert Uytterhoeven wrote:
> BTW, I'm not an IIO expert, but from my limited knowledge, it looks like "O"
> support in IIO is limited to DACs?

Depends on what you categorize as DACs. There are also
potentiometer/rheostat drivers. They are kind of like DACs but the unit you
control are ohm, rather than current or voltage.
