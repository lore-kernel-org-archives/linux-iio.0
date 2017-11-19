Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdKSLeV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 06:34:21 -0500
Date: Sun, 19 Nov 2017 11:34:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pan Bian <bianpan2016@163.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: cpcap: fix incorrect validation
Message-ID: <20171119113416.377957d0@archlinux>
In-Reply-To: <20171113184903.GX28152@atomide.com>
References: <1510502480-27117-1-git-send-email-bianpan2016@163.com>
        <20171112182848.li5chdcsrhjv3du6@earth>
        <20171113184903.GX28152@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 13 Nov 2017 10:49:03 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Sebastian Reichel <sre@kernel.org> [171112 18:30]:
> > Hi,
> > 
> > On Mon, Nov 13, 2017 at 12:01:20AM +0800, Pan Bian wrote:  
> > > Function platform_get_irq_byname() returns a negative error code on
> > > failure, and a zero or positive number on success. However, in function
> > > cpcap_adc_probe(), positive IRQ numbers are also taken as error cases.
> > > Use "if (ddata->irq < 0)" instead of "if (!ddata->irq)" to validate the
> > > return value of platform_get_irq_byname().
> > > 
> > > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > > ---  
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>  
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
