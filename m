Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752907AbeDURSJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 13:18:09 -0400
Date: Sat, 21 Apr 2018 18:18:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Syne <john3909@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] stagging:iio:meter: Add essential IIO API
 structures for ADE7854
Message-ID: <20180421181803.53addc6c@archlinux>
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Apr 2018 08:54:45 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patchset aims to update ADE7854 by adding the required IIO API
> components. The first patch adds the iio_chan_spec for handling seven
> different registers (all of them with a similar behavior). The second
> patch appends the read_raw function defined by the IIO API. Finally, the
> third patch adds the write_raw function and remove the attributes used
> for handling the seven registers. This patchset has the contribution of
> John Syne, which was responsible for mapping the correct ABI name per
> element in the ADE7854; additionally, John provided codes that helped to
> shape these patches.
> 
> Rodrigo Siqueira (3):
>   stagging:iio:meter: Add iio_chan_spec
>   stagging:iio:meter: Add ade7854_read_raw function
>   stagging:iio:meter: Add ade7854_write_raw function
> 
>  drivers/staging/iio/meter/ade7854.c | 129 ++++++++++++++++++++--------
>  1 file changed, 94 insertions(+), 35 deletions(-)
> 
Hi Rodrigo,

Please don't do it like this.   The original discussion with John
involved the addition of an extra chunk of core logic so we would have
the ability to specify the channel without using extended_name.

Extended name is not intended to differentiate between channels (it
isn't in general enough to do so - though it works in this little
corner case of sysfs attributes like you have here).

So the plan is to add another field to the iio_chan_spec structure
to allow for the complexity we need.  See the long discussions
over how we represent the myriad of channels in here.

If you need some pointers, feel free to ask but it may take
me a little while to put together a full description of what needs
doing.

I'll put a few more direct comments in the individual patches.

Thanks,

Jonathan

