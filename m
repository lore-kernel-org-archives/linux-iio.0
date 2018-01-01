Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbeAAJxs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 04:53:48 -0500
Date: Mon, 1 Jan 2018 09:53:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
Message-ID: <20180101095342.4d4d5325@archlinux>
In-Reply-To: <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
        <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
        <20171229175449.760e734d@archlinux>
        <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Dec 2017 15:43:38 +0300
Dmitry Mastykin <mastichi@gmail.com> wrote:

> > On Fri, 29 Dec 2017 17:30:39 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> >> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>  
> I was not aware of this tag, that's what I wanted to write, thanks!
> 
> On Fri, Dec 29, 2017 at 8:54 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > I'm a little confused.  Why does this now make module autoloading
> > work where it previously didn't?
> >  
> As I understand, .probe is not called if module doesn't export i2c id table,
> there is nothing to put into second argument.
> But .probe_new is called, because it's supposed to do of_match_device itself.
Not that I can see.  They are a straight swap in drivers/i2c/i2c-core-base.c
presumably intended to drop the parameter that is unused in the devicetree
and acpi cases.

This isn't an area I know that much about so I've just played follow the
code for a few minutes.

Module autoloading relies on the MODULE_DEVICE_TABLE macro.  This creates
an alias so the scripts/mod/file2alias.c file can work out what MODULE_ALIAS
lines need to be created.  This results in entries being added to section
.modinfo of the module which userspace can then read to work out which
module does what.

Here you already have that for the device tree case so this should already work
with or without this change.

So what circumstance did you have where this module did not autoprobe correctly?

I may well be missing some subtle detail of course having spent only a few
minute looking at this!

Jonathan

> 
> Kind regards,
> Dmitry
> 
> >> > Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
> >> > ---
> >> >  drivers/iio/adc/max9611.c | 5 ++---
> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> >> > index b1dd17c..ce0115a 100644
> >> > --- a/drivers/iio/adc/max9611.c
> >> > +++ b/drivers/iio/adc/max9611.c
> >> > @@ -523,8 +523,7 @@ static const struct of_device_id max9611_of_table[] = {
> >> >  };
> >> >
> >> >  MODULE_DEVICE_TABLE(of, max9611_of_table);
> >> > -static int max9611_probe(struct i2c_client *client,
> >> > -                        const struct i2c_device_id *id)
> >> > +static int max9611_probe(struct i2c_client *client)
> >> >  {
> >> >         const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
> >> >         const struct device_node *of_node = client->dev.of_node;
> >> > @@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver = {
> >> >                    .owner = THIS_MODULE,
> >> >                    .of_match_table = max9611_of_table,
> >> >         },
> >> > -       .probe = max9611_probe,
> >> > +       .probe_new = max9611_probe,
> >> >  };
> >> >  module_i2c_driver(max9611_driver);
> >> >
> >> > --
> >> > 2.7.4
> >> >  

