Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34853 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCAUyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 15:54:47 -0500
Date: Wed, 1 Mar 2017 15:46:52 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 0/3] pc104: Mask PC/104 Kconfig options
Message-ID: <20170301204652.GA31812@sophia>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
 <CACRpkdaqeLktgqmd6qcdGmruxABS0fWQacPOTYf0V24cKyiSRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACRpkdaqeLktgqmd6qcdGmruxABS0fWQacPOTYf0V24cKyiSRA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 11, 2017 at 04:26:19PM +0100, Linus Walleij wrote:
>On Tue, Jan 10, 2017 at 7:50 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> PC/104 form factor devices serve a specific niche of embedded system
>> users. Since PC/104 devices and hardware are typically used by just a
>> subset of Linux users, it would be appropriate to filter PC/104 related
>> Kconfig options for those uninterested.
>>
>> This patchset introduces the PC104 Kconfig option, and uses it to mask
>> PC/104 specific device drivers and options, so that only those users
>> interested in PC/104 related Kconfig options are exposed to them.
>
>Tell me when/if the PC104 option is merged and I can merge the GPIO
>patch.
>
>Yours,
>Linus Walleij

Jonathan and Linus,

Now that the PC104 option is merged for 4.11, it should be all right to
merge in the GPIO and IIO patches without worry of warnings. Please
merge the relevant patch to your respective tree after you pull in the
PC104 option.

Thank you,

William Breathitt Gray
