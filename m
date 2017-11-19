Return-Path: <SRS0=7QOn=CR=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171119164452.4f457021@archlinux>
References: <20171025181609.3803-1-lorenzo.bianconi@st.com>
 <20171025181609.3803-2-lorenzo.bianconi@st.com> <20171026183540.288dfdea@archlinux>
 <CAA2SeN+WGorb6t52euEnVYOp+R8Mxa0_Y9eeM0qo6=-MsnZ3EQ@mail.gmail.com> <20171119164452.4f457021@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 19 Nov 2017 18:24:58 +0100
Message-ID: <CAA2SeNL7FT+S9OjNggZ=rY9jnMaKNoZiF8JMYKSB-TmH-10UKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: add support to UVIS25 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

comments inline.

> On Fri, 27 Oct 2017 15:26:09 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> > On Wed, 25 Oct 2017 20:16:08 +0200
>> > Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>> >
>> > Really minor English comment to start.
>> > add support 'for' UVIS25 sensor
>> >
>>
>> Hi Jonathan,
>>
>> I added regmap support, thanks for the hint, the code is much better :)
>> Just wondering how to manage drdy issue in more elegant way.
>> As you outlined, the problem is due to the fact the trigger interrupt
>> is currently masked
>> but st_uvis25_set_enable() in st_uvis25_read_oneshot() actually
>> enables interrupt generation
>> so during the msleep() we get tons of interrupts if we configured the
>> line as IRQ_TYPE_LEVEL_HIGH.
> Can you clear it with a single read at the start of the read_oneshot?

I guess we could have a potential race doing in that way right?

>
>> One possible solution could be to drop trigger support and push data
>> to iio buffer directly in main irq thread handler (but in this way we
>> are force to use just this kind of trigger).
>> What do you think?
>
> Not ideal... It's another case of hardware doing something unhelpful
> for software.  We'll have to paper over it as usual ;)
>
> Go with which ever route you think works out nicest.

I guess the less ugly approach is to mask the irq line for one-shot reading.
Right, in this case hw is doing something unhelpful for sw guys :)

>
> Sorry for the delay on this reply - I missed your reply on my first
> pass through my emails in amongst the other parts of the thread.
>

No worries, I knew you were traveling :)
Btw I have to send the v2 with a different Signed-off-by, my email
address is no more valid since I moved to a different company

Regards,
Lorenzo

>>
>> Reagrds,
>> Lorenzo
>>
> <snip>
>>
>> >> +
>> >> +     err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
>> >> +     if (err < 0) {
>> >> +             dev_err(hw->dev, "failed to read %02x register\n", addr);
>> >> +             goto unlock;
>> >> +     }
>> >> +
>> >> +     data = (data & ~mask) | ((val << __ffs(mask)) & mask);
>> >> +
>> >> +     err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
>> >> +     if (err < 0)
>> >> +             dev_err(hw->dev, "failed to write %02x register\n", addr);
>> >> +
>> >> +unlock:
>> >> +     mutex_unlock(&hw->lock);
>> >> +
>> >> +     return err < 0 ? err : 0;
>> >> +}
>> >> +
>> >> +int st_uvis25_set_enable(struct st_uvis25_hw *hw, bool enable)
>> >> +{
>> >> +     int err;
>> >> +
>> >> +     err = st_uvis25_write_with_mask(hw, ST_UVIS25_REG_CTRL1_ADDR,
>> >> +                                     ST_UVIS25_REG_ODR_MASK, enable);
>> >> +     if (err < 0)
>> >> +             return err;
>> >> +
>> >> +     hw->enabled = enable;
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static int st_uvis25_read_oneshot(struct st_uvis25_hw *hw, u8 addr, int *val)
>> >> +{
>> >> +     u8 data;
>> >> +     int err;
>> >> +
>> >> +     err = st_uvis25_set_enable(hw, true);
>> >> +     if (err < 0)
>> >> +             return err;
>> >> +
>> >> +     msleep(1500);
>> >
>> > Could drive this off the interrupt rather than disabling the interrupt?
>> > Would that be a little neater (simple completion here).
>> >
>>
>> What do you mean? I did not get you.
> If the interrupt 'stuck' case wasn't occuring you could basically
> let the buffered path run once in order to get the oneshot read.
> Thus you could use an interrupt instead of a sleep.
> Doesn't really matter though.
>
>>
>> >> +
>> >> +     err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
>> >> +     if (err < 0)
>> >> +             return err;
>> >
>> > Is there a potential race here if for some reason we managed to
>> > got to sleep for another conversion?  I think to be completely
>> > safe you need force an additional read after the disable (or
>> > will that fail to clear the data ready?
>> >
>>
>> We can move the read access after the st_uvis25_set_enable(hw, false)
>> in order to avoid an unnecessary read, do you agree?
> You could perhaps get a later reading if you did that?
> I don't suppose it really matters.

The output register will keep the right value since the ODR is just
1Hz, so I guess it does not matter

>>
>> >> +
>> >> +     st_uvis25_set_enable(hw, false);
>> >> +
>> >> +     *val = data;
>> >> +
>> >> +     return IIO_VAL_INT;
>> >> +}
>> >> +
>> >> +static int st_uvis25_read_raw(struct iio_dev *iio_dev,
>> >> +                           struct iio_chan_spec const *ch,
>> >> +                           int *val, int *val2, long mask)
>> >> +{
>> >> +     int ret;
>> >> +
>> >> +     ret = iio_device_claim_direct_mode(iio_dev);
>> >> +     if (ret)
>> >> +             return ret;
>> >> +
>> >> +     switch (mask) {
>> >> +     case IIO_CHAN_INFO_PROCESSED: {
>> >> +             struct st_uvis25_hw *hw = iio_priv(iio_dev);
>> >> +
>> >> +             /*
>> >> +              * mask irq line during oneshot read since the sensor
>> >> +              * does not export the capability to disable data-ready line
>> >> +              * in the register map and it is enabled by default.
>> >> +              * If the line is unmasked during read_raw() it will be set
>> >> +              * active and never reset since the trigger is disabled
>> >> +              */
>> >
>> > Nasty but well documented...
>> >
>> > I wonder if there is a nicer way to handle this... If we leave it on
>> > the issues is that we end up with the status being checked by the interrupt
>> > handler for the trigger (harmless if a waste of time) then the trigger
>> > being fired (with nothing associated with it).  No consumers are attached
>> > so we call notify done for all of them and finally that will result in
>> > a try reenable. You could supply one of those that results in a read
>> > to the device.  It think that would always deal with your case of
>> > the data ready getting stuck high..
>> >
>> > (Not totally sure though as it's been a while since I dealt with a
>> > sensor with this particular issue).
>> >
>> >> +             if (hw->irq > 0)
>> >> +                     disable_irq(hw->irq);
>> >> +             ret = st_uvis25_read_oneshot(hw, ch->address, val);
>> >> +             if (hw->irq > 0)
>> >> +                     enable_irq(hw->irq);
>> >> +             break;
>> >> +     }
>> >> +     default:
>> >> +             ret = -EINVAL;
>> >> +             break;
>> >> +     }



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
