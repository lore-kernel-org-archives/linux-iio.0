Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <557D5562.8020209@kernel.org>
References: <20150611120635.GA15709@Inspiron>
	<557D5562.8020209@kernel.org>
Date: Sun, 21 Jun 2015 16:57:43 +0300
Message-ID: <CAEnQRZCHxqkLO5ox2em7guJdp3x-wyP9CZRC656HcZPcptNLCg@mail.gmail.com>
Subject: Re: [PATCH] iio: Fix parameters in iio_triggered_buffer_setup
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Cristina Opriceana <cristina.opriceana@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 14, 2015 at 1:20 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 11/06/15 13:06, Cristina Opriceana wrote:
>> This patch renames the top half handler and the bottom half handler
>> of iio_triggered_buffer_setup() in accordance with their usage.
>> The names of the parameters were swapped, thus creating confusion.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> Good point.  This is definitely misleading.  I wonder if the _th naming
> is a good idea anymore though given that the bottom half (in the traditional
> sense) is now a thread based call and hence the th might be confusing?
> Perhaps the h and thread naming used in the pollfunc code would be clearer?
>

Sounds like a good idea. Cristina can prepare a patch for this.

> Lars, this bit was yours originally.  Any thoughts?

Lets wait for Lars thoughts on this.

Daniel.
