Return-Path: <lars@metafoo.de>
Message-ID: <561CE342.9020700@metafoo.de>
Date: Tue, 13 Oct 2015 12:56:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Daniel Baluta <daniel.baluta@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Cristina Opriceana <cristina.opriceana@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "octavian.purdila@intel.com" <octavian.purdila@intel.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Move IIO Dummy Driver out of staging
References: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com> <561A63EE.5040206@kernel.org> <CAEnQRZDanmW90PifFcsTWLEzFNBUK25vDbcR9_iYVCJh3w4FYA@mail.gmail.com> <2696972F-5414-4DD5-AA66-08254496633D@jic23.retrosnub.co.uk>
In-Reply-To: <2696972F-5414-4DD5-AA66-08254496633D@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/13/2015 07:44 AM, Jonathan Cameron wrote:
> 
> 
> On 12 October 2015 18:59:57 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> <snip>
>>
>>>> +static unsigned instances = 1;
>>>> +module_param(instances, uint, 0);
>>
>> One concern about this. We will still create a default number of
>> 'instances'
>> when using configuration via configfs?
>>
>> I'm not sure we can remove this parameter once the module is moved
>> out of staging, since we break the ABI (?)
> I'm not that bothered about ABI breakage on this one. Not going to break anything
> real after all!

ABI gets only broken if there is somebody to complain about it ;)
