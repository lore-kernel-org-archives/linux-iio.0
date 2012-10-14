Return-Path: <lars@metafoo.de>
Message-ID: <507B0DC5.5050807@metafoo.de>
Date: Sun, 14 Oct 2012 21:08:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 Denis CIOCCA <denis.ciocca@st.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com>	<5073260C.3010506@metafoo.de>	<20121008195007.GA32042@elf.ucw.cz>	<507338B5.60307@metafoo.de>	<665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
In-Reply-To: <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/14/2012 05:05 PM, Denis Ciocca wrote:
> Hi guys,
> 
> according to your requests I have modified my driver. Only one things
> about this function:
> 
> static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> 
> You tell to me:
> 
>> In buffered mode the samples should not be postprocessed. Userspace expects the
>> samples in the format as described by the scan_type. The buffer demuxing should
>> be handled by the IIO core. If you set up available_scan_masks correctly it
>> will automatically do the right thing.
> 
> I agree with you for the postprocessed samples part, but I don't understand very
> well the second one.
> I saw the other drivers, if I check only the available_scan_masks variable
> I don't know which channels are actives and which not.
> I will read every time all data channels, but I choose which channel
> put in the buffer.

You can tell the IIO core that you can only handle certain combinations of
channels which can be sampled at the same time. E.g. in you case there is only
one possible combination, which is that all channels are always sampled. If in
userspace only a subset of that list is selected the IIO core will take of only
passing those samples on to userspace which it actually requested.

Right now you do this by hand in your driver. But if you setup
scan_masks_available for you IIO device with only one scan mask which has all
channels set you can skip that step and just pass the buffer containing all
samples on to the IIO core and it will take care of picking those out which are
actually needed. There are a few examples of this, grep for
available_scan_masks to find them.

I now there are also some examples of IIO drivers which do what you did in your
driver, but these are older drivers which were written when the demuxing
infrastructure in the core was not in place. But the plan is to switch this
over as we continue to improve the existing drivers.

Will try take a look at the new patch tomorrow.

- Lars
