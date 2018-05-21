Return-Path: <SRS0=6PT2=II=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1e4b1957be1b64d0bc17a1d6f2d004435ee554df.camel@linux.intel.com>
Subject: Re: [PATCH 2/9] i2c: Allow specifying irq-index to be used in
 i2c_device_probe()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki"
	 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Hartmut Knaack
	 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Date: Mon, 21 May 2018 12:08:39 +0300
In-Reply-To: <77af193a6335f8f29278dd23365f8c619a2c6e5f.camel@linux.intel.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
	 <20180520132857.8103-3-hdegoede@redhat.com>
	 <77af193a6335f8f29278dd23365f8c619a2c6e5f.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2018-05-21 at 12:07 +0300, Andy Shevchenko wrote:
> On Sun, 2018-05-20 at 15:28 +0200, Hans de Goede wrote:
> > Some types of interrupts are retrieved in i2c_device_probe() because
> > getting them might fail with -EPROBE_DEFER.
> > 
> > So far we've always assumed the first IRQ (index 0) in the firmware-
> > node
> > is the one we want.
> > 
> > At least with ACPI enumerated i2c-clients in some cases the
> > firmware-
> > node
> > is shared between multiple i2c-clients so we need to be able to
> > specify
> > the index rather then hardcoding it at 0.
> > 
> > This commit adds a new fwnode_irq_index member to i2c_board_info and
> > i2c_client which allows specifying the index.
> > 
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> P.S. I would go with 'unsigned int' for the index.

Ah, it seems it is needed to be -1 in some cases. Discard my comment.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
