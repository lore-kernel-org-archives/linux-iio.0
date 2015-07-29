Return-Path: <pebolle@tiscali.nl>
Message-ID: <1438156610.5106.4.camel@tiscali.nl>
Subject: Re: [PATCH v2 5/5] iio: Support triggered events
From: Paul Bolle <pebolle@tiscali.nl>
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Date: Wed, 29 Jul 2015 09:56:50 +0200
In-Reply-To: <1438038442-13082-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: 
	<1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
	 <1438038442-13082-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Just a nit, I'm afraid.

On di, 2015-07-28 at 02:07 +0300, Vladimir Barinov wrote:
> --- /dev/null
> +++ b/drivers/iio/industrialio-triggered-event.c

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So either the comment or the ident used in the
MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle
