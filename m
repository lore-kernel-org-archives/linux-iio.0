Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbdGDTaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:30:10 -0400
Date: Tue, 4 Jul 2017 20:30:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix unbalanced irq
 enable/disable
Message-ID: <20170704203005.49d9887e@kernel.org>
In-Reply-To: <20170703211945.4vjnnjwl2lkcfr7u@flea>
References: <20170703130926.32315-1-quentin.schulz@free-electrons.com>
        <20170703211945.4vjnnjwl2lkcfr7u@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 3 Jul 2017 23:19:45 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Mon, Jul 03, 2017 at 03:09:26PM +0200, Quentin Schulz wrote:
> > When initializing interrupts, the devm_request_any_context_irq will
> > enable them right away. An atomic flag was set in sun4i_irq_init and read
> > in the interrupt handler to make sure no unwanted interrupts were
> > handled. If an unwanted interrupt occurred, the handler would disable
> > the irq and return IRQ_HANDLED. However, at the end of sun4i_irq_init,
> > the irq would be disabled as well, resulting in an unbalanced enable
> > (since there are more disables than enables, the code enabling the
> > interrupt would never be called).
> > 
> > When reading the ADC or the temperature, the respective irq would be
> > enabled in the read function and disabled in the irq handler. In the
> > read function, we would wait for a completion (with a timeout) that will
> > be set in the irq handler. However, if the completion is never set or if
> > the wait for completion times out, the irq would not be disabled in the
> > read function resulting in an unbalanced enable once the read function
> > is called again (since there are 2+ enables for no disable).
> > 
> > Moving disable_irq from the irq handler to the read function get rid of
> > these two cases of unbalanced enable.
> > 
> > Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> > 
> > Reported-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>  
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Nice detailed explanation - thanks.

Applied to the fixes-togreg branch of iio.git.

Jonathan
> 
> Thanks!
> Maxime
> 

