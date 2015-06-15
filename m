Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbFOIfQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 04:35:16 -0400
Date: Mon, 15 Jun 2015 10:35:06 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: stk3310: use flags argument of devm_gpiod_get
Message-ID: <20150615083506.GZ18985@pengutronix.de>
References: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaLUGyZEB0gK--s-H0t8NCw8JuKWHJgCzmx4H=pQJekFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACRpkdaLUGyZEB0gK--s-H0t8NCw8JuKWHJgCzmx4H=pQJekFQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Linus,

On Mon, Jun 15, 2015 at 10:16:46AM +0200, Linus Walleij wrote:
> On Fri, Jun 12, 2015 at 9:51 AM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Note I plan to make the flags parameter mandatory for 4.3. So unless
> > this change gets into 4.2, would it be ok to let it go in via the gpio
> > tree?
> 
> Sounds like a plan. If you will have a patch set with the remaining
> consumers fixed and then remove the non-flagged functions
> on top, let's merge that into the GPIO tree for linux-next right after
> the 4.2 merge window so we can terminate this task.
That's exactly my plan.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
