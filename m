Return-Path: <SRS0=K0a+=A2=posteo.de=martink@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 25 Sep 2017 12:11:43 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com
Subject: Re: [PATCH 0/3] Refactor event related code
In-Reply-To: <1506334065-2891-1-git-send-email-harinath922@gmail.com>
References: <1506334065-2891-1-git-send-email-harinath922@gmail.com>
Message-ID: <5d8c841101a35b47aec56cef1b5a3ff1@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

Am 25.09.2017 12:07 schrieb Harinath Nampally:
> Rename some struct names and function names to
> improve code readability.
> 
> Harinath Nampally (3):
>   iio: accel: mma8452: Rename structs holding event     configuration
>     registers to more appropriate names.
>   iio: accel: mma8452: Rename time step look up struct     to generic
>     name as the values are same for all the events.
>   iio: accel: mma8452: Rename read/write event value     callbacks to
>     generic function name.
> 

First, this is at least v2 of this series. Second, it still seems to 
include
a 4th unrelated patch.

It's sometimes not trivial to get email right. Why not test sending it 
privately
to yourself first?
