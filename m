Return-Path: <SRS0=D4jH=JS=loewensteinmedical.de=nikolaus.voss@kernel.org>
Date: Mon, 2 Jul 2018 09:32:46 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Jonathan Cameron <jic23@kernel.org>
cc: Nikolaus Voss <nv@vosn.de>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Xiongfeng Wang <xiongfeng.wang@linaro.org>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] IIO: st_accel.h: sync DT and I2C device ID table
 strings
In-Reply-To: <20180630163305.00e08e17@archlinux>
Message-ID: <alpine.DEB.2.20.1807020925290.31768@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de> <5d00983e4fb2869fd3152a609c1fffe7616c4963.1530268235.git.nikolaus.voss@loewensteinmedical.de> <20180630163305.00e08e17@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Sat, 30 Jun 2018, Jonathan Cameron wrote:

> On Fri, 29 Jun 2018 10:45:54 +0200
> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:
>
>> I2C device ID table strings should really match the DT compatible
>> strings (without the manufacturer prefix) to avoid confusion. This is
>> especially reasonable when using ACPI PRP0001 HID /DT compatibility
>> entries along with the DT compatible property in DSD which is
>> used as a modalias (with manufacturer prefix stripped off) by the ACPI
>> layer and thus as i2c_board_info->type by the I2C layer.
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> Nice to have I agree.  However, it's an ABI change as this is exposed
> via
> /sys/bus/iio/devices/iio:\deviceN/name and is used by lots of scripts
> etc to identify the device.  So we are stuck with it.
>
> There is a reason we've kept this mess here for quite some time.

Ok, I feared there could be some reason ;-). Tell me, if you want me to 
respin anything...

Niko
