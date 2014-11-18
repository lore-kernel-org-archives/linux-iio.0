Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <20141118134907.B4DF940375@saturn.retrosnub.co.uk>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-9-git-send-email-octavian.purdila@intel.com>
	<20141118134907.B4DF940375@saturn.retrosnub.co.uk>
Date: Tue, 18 Nov 2014 17:31:09 +0200
Message-ID: <CAE1zotK0nwjJkhXCx27Q8wn8RrGyLKx-BtZc7eHr=EGz2mKb5A@mail.gmail.com>
Subject: Re: [RFC 8/8] iio: bmc150: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 18, 2014 at 3:49 PM,  <jic23@kernel.org> wrote:
> Octavian Purdila writes:
>>
>> This patch adds support for hardware fifo. Fifo and stream mode are
>> supported as well as fifo-full and fifo-watermark events.
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>
> A few minor bits inline.  The implementation seems fine, I am just
> unconvinced that the user interface is the best way to go.
>

Of course, I didn't expect to get the right interface :) This was
suppose to be just code support for discussing it (the interface).

>> +
>> +       if (!data->timestamp)
>> +               data->timestamp = iio_get_time_ns();
>> +
>> +       tstamp = data->timestamp - count * sample_freq;
>
>
> Hmm... These are likely to be less than accurate...
>

Yes, especially for fifo mode (for stream should be close).
Unfortunately the hardware doesn't store any sort of timestamp in the
buffer, so any ideas of how can we improve this?

>> +static int bmc150_accel_fifo_mode_set(struct iio_dev *indio_dev,
>> +                                     const struct iio_chan_spec *chan,
>> +                                     unsigned int mode)
>> +{
>> +       struct bmc150_accel_data *data = iio_priv(indio_dev);
>> +       int ret;
>> +       u8 val;
>> +
>> +       switch (mode) {
>> +       case 0:
>
> Some defines and a local enum should get rid of the magic numbers here.

You're right, I'll update that.

Thanks for taking the time to look at these patches Jonathan, I know
that you are very busy.
