Return-Path: <ao2@ao2.it>
Date: Thu, 30 Apr 2015 17:15:51 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to
 polling_mode
Message-Id: <20150430171551.02627d4ea8b22126c8a0f2be@ao2.it>
In-Reply-To: <1430404069.2525.112.camel@hadess.net>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	<1430298111-20127-3-git-send-email-ao2@ao2.it>
	<CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
	<20150430162552.f42e3caa42a44a7e04204d8e@ao2.it>
	<1430404069.2525.112.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 30 Apr 2015 16:27:49 +0200
Bastien Nocera <hadess@hadess.net> wrote:

> On Thu, 2015-04-30 at 16:25 +0200, Antonio Ospite wrote:
> > It was mainly to prevent error messages being printed in the logs 
> > when
> > trying to getting a gpio descriptor, is that correct Bastien?
> 
> Actually, to prevent it failing to init the driver altogether.

Then I am afraid I am failing to follow the code (4.1-rc1), from what
I read:

  - is_smo8500_device is only used in kxcjk1013_gpio_probe() to make it
    return -ENOTSUPP; i.e. client->irq = -ENOTSUPP;

  - when client->irq < 0 (even after kxcjk1013_gpio_probe), the driver
    does not request an interrupt  and does not set up triggers but it
    can still finish initialization.

So it looks to me that is_smo8500_device just prevents
devm_gpiod_get_index() from being called, but even if it was called it
(or gpiod_to_irq) should return an error.

Mmh, maybe the problem is "just" in checking the return value of
devm_gpiod_get_index() in kxcjk1013_gpio_probe(), maybe it's NULL in
your case and that was causing your original problem; BTW if it is NULL
then desc_to_gpio() in the debug print will Oops after commit b457f5.

I'll double check and get back to you.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
