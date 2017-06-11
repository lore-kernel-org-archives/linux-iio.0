Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41474 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdFKLJy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jun 2017 07:09:54 -0400
Date: Sun, 11 Jun 2017 12:09:52 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: spi 3wire support for ST MEMs sensors
Message-ID: <20170611120952.17624c24@jic23.retrosnub.co.uk>
In-Reply-To: <CAA2SeNJKoERD=ejx8ip=4fhdjB7AY8-9KZyndnnFyvcfU0TohQ@mail.gmail.com>
References: <CAA2SeNJKoERD=ejx8ip=4fhdjB7AY8-9KZyndnnFyvcfU0TohQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Jun 2017 11:30:00 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Hi all,
> 
> I started working on supporting spi-3wire mode in some STM MEMs
> drivers and I am facing a tricky issue. Let's consider the driver for
> LSM303AGR accel device
> (http://www.st.com/resource/en/datasheet/lsm303agr.pdf). The sensor is
> configured by default in spi 4 wire mode (BIT 0 in register 0x23) but
> the package does not export the MISO line for accelerometer. The only
> way to support spi is to enable 3-wire at bootstrap. I am wondering
> how to figure out the correct register address since it is not
> possible to read the device whoami. The only way that come up to my
> mind is to add a lookup table in st_accel_spi.c based on
> spi_device_id. Is there something better? Or should I just remove the
> spi support for LSM303AGR? Thanks
> 
> Regards,
> Lorenzo
> 

Hi Lorenzo,

Look up table is probably the best option when a device only supports
3 wire mode.

However, don't we need DT of ACPI to provide info on whether a 3 wire
bus is being used?  If so can we query it from the spi core?

Jonathan
