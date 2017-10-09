Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbdJJTmT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 15:42:19 -0400
Date: Mon, 9 Oct 2017 21:59:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] iio: st_sensors: do not always write enable_axis
 register
Message-ID: <20171009215908.57358b45@archlinux>
In-Reply-To: <CACRpkdbFvAr26d_ExN-PuazsA_ZbPoOFuCKn-k-s3uwVvd64jg@mail.gmail.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com>
        <20170830115043.3738-4-lorenzo.bianconi@st.com>
        <CACRpkdbFvAr26d_ExN-PuazsA_ZbPoOFuCKn-k-s3uwVvd64jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Sep 2017 13:15:55 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Aug 30, 2017 at 1:50 PM, Lorenzo Bianconi
> <lorenzo.bianconi83@gmail.com> wrote:
> 
> > New devices (e.g. LIS2DW12) enable all axis by default and do not export
> > that capability in register map. Check if the enable_axis register
> > address has been declared in st_sensor_settings map in order to verify if
> > the driver needs to enable all sensor axis
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied.
> 
> Yours,
> Linus Walleij

