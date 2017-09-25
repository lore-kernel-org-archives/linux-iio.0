Return-Path: <SRS0=urO0=A2=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d8c841101a35b47aec56cef1b5a3ff1@posteo.de>
References: <1506334065-2891-1-git-send-email-harinath922@gmail.com> <5d8c841101a35b47aec56cef1b5a3ff1@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 25 Sep 2017 06:16:49 -0400
Message-ID: <CAAGUq_o68DAm=nf5P770ZuzpjZCtfxneouWu0mRCXE=0wQmpxA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Refactor event related code
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> First, this is at least v2 of this series. Second, it still seems to include
> a 4th unrelated patch.
ok I was not sure whether to make it v2 as the change was to only cover letter
and no code changes. But now I know, will send v3 of this series.

> It's sometimes not trivial to get email right. Why not test sending it privately
> to yourself first?
Sure will do, sorry for the convenience.

Thanks,
Harinath

On Mon, Sep 25, 2017 at 6:11 AM, Martin Kepplinger <martink@posteo.de> wrote:
> Am 25.09.2017 12:07 schrieb Harinath Nampally:
>>
>> Rename some struct names and function names to
>> improve code readability.
>>
>> Harinath Nampally (3):
>>   iio: accel: mma8452: Rename structs holding event     configuration
>>     registers to more appropriate names.
>>   iio: accel: mma8452: Rename time step look up struct     to generic
>>     name as the values are same for all the events.
>>   iio: accel: mma8452: Rename read/write event value     callbacks to
>>     generic function name.
>>
>
> First, this is at least v2 of this series. Second, it still seems to include
> a 4th unrelated patch.
>
> It's sometimes not trivial to get email right. Why not test sending it
> privately
> to yourself first?
