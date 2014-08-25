Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41743 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaHYHWR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 03:22:17 -0400
In-Reply-To: <CABLc4a_SoUktjQ=27w3=z2p65rgdDY8EKD8mTKZvo7ub6165Cg@mail.gmail.com>
References: <CABLc4a_SoUktjQ=27w3=z2p65rgdDY8EKD8mTKZvo7ub6165Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: help - pushing data to kernel buffers at unequal intervals for different ADC channels
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 25 Aug 2014 08:22:10 +0100
To: Sricharan Chalasani <sricharan.chalasani@gmail.com>,
	linux-iio@vger.kernel.org
Message-ID: <0770b48e-d25e-4b48-90b1-bbe34f74f4f2@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On August 25, 2014 5:06:18 AM GMT+01:00, Sricharan Chalasani <sricharan.chalasani@gmail.com> wrote:
>Hi Jonathan and all,
>
>I have 4 channels on my Analog to digital converter. I like to enable
>all the 4 channels with the following set of commands
>
>Setting up channels in use
>
># echo 1 >
>/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en
># echo 1 >
>/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage1_en
># echo 1 >
>/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage2_en
># echo 1 >
>/sys/bus/iio/devices/iio:device0/scan_elements/in_voltage3_en
>
>
>Setting up the trigger
>
># echo "my_periodic_timer_trigger" >
>/sys/bus/iio/devices/iio:device0/trigger/current_trigger
>
>Setting up buffer length
>
># echo 100 > /sys/bus/iio/devices/iio:device0/buffer/length
>
>Enable the buffer
>
># echo 1 > /sys/bus/iio/devices/iio:device0/buffer/enable
>
>
>Now in my IIO ADC driver data is available at unequal intervals
>meaning that ... (assuming that my ADC trigger handler is called once
>in every 1 milli second)
>
>1. After 1 milli seconds data is available on channel1 only ...
>2. After 2 millli seconds new data is available on channel0 and
>channel2
>3. After 3 milli seconds new data is available on channel0, channel2
>and channel3
>4. After 4 milli seconds new data is available on channel 2 and channel
>channel3
>5. After 5 milli seconds new data is available on channel0. channel1,
>chanel2, channel3
>
>and it goes on like this ..... and my IIO ADC driver knows that on
>which channels data is available at any given point of time ....
>
>
>The idea is to push data to IIO buffer as and when data is available
>on one or more channels. But, I understand that, the following
>function expects that data (second argument to the function) be
>available on all the 4 enabled channels before the function is called.
>
>static inline int iio_push_to_buffers_with_timestamp(struct iio_dev
>*indio_dev, void *data, int64_t timestamp)
>
>Assuming that all the 4 channels are enabled from the user space for
>buffered capture:
>
>1. I understand that IIO supports pushing data to buffer if data is
>available on all the enabled channels.
>
>2. Please let me know if it is possible for me to push data to buffer
>from my IIO ADC driver whenever data is available on any of the
>channels.

Not really as we have no way to describe this flow to user space.  Would 4 separate single channel buffers work for your use case? 

Note this boils down to 4 separate iio devices registered by the one driver.

That is what we have suggested for other such complex capture timings.

The only other option would be to pad with dummy data when a channel is not available but that is really ugly.

J
>
>
>
>Thanks and regards,
>Sricharan.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
