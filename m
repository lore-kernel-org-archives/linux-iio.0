Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35120 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcFVTPI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 15:15:08 -0400
Received: by mail-oi0-f50.google.com with SMTP id r2so36960284oih.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 12:15:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkda9+Ph1S7GpD2jgZbo5gLqR-gYyhDrQdZ3ccGmX9vQo3Q@mail.gmail.com>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
 <CAKzfze_MasVedhUoTaGTj0CXMQWwamLoNyDnj_GTRq8xV0z_kQ@mail.gmail.com> <CACRpkda9+Ph1S7GpD2jgZbo5gLqR-gYyhDrQdZ3ccGmX9vQo3Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jun 2016 21:15:07 +0200
Message-ID: <CACRpkda+a99AGHKB5zwCCqh=ggV-v8LNmkYh2_uCbuny4nT7oQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] iio: bmp280: improve driver
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 22, 2016 at 5:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jun 22, 2016 at 9:31 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>
>> Ok looks okay overall but you are dropping my BME280 part changes here
>> -> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=14beaa8f5ab11b881c5e822e2474f5278d0946d5
>
> I'm not the maintainer of this driver, so I have not looked to see if
> there are new patches for it around. My patches are simply based
> on mainline.
>
> Do you want me to include this patch in my patch series and
> push towards Jonathan?

Aha I see there is stuff queued in Jonathan's tree that I need to rebase
on. OK I will base a revised patch series on Jonathan's iio-for-4.8a
branch.

Yours,
Linus Walleij
