Return-Path: <sameo@linux.intel.com>
Date: Mon, 19 Nov 2012 18:30:36 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Cc: linus.walleij@linaro.org, poeschel@lemonage.de,
	linux-kernel@vger.kernel.org, jic23@cam.ac.uk, khali@linux-fr.org,
	ben-linux@fluff.org, w.sang@pengutronix.de,
	grant.likely@secretlab.ca, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mfd: add viperboard driver
Message-ID: <20121119173036.GE18738@sortiz-mobl>
References: <1352126906-4560-1-git-send-email-larsi@wh2.tu-dresden.de>
 <1352126906-4560-2-git-send-email-larsi@wh2.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352126906-4560-2-git-send-email-larsi@wh2.tu-dresden.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Lars,

On Mon, Nov 05, 2012 at 03:48:23PM +0100, Lars Poeschel wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> Add mfd driver for Nano River Technologies viperboard.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/mfd/Kconfig            |   14 +++++
>  drivers/mfd/Makefile           |    1 +
>  drivers/mfd/viperboard.c       |  130 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/viperboard.h |  105 ++++++++++++++++++++++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 drivers/mfd/viperboard.c
>  create mode 100644 include/linux/mfd/viperboard.h
This looks way better than your initial submission.
Patches 2,3,4 and 5 all applied. I would really appreciate to get an ACK from
the i2c folks for patch #4.
I received a similar patch from Charles Keepax for patch 1, and I applied the
above 4 patches on top of it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
