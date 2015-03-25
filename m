Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:51242 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707AbbCYUPG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2015 16:15:06 -0400
Message-ID: <1427314499.10958.36.camel@x220>
Subject: Re: [PATCH 1/3] iio: configfs: Add configfs support to IIO
From: Paul Bolle <pebolle@tiscali.nl>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, jlbec@evilplan.org, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com
Date: Wed, 25 Mar 2015 21:14:59 +0100
In-Reply-To: <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>
	 <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A license nit.

On Wed, 2015-03-25 at 19:00 +0200, Daniel Baluta wrote:
> --- /dev/null
> +++ b/drivers/iio/industrialio-configfs.c

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.

> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_DESCRIPTION("Industrial I/O configfs support");

You probably want
    MODULE_LICENSE("GPL v2");

here too. Because now, at module load time, the license will default to
"unspecified" which will taint the kernel.


Paul Bolle

