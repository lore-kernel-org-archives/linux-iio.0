Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1032 "EHLO
	smtp-out-038.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbHGLiu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2015 07:38:50 -0400
Message-ID: <55C498C2.1070709@metafoo.de>
Date: Fri, 07 Aug 2015 13:38:42 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Daniel Baluta <daniel.baluta@gmail.com>
CC: =?windows-1252?Q?ayb=FCke_=F6zdemir?= <aybuke.147@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: staging: iio: accel: Use __be16 instead of u16
References: <20150715193650.GA28245@mwanda> <CAEnQRZC6-4n7ZUi0PPiQ2bG-c1P3fADn6CmyYLmHa2NbWVeaJg@mail.gmail.com> <20150807112733.GI5096@mwanda>
In-Reply-To: <20150807112733.GI5096@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/2015 01:27 PM, Dan Carpenter wrote:
> On Fri, Aug 07, 2015 at 01:59:40PM +0300, Daniel Baluta wrote:
>>>    119          for (i = 0; i < num_read; i++)
>>>    120                  *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
>>>                           ^^^^^^^^^^^^^^^
>>>
>>> We're writing beyond the end of the array here because of the pointer
>>> math issue.  The fix is probably to say:
>>>
>>>                 for (i = 0; i < num_read / sizeof(u16); i++)
>>>                         *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
>>>
>>>    121
>>>    122          if (copy_to_user(buf, rx, num_read))
>>>    123                  ret = -EFAULT;
>>
>> Looks good to me. Please send a formal patch.
> 
> It's weird that no one has noticed this bug in testing because we end
> up corrupting memory every time this function is called.

The buffers are probably smaller than the minimum allocation size so there
is a bit of unused space after the buffer and overwriting it will not result
in a corruption of used memory and nobody ever noticed.

But in any way we should just drop the endianness conversion in kernelspace
and advertise the data as big-endian to userspace.

- Lars

