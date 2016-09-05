Return-Path: <lars@metafoo.de>
Subject: Re: iio_push_event() race conditions
To: Jonathan Cameron <jic23@kernel.org>,
 Daniel Baluta <daniel.baluta@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <0e1e64ac-5c40-6319-1132-e5d7b2478f01@metafoo.de>
 <58a59b36-b528-038f-38ed-7ce1b1e9f35f@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e322d764-45a7-da49-b70d-9a8626d1b1d9@metafoo.de>
Date: Mon, 5 Sep 2016 14:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <58a59b36-b528-038f-38ed-7ce1b1e9f35f@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/03/2016 05:33 PM, Jonathan Cameron wrote:
[...]
>> I'm a bit conflicted on what is the best way to resolve this. On one hand
>> the correct approach appears to be to simply delay the requesting of the IRQ
>> until iio_device_register() has completed. 
> I'm not keen on the churn that would cause.
>> On the other hand it is possible
>> to argue that users should be able to expect that it is safe to call APIs
>> that take a struct iio_dev if iio_device_alloc() succeeded.
> Agreed.  This is explicitly allowed in the equivalent in input.
> 
> See input_event in input.c description text.

Ok, than lets go with that.

Thanks,
- Lars
