Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbeAFNOj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 08:14:39 -0500
Date: Sat, 6 Jan 2018 13:14:34 +0000
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
Message-ID: <20180106131434.550e8e42@archlinux>
In-Reply-To: <CALieaecknYWjOvUuD_Qhaepj0fwGBCPX0pcT3pgNTnLQ17WMSA@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
        <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
        <20171229175449.760e734d@archlinux>
        <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
        <20180101095342.4d4d5325@archlinux>
        <CALieaecknYWjOvUuD_Qhaepj0fwGBCPX0pcT3pgNTnLQ17WMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 3 Jan 2018 15:41:13 +0300
Dmitry Mastykin <mastichi@gmail.com> wrote:

> On Mon, Jan 1, 2018 at 12:53 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Not that I can see.  They are a straight swap in drivers/i2c/i2c-core-base.c
> > presumably intended to drop the parameter that is unused in the devicetree
> > and acpi cases.
> >
> > This isn't an area I know that much about so I've just played follow the
> > code for a few minutes.
> >
> > Module autoloading relies on the MODULE_DEVICE_TABLE macro.  This creates
> > an alias so the scripts/mod/file2alias.c file can work out what MODULE_ALIAS
> > lines need to be created.  This results in entries being added to section
> > .modinfo of the module which userspace can then read to work out which
> > module does what.
> >
> > Here you already have that for the device tree case so this should already work
> > with or without this change.
> >
> > So what circumstance did you have where this module did not autoprobe correctly?
> >
> > I may well be missing some subtle detail of course having spent only a few
> > minute looking at this!
> >
> > Jonathan  
> 
> Hi Johnatan,
> Thank you for the answer, I think you're right.
> I use the driver as module and one my colleague as built-in.
> With current driver module auto-load doesn't work, but built-in does
> auto-probe well.
> In patch v1 I added MODULE_DEVICE_TABLE(i2c,... and auto-load started to work.
> Then in patch v2 I removed the table and switched to probe_new.
> I think v2 worked only because I forgot to do depmod after replacing .ko-file.
> I will have chance to try it again after 2 weeks.
> May be better way for me is to build in the driver, because it seems
> strange to add the table
> to driver whereas people get rid of this table in other drivers.

Are you using devicetree or some other method to instantiate the device?
i.e. How does the kernel know it exists?
> 
> Kind regards,
> Dmitry
> 
> >> >> > Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
> >> >> > ---
> >> >> >  drivers/iio/adc/max9611.c | 5 ++---
> >> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> >> >> > index b1dd17c..ce0115a 100644
> >> >> > --- a/drivers/iio/adc/max9611.c
> >> >> > +++ b/drivers/iio/adc/max9611.c
> >> >> > @@ -523,8 +523,7 @@ static const struct of_device_id max9611_of_table[] = {
> >> >> >  };
> >> >> >
> >> >> >  MODULE_DEVICE_TABLE(of, max9611_of_table);
> >> >> > -static int max9611_probe(struct i2c_client *client,
> >> >> > -                        const struct i2c_device_id *id)
> >> >> > +static int max9611_probe(struct i2c_client *client)
> >> >> >  {
> >> >> >         const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
> >> >> >         const struct device_node *of_node = client->dev.of_node;
> >> >> > @@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver = {
> >> >> >                    .owner = THIS_MODULE,
> >> >> >                    .of_match_table = max9611_of_table,
> >> >> >         },
> >> >> > -       .probe = max9611_probe,
> >> >> > +       .probe_new = max9611_probe,
> >> >> >  };
> >> >> >  module_i2c_driver(max9611_driver);
> >> >> >
> >> >> > --
> >> >> > 2.7.4
> >> >> >  
> >  

