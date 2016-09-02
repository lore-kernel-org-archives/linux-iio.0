Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36080 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbcIBRuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 13:50:08 -0400
Date: Fri, 2 Sep 2016 12:50:06 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2 v4] iio: gyro: Add MPU-3050 device tree bindings
Message-ID: <20160902175006.GA7869@rob-hp-laptop>
References: <1472646781-5551-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472646781-5551-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 31, 2016 at 02:33:00PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the MPU-3050 gyroscope. Since it
> is the first set of bindings for a gyroscope, the folder for it
> is also created.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - No changes, just reposting. If we agree on these bindings and since
>   the dependent I2C bindings are merged, this patch should be merge
>   material now I guess.
> ChangeLog v2->v3:
> - Augmented device tree bindings to reflect Peter Rosins now merged
>   I2C gate bindings.
> ChangeLog v1->v2:
> - Not yet convered to use i2c-gate as I'm waiting for that
>   patch set to stabilize.
> ---
>  .../bindings/iio/gyroscope/invensense,mpu3050.txt  | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt

Acked-by: Rob Herring <robh@kernel.org>
