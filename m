Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:40424 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476AbaGQOFb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jul 2014 10:05:31 -0400
Received: by mail-la0-f54.google.com with SMTP id el20so1802840lab.27
        for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2014 07:05:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHfPSqCGf2d6xXDGr974+4ipNsYx3-fOLT+u2OGN=c9FVPEkZg@mail.gmail.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
	<02b501cf9064$34f16b80$9ed44280$@samsung.com>
	<53AAD8C8.3080506@roeck-us.net>
	<CAHfPSqCGf2d6xXDGr974+4ipNsYx3-fOLT+u2OGN=c9FVPEkZg@mail.gmail.com>
Date: Thu, 17 Jul 2014 16:05:30 +0200
Message-ID: <CABxcv=mko=1bQ+VnKhPtRbx6Leop+gRNNkiSO-CbvN=JiyWh2A@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] hwmon: ntc_thermistor: prepose vendor prefix change
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>, jdelvare@suse.de,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Naveen,

On Thu, Jul 17, 2014 at 6:21 AM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
>
> Can you pull the 3/4 and 4/4 patches.
>

Patch 4/4 depends on the max77802 support series [0] since the ADC
uses the max77802 ldo9 regulator as its voltage supply. So that patch
can't be merged before the series land in mainline.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/7/14/273
