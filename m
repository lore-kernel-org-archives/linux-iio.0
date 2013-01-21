Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:57695 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3AUVxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 16:53:11 -0500
From: Marek Vasut <marex@denx.de>
To: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
Date: Mon, 21 Jan 2013 22:53:09 +0100
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
References: <1358798722-25102-1-git-send-email-marex@denx.de> <201301212232.52161.marex@denx.de> <CAHXqBFJ5=P2OHez74gK-DBT+3O=KHoHjffxRAe2u-9ppXOmExA@mail.gmail.com>
In-Reply-To: <CAHXqBFJ5=P2OHez74gK-DBT+3O=KHoHjffxRAe2u-9ppXOmExA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201301212253.10332.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Michał Mirosław,

[...]

> >> I'm asking, because you don't use this number anywhere other than in
> >> mxs_lradc_probe()
> >> and there only to dereference the irq-names table. After that the
> >> structure and number
> >> are forgotten.
> > 
> > Certainly, so far it's used only this way. But please see my argument
> > about register layout, that's why I went down this road of abstraction.
> 
> Hmm. Then is IMX23 LRADC going to just work after this series
> (assuming I don't use unsupported features) or this needs more patches
> to be usable?

It's gonna work, touchscreen will work as well. You won't have the touchbuttons, 
but when these're gonna be implemented, we will need to be careful to enable 
them only for mx28.

Best regards,
Marek Vasut
