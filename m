Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753340AbeAFO0b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 09:26:31 -0500
Date: Sat, 6 Jan 2018 14:26:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] add regmap API support to st_lsm6dsx iio driver
Message-ID: <20180106142627.6a2510a3@archlinux>
In-Reply-To: <CAA2SeNLUiBB5iPDUEkWg0Dh8YdBjyt64ZJ7D+ZUjvLyAkUKN-A@mail.gmail.com>
References: <20180101185444.22045-1-lorenzo.bianconi@redhat.com>
        <20180106122120.3c79810e@archlinux>
        <CAA2SeNLUiBB5iPDUEkWg0Dh8YdBjyt64ZJ7D+ZUjvLyAkUKN-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 6 Jan 2018 13:31:15 +0100
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> > On Mon,  1 Jan 2018 19:54:41 +0100
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> >
> > Would have been nice to have a brief bit of text saying why...
> >
> > Whilst I know all the advantages, that may not be the case for
> > someone new to the area who might read your series.
> >  
> 
> Ack, I will do in v2..can I send just regmap API patch since you have
> just applied the first two?
> Regards,
Actually I applied all 3 but forgot to say that on the 3rd.

ooops.  Stuff I suggested there wasn't about the content of the
patch afterall.

Jonathan
> 
> Lorenzo
> 
> > Thanks,
> >
> > Jonathan
> >
> >  
> >> Lorenzo Bianconi (3):
> >>   iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
> >>   iio: imu: st_lsm6dsx: introduce conf_lock mutex
> >>   iio: imu: st_lsm6dsx: add regmap API support
> >>
> >>  drivers/iio/imu/st_lsm6dsx/Kconfig             |   2 +
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  33 ++------
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 102 +++++++++++++++--------
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 111 +++++++++++--------------
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  55 ++++--------
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  70 ++++------------
> >>  6 files changed, 153 insertions(+), 220 deletions(-)
> >>  
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
> 
> 

