Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33434 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcHSBWP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2016 21:22:15 -0400
Date: Thu, 18 Aug 2016 14:21:06 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/17] iio: accel: kxsd9: Add device tree bindings
Message-ID: <20160818192106.GA28115@rob-hp-laptop>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-2-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471354423-19186-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 16, 2016 at 03:33:27PM +0200, Linus Walleij wrote:
> This accelerometer can be probed from the device tree, so it needs
> to have proper documentation of it's device tree bindings.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxsd9.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt

Acked-by: Rob Herring <robh@kernel.org>
