Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47227 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbBRLkd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 06:40:33 -0500
MIME-Version: 1.0
In-Reply-To: <54E47571.7060904@samsung.com>
References: <1424256432-20808-1-git-send-email-geert@linux-m68k.org>
	<54E47571.7060904@samsung.com>
Date: Wed, 18 Feb 2015 12:40:33 +0100
Message-ID: <CAMuHMdUa7E2=3TSBz9j8yZq1YLkbn58KJGb8WKGVnyBBbwbSMg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: mma9551: Protect PM-only functions by #ifdef CONFIG_PM_SLEEP
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Karol Wrona <k.wrona@samsung.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 18, 2015 at 12:20 PM, Karol Wrona <k.wrona@samsung.com> wrote:
> Patch is ok but commit title points to different driver.  Irina would be
> surprised and confused to see it on the list and log.

Woops, that was a serious copy-and-paste bug on my side. Sorry for that.

> Please, use something like that: iio: common: ssp_sensors: Fix warnings ...

Resent with corrected subject.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
