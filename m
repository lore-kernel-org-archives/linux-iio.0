Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34220 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdHPXWG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 19:22:06 -0400
Date: Thu, 17 Aug 2017 07:21:55 +0800
In-Reply-To: <CAA2SeNLqz-yxqD-SP975kzyDp1x02=80d+n9-QK7RudKZ6BSdQ@mail.gmail.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com> <CAA2SeNLqz-yxqD-SP975kzyDp1x02=80d+n9-QK7RudKZ6BSdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 0/4] Add support to LIS2MDL magnetometer sensor
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <ADC7EC14-D285-4160-AB42-AA9483466FD2@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reply to the ft patch adding the cc is fine.

On 17 August 2017 02:52:06 GMT+08:00, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>Jonathan I forgot to add in cc device tree ML. Should I resend?
>
>Regards,
>Lorenzo
>
>On Wed, Aug 16, 2017 at 7:02 PM, Lorenzo Bianconi
><lorenzo.bianconi83@gmail.com> wrote:
>> Fix two interrupt issues for LSM303AGR magn sensor
>>
>> Lorenzo Bianconi (4):
>>   iio: magnetometer: st_magn: fix status register address for
>LSM303AGR
>>   iio: magnetometer: st_magn: remove ihl property for LSM303AGR
>>   iio: magnetometer: add support to LIS2MDL
>>   dt-bindings: iio: magn: add LIS2MDL sensor device binding
>>
>>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>>  drivers/iio/magnetometer/st_magn.h                   | 1 +
>>  drivers/iio/magnetometer/st_magn_core.c              | 5 ++---
>>  drivers/iio/magnetometer/st_magn_i2c.c               | 5 +++++
>>  drivers/iio/magnetometer/st_magn_spi.c               | 5 +++++
>>  5 files changed, 14 insertions(+), 3 deletions(-)
>>
>> --
>> 2.14.0
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
