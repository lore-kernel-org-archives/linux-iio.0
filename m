Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35132 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbcDCQau (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 12:30:50 -0400
Received: by mail-oi0-f42.google.com with SMTP id p188so138502876oih.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Apr 2016 09:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5700E7AF.6040903@kernel.org>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
	<5700E7AF.6040903@kernel.org>
Date: Sun, 3 Apr 2016 18:30:49 +0200
Message-ID: <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Paul Walmsley <paul@pwsan.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 3, 2016 at 11:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/03/16 09:34, Linus Walleij wrote:

>> I want to phase out the old misc driver, but don't know how that
>> should properly be handled. The driver has an old (totally
>> undocumented) sysfs ABI for raw measurements, should I add
>> this as backward-compatibility and symlink the device to the old
>> location?
>
> Good question.  I guess we unfortunately do need to jump through the hoops as
> who knows what userspace code there is out there using that interface.
> At least it is small!

The maintainer Hemanth seems to have disappeared.

Let's ask some of the OMAP and ex-OMAP people, I think they know
or know who knows...

Tony, Peter, Paul: drivers/misc/bh1780gli.c has a funky sysfs ABI.
It is only used in arch/arm/boot/dts/omap4-sdp.dts as far as I can
tell. What device is this, and more importantly, who is running it
and with what userspace? I'm happy to go and patch that userspace
if I can just get a pointer to whoever is developing it. Sailfish?

Yours,
Linus Walleij
