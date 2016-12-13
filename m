Return-Path: <SRS0=qENR=X4=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161212165843.32322-2-m.niestroj@grinn-global.com>
References: <20161212165843.32322-1-m.niestroj@grinn-global.com> <20161212165843.32322-2-m.niestroj@grinn-global.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Dec 2016 09:52:04 +0100
Message-ID: <CACRpkda3H15KSv9U8e38hb0C+7dNz01MrdgCYwb=PqEdq89q0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: st_pressure: Export sampling frequency for
 lps25h and lps331ap
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 12, 2016 at 5:58 PM, Marcin Niestroj
<m.niestroj@grinn-global.com> wrote:

> Both devices are using the same iio_chan_spec to define which settings
> are exported with sysfs. Both are properly configured to set/get
> sampling frequency for pressure and temperature. They also properly
> export available sampling frequencies. The only missing thing is
> sampling_frequency sysfs file, which allows to set/get this property
> from userspace.
>
> Add sampling frequency to iio channel info mask, so sampling_frequency
> file is properly exported using sysfs.
>
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
