Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53241 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbcHUTmp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:42:45 -0400
Subject: Re: [PATCH 01/17] iio: accel: kxsd9: Add device tree bindings
To: Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-2-git-send-email-linus.walleij@linaro.org>
 <20160818192106.GA28115@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ff3e8465-d550-6aa8-2a04-e70e4ff1c4f9@kernel.org>
Date: Sun, 21 Aug 2016 20:41:35 +0100
MIME-Version: 1.0
In-Reply-To: <20160818192106.GA28115@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/16 20:21, Rob Herring wrote:
> On Tue, Aug 16, 2016 at 03:33:27PM +0200, Linus Walleij wrote:
>> This accelerometer can be probed from the device tree, so it needs
>> to have proper documentation of it's device tree bindings.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  .../devicetree/bindings/iio/accel/kionix,kxsd9.txt | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - pushed out as
testing.  Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

