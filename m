Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35983 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcHZHjk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2016 03:39:40 -0400
Received: by mail-oi0-f41.google.com with SMTP id f189so99881108oig.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2016 00:39:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5903e282-aaf9-9c86-5df5-17b75d5b4018@axentia.se>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org> <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com> <5903e282-aaf9-9c86-5df5-17b75d5b4018@axentia.se>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Aug 2016 09:39:03 +0200
Message-ID: <CACRpkdZViewtQgW4GCuOkiKthqZMvXheORmg2rc-xG1cK4S4iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 25, 2016 at 10:32 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2016-08-25 14:44, Linus Walleij wrote:

>> Then the rest is merge mechanics, dunno the best there,
>> Jonathan can decide.
>
> I waited a bit for someone to scream about v4.8-rc3 being a bad base
> for some reason, but there was only silence. I have now pushed the
> series, and it can be pulled by anyone interested.
>
> Wolfram, please merge it into i2c/for-next
>
> Linus/Jonathan, technically you don't need all patches and can skip
> the last three, but it seems a bit over the top to be super anal
> about that detail...

OK I'll pull this into my development branch. At least we can
merge the bindings, whether to merge the driver this or next merge
window (or simply apply the patch to the I2C tree!) is another issue.

Yours,
Linus Walleij
