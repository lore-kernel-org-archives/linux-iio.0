Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44920 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbcICPbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 11:31:47 -0400
Subject: Re: A potential race in drivers/iio/adc/vf610_adc.ko
To: Pavel Andrianov <andrianov@ispras.ru>
References: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaishali Thakkar <vaishali.thakkar@oracle.com>,
        ldv-project@linuxtesting.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bdc8ff42-d4a2-8701-45de-4c8ab6657571@kernel.org>
Date: Sat, 3 Sep 2016 16:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 09:05, Pavel Andrianov wrote:
> 

> Hi!
Hi Pavel,
> 
> There is a potential race in drivers/iio/adc/vf610_adc.ko. Handlers
> vf610_set_conversion_mode and vf610_write_raw are called via
> device_attibute interface, but they are related to different
> attributes, so may be executed in parallel. vf610_set_conversion_mode
> acquires the mutex indio_dev->mlock, and vf610_write_raw does not.
> Thus updating the structure 'info' may be performed simultaneously.
> 
> Should vf610_write_raw also acquire the same mutex indio_dev->mlock?
> 

As Alison observed, mlock is not a general purpose lock for use by
drivers. It's there to prevent state changes between direct reads
(polled) and buffered/triggered reads (pushed).

The write raw simply sets the sampling frequency. That's not a problem
whilst buffered capture is running or otherwise.  Interesting question
of whether changing mode causes any trouble as well.  It's possible 
something is undefined in the hardware during a mode change...

Anyhow, that covers mlock.  Next question: Is there a race condition in
general?

Yes there definitely is as we have read modify write cycles
on VF610_REG_ADC_CFG in both paths.  So what is needed is a local lock
to protect these accesses.  Whilst in theory mlock could be used
it should not be as it has a clearly stated purpose and using it
for other purposes makes for much fiddlier and harder to read code!

(as an aside IIRC there is no locking in sysfs attributes to prevent
a single attribute being read twice at the same time.)

Jonathan
