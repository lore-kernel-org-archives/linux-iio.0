Return-Path: <SRS0=IFCX=A2=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170924165010.03f06740@archlinux>
References: <20170923191052.14419-1-lorenzo.bianconi@st.com>
 <20170923191052.14419-2-lorenzo.bianconi@st.com> <20170924165010.03f06740@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 25 Sep 2017 09:37:21 +0200
Message-ID: <CAA2SeNLaFm4p5e-E5azU8gFwhYwFwaJ2_Fm4j62VepOQt7wnMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: remove LIR configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Sat, 23 Sep 2017 21:10:51 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Remove Latched Interrupt configuration since it is enabled by default
>> for FIFO watermark interrupt
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>
> Not the most detailed explanation ever of a change, but I guess it
> suffices (just!)

Ack, sorry :)
Watermark interrupt rises when the number of bytes written in FIFO is
equal or grater than the watermark level and it is reset when number
of samples is lower than that threshold.
Consequently the is no need to configure latched mode for that interrupt source.

Regards,
Lorenzo


>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index c68cc7c91928..37d6e324ae74 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -56,8 +56,6 @@
>>  #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK     BIT(5)
>>  #define ST_LSM6DSX_REG_ROUNDING_ADDR         0x16
>>  #define ST_LSM6DSX_REG_ROUNDING_MASK         BIT(2)
>> -#define ST_LSM6DSX_REG_LIR_ADDR                      0x58
>> -#define ST_LSM6DSX_REG_LIR_MASK                      BIT(0)
>>
>>  #define ST_LSM6DSX_REG_ACC_ODR_ADDR          0x10
>>  #define ST_LSM6DSX_REG_ACC_ODR_MASK          GENMASK(7, 4)
>> @@ -607,12 +605,6 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>>
>>       msleep(200);
>>
>> -     /* latch interrupts */
>> -     err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_LIR_ADDR,
>> -                                      ST_LSM6DSX_REG_LIR_MASK, 1);
>> -     if (err < 0)
>> -             return err;
>> -
>>       /* enable Block Data Update */
>>       err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_BDU_ADDR,
>>                                        ST_LSM6DSX_REG_BDU_MASK, 1);
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
