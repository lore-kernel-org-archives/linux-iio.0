Return-Path: <SRS0=kTOX=CR=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOFm3uE0GsBn1g054rD9iym-kjC2bdsCOVO8WPBe7zZQ0a+Vvg@mail.gmail.com>
References: <20171118091011.9061-1-martink@posteo.de> <20171118155318.6a1f3b3f@archlinux>
 <CAOFm3uE0GsBn1g054rD9iym-kjC2bdsCOVO8WPBe7zZQ0a+Vvg@mail.gmail.com>
From: harinath Nampally <harinath922@gmail.com>
Date: Sat, 18 Nov 2017 23:23:57 -0500
Message-ID: <CAAGUq_pXNMSMAsvtMomHQiCjXhrZ5Yx5agowXAVhWt8Gkb=2ug@mail.gmail.com>
Subject: Re: [PATCH v2] iio: mma8452: replace license description with SPDX specifier
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Martin Kepplinger <martink@posteo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, lars@metafoo.de, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> This replaces the custom license information text with the appropriate
> SPDX identifier. While the information here stays the same, it is easier
> to read.
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Acked-by: Harinath Nampally <harinath922@gmail.com>

On Sat, Nov 18, 2017 at 11:29 AM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> On Sat, Nov 18, 2017 at 4:53 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On Sat, 18 Nov 2017 10:10:11 +0100
>> Martin Kepplinger <martink@posteo.de> wrote:
>>
>>> This replaces the custom license information text with the appropriate
>>> SPDX identifier. While the information here stays the same, it is easier
>>> to read.
>>>
>>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>>> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>>
>> I'm not 100% sure the intent of the SPDX work is to remove
>> existing licence text.  So far the big sets have only been
>> adding tags to files missing their licenses entirely...
>>
>> Anyone found any specific guidance on this?
>
> Jonathan:
> you might want to check the doc patches from tglx [1] as well as
> several related patches from greg k-h such as these  [2] and his
> initial pull [3]
>
> To get a lot of details you can check all the recent SPDX-related posts too [4]
>
> [1] https://marc.info/?l=linux-kernel&m=151051532322831&w=2
> [2] https://marc.info/?l=linux-kernel&m=151068111802610&w=2
> [3] https://marc.info/?l=linux-kernel&m=150963579219623&w=2
> [4] https://marc.info/?l=linux-kernel&w=2&r=1&s=spdx&q=b
> --
> Cordially
> Philippe Ombredanne
