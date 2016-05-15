Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <de2cc75b-4d17-0fb5-e754-8a30f3bdb893@kernel.org>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
	<de2cc75b-4d17-0fb5-e754-8a30f3bdb893@kernel.org>
Date: Sun, 15 May 2016 21:10:53 +0200
Message-ID: <CACRpkda6Szkz__r6E_+qzUO819gX=bncFbBedmDKUFERYrSNJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v6] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, May 14, 2016 at 6:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/05/16 10:00, Linus Walleij wrote:

>> +             /*
>> +              * If this was not caused by any channels on this sensor,
>> +              * return IRQ_NONE
>> +              */
>> +             if (!indio_dev->active_scan_mask)
>> +                     return IRQ_NONE;
>
> I'm wondering if this is the right check...   It might be racey with a buffer
> being disabled.

It needs to be there if we get a spurious interrupt before any channels
are enabled, as at that point ->active_scan_mask is NULL and
will cause a segfault also it bit me for real, so not just a theoretical
point.

> Take mlock around the check perhaps? + the use of it below.  I haven't
> thought this through enough to be sure that's sufficient though...

I don't see how ->mlock would help? The code in e.g.
iio_enable_buffers() is just optimistically setting ->active_scan_mask
with no locks held. This NULL check is *only* for the case where an
IRQ fires after the buffer has been registered but before the buffer is enabled,
(or after the buffer is disabled, but the IRQ still fires for some reason)
it seems safe to me?

>> +             if (!(status & (u8)indio_dev->active_scan_mask[0]))
>> +                     return IRQ_NONE;
>
> A bitmap comparison might be more elegant.

I guess, but the whole logic of these ST sensors drivers are quite brutally
just assuming bits 0,1,2 in the active_scan_mask is equal to
axis x,y,z, c.f.:

st_accel_buffer_postenable():
err = st_sensors_set_axis_enable(indio_dev,
                                        (u8)indio_dev->active_scan_mask[0]);
(...)

Which goes here:

int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
{
        struct st_sensor_data *sdata = iio_priv(indio_dev);

        return st_sensors_write_data_with_mask(indio_dev,
                                sdata->sensor_settings->enable_axis.addr,
                                sdata->sensor_settings->enable_axis.mask,
                                axis_enable);
}

I.e. just writing the value of active_scan_mask into the register as you can
see. (Not elegant, but I did not write this code.)

The status check follows the same 1:1 mapping pattern so as to not
fuzz things up. If we change that we should make a separate patch
fixing this design pattern to do bitmap operations everywhere I think.

> Also I would suggest it would
> be neater to mask status to only have the relevant bits - not technically
> necessary as those are the only ones that should overlap with the scan_mask
> but neater none the less.

It relies on the same pattern and any other bits than 0,1,2 of active_scan_mask
being zero indeed. I can &= 3 the status register first, I'll send a patch with
that change once we agree on the rest.

Yours,
Linus Walleij
