Return-Path: <SRS0=Ghnl=4H=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Mon, 01 May 2017 20:48:15 +0100
In-Reply-To: <CAHp75VdcqWaQ7HB7V_UjHbErJenWV1iW=VCpgUt+7TcE4JvS1w@mail.gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com> <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com> <652e2497-d091-9468-a4ee-983bcc626d6b@kernel.org> <CAHp75VdcqWaQ7HB7V_UjHbErJenWV1iW=VCpgUt+7TcE4JvS1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and data_ready functions
To: Andy Shevchenko <andy.shevchenko@gmail.com>,Jonathan Cameron <jic23@kernel.org>
CC: Eva Rachel Retuya <eraretuya@gmail.com>,linux-iio@vger.kernel.org,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald <pmeerw@pmeerw.net>,Dmitry Torokhov <dmitry.torokhov@gmail.com>,Michael Hennerich <michael.hennerich@analog.com>,Daniel Baluta <daniel.baluta@gmail.com>,Alison Schofield <amsfield22@gmail.com>,Florian Vaussard <florian.vaussard@heig-vd.ch>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <9C6C5B25-76A9-48CE-841D-5D9FC92A8FDA@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 1 May 2017 20:42:08 BST, Andy Shevchenko <andy=2Eshevchenko@gmail=2Ecom=
> wrote:
>On Mon, May 1, 2017 at 3:22 AM, Jonathan Cameron <jic23@kernel=2Eorg>
>wrote:
>> On 29/04/17 08:48, Eva Rachel Retuya wrote:
>
>>> +static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
>>> +{
>>> +     struct device *dev =3D regmap_get_device(data->regmap);
>>> +     int ret;
>>> +
>>> +     ret =3D regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
>>> +     if (ret < 0) {
>>> +             dev_err(dev, "Failed to set power mode, %d\n", ret);
>>> +             return ret;
>> drop the return ret here and just return ret at the end of the
>function=2E
>> One of the static checkers will probably moan about this otherwise=2E
>
>But this will be not equivalent!
Why? Regmap_write returns 0 for success=2E
>
>>> +     }
>>> +
>>> +     return 0;
>>> +}

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
