Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdFKLrx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 07:47:53 -0400
Date: Sun, 11 Jun 2017 12:47:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: support
 active-low interrupts
Message-ID: <20170611124748.323fb7a4@kernel.org>
In-Reply-To: <20170609141816.jllbisljifdj4vhr@rob-hp-laptop>
References: <20170607181711.16195-1-lorenzo.bianconi@st.com>
        <20170607181711.16195-3-lorenzo.bianconi@st.com>
        <20170609141816.jllbisljifdj4vhr@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Jun 2017 09:18:16 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jun 07, 2017 at 08:17:11PM +0200, Lorenzo Bianconi wrote:
> > Update st_lsm6dsx device binding with active-low interrupts support
> > (IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)  
> 
> "dt-bindings: iio: ..." is preferred for subject. Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Fixed and applied to the togreg branch of iio.git - pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
