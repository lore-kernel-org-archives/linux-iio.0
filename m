Return-Path: <SRS0=RH33=2K=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3] staging: iio: ad9832: Moved contents of the header to
 the source file
To: Narcisa Vasile <narcisaanamaria12@gmail.com>,
 outreachy-kernel <outreachy-kernel@googlegroups.com>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
 <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
 <1488216496-16969-1-git-send-email-narcisaanamaria12@gmail.com>
 <c5b95296-f346-4e7e-9248-0d68d7a51339@googlegroups.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <376d777d-2579-7553-c488-aef80acf81ec@metafoo.de>
Date: Wed, 1 Mar 2017 19:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <c5b95296-f346-4e7e-9248-0d68d7a51339@googlegroups.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 03/01/2017 06:12 PM, Narcisa Vasile wrote:
> Hi,
> Is this patch correct now or should I improve it ?

Patch looks OK. But in general you need to allow some time for review.
People are often busy with work, tight deadlines, etc. Jonathan for example
who will apply your patch works on this in his spare time. So it might take
a few days before somebody gets the time to look at your patch. Asking about
the state of the patch after a few days is just one more e-mail to read for
the maintainer. I understand that for you your patch is the most important
patch, but maintainers get bombarded with tens if not even hundreds of
patches a day and they have to care about them all equally.
