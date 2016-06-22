Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35307 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcFVPlw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 11:41:52 -0400
Received: by mail-oi0-f47.google.com with SMTP id r2so27931696oih.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 08:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <576A7C28.70905@parrot.com>
References: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
 <1466547498-15484-2-git-send-email-linus.walleij@linaro.org> <576A7C28.70905@parrot.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jun 2016 17:41:51 +0200
Message-ID: <CACRpkdZT_9gs9vPYGku2XeZnxaXPaE=X3XLWccPkB2iK9_KvcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: magn: ak8975: fix regulator usage
To: Gregor Boirie <gregor.boirie@parrot.com>,
	Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Disclaimer: I am not the regulator maintainer but I think I
understand how these things are supposed to work.
Mark will correct me if I say something stupid, I hope.

On Wed, Jun 22, 2016 at 1:53 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
> On 06/22/2016 12:18 AM, Linus Walleij wrote:

>>         data->vdd = devm_regulator_get(&client->dev, "vdd");
>> -       if (IS_ERR_OR_NULL(data->vdd)) {
>> +       if (IS_ERR(data->vdd)) {
>>                 ret = PTR_ERR(data->vdd);
>> -               if (ret == -ENODEV)
>> -                       ret = 0;
>
> what if dummy supplies are not allowed and regulator is not declared / found
> into device tree ?

What do you mean with "dummy supplies not allowed"? It is an
integral part of the regulator framework. It's not like you can choose
not to have it.

The only way a regulator doesn't resolve to a dummy
is with regulator_get_exclusive() which I'm not using or if your board
is lacking full constraints. (All DT boards have full constraints.)

In that case I think you should make sure to call
regulator_has_full_constraints() in your boardfile, and fix your
regulators because they're likely just broken.

> I have no such regulator on some boards, just a main power supply that is
> not driven by soft.

That should be defined in the DT as a fixed regulator
something like this:

+               /* Main power of the board: 3.7V */
+               vph: regulator-fixed {
+                       compatible = "regulator-fixed";
+                       regulator-min-microvolt = <3700000>;
+                       regulator-max-microvolt = <3700000>;
+                       regulator-name = "VPH";
+                       regulator-type = "voltage";
+                       regulator-always-on;
+                       regulator-boot-on;
+               };

This can also be done with a boardfile.

Of course also select REGULATOR_FIXED_VOLTAGE for
your board in KConfig.

> How should this be handled in this case ?

If the component has a (non-optional) external power
supply, its driver should issue regulator_get/enable for it.

If a board does not have all the proper regulators defined (which
is easy, in worst case just use fixed-regulator), it should
resort to use dummy regulators. It needs to call
regulator_has_full_constraints() for the dummies to kick in.

It is not proper to try to quirk around in the driver and
avoid getting a regulator just to stay compatible. Not
properly supplying either proper regulators nor dummies is
considered a bug.

Yours,
Linus Walleij
