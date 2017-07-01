Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdGAJS7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 05:18:59 -0400
Date: Sat, 1 Jul 2017 10:18:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, srv_heupstream@mediatek.com,
        liguo.zhang@mediatek.com, yingjoe.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: adc: mt7622: add binding document
Message-ID: <20170701101853.329e3291@kernel.org>
In-Reply-To: <20170628164622.4fmqmlhhyvkwvbwd@rob-hp-laptop>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
        <1498457502-3669-2-git-send-email-zhiyong.tao@mediatek.com>
        <20170628164622.4fmqmlhhyvkwvbwd@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Jun 2017 11:46:22 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jun 26, 2017 at 02:11:40PM +0800, Zhiyong Tao wrote:
> > The commit adds mt7622 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
> >  1 file changed, 1 insertion(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
