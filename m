Return-Path: <richard@nod.at>
Message-ID: <547DFDD8.1010404@nod.at>
Date: Tue, 02 Dec 2014 18:58:48 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, sanjeev_sharma@mentor.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dht11: Add locking
References: <1417465651-16036-1-git-send-email-richard@nod.at> <E1XvkMu-000137-KP@stardust.g4.wien.funkfeuer.at> <547D99DE.6030309@nod.at> <E1XvmLC-0001BT-F3@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1XvmLC-0001BT-F3@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Harald,

Am 02.12.2014 um 13:14 schrieb Harald Geyer:
>>> Move the locking out of the if statement.
>>
>> Care to explain why?
> 
> The purpose of the if statement is to limit the number of data
> transmissions if values are requested multiple times in short
> succession. (Ie an application reading both sensor values.)
> 
> If we have concurrent reads, then the later one will wait in the
> mutex_lock() while the former will update the timestamp. If the
> later one resumes, it won't check the timestamp and cause an
> unnecessary data transmission.

Okay, makes sense.
I'll update my patch!

>  
>> But I found another issue in my patch.
>> The "dht11->num_edges = -1;" before "return ret" needs to go into the locked area.
>> Will send an updated version soon.
>>
>>> BTW, it seems that there is already locking around read_raw() in the
>>> in-kernel consumer interface but not in the sysfs interface. Is there
>>> any reason for this difference?
>>
>> Dunno. :-)
> 
> If locking is actually necessary, then this would be a bug in the
> current version of the driver, which wasn't caught by at least three
> people doing reviews, so maybe let's find out if it really is necessary
> or if I'm missing something ...

Maybe IIO folks can tell us more.
What I see in other IIO drivers is that they all have locking in the read functions
and so far I see no global serialization in IIO itself.

Thanks,
//richard
