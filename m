Return-Path: <SRS0=qvTI=24=gmail.com=gs051095@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e2f98c2b-8d75-4595-0634-8581403df2c0@kernel.org>
References: <20170312133250.GA7772@singhal-Inspiron-5558> <6e55c61d-7587-4191-1fc5-de43e26986d7@metafoo.de>
 <CAOCi2DH8xVeD8_sZtxg9jqaF_29D9zEQSBR8-pYNRAbnmESNyQ@mail.gmail.com> <e2f98c2b-8d75-4595-0634-8581403df2c0@kernel.org>
From: Gargi Sharma <gs051095@gmail.com>
Date: Sun, 19 Mar 2017 18:46:14 +0530
Message-ID: <CAOCi2DF=KQ9c4Trd_C_L8DsyeBeJehh-TCpOswgVWwsNoyz+Bg@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: iio: ade7753: replace
 mlock with driver private lock
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, simran singhal <singhalsimran0@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Pete Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 19, 2017 at 4:01 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 17/03/17 09:32, Gargi Sharma wrote:
>> On Mon, Mar 13, 2017 at 5:30 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>
>>> On 03/12/2017 02:32 PM, simran singhal wrote:
>>>> The IIO subsystem is redefining iio_dev->mlock to be used by
>>>> the IIO core only for protecting device operating mode changes.
>>>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>>>
>>>> In this driver, mlock was being used to protect hardware state
>>>> changes.  Replace it with a lock in the devices global data.
>>>>
>>>> Fix some coding style issues related to white space also.
>>>>
>>>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>>>> ---
>>>>  drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>>>> index dfd8b71..ca99d82 100644
>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>> @@ -81,12 +81,14 @@
>>>>   * @tx:         transmit buffer
>>>>   * @rx:         receive buffer
>>>>   * @buf_lock:       mutex to protect tx and rx
>>>> + * @lock:    protect sensor state
>>>
>>> It might make sense to reuse the existing lock which currently protects the
>>> read/write functions. You can do this by introducing a variant of
>>> ade7753_spi_{read,write}_reg_16() that does not take a lock and use these to
>>> implement the read-modify-write cycle in a protected section.
>>
>> There are other read/write functions for example,
>> ade7753_spi_{read/write}_reg_8 that use the mutex as well. Should a
>> variant of these functions be introduced as well? Also, how does one
>> go about implementing RMW inside a protected section.
> Hmm. Simran has also been progressing with patches for this.
>
I was trying to work through a patch for ade7754. So ran into the same
problem :)

> You raise a good question. There are other read/modify/write sequences in
> the driver.  They don't have the same issue with potentially deadlocking
> against the buf lock as they are all using the spi subsystems provisions
> for small write/read cycles where buffer protection is handled internally.
>
> So let us address the cases in turn:
>
> static int ade7753_reset(struct device *dev)
> {
>         u16 val;
>         int ret;
>
>         ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
>         if (ret)
>                 return ret;
>
>         val |= BIT(6); /* Software Chip Reset */
>
>         return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
> }
> This is only called in the device initialization.  At that point
> we should be fine in assuming no parallel calls.  Crucial point
> is it is before the call to iio_device_register which exposes
> the userspace interfaces.
>
> static int ade7753_set_irq(struct device *dev, bool enable)
> {
>         int ret;
>         u8 irqen;
>
>         ret = ade7753_spi_read_reg_8(dev, ADE7753_IRQEN, &irqen);
>         if (ret)
>                 goto error_ret;
>
>         if (enable)
>                 irqen |= BIT(3); /* Enables an interrupt when a data is
>                                   * present in the waveform register
>                                   */
>         else
>                 irqen &= ~BIT(3);
>
>         ret = ade7753_spi_write_reg_8(dev, ADE7753_IRQEN, irqen);
>
> error_ret:
>         return ret;
> }
>
> This one is actually safe because it is the only function that
> modifies that particular register.
>
> /* Power down the device */
> static int ade7753_stop_device(struct device *dev)
> {
>         u16 val;
>         int ret;
>
>         ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
>         if (ret)
>                 return ret;
>
>         val |= BIT(4);  /* AD converters can be turned off */
>
>         return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
> }
>
> Only called in remove (after userspace interfaces have been
> removed by the iio_device_unregister call so also should not
> be running concurrently with much else.
>

The only nested lock here is ade7754_spi_write_reg_16, so as long as
that is refactored, it'll be fine.

> So I think all the other cases are safe.  Perhaps it would have
> been better to have had a lock around them, purely to make
> the code more resilient against future changes though.
> Probably a job to do as part of a larger scale pile of work
> on that driver rather than as a one off patch.

Another question that I have is why are we writing inside a read
function(ade7754_spi_read_reg_24)?

static int ade7754_spi_read_reg_24(struct device *dev,
                                   u8 reg_address, u32 *val)
{
        struct iio_dev *indio_dev = dev_to_iio_dev(dev);
        struct ade7754_state *st = iio_priv(indio_dev);
        int ret;
        struct spi_transfer xfers[] = {
                {
                        .tx_buf = st->tx,
                        .rx_buf = st->rx,
                        .bits_per_word = 8,
                        .len = 4,
                },
        };

        mutex_lock(&st->buf_lock);
        st->tx[0] = ADE7754_READ_REG(reg_address);
        st->tx[1] = 0;
        st->tx[2] = 0;
        st->tx[3] = 0;

        ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
        if (ret) {
                dev_err(&st->us->dev, "problem when reading 24 bit
register 0x%02X",
                        reg_address);
                goto error_ret;
        }
        *val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];

error_ret:
        mutex_unlock(&st->buf_lock);
        return ret;
}

Thanks!
Gargi

>
> Jonathan
>
>
>
>
>
>
>
>>
>>
>>>
>>> Looking through the driver there seem to be other places as well that do
>>> read-modify-write that should be protected by a lock, but currently are not.
>>> This might be a good task.
>>
>> Am I right in understanding that we want to introduce mutex lock for
>> writes in other drivers as well?
>>
>> Thanks,
>> Gargi
>>>
>>>>   **/
>>>>  struct ade7753_state {
>>>> -         struct spi_device   *us;
>>>> -                 struct mutex        buf_lock;
>>>> -                         u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>>>> -                                 u8          rx[ADE7753_MAX_RX];
>>>> +     struct spi_device   *us;
>>>> +     struct mutex        buf_lock;
>>>> +     struct mutex        lock;       /* protect sensor state */
>>>> +     u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>>>> +     u8          rx[ADE7753_MAX_RX];
>>>>  };
>>>>
>>>>  static int ade7753_spi_write_reg_8(struct device *dev,
>>>> @@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>>>       if (!val)
>>>>               return -EINVAL;
>>>>
>>>> -     mutex_lock(&indio_dev->mlock);
>>>> +     mutex_lock(&st->lock);
>>>>
>>>>       t = 27900 / val;
>>>>       if (t > 0)
>>>> @@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>>>       ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>>>>
>>>>  out:
>>>> -     mutex_unlock(&indio_dev->mlock);
>>>> +     mutex_unlock(&st->lock);
>>>>
>>>>       return ret ? ret : len;
>>>>  }
>>>>
>>>
>>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
