Return-Path: <lars@metafoo.de>
Message-ID: <54FDA14D.3010803@metafoo.de>
Date: Mon, 09 Mar 2015 14:34:05 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 abhijit <abhijitnaik27@gmail.com>,
 linux-iio@vger.kernel.org, Patrick Vasseur <patrick.vasseur@c-s.fr>,
 Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: AD7923 sequencer functionality implementation in Kernel
References: <54FD2F9A.2070502@gmail.com> <54FD9CD9.3080306@kernel.org>
In-Reply-To: <54FD9CD9.3080306@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/09/2015 02:15 PM, Jonathan Cameron wrote:
> On 09/03/15 05:28, abhijit wrote:
>> Hi All,
>>
>> We are using AD7923 driver as reference for one of our customer's ADC IP
>>
>> The ADC that we are using, has sequencer functionality. In current state of AD7923 driver, there is no support for sequencer functionality.
>>
>> Can you please let me know whether the IIO driver team is coming up with design for sequencer functionality of the device.
> Cc'd Lars, Michael and Patrick.  Looks like a fairly standard sequencer.
> Just a question of whether anyone has already looked at it.

I've been tormenting my head now for a while how to properly model 
sequencers in IIO, but haven't come to a conclusion yet.

The problem is you have one physical channel but a configurable amount of 
logical channels. The ADC will cycle through the selected channels one after 
another.

IIO on the other hand expects that all channels that are selected are 
actually converted at the same time. E.g. you have to supply all the 
selected channels at the same time to iio_buffer_push_data() and also 
metadata, like the timestamps, is expected to be supplied only once for 
every set of samples and not for every individual logical channel.

Furthermore things like the output data rate of each channel depend on the 
number of selected channels. So if you configure the sample rate and then 
change the number of selected channels you potentially end up with a 
different sample rate than initially selected.

- Lars
