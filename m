Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Oct 2018 18:23:59 -0400
Date: Wed, 24 Oct 2018 08:55:44 -0500
From: Rob Herring <robh@kernel.org>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO
 bindings
Message-ID: <20181024135544.GA31518@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-4-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181023185330.10472-4-oskari@lemmela.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 Oct 2018 21:53:22 +0300, Oskari Lemmela wrote:
> The AXP803 GPIO is compatible with AXP813 GPIO, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
