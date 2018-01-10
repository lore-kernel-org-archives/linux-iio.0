Return-Path: <SRS0=kZWo=EF=gmail.com=mastichi@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALieaecOxkh+SCnYA_ScoaKeRbYTdbKy7PH0=SuxcT3GEn3-Hw@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
 <20171229175449.760e734d@archlinux> <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
 <20180101095342.4d4d5325@archlinux> <CALieaecknYWjOvUuD_Qhaepj0fwGBCPX0pcT3pgNTnLQ17WMSA@mail.gmail.com>
 <20180106131434.550e8e42@archlinux> <CALieaefJ-dPNMydGZD-jCC66gRs1SGqFNNs__y9BWyC05g5bqQ@mail.gmail.com>
 <20180107160820.05660804@archlinux> <CALieaecOxkh+SCnYA_ScoaKeRbYTdbKy7PH0=SuxcT3GEn3-Hw@mail.gmail.com>
From: Dmitry Mastykin <mastichi@gmail.com>
Date: Wed, 10 Jan 2018 06:51:23 +0300
Message-ID: <CALieaecgHPWG0sKRf6A6gwxP1TkSqsjX09ZULxGAMQj9f0P_pw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Dan Carpenter <dan.carpenter@oracle.com>,
	Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hello Johnatan,
May be the issue is the same as Javier Martinez Canillas wrote:
"What is not correct is to require OF-only drivers to have an I2C
device ID table just as a workaround to have their modules
auto-loading working."
Please see: http://lkml.iu.edu/hypermail/linux/kernel/1712.0/01779.html
So the problem is not in driver, but in auto-loading procedure.
Thank you!

Kind regards,
Dmitry
>>> >> >> >> > Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
>>> >> >> >> > ---
>>> >> >> >> >  drivers/iio/adc/max9611.c | 5 ++---
>>> >> >> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
>>> >> >> >> >
>>> >> >> >> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
>>> >> >> >> > index b1dd17c..ce0115a 100644
>>> >> >> >> > --- a/drivers/iio/adc/max9611.c
>>> >> >> >> > +++ b/drivers/iio/adc/max9611.c
>>> >> >> >> > @@ -523,8 +523,7 @@ static const struct of_device_id max9611_of_table[] = {
>>> >> >> >> >  };
>>> >> >> >> >
>>> >> >> >> >  MODULE_DEVICE_TABLE(of, max9611_of_table);
>>> >> >> >> > -static int max9611_probe(struct i2c_client *client,
>>> >> >> >> > -                        const struct i2c_device_id *id)
>>> >> >> >> > +static int max9611_probe(struct i2c_client *client)
>>> >> >> >> >  {
>>> >> >> >> >         const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
>>> >> >> >> >         const struct device_node *of_node = client->dev.of_node;
>>> >> >> >> > @@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver = {
>>> >> >> >> >                    .owner = THIS_MODULE,
>>> >> >> >> >                    .of_match_table = max9611_of_table,
>>> >> >> >> >         },
>>> >> >> >> > -       .probe = max9611_probe,
>>> >> >> >> > +       .probe_new = max9611_probe,
>>> >> >> >> >  };
>>> >> >> >> >  module_i2c_driver(max9611_driver);
>>> >> >> >> >
>>> >> >> >> > --
>>> >> >> >> > 2.7.4
>>> >> >> >> >
>>> >> >
>>> >
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
