Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35537 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPSwI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 14:52:08 -0400
Received: by mail-pg0-f68.google.com with SMTP id l64so5949245pge.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Aug 2017 11:52:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170816170253.8382-1-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Wed, 16 Aug 2017 20:52:06 +0200
Message-ID: <CAA2SeNLqz-yxqD-SP975kzyDp1x02=80d+n9-QK7RudKZ6BSdQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support to LIS2MDL magnetometer sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan I forgot to add in cc device tree ML. Should I resend?

Regards,
Lorenzo

On Wed, Aug 16, 2017 at 7:02 PM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:
> Fix two interrupt issues for LSM303AGR magn sensor
>
> Lorenzo Bianconi (4):
>   iio: magnetometer: st_magn: fix status register address for LSM303AGR
>   iio: magnetometer: st_magn: remove ihl property for LSM303AGR
>   iio: magnetometer: add support to LIS2MDL
>   dt-bindings: iio: magn: add LIS2MDL sensor device binding
>
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  drivers/iio/magnetometer/st_magn.h                   | 1 +
>  drivers/iio/magnetometer/st_magn_core.c              | 5 ++---
>  drivers/iio/magnetometer/st_magn_i2c.c               | 5 +++++
>  drivers/iio/magnetometer/st_magn_spi.c               | 5 +++++
>  5 files changed, 14 insertions(+), 3 deletions(-)
>
> --
> 2.14.0
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
