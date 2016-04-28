Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
 <571F49B0.4060407@metafoo.de>
 <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
 <571F588D.3010800@metafoo.de>
 <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
 <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
 <5720EFAA.3040407@intel.com> <5721C904.3010505@metafoo.de>
 <20160428142458.09e498e2@lxorguk.ukuu.org.uk>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, Yong Li <sdliyong@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
 Matt Ranostaj <mranostay@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57221B76.5080108@metafoo.de>
Date: Thu, 28 Apr 2016 16:17:26 +0200
MIME-Version: 1.0
In-Reply-To: <20160428142458.09e498e2@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/28/2016 03:24 PM, One Thousand Gnomes wrote:
>> It's clearly wrong. But the problem is there might be an application that
>> depends on the wrong behavior, the driver has been around for 2.5 years. So
>> it's difficult to fix. We might just go ahead in this case and take the
>> chance that nobody will complain. But if somebody complains this will bring
>> us the wrath of the Linus.
> 
> Not if you put it into next, test it, then into a new release as early as
> possible (for -rc1), clearly document that it's got a user visible change
> that should not matter with instructions if anyone hits this as a
> bisection for their app failing to email so you know and can revert it.

I don't expend application developers to run -rc kernels just to check
whether their application still works. You'd get such a report 6 month after
the kernel has been released once the change has trickled down.
