Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35883 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbbFOIQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 04:16:47 -0400
Received: by oial131 with SMTP id l131so20606277oia.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2015 01:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de>
Date: Mon, 15 Jun 2015 10:16:46 +0200
Message-ID: <CACRpkdaLUGyZEB0gK--s-H0t8NCw8JuKWHJgCzmx4H=pQJekFQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: stk3310: use flags argument of devm_gpiod_get
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 12, 2015 at 9:51 AM, Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:

> Note I plan to make the flags parameter mandatory for 4.3. So unless
> this change gets into 4.2, would it be ok to let it go in via the gpio
> tree?

Sounds like a plan. If you will have a patch set with the remaining
consumers fixed and then remove the non-flagged functions
on top, let's merge that into the GPIO tree for linux-next right after
the 4.2 merge window so we can terminate this task.

Yours,
Linus Walleij
