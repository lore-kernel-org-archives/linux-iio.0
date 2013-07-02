Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Tue, 2 Jul 2013 19:58:06 +0200
Cc: linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 Fabio Estevam <fabio.estevam@freescale.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de> <CAP9ODKr6MGYKKRZm7prGRQhPXpfuEimOmrgUucraCfF_7SPTEA@mail.gmail.com>
In-Reply-To: <CAP9ODKr6MGYKKRZm7prGRQhPXpfuEimOmrgUucraCfF_7SPTEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307021958.06343.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Otavio Salvador,

> On Mon, Jul 1, 2013 at 9:08 PM, Marek Vasut <marex@denx.de> wrote:
> > The removed check in the read_raw implementation was always true,
> > therefore remove it.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This fixes the driver for MX23 but why this code were add at first?

Obviously because I wrote the code incorrectly. I appologize for the trouble.

Jonathan, can we get this one into 3.10.1 maybe ?

Best regards,
Marek Vasut
