Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40541 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbeKLDYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 22:24:31 -0500
MIME-Version: 1.0
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com> <20181111164655.786268b0@archlinux>
In-Reply-To: <20181111164655.786268b0@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 11 Nov 2018 18:35:11 +0100
Message-ID: <CAA2SeN+P2r5xEj9pn7KPR+OvJvDpqVXfvbE5YjaYOWivH+Tzqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] add i2c controller support to st_lsm6dsx driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>
> On Sun, 11 Nov 2018 15:15:27 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > Introduce i2c controller support to st_lsm6dsx driver for lsm6dso sensor.
> > st_lsm6dsx sensor-hub supports up to 3 concurrent slave devices.
> > Add register map for lis2mdl magnetometer sensor.
> > Add hw FIFO support to st_lsm6dsx sensorhub driver.
> Hi Lorenzo.

Hi Jonathan,

>
> A very nice series in general, though I did make a small change in patch 6
> so please check I didn't mess that up.  It seemed fairly obvious but I've
> been wrong on obvious things many times before :)
>

Thx for the fast review :) Looking at the code I think it is fine.
Moreover I guess we
can generalize it taking into account different channel lengths (e.g. if we want
to connect a pressure sensor). I will send a follow-up patch.

Regards,
Lorenzo

> Thanks,
>
> Jonathan
>
