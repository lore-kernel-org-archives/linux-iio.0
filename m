Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35091 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935744AbdAKP0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 10:26:20 -0500
Received: by mail-qt0-f170.google.com with SMTP id x49so132088374qtc.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2017 07:26:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1484073324.git.vilhelm.gray@gmail.com>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Jan 2017 16:26:19 +0100
Message-ID: <CACRpkdaqeLktgqmd6qcdGmruxABS0fWQacPOTYf0V24cKyiSRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pc104: Mask PC/104 Kconfig options
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 10, 2017 at 7:50 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> PC/104 form factor devices serve a specific niche of embedded system
> users. Since PC/104 devices and hardware are typically used by just a
> subset of Linux users, it would be appropriate to filter PC/104 related
> Kconfig options for those uninterested.
>
> This patchset introduces the PC104 Kconfig option, and uses it to mask
> PC/104 specific device drivers and options, so that only those users
> interested in PC/104 related Kconfig options are exposed to them.

Tell me when/if the PC104 option is merged and I can merge the GPIO
patch.

Yours,
Linus Walleij
