Return-Path: <SRS0=EUjZ=CG=embeddedor.com=garsilva@kernel.org>
Date: Wed, 08 Nov 2017 12:02:45 -0600
Message-ID: <20171108120245.Horde.X3xvu9MyIH2qhMzfKf1uUB2@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: core: mark expected switch fall-through
References: <20171108173621.GA20008@embeddedor.com>
 <alpine.DEB.2.20.1711081856310.656@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.20.1711081856310.656@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


Quoting Peter Meerwald-Stadler <pmeerw@pmeerw.net>:

>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>
> please fix the subject line, should be
> iio: core: Mark...
>

Oh yeah. I'll send v2 shortly.

Thanks!
--
Gustavo A. R. Silva
