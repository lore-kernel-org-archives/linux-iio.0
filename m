Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35975 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbbHQJLS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 05:11:18 -0400
Received: by obnw1 with SMTP id w1so106647425obn.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2015 02:11:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkdbFcgK69yakt+XYOg2q_QT8R263+FrADzz=r+fYNEFPSg@mail.gmail.com>
References: <1403621185-9581-1-git-send-email-denis@eukrea.com>
	<CACRpkdbFcgK69yakt+XYOg2q_QT8R263+FrADzz=r+fYNEFPSg@mail.gmail.com>
Date: Mon, 17 Aug 2015 11:11:17 +0200
Message-ID: <CACRpkda9LTxmOBXyGDUuhMej4W_waJwYkmay4ELYmQ1zJstSRA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Denis Carikli <denis@eukrea.com>, Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Linux Input <linux-input@vger.kernel.org>,
	Markus Pargmann <mpa@pengutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 27, 2014 at 11:18 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Jun 24, 2014 at 4:46 PM, Denis Carikli <denis@eukrea.com> wrote:

>> +       irq_set_chip_and_handler(irq, &dummy_irq_chip,
>> +                                handle_level_irq);
>> +       set_irq_flags(irq, IRQF_VALID);
>
> This function only exists on ARM. Unless Kconfig ensures
> this is only available on ARM platforms, use
>
> #ifdef CONFIG_ARM
>       set_irq_flags(irq, IRQF_VALID);
> #else
>       irq_set_noprobe(irq);
> #endif
>
> (Sorry we have no better way of doing it.)

Since I wrote this, there have been cleanups from Rob Herring merged
to the kernel to get rid of this oddity. Please check in linux-next how
to get this right, see c.f. commit
e8d36d5dbb6a6ec4f5222f8775d664ec29d5527d
"ARM: kill off set_irq_flags usage"

Yours,
Linus Walleij
