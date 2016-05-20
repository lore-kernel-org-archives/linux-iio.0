Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH v2 2/7] iio: inv_mpu6050: Initial regcache support
To: Peter Rosin <peda@axentia.se>, Matt Ranostay <mranostay@gmail.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <e29974565e941e37684fcd883330915cfaf2cf47.1463582011.git.leonard.crestez@intel.com>
 <CAKzfze8dDENOvaDf_VH8MRy-HEmCu3q_aGEzD+GYR7B1Ob2rBw@mail.gmail.com>
 <e0cee595-043b-3642-9e40-2a23975e855a@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Ge Gao <ggao@invensense.com>,
 linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <61c0fb3d-207a-c126-b80c-f1342fda5878@intel.com>
Date: Fri, 20 May 2016 14:01:55 +0300
MIME-Version: 1.0
In-Reply-To: <e0cee595-043b-3642-9e40-2a23975e855a@axentia.se>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/20/2016 09:39 AM, Peter Rosin wrote:
> On 2016-05-20 04:34, Matt Ranostay wrote:
>> On Wed, May 18, 2016 at 8:00 AM, Crestez Dan Leonard
>> <leonard.crestez@intel.com> wrote:
>>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>>> ---
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 47 ++++++++++++++++++++++++++++++
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  5 ----
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 +
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 ----
>>>  4 files changed, 48 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index b269b37..5918c23 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -116,6 +116,53 @@ static const struct inv_mpu6050_hw hw_info[] = {
>>>         },
>>>  };
>>>
>>> +static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +       if (reg >= INV_MPU6050_REG_RAW_ACCEL && reg < INV_MPU6050_REG_RAW_ACCEL + 6)
>>> +               return true;
>>> +       if (reg >= INV_MPU6050_REG_RAW_GYRO && reg < INV_MPU6050_REG_RAW_GYRO + 6)
>>> +               return true;
>>
>> I think you want to put parenthesis around the addition operations...
> 
> Maybe.
> 
>> the condition check probably don't evaluate to what you are expecting.
> 
> Looks sane to me since + has highest precedence, then < and >=, and && comes
> in last...
> 
> ...but even so, I think I would use an ellipsis in the switch statement
> instead, like so:
> 
> static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case INV_MPU6050_REG_RAW_ACCEL ... INV_MPU6050_REG_RAW_ACCEL + 5:
> 	case INV_MPU6050_REG_RAW_GYRO ... INV_MPU6050_REG_RAW_GYRO  + 5:
> 	case INV_MPU6050_REG_TEMPERATURE:
> 	case INV_MPU6050_REG_TEMPERATURE + 1:
> 	case INV_MPU6050_REG_USER_CTRL:
> 	case INV_MPU6050_REG_PWR_MGMT_1:
> 	case INV_MPU6050_REG_FIFO_COUNT_H:
> 	case INV_MPU6050_REG_FIFO_COUNT_H + 1:
> 	case INV_MPU6050_REG_FIFO_R_W:
> 		return true;
> 	default:
> 		return false;
> 	}
> }

Neat, I didn't know about this extension. It does look nicer in this
function.
