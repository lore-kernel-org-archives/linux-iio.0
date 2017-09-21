Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35510 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdIUPif (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2017 11:38:35 -0400
MIME-Version: 1.0
In-Reply-To: <CACRpkdY-xgQ_Eu_Zf1EH-AnSo1pxTq8Pfg37UorMKCk_N7_TEg@mail.gmail.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com>
 <20170830115043.3738-3-lorenzo.bianconi@st.com> <CACRpkdY-xgQ_Eu_Zf1EH-AnSo1pxTq8Pfg37UorMKCk_N7_TEg@mail.gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Thu, 21 Sep 2017 17:38:34 +0200
Message-ID: <CAA2SeNJ8cq+hdEQP4d9Ped9SBQnwCgmSydbShtOexuSEwRGzeA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: st_sensors: decouple irq1 configuration
 parameters from the irq2 ones
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Wed, Aug 30, 2017 at 1:50 PM, Lorenzo Bianconi
> <lorenzo.bianconi83@gmail.com> wrote:
>
>> Separate data-ready configuration parameters for INT1 and INT2 pins in
>> st_sensor_data_ready_irq data structure. That change will be use to
>> properly support LIS2DW12 accel sensor.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Also here I feel we should make a sweep over old sensors
> and make sure we got this right everywhere.

I checked all supported devices and irq configurations seem fine.
Regards,

Lorenzo

>
> Yours,
> Linus Walleij



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
