Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJaMCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2018 08:02:15 -0400
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-9-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-9-oskari@lemmela.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 31 Oct 2018 11:05:53 +0800
Message-ID: <CAGb2v66cM5NtCQnCBeoimXGmd2DDt+19Qq=xJjATHYEbR_UviQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] arm64: dts: allwinner: a64: pinebook: enable
 power supplies
To: oskari@lemmela.net
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> From: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Pinebook has ACIN connector and 10000 mAh battery.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

You should have your own SoB following the author's when you resend other
people's patches. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
