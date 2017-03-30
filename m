Return-Path: <SRS0=zh/i=3H=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Thu, 30 Mar 2017 20:48:13 +0100
In-Reply-To: <CALrZqyMdKLjZAN+zH31nPMYnCrWdeaRjWdUKgGGyOHtzP1ueDw@mail.gmail.com>
References: <20170323183520.GA9871@singhal-Inspiron-5558> <20170323192116.GA6614@d830.WORKGROUP> <CALrZqyNP-8CeAGRr3uDuAhBweT1Sp3H4bWPy8y__7tvnzxR=zw@mail.gmail.com> <20170328183732.GA3808@d830.WORKGROUP> <f942b9c4-e0a9-eb01-ac9f-dc75a8358fea@kernel.org> <CALrZqyMdKLjZAN+zH31nPMYnCrWdeaRjWdUKgGGyOHtzP1ueDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [Outreachy kernel] [PATCH v4] staging: iio: ade7753: Replace mlock with driver private lock
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>,Jonathan Cameron <jic23@kernel.org>
CC: Alison Schofield <amsfield22@gmail.com>,Lars-Peter Clausen <lars@metafoo.de>,Michael Hennerich <Michael.Hennerich@analog.com>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Greg KH <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org,Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,outreachy-kernel <outreachy-kernel@googlegroups.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <6F19C790-695E-4735-988D-8DD7C732F2D9@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 30 March 2017 19:44:26 BST, SIMRAN SINGHAL <singhalsimran0@gmail=2Ecom>=
 wrote:
>On Fri, Mar 31, 2017 at 12:02 AM, Jonathan Cameron <jic23@kernel=2Eorg>
>wrote:
>> On 28/03/17 19:37, Alison Schofield wrote:
>>> On Tue, Mar 28, 2017 at 10:55:17PM +0530, SIMRAN SINGHAL wrote:
>>>> On Fri, Mar 24, 2017 at 12:51 AM, Alison Schofield
><amsfield22@gmail=2Ecom> wrote:
>>>>> On Fri, Mar 24, 2017 at 12:05:20AM +0530, simran singhal wrote:
>>>>>> The IIO subsystem is redefining iio_dev->mlock to be used by
>>>>>> the IIO core only for protecting device operating mode changes=2E
>>>>>> ie=2E Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes=2E
>>>>>>
>>>>>> In this driver, mlock was being used to protect hardware state
>>>>>> changes=2E  Replace it with a lock in the devices global data=2E
>>>>>
>>>>> Hi Simran,
>>>>>
>>>>> Please post all revision histories below the --- not just the most
>>>>> recent=2E
>>>>>
>>>> Sorry, will not repeat this=2E
>>>>
>>>>> Does this lock enforce the needed "atomicity" in the
>write_frequency
>>>>> function? I read Jonathans comment on a previous revision about
>>>>> "ensuring the spi bus frequency and sampling frequency of the
>device
>>>>> are changed in an atomic fashion"
>>>>>
>>>>
>>>> By introducing another lock I am protecting read_modify_write and
>>>> in this way also protecting the designated register that we are
>about
>>>> to write=2E
>>>
>>> I see it protecting this path from being re-entered=2E  My uncertainty
>>> is about other paths to read/write=2E
>>>
>>>>
>>>>> Is it possible for another spi bus transaction (read or write) to
>>>>> occur between the read and write in write_frequency?
>>>>>
>>>>
>>>> Gargi has also come up with a solution=2E
>>>>
>https://groups=2Egoogle=2Ecom/forum/#!topic/outreachy-kernel/kzE9CrI5Bd8
>>>>
>>>> Should I do like her as her's also seem correct or go ahead with
>this=2E
>>>
>>> My suggestion would be to wait for feedback on Gargi's patch=2E
>>> (See the Outreachy log about creating similar solutions=2E)
>>>
>>> We will not be able to close on this set of patches during the
>>> Outreachy application window=2E  You can continue to push for closure
>>> beyond the March 30th date as your time allows :)
>>>
>> It is a close choice between the two approaches=2E In some ways
>> yours is easier to follow, but Gargi's is more elegant=2E
>>
>> Lets go with that one for consistency across similar drivers,
>> but if you had been the original author and done it this way
>> I certainly wouldn't bother asking you to change it!
>
>Yes, jonathan I am the original author=2E

