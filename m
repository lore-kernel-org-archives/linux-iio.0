Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2015 17:06:54 +0200
From: <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Richard Weinberger <richard@nod.at>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] iio: dht11: Use new function =?UTF-8?Q?ktime=5Fget=5Fre?=
 =?UTF-8?Q?solution=5Fns=28=29?=
In-Reply-To: <55991FEA.50703@kernel.org>
References: <1428405156-6761-1-git-send-email-harald@ccbib.org> <1428405156-6761-3-git-send-email-harald@ccbib.org> <55267AEC.8000500@kernel.org> <E1Z9eHR-00014C-6g@stardust.g4.wien.funkfeuer.at> <55919E72.3010807@gmx.de> <02a909f41c0b1c16251d016d71ac86bc@imap.cosmopool.net> <55991FEA.50703@kernel.org>
Message-ID: <74036b56526db70333507c1f171531bc@imap.cosmopool.net>
List-ID: <linux-iio@vger.kernel.org>

On Sun, 05 Jul 2015 13:15:38 +0100, Jonathan Cameron <jic23@kernel.org>
wrote:
> On 30/06/15 20:37, harald@ccbib.org wrote:
>> Thanks for pointing out --strict - didn't know about that yet.
>> 
>> I get the following output:
>> 
>> CHECK: spaces preferred around that '*' (ctx:VxV)
>> #96: FILE: drivers/iio/humidity/dht11.c:167:
>> +               if (DHT11_DATA_BIT_HIGH < 2*timeres) {
>>                                            ^
>> 
>> With this one I disagree. Omitting the spaces makes the code easier to
>> read, because it reflects the relative binding power of operators
>> involed.
>> This style (omitting spaces around * if there is a +, <, etc in the
same
>> experession) is used throughout the driver. I'd change this only if
there
>> is consensus, that this really is the preferred way.
> Personal taste wise I agree with you, but conventions are conventions
> and the kernel way is spaces around binary operators to distinguish them
> from unary operators...
> 
> I'll only get a newbie patch 'fixing' this otherwise, so please do
change
> it!

Of course you have the last word on this. As long as the newbies are
competent enough to really only do whitespace changes, I'd be tempted
to wait for them to do the work. Alas I really want the original patch
merged soon so I will do the obfuscation myself.

Thanks,
Harald the newbie :)
