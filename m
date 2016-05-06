Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34151 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517AbcEFSb1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2016 14:31:27 -0400
Received: by mail-oi0-f44.google.com with SMTP id k142so148626606oib.1
        for <linux-iio@vger.kernel.org>; Fri, 06 May 2016 11:31:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dc142147-fffe-19ad-5c74-239ab85040b7@intel.com>
References: <1462535191-21131-1-git-send-email-linus.walleij@linaro.org>
	<dc142147-fffe-19ad-5c74-239ab85040b7@intel.com>
Date: Fri, 6 May 2016 20:31:26 +0200
Message-ID: <CACRpkdYjXgh_UFV-W00y1ZzK43mtkxOLpqvqyvUEY=iaZAE2Lg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 6, 2016 at 8:08 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:

>> In order to get the same precision in timestamps as
>> previously, where samples would be timestamped in the
>> poll function pf->timestamp when calling
>> iio_trigger_generic_data_rdy_poll() we introduce a
>> local timestamp in the sensor data, set it in the top half
>> (fastpath) of the interrupt handler and provide that to the
>> core when calling iio_push_to_buffers_with_timestamp().
>
> This doesn't work correctly with software timers. sdata->timestamp won't
> update because st_sensors_irq_handler doesn't get called in this mode.
>
> Easiest fix would be to set pollfunc->timestamp in
> st_sensors_irq_handler. But I don't really know how this is supposed to
> work.

Aha so it is implicit from the construction that whether it is a hardware
IRQ or a hrtimer, the top half must always update the timestamp in
pollfunc-timestamp, that was kind of hard to see :D

What the other threaded driver does is simply add the timestamp
in the trigger handler, like this:

iio_push_to_buffers_with_timestamp(indio_dev, buffer,
                                           iio_get_time_ns());

But that pushes the timestamp away from the sampling time (when
the actual IRQ occurs) so I wanted to avoid that.

But maybe it has no bigger effect on anything anyways...

To updates pf->timestamp I probably need to patch a new function
into the trigger core that does only that. Will look into it.

Yours,
Linus Walleij
