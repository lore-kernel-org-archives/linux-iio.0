Return-Path: <pebolle@tiscali.nl>
Message-ID: <1426939531.15426.9.camel@x220>
Subject: Re: [PATCH 1/4] iio: adc: add support for Berlin
From: Paul Bolle <pebolle@tiscali.nl>
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, zmxu@marvell.com, jszhang@marvell.com,
	yrliao@marvell.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 21 Mar 2015 13:05:31 +0100
In-Reply-To: <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
References: 
	<1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
	 <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Just a license nit.

On Fri, 2015-03-20 at 14:36 +0100, Antoine Tenart wrote:
> --- /dev/null
> +++ b/drivers/iio/adc/berlin-adc.c

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And
    MODULE_LICENSE("GPL v2");

would match that statement.


Paul Bolle
