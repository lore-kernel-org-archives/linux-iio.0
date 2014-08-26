Return-Path: <iivanov@mm-sol.com>
Message-ID: <1409060908.5256.83.camel@iivanov-dev>
Subject: Re: [PATCH] iio: core: Propagate error codes from OF layer to
 client drivers
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Adam.Thomson.Opensource@diasemi.com,  knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2014 16:48:28 +0300
In-Reply-To: <53FC8AB3.2080603@roeck-us.net>
References: <1408971437-10751-1-git-send-email-iivanov@mm-sol.com>
		 <53FB5FF7.8020504@kernel.org> <20140825165430.GB14614@roeck-us.net>
	 <1409039490.5256.75.camel@iivanov-dev> <53FC8AB3.2080603@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2014-08-26 at 06:25 -0700, Guenter Roeck wrote:
> On 08/26/2014 12:51 AM, Ivan T. Ivanov wrote:
> > Hi,
> >
> [ ... ]
> >
> > Another, less intrusive, solution will be if we revert last patch and explicitly
> > check for EPROBE_DEFER on of_ by_name() return. How this sounds?
> >
> How is that different to the just accepted patch ?

You mean this one[1]. I have prepared fix last Friday and forget to
check again before posting it, sorry. Please ignore my patch.

Thanks, 
Ivan

[1] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
