Return-Path: <SRS0=f3yP=NF=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
To: Himanshu Jha <himanshujha199640@gmail.com>,
 Renato Lui Geh <renatogeh@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 alexandru.Ardelean@analog.com, stefan.popa@analog.com,
 giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 kernel-usp@googlegroups.com
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
 <20181025142635.3apgyaxzhr73kehc@renatolg>
 <20181025145520.GA16950@himanshu-Vostro-3559>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2007f2b3-5d1a-14c6-4c98-1d9faf6d21bf@metafoo.de>
Date: Thu, 25 Oct 2018 18:01:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181025145520.GA16950@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/25/2018 04:55 PM, Himanshu Jha wrote:
> On Thu, Oct 25, 2018 at 11:26:36AM -0300, Renato Lui Geh wrote:
>> Hi,
>>
>> Thanks for the quick review. :)
>>
>>> But please create one patch per issue and do not put unrelated changes into
>>> the same patch.
>>
>> Should I resend this patch as a patchset containing the two changes?
> 
> Yes! "One patch per change policy"
> 
>>> Also your mail client seems to have replaced tabs in the patch with spaces,
>>> this means the patch will not apply cleanly. Check the
>>> Documentation/email-clients.txt file for some hints how to configure your
>>> mail client so it will not break patches.
>>
>> From my end my original email patch appears to have tabs instead of
>> spaces. I redownloaded my email and vim shows that the indentation has
>> the ^I tab characters. But when downloading your reply it was converted
>> to spaces. Am I missing something?
> 
> Your patch applies fine.
> 
> I think the problem is on Lars end due to Thunderbird.

Yeah, looks like I need to read email-clients.txt...

I think it is mis-rendered on my side due to the "Content-Type: ...
format=flowed" in the header.
