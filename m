Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50535 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbcL3Kt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 05:49:56 -0500
Subject: Re: [PATCH v2 5/6] iio: bmi160: Fix time needed to sleep after
 command execution
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
 <20161208142259.26230-6-m.niestroj@grinn-global.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7668f191-dafd-e616-171a-cafc52791292@kernel.org>
Date: Fri, 30 Dec 2016 10:49:54 +0000
MIME-Version: 1.0
In-Reply-To: <20161208142259.26230-6-m.niestroj@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/16 14:22, Marcin Niestroj wrote:
> Datasheet specifies typical and maximum execution times for which CMD
> register is occupied after previous command execution. We took these
> values as minimum and maximum time for usleep_range() call before making
> a new command execution.
> 
> To be sure, that the CMD register is no longer occupied we need to wait
> *at least* the maximum time specified by datasheet.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
This looks like a definite bug that we would want to fix in stable as well.
If possible, could you ensure this is the first patch in the updated series?

Thanks,

Jonathan
> ---
> Patch introduced in v2
> 
>  drivers/iio/imu/bmi160/bmi160_core.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 095533c..88bcf3f 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -67,10 +67,8 @@
>  
>  #define BMI160_REG_DUMMY		0x7F
>  
> -#define BMI160_ACCEL_PMU_MIN_USLEEP	3200
> -#define BMI160_ACCEL_PMU_MAX_USLEEP	3800
> -#define BMI160_GYRO_PMU_MIN_USLEEP	55000
> -#define BMI160_GYRO_PMU_MAX_USLEEP	80000
> +#define BMI160_ACCEL_PMU_MIN_USLEEP	3800
> +#define BMI160_GYRO_PMU_MIN_USLEEP	80000
>  #define BMI160_SOFTRESET_USLEEP		1000
>  
>  #define BMI160_CHANNEL(_type, _axis, _index) {			\
> @@ -153,20 +151,9 @@ static struct bmi160_regs bmi160_regs[] = {
>  	},
>  };
>  
> -struct bmi160_pmu_time {
> -	unsigned long min;
> -	unsigned long max;
> -};
> -
> -static struct bmi160_pmu_time bmi160_pmu_time[] = {
> -	[BMI160_ACCEL] = {
> -		.min = BMI160_ACCEL_PMU_MIN_USLEEP,
> -		.max = BMI160_ACCEL_PMU_MAX_USLEEP
> -	},
> -	[BMI160_GYRO] = {
> -		.min = BMI160_GYRO_PMU_MIN_USLEEP,
> -		.max = BMI160_GYRO_PMU_MIN_USLEEP,
> -	},
> +static unsigned long bmi160_pmu_time[] = {
> +	[BMI160_ACCEL] = BMI160_ACCEL_PMU_MIN_USLEEP,
> +	[BMI160_GYRO] = BMI160_GYRO_PMU_MIN_USLEEP,
>  };
>  
>  struct bmi160_scale {
> @@ -293,7 +280,7 @@ int bmi160_set_mode(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	if (ret < 0)
>  		return ret;
>  
> -	usleep_range(bmi160_pmu_time[t].min, bmi160_pmu_time[t].max);
> +	usleep_range(bmi160_pmu_time[t], bmi160_pmu_time[t] + 1000);
>  
>  	return 0;
>  }
> 

