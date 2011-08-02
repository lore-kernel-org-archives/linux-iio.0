Return-Path: <bjdooks@googlemail.com>
Message-ID: <4E382924.2050201@googlemail.com>
Date: Tue, 02 Aug 2011 17:43:16 +0100
From: Ben Dooks <bjdooks@googlemail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
 LKML <linux-kernel@vger.kernel.org>
Subject: uses of irq_to_gpio() in drivers/staging/iio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Whilst looking in drivers/staging/iio/accel/lis3l02dq_core.c, I
came across the following lines of code

    708          if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
    709                  ret = request_threaded_irq(st->us->irq,
    710                                             &lis3l02dq_th,
    711 
&lis3l02dq_event_handler,
    712                                             IRQF_TRIGGER_RISING,
    713                                             "lis3l02dq",
    714                                             indio_dev);

Which gives rise to the following questions:

1) IRQ0 and GPIO0 are often valid numbers for GPIOs.

2) Not all interrupts are necessarily GPIO interrupts. What happens
    if the device is attached to a hardware interrupt line which is
    not a GPIO?

-- 
Ben Dooks <bjdooks@googlemail.com> http://www.fluff.org/ben/
