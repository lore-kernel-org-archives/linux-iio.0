Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
Date: Thu, 30 Apr 2015 22:58:24 +0200
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>,
 jic23@kernel.org,
 knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 marxin.liska@gmail.com,
 rui.zhang@intel.com,
 linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com> <1430426026.2187.5.camel@x220>
In-Reply-To: <1430426026.2187.5.camel@x220>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201504302258.24154.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday, April 30, 2015 at 10:33:46 PM, Paul Bolle wrote:
> Just a nit: a license mismatch.
> 
> On Wed, 2015-04-29 at 13:27 +0200, Gabriele Mazzotta wrote:
> > --- /dev/null
> > +++ b/drivers/iio/light/acpi-als.c
> > 
> > + * This program is free software; you can redistribute it and/or modify
> > it + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> > WITHOUT + * ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > General Public License for + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> 
> This states the license is GPL v2.
> 
> > +MODULE_LICENSE("GPL");
> 
> And, according to include/linux/module.h, this states the license is GPL
> v2 or later. So I think either the comment at the top of this file or
> the ident used in the MODULE_LICENSE() macro should be changed.

I'm OK with v2+ or later .

Best regards,
Marek Vasut
