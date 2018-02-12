Return-Path: <SRS0=KvD6=FG=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com> <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 15:10:56 +0100
Message-ID: <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of staging
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: 21cnbao@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 12:54 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Move the adis16201 driver out of staging directory and merge to the
> mainline IIO directory.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

<snip>
> --- /dev/null
> +++ b/drivers/iio/accel/adis16201.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0+

<snip>

> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16201");

Your MODULE_LICENSE does not match your SPDX license id.
MODULE_LICENSE("GPL v2"); means SPDX GPL-2.0
MODULE_LICENSE("GPL"); means SPDX GPL-2.0+


-- 
Cordially
Philippe Ombredanne
