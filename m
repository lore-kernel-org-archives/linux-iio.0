Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbeCQW1U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 18:27:20 -0400
Date: Sat, 17 Mar 2018 22:27:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: Plan to move cdc:ad7746 driver out of staging
Message-ID: <20180317222714.101ce507@archlinux>
In-Reply-To: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
References: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Mar 2018 16:25:52 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Hi,
> 
> This is my plan for moving out the ad7746 driver out of staging. I
> have some specific questions that would be really helpful if someone
> can point me in the right direction to go.
> 
> 1. Pick up on David's clean-up patch. Finish cleaning CHECKs from
> checkpatch.pl if possible.
> 
> 2. Reorder includes alphabetically.
> 
> 3. Reorder some variable declarations in an inverse-pyramid scheme.
> 
> 4. Fix sysfs attrs naming to comply with the ABI, e.g.:
> in_capacitance0_calibbias_calibration -> in_capacitance0_calibbias
Take a careful look at what these are doing before you do that :)
Then consider what the usecases are.  If we need to, we may need
to add new ABI to cover the requirement.

> 
> 5. Add documentation to the {cap,vt}_filter_rate tables and to the
> processed info read. There are some magic numbers out there, I will
> read the datasheet and explain the math that I consider appropiate.
> 
> 6. There are a few too many defines that are not used at all but they
> do follow the datasheet. I don't know if there are plans to keep
> adding functionalities to this driver or if I should just remove them.
> 
> 8. EXCLVL is duplicated. There's a simple macro in ad7746.c and some
> defines in ad7746.h. The latter are not used anywhere in the code.
> Remove them.
> 
> 7. Move the struct ad7746_platform_data to include/linux/iio.
> 
> As mentioned in earlier mails, I will avoid adding new features as I
> have no access to the hardware and, therefore, could not test it.
Michael has stated he has at least some of the CDCs still so may be able
to help with that.

> 
> I guess that'd be all. If I'm missing something I would be really
> grateful if you can let me know or give me some pointers where to look
> at.

It would probably be a good idea to add devicetree bindings if possible.
Hardly anything is done with board files these days - though we should
maintain the platform data for anyone who is using them (for now).

There may well be other things that come out of the woodwork once
we do a formal review of the patch that proposes moving it out of
staging (there almost always is!)

Jonathan

> 
> Cheers,
> 
> Hernán
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

