Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdB0XQV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Feb 2017 18:16:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170219150009.22825-1-tduszyns@gmail.com>
References: <20170219150009.22825-1-tduszyns@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Feb 2017 11:37:34 -0600
Message-ID: <CAL_JsqKvW51QwmRgzOFYNsCwCs+Us=FoXOZGxz5pg3x0w=d4EQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] DT: i2c: add sht21 to trivial-devices
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 19, 2017 at 9:00 AM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> Add binding for Sensirion sht21 relative humidity and temperature
> sensor driver.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)

Looks fine, but you are going to need to resend after -rc1. We're
planning to move this file up a level.

Rob
