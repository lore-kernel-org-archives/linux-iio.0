Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbdGAMNi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 08:13:38 -0400
Date: Sat, 1 Jul 2017 13:13:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>
Subject: Re: [PATCH v3 1/4] iio: accel: st_accel_spi: add OF capability to
 st_accel_spi
Message-ID: <20170701131334.7dc77c12@kernel.org>
In-Reply-To: <CACRpkdbF3iVLSr3kBNGmoZjoPX=1KOO74OS3wmTSxFrzqwak3A@mail.gmail.com>
References: <20170626225346.12019-1-lorenzo.bianconi@st.com>
        <20170626225346.12019-2-lorenzo.bianconi@st.com>
        <CACRpkdbF3iVLSr3kBNGmoZjoPX=1KOO74OS3wmTSxFrzqwak3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Jun 2017 14:48:31 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jun 27, 2017 at 12:53 AM, Lorenzo Bianconi
> <lorenzo.bianconi83@gmail.com> wrote:
> 
> > Add device tree support for LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> > LIS331DLH, LSM330, LSM303AGR, LIS2DH12, LIS3L02DQ, LNG2DM accel sensors.
> > Fix LIS302DL support defining of_device_id data field in st_accel_of_match
> > table
> >
> > Fixes: 762227721fe6 (iio: accel: st_accel: handle deprecated bindings)
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> 
> Looks right.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
