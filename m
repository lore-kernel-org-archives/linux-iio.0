Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeGOJAh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Jul 2018 05:00:37 -0400
Date: Sun, 15 Jul 2018 09:38:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180715093821.50824bd2@archlinux>
In-Reply-To: <20180711135400.GA14723@rob-hp-laptop>
References: <20180710181831.GA5374@arbeit>
        <20180711135400.GA14723@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 11 Jul 2018 07:54:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jul 10, 2018 at 08:18:31PM +0200, Andreas Klinger wrote:
> > Add clock-frequency property for hx711 ADC. This is the frequency of
> > PD_SCK.
> > 
> > After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> > This is necessary because of parasitic capacitance on the wiring.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

