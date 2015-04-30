Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:51595 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbbD3Udv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 16:33:51 -0400
Message-ID: <1430426026.2187.5.camel@x220>
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
From: Paul Bolle <pebolle@tiscali.nl>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, marxin.liska@gmail.com, marex@denx.de,
	rui.zhang@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Date: Thu, 30 Apr 2015 22:33:46 +0200
In-Reply-To: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just a nit: a license mismatch.

On Wed, 2015-04-29 at 13:27 +0200, Gabriele Mazzotta wrote:
> --- /dev/null
> +++ b/drivers/iio/light/acpi-als.c

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think either the comment at the top of this file or
the ident used in the MODULE_LICENSE() macro should be changed.


Paul Bolle

