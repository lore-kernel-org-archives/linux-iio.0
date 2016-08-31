Return-Path: <stillcompiling@gmail.com>
Subject: Re: iio channel sync
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Matt Ranostay <mranostay@gmail.com>
References: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com>
 <CAKzfze-T6UqYp05YiGvHzxkV1bupSov0y_-p+0AiOtkbJETiKQ@mail.gmail.com>
 <9706EDAC-1039-4D89-B5D8-CA327FA1E300@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Joshua Clayton <stillcompiling@gmail.com>
Message-ID: <aa577c0c-c18c-26d3-b5c6-16692e813d35@gmail.com>
Date: Wed, 31 Aug 2016 15:47:18 -0700
MIME-Version: 1.0
In-Reply-To: <9706EDAC-1039-4D89-B5D8-CA327FA1E300@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Greetings,

On 08/30/2016 09:26 AM, Jonathan Cameron wrote:
>
> On 30 August 2016 08:41:18 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>> On Mon, Aug 29, 2016 at 10:03 AM, Joshua Clayton
>> <stillcompiling@gmail.com> wrote:
>>> Jonathan,
>>>
>>> I have an out-of tree driver I am working on mainlining.
>>>
>>> The device is a sensor that gets phase and amplitude (x and y) data
>>>
>>> on multiple physical and/or time multiplexed channels.
>>>
>>> It also has up to 4 optical encoders to get physical location.
>>>
>>> The existing driver bundles x and y together with a snapshot
>>>
>>> of the encoder sums at that moment.
>>>
>>>
>>> This seems like a good fit for iio, but one item is bothering me.
>>>
>>> How is synchronization between streams usually handled with
>>>
>>> iio drivers? Timing can be important.
>> Wouldn't the trigger buffer framework be good enough for this?
> Perhaps you could describe your usecase a little more?
>
> Is the interesting bit that you want to sync streams with different sampling frequencies?
> Are those encoders better represented by a separate driver? (In which case I have some thoughts on simple additions to IIO trigger handling that might help - basically a hold off on triggers until all relevant devices are attached)
Thanks for responding.

The encoders (often a pair of them, could be up to 4) represent the position
of the sensor in relation to an object to be tested. (linear movement or
rotation around an axis).
The Maximum sample rate of the encoders is much higher than the sensor,
but they are moved by a motor or by hand, so the actual sample rate is
variable and may be higher or lower that the sensor sample rate.

The encoders are sometimes used as a trigger for data collection, but
the encoders are also used as positional data alongside the sensor data.

The way we get around this now is to bundle a snapshot of the encoder
with the sensor data and discard it later if the encoder hasn't changed and
the trigger function is enabled.
