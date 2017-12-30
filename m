Return-Path: <SRS0=onwM=D2=gmail.com=mastichi@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171229175449.760e734d@archlinux>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com> <20171229175449.760e734d@archlinux>
From: Dmitry Mastykin <mastichi@gmail.com>
Date: Sat, 30 Dec 2017 15:43:38 +0300
Message-ID: <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Dan Carpenter <dan.carpenter@oracle.com>,
	Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Fri, 29 Dec 2017 17:30:39 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
I was not aware of this tag, that's what I wanted to write, thanks!

On Fri, Dec 29, 2017 at 8:54 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> I'm a little confused.  Why does this now make module autoloading
> work where it previously didn't?
>
As I understand, .probe is not called if module doesn't export i2c id table,
there is nothing to put into second argument.
But .probe_new is called, because it's supposed to do of_match_device itself.

Kind regards,
Dmitry

>> > Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
>> > ---
>> >  drivers/iio/adc/max9611.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
>> > index b1dd17c..ce0115a 100644
>> > --- a/drivers/iio/adc/max9611.c
>> > +++ b/drivers/iio/adc/max9611.c
>> > @@ -523,8 +523,7 @@ static const struct of_device_id max9611_of_table[] = {
>> >  };
>> >
>> >  MODULE_DEVICE_TABLE(of, max9611_of_table);
>> > -static int max9611_probe(struct i2c_client *client,
>> > -                        const struct i2c_device_id *id)
>> > +static int max9611_probe(struct i2c_client *client)
>> >  {
>> >         const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
>> >         const struct device_node *of_node = client->dev.of_node;
>> > @@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver = {
>> >                    .owner = THIS_MODULE,
>> >                    .of_match_table = max9611_of_table,
>> >         },
>> > -       .probe = max9611_probe,
>> > +       .probe_new = max9611_probe,
>> >  };
>> >  module_i2c_driver(max9611_driver);
>> >
>> > --
>> > 2.7.4
>> >
