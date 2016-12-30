Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50766 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753914AbcL3Lel (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 06:34:41 -0500
Subject: Re: [PATCH 2/2] iio: st_pressure: Export sampling frequency for
 lps25h and lps331ap
To: Linus Walleij <linus.walleij@linaro.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161212165843.32322-1-m.niestroj@grinn-global.com>
 <20161212165843.32322-2-m.niestroj@grinn-global.com>
 <CACRpkda3H15KSv9U8e38hb0C+7dNz01MrdgCYwb=PqEdq89q0Q@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6fdaebff-16bd-9d73-013c-fdddfdc21bbc@kernel.org>
Date: Fri, 30 Dec 2016 11:34:39 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkda3H15KSv9U8e38hb0C+7dNz01MrdgCYwb=PqEdq89q0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/12/16 08:52, Linus Walleij wrote:
> On Mon, Dec 12, 2016 at 5:58 PM, Marcin Niestroj
> <m.niestroj@grinn-global.com> wrote:
> 
>> Both devices are using the same iio_chan_spec to define which settings
>> are exported with sysfs. Both are properly configured to set/get
>> sampling frequency for pressure and temperature. They also properly
>> export available sampling frequencies. The only missing thing is
>> sampling_frequency sysfs file, which allows to set/get this property
>> from userspace.
>>
>> Add sampling frequency to iio channel info mask, so sampling_frequency
>> file is properly exported using sysfs.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
