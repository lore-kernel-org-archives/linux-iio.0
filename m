Return-Path: <SRS0=DPDv=YY=gmail.com=vilhelm.gray@kernel.org>
Date: Tue, 10 Jan 2017 16:45:35 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, gnurou@gmail.com
Subject: Re: [PATCH 3/3] iio: pc104: Mask PC/104 drivers via the PC104
 Kconfig option
Message-ID: <20170110214535.GA21354@sophia>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
 <512f7f9909c9ff6964b34e0302eeb404e703f033.1484073325.git.vilhelm.gray@gmail.com>
 <4236ccf5-1480-ea3c-fee6-35ea252e3756@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4236ccf5-1480-ea3c-fee6-35ea252e3756@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 10, 2017 at 09:13:02PM +0000, Jonathan Cameron wrote:
>On 10/01/17 18:51, William Breathitt Gray wrote:
>> PC/104 drivers should be hidden on machines which do not support PC/104
>> devices. This patch adds the PC104 Kconfig option as a dependency for
>> the relevant PC/104 device driver Kconfig options.
>> 
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>Now the question is how to merge this one.  Let me know if you
>want me to take this one via IIO after the first patch is in.
>If you want to take it another route I'm fine with that.
>
>Jonathan

This is such a simple patchset that I envision Greg K-H picking up all
three patches via driver-core; however, I'm pretty indifferent about the
ultimate path in the end. I'll leave it up to Greg K-H to decide.

William Breathitt Gray
