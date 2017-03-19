Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48394 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdCSKua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:50:30 -0400
Subject: Re: [PATCH v2 02/17] iio: mlx96014: Add OF device ID table
To: Crt Mori <cmo@melexis.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-3-javier@osg.samsung.com>
 <CAKv63ut_b2-hGVHfS0Pa52oiajMJOoOXDBATJ2FPua7rtZxeEg@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8570bd1a-a74b-36e2-b0a0-8a4e29e2c838@kernel.org>
Date: Sun, 19 Mar 2017 10:49:53 +0000
MIME-Version: 1.0
In-Reply-To: <CAKv63ut_b2-hGVHfS0Pa52oiajMJOoOXDBATJ2FPua7rtZxeEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 10:46, Crt Mori wrote:
> Hi,
> Thanks for the patch. If the assumption will not be there than this
> fix is needed. I tested it on BeagleBoneBlack and it does not effect
> anything.
> 
> Tested-by: Crt Mori <cmo@melexis.com>
> Acked-by: Crt Mori <cmo@melexis.com>
Applied.

Thanks,

Jonathan
> 
> Best regards,
> Crt
> 
> 
> On 15 March 2017 at 05:44, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  drivers/iio/temperature/mlx90614.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
>> index 4b645fc672aa..2077eef4095c 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -585,6 +585,12 @@ static const struct i2c_device_id mlx90614_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
>>
>> +static const struct of_device_id mlx90614_of_match[] = {
>> +       { .compatible = "melexis,mlx90614" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, mlx90614_of_match);
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  static int mlx90614_pm_suspend(struct device *dev)
>>  {
>> @@ -644,6 +650,7 @@ static const struct dev_pm_ops mlx90614_pm_ops = {
>>  static struct i2c_driver mlx90614_driver = {
>>         .driver = {
>>                 .name   = "mlx90614",
>> +               .of_match_table = mlx90614_of_match,
>>                 .pm     = &mlx90614_pm_ops,
>>         },
>>         .probe = mlx90614_probe,
>> --
>> 2.9.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

