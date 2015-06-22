Return-Path: <lars@metafoo.de>
Message-ID: <5587C6AB.8070903@metafoo.de>
Date: Mon, 22 Jun 2015 10:26:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Cristina Opriceana <cristina.opriceana@gmail.com>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "octavian.purdila@intel.com" <octavian.purdila@intel.com>
Subject: Re: [PATCH] iio: Fix parameters in iio_triggered_buffer_setup
References: <20150611120635.GA15709@Inspiron>	<557D5562.8020209@kernel.org> <CAEnQRZCHxqkLO5ox2em7guJdp3x-wyP9CZRC656HcZPcptNLCg@mail.gmail.com>
In-Reply-To: <CAEnQRZCHxqkLO5ox2em7guJdp3x-wyP9CZRC656HcZPcptNLCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/21/2015 03:57 PM, Daniel Baluta wrote:
> On Sun, Jun 14, 2015 at 1:20 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 11/06/15 13:06, Cristina Opriceana wrote:
>>> This patch renames the top half handler and the bottom half handler
>>> of iio_triggered_buffer_setup() in accordance with their usage.
>>> The names of the parameters were swapped, thus creating confusion.
>>>
>>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
>> Good point.  This is definitely misleading.  I wonder if the _th naming
>> is a good idea anymore though given that the bottom half (in the traditional
>> sense) is now a thread based call and hence the th might be confusing?
>> Perhaps the h and thread naming used in the pollfunc code would be clearer?
>>
>
> Sounds like a good idea. Cristina can prepare a patch for this.
>
>> Lars, this bit was yours originally.  Any thoughts?

Jonathan, that's your naming convention I merely added the wrapper function.

I'm OK with changing the naming.
