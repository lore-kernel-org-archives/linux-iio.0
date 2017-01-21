Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35499 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdAUUdK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 15:33:10 -0500
Date: Sat, 21 Jan 2017 14:33:07 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marek.vasut@gmail.com, geert@linux-m68k.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCHv5 2/2] dt-bindings: iio: document MAX11100 ADC
Message-ID: <20170121203307.3ylfbh3xlhp5mkjs@rob-hp-laptop>
References: <1484757053-7102-1-git-send-email-jacopo+renesas@jmondi.org>
 <1484757053-7102-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484757053-7102-3-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 05:30:53PM +0100, Jacopo Mondi wrote:
> Add device tree bindings documentation for Maxim MAX11100 single-channel
> ADC
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/iio/adc/max11100.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt

Acked-by: Rob Herring <robh@kernel.org>
