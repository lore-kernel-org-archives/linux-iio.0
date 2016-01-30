Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53373 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbcA3Pr3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 10:47:29 -0500
Subject: Re: [PATCH 04/22] staging: iio: Fix dependencies for !HAS_IOMEM archs
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-5-git-send-email-richard@nod.at>
 <CAMuHMdWk9A+3j85jX00jdqdvhndL4t-VyjF1gj-N7ZnR8DH8dg@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Marek <mmarek@suse.com>, linux-iio@vger.kernel.org,
	driverdevel <devel@driverdev.osuosl.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACDB0E.5070009@kernel.org>
Date: Sat, 30 Jan 2016 15:47:26 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWk9A+3j85jX00jdqdvhndL4t-VyjF1gj-N7ZnR8DH8dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/16 10:59, Geert Uytterhoeven wrote:
> On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
>> Not every arch has io memory.
>> So, unbreak the build by fixing the dependencies.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Applied to the same obscure branch of iio.git as patch 6.
Will unwind this cross merge window mess in my tree sometime
in the next week or so.

Thanks,

Jonathan
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

