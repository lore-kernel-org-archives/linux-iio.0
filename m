Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdFYQPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jun 2017 12:15:33 -0400
Date: Sun, 25 Jun 2017 17:15:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 0/4] Add OF support to ST sensor framework
Message-ID: <20170625171528.55d48ee4@kernel.org>
In-Reply-To: <20170625152413.22325-1-lorenzo.bianconi@st.com>
References: <20170625152413.22325-1-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Jun 2017 17:24:09 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Changes since v1:
> - add missing devices to {accel, magn, gyro, press} of_device_id table
> 
> Lorenzo Bianconi (4):
>   iio: accel: st_accel_spi: add OF capability to st_accel_spi
>   iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
>   iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
>   iio: pressure: st_pressure_spi: add OF capability to st_pressure_spi
I am going to let the series as a whole sit a little while to see
if anyone has a better way of dealing with the prefixes we added in the past
that aren't really right for devicetree bindings.

Jonathan
> 
>  drivers/iio/accel/st_accel_spi.c       | 67 ++++++++++++++++++++++++++++++----
>  drivers/iio/gyro/st_gyro_spi.c         | 53 +++++++++++++++++++++++++++
>  drivers/iio/magnetometer/st_magn_spi.c | 25 +++++++++++++
>  drivers/iio/pressure/st_pressure_spi.c | 33 +++++++++++++++++
>  4 files changed, 170 insertions(+), 8 deletions(-)
> 

