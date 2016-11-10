Return-Path: <peda@axentia.se>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: inform the i2c mux core about how
 it is used
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
References: <1472630560-4905-1-git-send-email-peda@axentia.se>
 <8a4804d5-3d92-fff0-e48e-beebfb8ba1e2@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>, Crestez
 Dan Leonard <leonard.crestez@intel.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <4765c3f7-dcdb-bc4c-4812-6542202d2405@axentia.se>
Date: Thu, 10 Nov 2016 10:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <8a4804d5-3d92-fff0-e48e-beebfb8ba1e2@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-09-03 18:30, Jonathan Cameron wrote:
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
> 
> If not give me a poke!

Friendly *poke* :-)

Cheers,
Peter
