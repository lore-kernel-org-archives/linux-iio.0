Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <8a4804d5-3d92-fff0-e48e-beebfb8ba1e2@kernel.org>
References: <1472630560-4905-1-git-send-email-peda@axentia.se> <8a4804d5-3d92-fff0-e48e-beebfb8ba1e2@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Sep 2016 22:44:29 +0200
Message-ID: <CACRpkdbUsas+eWq9C0DkQjrm9BNk8XhfRgr8q+AvyPU3ftYFeQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: inform the i2c mux core about how
 it is used
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 3, 2016 at 6:30 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 31/08/16 09:02, Peter Rosin wrote:
>> The i2c mux core can then take appropriate action depending on if it is
>> used for an actual i2c mux, or for an arbitrator or gate. In this case
>> it is used as a gate.
>>
>> This will make devicetree bindings simpler when they are eventually
>> added.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> So, this depends on the i2c-mux-dt-3 branch [1] that Jonathan
>> pulled to support the new mpu-3050 gyroscope driver. I had
>> planned to submit this post 4.9-rc1, but since the iio tree
>> got the prerequisite already, I'm sending it right away.
> It's not there yet as the mpu-3050 has to go round again
> for other reasons.  As such I haven't yet pulled your branch.
> This patch isn't going to justify the pull on it's own.
>
> I'll try and remember to pick it up when Linus gets back with
> the final mpu-3050 and I pull your tree in.

I think it sounds stressy and messy.

I'll just hold the driver for v4.10, there is no hurry.

Yours,
Linus Walleij
