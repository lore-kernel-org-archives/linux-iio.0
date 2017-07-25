Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbdGYTCd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Jul 2017 15:02:33 -0400
Date: Tue, 25 Jul 2017 20:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 09/10] dt-bindings: iio: humidity: hts221: support
 open drain mode
Message-ID: <20170725200231.517ec147@kernel.org>
In-Reply-To: <20170724174816.zgdsfzuq2frsggzn@rob-hp-laptop>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-10-lorenzo.bianconi@st.com>
        <20170724174816.zgdsfzuq2frsggzn@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 24 Jul 2017 12:48:16 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jul 17, 2017 at 07:39:04PM +0200, Lorenzo Bianconi wrote:
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan
