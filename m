Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 1/2 v6] iio: st_sensors: switch to a threaded interrupt
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>, Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <4f467217-3a09-7dfb-367e-846fd5ac2244@intel.com>
Date: Fri, 13 May 2016 22:04:48 +0300
MIME-Version: 1.0
In-Reply-To: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/10/2016 12:00 PM, Linus Walleij wrote:
> commit 98ad8b41f58dff6b30713d7f09ae3834b8df7ded
> ("iio: st_sensors: verify interrupt event to status") caused
> a regression when reading ST sensors from a HRTimer trigger
> rather than the intrinsic interrupts: the HRTimer may
> trigger faster than the sensor provides new values, and
> as the check against new values available as a cause of
> the interrupt trigger was done in the poll function,
> this would bail out of the HRTimer interrupt with
> IRQ_NONE.
> 
> So clearly we need to only check the new values available
> from the proper interrupt handler and not from the poll
> function, which should rather just read the raw values
> from the registers, put them into the buffer and be happy.
> 
> To achieve this: switch the ST Sensors over to using a true
> threaded interrupt handler.
> 
> In the interrupt thread, check if new values are available,
> else yield to the (potential) next device on the same
> interrupt line to check the registers. If the interrupt
> was ours, proceed to poll the values.
> 
> Instead of relying on iio_trigger_generic_data_rdy_poll() as
> a top half to wake up the thread that polls the sensor for
> new data, have the thread call iio_trigger_poll_chained()
> after determining that is is the proper source of the
> interrupt. This is modelled on drivers/iio/accel/mma8452.c
> which is already using a properly threaded interrupt handler.
> 
> In order to get the same precision in timestamps as
> previously, where samples would be timestamped in the
> poll function pf->timestamp when calling
> iio_trigger_generic_data_rdy_poll() we introduce a
> local timestamp in the sensor data, set it in the top half
> (fastpath) of the interrupt handler and provide that to the
> core when calling iio_push_to_buffers_with_timestamp().
> 
> Additionally: if the active scanmask is not set for the
> sensor no IRQs should be enabled and we need to bail out
> with IRQ_NONE. This can happen if spurious IRQs fire when
> installing the threaded interrupt handler.
> 
> Tested with hard interrupt triggers on LIS331DL, then also
> tested with hrtimers on the same sensor by creating a 75Hz
> HRTimer and using it to poll the sensor.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Tested-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Fixes: 97865fe41322 ("iio: st_sensors: verify interrupt event to status")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch 2 is questionable but this patch works great and fixes a distinct
issue. It should be applied separately.

-- 
Regards,
Leonard
