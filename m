Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbdHQOzg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:55:36 -0400
Date: Thu, 17 Aug 2017 15:55:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: iio: magn: add LIS2MDL sensor device
 binding
Message-ID: <20170817155528.68354457@archlinux>
In-Reply-To: <CAA2SeN+iPatt4h1B+qkez0HuVd1ZiojjgXkvu5hYLL_xOU5O2g@mail.gmail.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
        <20170816170253.8382-5-lorenzo.bianconi@st.com>
        <CAA2SeN+iPatt4h1B+qkez0HuVd1ZiojjgXkvu5hYLL_xOU5O2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 09:01:22 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Added devicetree ml in cc
> 
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
I've applied this as it is about as trivial as you can get.
If one of the devicetree maintainers really wants to reply then feel free ;)

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> > ---
> >  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > index 1e305f61f3df..9ec6f5ce54fc 100644
> > --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> > +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > @@ -64,6 +64,7 @@ Magnetometers:
> >  - st,lsm303dlhc-magn
> >  - st,lsm303dlm-magn
> >  - st,lis3mdl-magn
> > +- st,lis2mdl
> >
> >  Pressure sensors:
> >  - st,lps001wp-press
> > --
> > 2.14.0
> >  