Sorry, I meant of the driver rather than this improvement=2E

Jonathan
>
>>
>> So in conclusion both patches are good=2E
>>
>> Jonathan
>>
>>> Thanks,
>>> alisons
>>>
>>>>
>>>>> alisons
>>>>>>
>>>>>> Signed-off-by: simran singhal <singhalsimran0@gmail=2Ecom>
>>>>>> ---
>>>>>>
>>>>>>  v4:
>>>>>>    -Add mutex_init
>>>>>>
>>>>>>  drivers/staging/iio/meter/ade7753=2Ec | 7 +++++--
>>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/staging/iio/meter/ade7753=2Ec
>b/drivers/staging/iio/meter/ade7753=2Ec
>>>>>> index b71fbd3=2E=2E30aebaf 100644
>>>>>> --- a/drivers/staging/iio/meter/ade7753=2Ec
>>>>>> +++ b/drivers/staging/iio/meter/ade7753=2Ec
>>>>>> @@ -80,11 +80,13 @@
>>>>>>   * @us:         actual spi_device
>>>>>>   * @tx:         transmit buffer
>>>>>>   * @rx:         receive buffer
>>>>>> + * @lock:       protect sensor state
>>>>>>   * @buf_lock:       mutex to protect tx and rx
>>>>>>   **/
>>>>>>  struct ade7753_state {
>>>>>>       struct spi_device   *us;
>>>>>>       struct mutex        buf_lock;
>>>>>> +     struct mutex        lock;  /* protect sensor state */
>>>>>>       u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>>>>>>       u8          rx[ADE7753_MAX_RX];
>>>>>>  };
>>>>>> @@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct
>device *dev,
>>>>>>       if (!val)
>>>>>>               return -EINVAL;
>>>>>>
>>>>>> -     mutex_lock(&indio_dev->mlock);
>>>>>> +     mutex_lock(&st->lock);
>>>>>>
>>>>>>       t =3D 27900 / val;
>>>>>>       if (t > 0)
>>>>>> @@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct
>device *dev,
>>>>>>       ret =3D ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>>>>>>
>>>>>>  out:
>>>>>> -     mutex_unlock(&indio_dev->mlock);
>>>>>> +     mutex_unlock(&st->lock);
>>>>>>
>>>>>>       return ret ? ret : len;
>>>>>>  }
>>>>>> @@ -581,6 +583,7 @@ static int ade7753_probe(struct spi_device
>*spi)
>>>>>>       st =3D iio_priv(indio_dev);
>>>>>>       st->us =3D spi;
>>>>>>       mutex_init(&st->buf_lock);
>>>>>> +     mutex_init(&st->lock);
>>>>>>
>>>>>>       indio_dev->name =3D spi->dev=2Edriver->name;
>>>>>>       indio_dev->dev=2Eparent =3D &spi->dev;
>>>>>> --
>>>>>> 2=2E7=2E4
>>>>>>
>>>>>> --
>>>>>> You received this message because you are subscribed to the
>Google Groups "outreachy-kernel" group=2E
>>>>>> To unsubscribe from this group and stop receiving emails from it,
>send an email to outreachy-kernel+unsubscribe@googlegroups=2Ecom=2E
>>>>>> To post to this group, send email to
>outreachy-kernel@googlegroups=2Ecom=2E
>>>>>> To view this discussion on the web visit
>https://groups=2Egoogle=2Ecom/d/msgid/outreachy-kernel/20170323183520=2EG=
A9871%40singhal-Inspiron-5558=2E
>>>>>> For more options, visit https://groups=2Egoogle=2Ecom/d/optout=2E
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
