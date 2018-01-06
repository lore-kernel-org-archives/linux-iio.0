Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37036 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbeAFMbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jan 2018 07:31:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id o13so3055143pgp.4
        for <linux-iio@vger.kernel.org>; Sat, 06 Jan 2018 04:31:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180106122120.3c79810e@archlinux>
References: <20180101185444.22045-1-lorenzo.bianconi@redhat.com> <20180106122120.3c79810e@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sat, 6 Jan 2018 13:31:15 +0100
Message-ID: <CAA2SeNLUiBB5iPDUEkWg0Dh8YdBjyt64ZJ7D+ZUjvLyAkUKN-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] add regmap API support to st_lsm6dsx iio driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Mon,  1 Jan 2018 19:54:41 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> Would have been nice to have a brief bit of text saying why...
>
> Whilst I know all the advantages, that may not be the case for
> someone new to the area who might read your series.
>

Ack, I will do in v2..can I send just regmap API patch since you have
just applied the first two?
Regards,

Lorenzo

> Thanks,
>
> Jonathan
>
>
>> Lorenzo Bianconi (3):
>>   iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
>>   iio: imu: st_lsm6dsx: introduce conf_lock mutex
>>   iio: imu: st_lsm6dsx: add regmap API support
>>
>>  drivers/iio/imu/st_lsm6dsx/Kconfig             |   2 +
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  33 ++------
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 102 +++++++++++++++--------
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 111 +++++++++++--------------
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  55 ++++--------
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  70 ++++------------
>>  6 files changed, 153 insertions(+), 220 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
