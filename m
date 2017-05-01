Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36451 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdEATmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 15:42:10 -0400
MIME-Version: 1.0
In-Reply-To: <652e2497-d091-9468-a4ee-983bcc626d6b@kernel.org>
References: <cover.1493450577.git.eraretuya@gmail.com> <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
 <652e2497-d091-9468-a4ee-983bcc626d6b@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 May 2017 22:42:08 +0300
Message-ID: <CAHp75VdcqWaQ7HB7V_UjHbErJenWV1iW=VCpgUt+7TcE4JvS1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and
 data_ready functions
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 1, 2017 at 3:22 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/04/17 08:48, Eva Rachel Retuya wrote:

>> +static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
>> +{
>> +     struct device *dev = regmap_get_device(data->regmap);
>> +     int ret;
>> +
>> +     ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
>> +     if (ret < 0) {
>> +             dev_err(dev, "Failed to set power mode, %d\n", ret);
>> +             return ret;
> drop the return ret here and just return ret at the end of the function.
> One of the static checkers will probably moan about this otherwise.

But this will be not equivalent!

>> +     }
>> +
>> +     return 0;
>> +}

-- 
With Best Regards,
Andy Shevchenko
