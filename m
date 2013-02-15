Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [RFC][PATCH] iio: basic ADC support for Freescale i.MX25
Date: Fri, 15 Feb 2013 11:45:01 +0100
Cc: Denis Darwish <darwish.d.d@gmail.com>,
 linux-iio@vger.kernel.org
References: <511D50E6.4060801@gmail.com> <511E090A.9090702@jic23.retrosnub.co.uk>
In-Reply-To: <511E090A.9090702@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201302151145.01876.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan Cameron,

> On 14/02/13 21:02, Denis Darwish wrote:
> > This patch adds basic support for Freescale i.MX25 ADC in the IIO
> > Subsystem. It is provides direct access via sysfs, IRQ not used now.
> > Compile tested with linux-next.
> > Functionality tested with linux 3.3.0.

The LRADC in MXS is sigmatel design. I suspect it'll be different from MX25 ADC.

Best regards,
Marek Vasut
