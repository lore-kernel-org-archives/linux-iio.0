Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754562AbdJIU6Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Oct 2017 16:58:24 -0400
Date: Mon, 9 Oct 2017 21:05:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] iio: st_sensors: decouple irq1 configuration
 parameters from the irq2 ones
Message-ID: <20171009210505.0b3eee5f@archlinux>
In-Reply-To: <CAA2SeNJ8cq+hdEQP4d9Ped9SBQnwCgmSydbShtOexuSEwRGzeA@mail.gmail.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com>
        <20170830115043.3738-3-lorenzo.bianconi@st.com>
        <CACRpkdY-xgQ_Eu_Zf1EH-AnSo1pxTq8Pfg37UorMKCk_N7_TEg@mail.gmail.com>
        <CAA2SeNJ8cq+hdEQP4d9Ped9SBQnwCgmSydbShtOexuSEwRGzeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Sep 2017 17:38:34 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> > On Wed, Aug 30, 2017 at 1:50 PM, Lorenzo Bianconi
> > <lorenzo.bianconi83@gmail.com> wrote:
> >  
> >> Separate data-ready configuration parameters for INT1 and INT2 pins in
> >> st_sensor_data_ready_irq data structure. That change will be use to
> >> properly support LIS2DW12 accel sensor.
> >>
> >> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Also here I feel we should make a sweep over old sensors
> > and make sure we got this right everywhere.  
> 
> I checked all supported devices and irq configurations seem fine.
> Regards,
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Lorenzo
> 
> >
> > Yours,
> > Linus Walleij  
> 
> 
> 

