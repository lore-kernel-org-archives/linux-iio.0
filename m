Return-Path: <SRS0=LoxJ=YQ=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v6 7/9] i2c: i2c-mux-simple: new driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-8-git-send-email-peda@axentia.se>
 <CAHp75Vc2uYhaYJu_eU-uBq_PZrUgaoNt8sxpuRF8eEEs2kPUwg@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet
 <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
 Linux Documentation List <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <49bbe0f9-8cf7-c932-265e-ebab39bc2a1e@axentia.se>
Date: Mon, 2 Jan 2017 16:30:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc2uYhaYJu_eU-uBq_PZrUgaoNt8sxpuRF8eEEs2kPUwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-01 16:38, Andy Shevchenko wrote:
> On Wed, Nov 30, 2016 at 10:17 AM, Peter Rosin <peda@axentia.se> wrote:
>> This is a generic simple i2c mux that uses the generic multiplexer
>> subsystem to do the muxing.
> 
>> +static const struct of_device_id i2c_mux_of_match[] = {
>> +       { .compatible = "i2c-mux-simple,parent-locked",
>> +         .data = (void *)0, },
>> +       { .compatible = "i2c-mux-simple,mux-locked",
>> +         .data = (void *)1, },
>> +       {},
>> +};
> 
> Perhaps
> 
> #define I2C_MUX_LOCKED_PARENT  0
> #define I2C_MUX_LOCKED         1

I2C_MUX_LOCKED is already "taken" in include/linux/i2c-mux.h but I'll
use SIMPLE_PARENT_LOCKED and SIMPLE_MUX_LOCKED instead.

Cheers,
peda
