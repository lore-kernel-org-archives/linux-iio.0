Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:47952 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdIULO7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2017 07:14:59 -0400
Received: by mail-it0-f48.google.com with SMTP id 85so229926ith.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2017 04:14:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830115043.3738-3-lorenzo.bianconi@st.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com> <20170830115043.3738-3-lorenzo.bianconi@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Sep 2017 13:14:58 +0200
Message-ID: <CACRpkdY-xgQ_Eu_Zf1EH-AnSo1pxTq8Pfg37UorMKCk_N7_TEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: st_sensors: decouple irq1 configuration
 parameters from the irq2 ones
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 30, 2017 at 1:50 PM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

> Separate data-ready configuration parameters for INT1 and INT2 pins in
> st_sensor_data_ready_irq data structure. That change will be use to
> properly support LIS2DW12 accel sensor.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Also here I feel we should make a sweep over old sensors
and make sure we got this right everywhere.

Yours,
Linus Walleij
