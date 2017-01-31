Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:33305 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdAaJmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 04:42:10 -0500
Received: by mail-it0-f45.google.com with SMTP id d9so27380296itc.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2017 01:41:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130171604.11266-1-vilhelm.gray@gmail.com>
References: <20170130171604.11266-1-vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Jan 2017 10:41:35 +0100
Message-ID: <CACRpkdbAn5QEah0oqVHcJz_-Bu-94A5ADYgXeFogZbzhuzrjnA@mail.gmail.com>
Subject: Re: [PATCH] iio: stx104: Add support for GPIO names
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 30, 2017 at 6:16 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This patch sets the gpio_chip names option with an array of GPIO line
> names that match the manual documentation for the Apex Embedded Systems
> STX104. This should make it easier for users to identify which GPIO line
> corresponds to a respective GPIO pin on the device.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
(...)
> +#define STX104_NGPIO 8
> +static const char *stx104_names[STX104_NGPIO] = {
> +       "DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
> +};
(...)
> +       stx104gpio->chip.ngpio = STX104_NGPIO;
> +       stx104gpio->chip.names = stx104_names;

If the device has a gpio-controller tagged node in a device tree, it is better
to use gpio-line-names = "foo" ...; for this. For ACPI there is something
similar.

If it is spawn from this device without any GPIO child node or hardware
description outside of the kernel driver, such as
ISA/PCI or whatever, this is a good way.

This is an isa_driver and falls in the latter category, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
