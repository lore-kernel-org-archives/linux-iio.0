Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E32EB21.2010000@cam.ac.uk>
Date: Fri, 29 Jul 2011 18:17:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio: remove broken support for multiple event
 interfaces.
References: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk> <1311600911-20353-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311600911-20353-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/25/11 14:35, Jonathan Cameron wrote:
> We don't have a use case for these.  Two drivers appeared to use them
> but both report all events on the first.
Silly bug in here as well.  It subtracts one from an unsigned before doing a
comparison.  Result is that for some devices, the masklength will end up as 0
and hence all sorts of fun will occur. Sorry about that, will be fixed in the
git tree in a few mins.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c |   13 +--
>  drivers/staging/iio/accel/sca3000_core.c   |    9 +-
>  drivers/staging/iio/adc/ad7150.c           |   21 +++--
>  drivers/staging/iio/adc/ad7291.c           |   13 +--
>  drivers/staging/iio/adc/ad7745.c           |    5 +-
>  drivers/staging/iio/adc/ad7816.c           |    5 +-
>  drivers/staging/iio/adc/ad799x_core.c      |    4 +-
>  drivers/staging/iio/adc/adt7310.c          |    7 +-
>  drivers/staging/iio/adc/adt7410.c          |    7 +-
>  drivers/staging/iio/adc/adt75.c            |    3 +-
>  drivers/staging/iio/adc/max1363_core.c     |    4 +-
>  drivers/staging/iio/addac/adt7316.c        |   18 ++--
>  drivers/staging/iio/dac/ad5504.c           |    4 +-
>  drivers/staging/iio/iio.h                  |   11 +--
>  drivers/staging/iio/industrialio-core.c    |  146 +++++++++++++--------------
>  drivers/staging/iio/light/tsl2563.c        |    3 +-
>  16 files changed, 123 insertions(+), 150 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 062632b..83c12b0 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -451,7 +451,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  				 &t);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Z,
> @@ -460,7 +460,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Z,
> @@ -469,7 +469,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Y,
> @@ -478,7 +478,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Y,
> @@ -487,7 +487,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_X,
> @@ -496,7 +496,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_X,
> @@ -650,7 +650,6 @@ static const struct attribute_group lis3l02dq_attribute_group = {
>  };
>  
>  static const struct iio_info lis3l02dq_info = {
> -	.num_interrupt_lines = 1,
>  	.read_raw = &lis3l02dq_read_raw,
>  	.write_raw = &lis3l02dq_write_raw,
>  	.read_event_value = &lis3l02dq_read_thresh,
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 9d1e699..02ff6ba 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -814,7 +814,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  	sca3000_ring_int_process(val, indio_dev->ring);
>  
>  	if (val & SCA3000_INT_STATUS_FREE_FALL)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_X_AND_Y_AND_Z,
> @@ -823,7 +823,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  			       last_timestamp);
>  
>  	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Y,
> @@ -832,7 +832,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  			       last_timestamp);
>  
>  	if (val & SCA3000_INT_STATUS_X_TRIGGER)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_X,
> @@ -841,7 +841,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  			       last_timestamp);
>  
>  	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
>  						  IIO_MOD_Z,
> @@ -1102,7 +1102,6 @@ error_ret:
>  static const struct iio_info sca3000_info = {
>  	.attrs = &sca3000_attribute_group,
>  	.read_raw = &sca3000_read_raw,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &sca3000_event_attribute_group,
>  	.read_event_value = &sca3000_read_thresh,
>  	.write_event_value = &sca3000_write_thresh,
> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
> index 672493e..240c208 100644
> --- a/drivers/staging/iio/adc/ad7150.c
> +++ b/drivers/staging/iio/adc/ad7150.c
> @@ -650,30 +650,34 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  
>  	ad7150_i2c_read(chip, AD7150_STATUS, &int_status, 1);
>  
> -	if ((int_status & AD7150_STATUS_OUT1) && !(chip->old_state & AD7150_STATUS_OUT1))
> -		iio_push_event(indio_dev, 0,
> +	if ((int_status & AD7150_STATUS_OUT1) &&
> +	    !(chip->old_state & AD7150_STATUS_OUT1))
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
>  				timestamp);
> -	else if ((!(int_status & AD7150_STATUS_OUT1)) && (chip->old_state & AD7150_STATUS_OUT1))
> -		iio_push_event(indio_dev, 0,
> +	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
> +		 (chip->old_state & AD7150_STATUS_OUT1))
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
>  			       timestamp);
>  
> -	if ((int_status & AD7150_STATUS_OUT2) && !(chip->old_state & AD7150_STATUS_OUT2))
> -		iio_push_event(indio_dev, 0,
> +	if ((int_status & AD7150_STATUS_OUT2) &&
> +	    !(chip->old_state & AD7150_STATUS_OUT2))
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  						    1,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
>  			       timestamp);
> -	else if ((!(int_status & AD7150_STATUS_OUT2)) && (chip->old_state & AD7150_STATUS_OUT2))
> -		iio_push_event(indio_dev, 0,
> +	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
> +		 (chip->old_state & AD7150_STATUS_OUT2))
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  						    1,
>  						    IIO_EV_TYPE_THRESH,
> @@ -702,7 +706,6 @@ static struct attribute_group ad7150_event_attribute_group = {
>  
>  static const struct iio_info ad7150_info = {
>  	.attrs = &ad7150_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad7150_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 96cbb17..3991633 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -478,28 +478,28 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
>  	ad7291_i2c_write(chip, AD7291_COMMAND, command);
>  
>  	if (t_status & (1 << 0))
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
>  			       timestamp);
>  	if (t_status & (1 << 1))
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
>  			       timestamp);
>  	if (t_status & (1 << 2))
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
>  			       timestamp);
>  	if (t_status & (1 << 3))
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
> @@ -508,14 +508,14 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
>  
>  	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i += 2) {
>  		if (v_status & (1 << i))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  							    i/2,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_FALLING),
>  				       timestamp);
>  		if (v_status & (1 << (i + 1)))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  							    i/2,
>  							    IIO_EV_TYPE_THRESH,
> @@ -779,7 +779,6 @@ static struct attribute_group ad7291_event_attribute_group = {
>  
>  static const struct iio_info ad7291_info = {
>  	.attrs = &ad7291_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad7291_event_attribute_group,
>  };
>  
> diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
> index d6e18e1..4a504ce 100644
> --- a/drivers/staging/iio/adc/ad7745.c
> +++ b/drivers/staging/iio/adc/ad7745.c
> @@ -539,12 +539,12 @@ static irqreturn_t ad774x_event_handler(int irq, void *private)
>  	ad774x_i2c_read(chip, AD774X_STATUS, &int_status, 1);
>  
>  	if (int_status & AD774X_STATUS_RDYCAP)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_EVENT_CODE_CAP_RDY,
>  			       iio_get_time_ns());
>  
>  	if (int_status & AD774X_STATUS_RDYVT)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_EVENT_CODE_VT_RDY,
>  			       iio_get_time_ns());
>  
> @@ -568,7 +568,6 @@ static struct attribute_group ad774x_event_attribute_group = {
>  static const struct iio_info ad774x_info = {
>  	.attrs = &ad774x_event_attribute_group,
>  	.event_attrs = &ad774x_event_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.driver_module = THIS_MODULE,
>  };
>  /*
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 91a61fc..fb861fb 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -253,9 +253,7 @@ static const struct attribute_group ad7816_attribute_group = {
>  
>  static irqreturn_t ad7816_event_handler(int irq, void *private)
>  {
> -	iio_push_event(private, 0,
> -		       IIO_EVENT_CODE_AD7816_OTI,
> -		       iio_get_time_ns());
> +	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI, iio_get_time_ns());
>  	return IRQ_HANDLED;
>  }
>  
> @@ -333,7 +331,6 @@ static struct attribute_group ad7816_event_attribute_group = {
>  
>  static const struct iio_info ad7816_info = {
>  	.attrs = &ad7816_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad7816_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 33d7fb1..11d0add 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -333,7 +333,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
>  
>  	for (i = 0; i < 8; i++) {
>  		if (status & (1 << i))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       i & 0x1 ?
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  							    (i >> 1),
> @@ -473,14 +473,12 @@ static const struct iio_info ad7991_info = {
>  
>  static const struct iio_info ad7992_info = {
>  	.read_raw = &ad799x_read_raw,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad7992_event_attrs_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad7993_4_7_8_info = {
>  	.read_raw = &ad799x_read_raw,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad7993_4_7_8_event_attrs_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
> index 2ed5e84..8f5c3fc 100644
> --- a/drivers/staging/iio/adc/adt7310.c
> +++ b/drivers/staging/iio/adc/adt7310.c
> @@ -399,19 +399,19 @@ static irqreturn_t adt7310_event_handler(int irq, void *private)
>  		return ret;
>  
>  	if (status & ADT7310_STAT_T_HIGH)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
>  			       timestamp);
>  	if (status & ADT7310_STAT_T_LOW)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
>  			       timestamp);
>  	if (status & ADT7310_STAT_T_CRIT)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
> @@ -749,7 +749,6 @@ static struct attribute_group adt7310_event_attribute_group[ADT7310_IRQS] = {
>  
>  static const struct iio_info adt7310_info = {
>  	.attrs = &adt7310_attribute_group,
> -	.num_interrupt_lines = ADT7310_IRQS,
>  	.event_attrs = adt7310_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
> index 0387c7c..c7b1ceb 100644
> --- a/drivers/staging/iio/adc/adt7410.c
> +++ b/drivers/staging/iio/adc/adt7410.c
> @@ -365,19 +365,19 @@ static irqreturn_t adt7410_event_handler(int irq, void *private)
>  		return IRQ_HANDLED;
>  
>  	if (status & ADT7410_STAT_T_HIGH)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
>  			       timestamp);
>  	if (status & ADT7410_STAT_T_LOW)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
>  			       timestamp);
>  	if (status & ADT7410_STAT_T_CRIT)
> -		iio_push_event(indio_dev, 0,
> +		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
> @@ -716,7 +716,6 @@ static struct attribute_group adt7410_event_attribute_group[ADT7410_IRQS] = {
>  
>  static const struct iio_info adt7410_info = {
>  	.attrs = &adt7410_attribute_group,
> -	.num_interrupt_lines = ADT7410_IRQS,
>  	.event_attrs = adt7410_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
> index ed42945..a306dbd 100644
> --- a/drivers/staging/iio/adc/adt75.c
> +++ b/drivers/staging/iio/adc/adt75.c
> @@ -264,7 +264,7 @@ static const struct attribute_group adt75_attribute_group = {
>  
>  static irqreturn_t adt75_event_handler(int irq, void *private)
>  {
> -	iio_push_event(private, 0,
> +	iio_push_event(private,
>  		       IIO_EVENT_CODE_ADT75_OTI,
>  		       iio_get_time_ns());
>  
> @@ -534,7 +534,6 @@ static struct attribute_group adt75_event_attribute_group = {
>  
>  static const struct iio_info adt75_info = {
>  	.attrs = &adt75_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &adt75_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index d4a200a..ad2631d 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -614,8 +614,7 @@ static irqreturn_t max1363_event_handler(int irq, void *private)
>  	i2c_master_recv(st->client, &rx, 1);
>  	mask = rx;
>  	for_each_set_bit(loc, &mask, 8)
> -		iio_push_event(indio_dev, 0, max1363_event_codes[loc],
> -			       timestamp);
> +		iio_push_event(indio_dev, max1363_event_codes[loc], timestamp);
>  	i2c_master_send(st->client, tx, 2);
>  
>  	return IRQ_HANDLED;
> @@ -844,7 +843,6 @@ static const struct iio_info max1363_info = {
>  	.write_event_config = &max1363_write_event_config,
>  	.read_raw = &max1363_read_raw,
>  	.driver_module = THIS_MODULE,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &max1363_event_attribute_group,
>  };
>  
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index ea6e994..bc7a196 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1776,43 +1776,43 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  
>  		time = iio_get_time_ns();
>  		if (stat1 & (1 << 0))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_RISING),
>  				       time);
>  		if (stat1 & (1 << 1))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_FALLING),
>  				       time);
>  		if (stat1 & (1 << 2))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_RISING),
>  				       time);
>  		if (stat1 & (1 << 3))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_FALLING),
>  				       time);
>  		if (stat1 & (1 << 5))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN, 1,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_EITHER),
>  				       time);
>  		if (stat1 & (1 << 6))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN, 2,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_EITHER),
>  				       time);
>  		if (stat1 & (1 << 7))
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN, 3,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_EITHER),
> @@ -1821,7 +1821,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
>  	if (!ret) {
>  		if (stat2 & ADT7316_INT_MASK2_VDD)
> -			iio_push_event(indio_dev, 0,
> +			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_IN,
>  							    0,
>  							    IIO_EV_TYPE_THRESH,
> @@ -2109,14 +2109,12 @@ EXPORT_SYMBOL(adt7316_enable);
>  
>  static const struct iio_info adt7316_info = {
>  	.attrs = &adt7316_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &adt7316_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info adt7516_info = {
>  	.attrs = &adt7516_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &adt7516_event_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
> index c706ea4..54c8198 100644
> --- a/drivers/staging/iio/dac/ad5504.c
> +++ b/drivers/staging/iio/dac/ad5504.c
> @@ -251,7 +251,7 @@ static struct attribute_group ad5504_ev_attribute_group = {
>  
>  static irqreturn_t ad5504_event_handler(int irq, void *private)
>  {
> -	iio_push_event(private, 0,
> +	iio_push_event(private,
>  		       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
> @@ -263,14 +263,12 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
>  
>  static const struct iio_info ad5504_info = {
>  	.attrs = &ad5504_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad5504_ev_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad5501_info = {
>  	.attrs = &ad5501_attribute_group,
> -	.num_interrupt_lines = 1,
>  	.event_attrs = &ad5504_ev_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 4311a36..480b4d0 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -206,7 +206,6 @@ struct iio_dev;
>   * struct iio_info - constant information about device
>   * @driver_module:	module structure used to ensure correct
>   *			ownership of chrdevs etc
> - * @num_interrupt_lines:number of physical interrupt lines from device
>   * @event_attrs:	event control attributes
>   * @attrs:		general purpose device attributes
>   * @read_raw:		function to request a value from the device.
> @@ -230,7 +229,6 @@ struct iio_dev;
>   **/
>  struct iio_info {
>  	struct module			*driver_module;
> -	int				num_interrupt_lines;
>  	struct attribute_group		*event_attrs;
>  	const struct attribute_group	*attrs;
>  
> @@ -275,7 +273,7 @@ struct iio_info {
>   * @currentmode:	[DRIVER] current operating mode
>   * @dev:		[DRIVER] device structure, should be assigned a parent
>   *			and owner
> - * @event_interfaces:	[INTERN] event chrdevs associated with interrupt lines
> + * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
>   * @ring:		[DRIVER] any ring buffer present
>   * @mlock:		[INTERN] lock used to prevent simultaneous device state
>   *			changes
> @@ -295,7 +293,7 @@ struct iio_dev {
>  	int				currentmode;
>  	struct device			dev;
>  
> -	struct iio_event_interface	*event_interfaces;
> +	struct iio_event_interface	*event_interface;
>  
>  	struct iio_ring_buffer		*ring;
>  	struct mutex			mlock;
> @@ -332,10 +330,7 @@ void iio_device_unregister(struct iio_dev *dev_info);
>   * @ev_code:		What event
>   * @timestamp:		When the event occurred
>   **/
> -int iio_push_event(struct iio_dev *dev_info,
> -		  int ev_line,
> -		  int ev_code,
> -		  s64 timestamp);
> +int iio_push_event(struct iio_dev *dev_info, int ev_code,  s64 timestamp);
>  
>  extern struct bus_type iio_bus_type;
>  
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 06ffc48..77b5b2d 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -150,13 +150,9 @@ struct iio_event_interface {
>  	unsigned long flags;
>  };
>  
> -int iio_push_event(struct iio_dev *dev_info,
> -		   int ev_line,
> -		   int ev_code,
> -		   s64 timestamp)
> +int iio_push_event(struct iio_dev *dev_info, int ev_code, s64 timestamp)
>  {
> -	struct iio_event_interface *ev_int
> -		= &dev_info->event_interfaces[ev_line];
> +	struct iio_event_interface *ev_int = dev_info->event_interface;
>  	struct iio_detected_event_list *ev;
>  	int ret = 0;
>  
> @@ -295,19 +291,19 @@ static void iio_device_free_chrdev_minor(int val)
>  
>  static int iio_event_getfd(struct iio_dev *indio_dev)
>  {
> -	if (indio_dev->event_interfaces == NULL)
> +	if (indio_dev->event_interface == NULL)
>  		return -ENODEV;
>  
> -	mutex_lock(&indio_dev->event_interfaces->event_list_lock);
> +	mutex_lock(&indio_dev->event_interface->event_list_lock);
>  	if (test_and_set_bit(IIO_BUSY_BIT_POS,
> -			     &indio_dev->event_interfaces->flags)) {
> -		mutex_unlock(&indio_dev->event_interfaces->event_list_lock);
> +			     &indio_dev->event_interface->flags)) {
> +		mutex_unlock(&indio_dev->event_interface->event_list_lock);
>  		return -EBUSY;
>  	}
> -	mutex_unlock(&indio_dev->event_interfaces->event_list_lock);
> +	mutex_unlock(&indio_dev->event_interface->event_list_lock);
>  	return anon_inode_getfd("iio:event",
>  				&iio_event_chrdev_fileops,
> -				&indio_dev->event_interfaces[0], O_RDONLY);
> +				indio_dev->event_interface, O_RDONLY);
>  }
>  
>  static void iio_setup_ev_int(struct iio_event_interface *ev_int)
> @@ -907,7 +903,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
>  					       how far*/
>  					     0,
>  					     &dev_info->dev,
> -					     &dev_info->event_interfaces[0].
> +					     &dev_info->event_interface->
>  					     dev_attr_list);
>  		kfree(postfix);
>  		if (ret)
> @@ -926,8 +922,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
>  					     mask,
>  					     0,
>  					     &dev_info->dev,
> -					     &dev_info->event_interfaces[0]
> -					     .dev_attr_list);
> +					     &dev_info->event_interface->
> +					     dev_attr_list);
>  		kfree(postfix);
>  		if (ret)
>  			goto error_ret;
> @@ -938,12 +934,11 @@ error_ret:
>  	return ret;
>  }
>  
> -static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info,
> -						  int i)
> +static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info)
>  {
>  	struct iio_dev_attr *p, *n;
>  	list_for_each_entry_safe(p, n,
> -				 &dev_info->event_interfaces[i].
> +				 &dev_info->event_interface->
>  				 dev_attr_list, l) {
>  		sysfs_remove_file_from_group(&dev_info->dev.kobj,
>  					     &p->dev_attr.attr,
> @@ -953,25 +948,23 @@ static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info,
>  	}
>  }
>  
> -static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
> +static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info)
>  {
>  	int j;
>  	int ret;
> -	INIT_LIST_HEAD(&dev_info->event_interfaces[i].dev_attr_list);
> +	INIT_LIST_HEAD(&dev_info->event_interface->dev_attr_list);
>  	/* Dynically created from the channels array */
> -	if (dev_info->channels) {
> -		for (j = 0; j < dev_info->num_channels; j++) {
> -			ret = iio_device_add_event_sysfs(dev_info,
> -							 &dev_info
> -							 ->channels[j]);
> -			if (ret)
> -				goto error_clear_attrs;
> -		}
> +	for (j = 0; j < dev_info->num_channels; j++) {
> +
> +		ret = iio_device_add_event_sysfs(dev_info,
> +						 &dev_info->channels[j]);
> +		if (ret)
> +			goto error_clear_attrs;
>  	}
>  	return 0;
>  
>  error_clear_attrs:
> -	__iio_remove_event_config_attrs(dev_info, i);
> +	__iio_remove_event_config_attrs(dev_info);
>  
>  	return ret;
>  }
> @@ -985,42 +978,49 @@ static struct attribute_group iio_events_dummy_group = {
>  	.attrs = iio_events_dummy_attrs
>  };
>  
> +static bool iio_check_for_dynamic_events(struct iio_dev *dev_info)
> +{
> +	int j;
> +	for (j = 0; j < dev_info->num_channels; j++)
> +		if (dev_info->channels[j].event_mask != 0)
> +			return true;
> +	return false;
> +}
> +
>  static int iio_device_register_eventset(struct iio_dev *dev_info)
>  {
> -	int ret = 0, i, j;
> +	int ret = 0;
>  
> -	if (dev_info->info->num_interrupt_lines == 0)
> +	if (!(dev_info->info->event_attrs ||
> +	      iio_check_for_dynamic_events(dev_info)))
>  		return 0;
>  
> -	dev_info->event_interfaces =
> -		kzalloc(sizeof(struct iio_event_interface)
> -			*dev_info->info->num_interrupt_lines,
> -			GFP_KERNEL);
> -	if (dev_info->event_interfaces == NULL) {
> +	dev_info->event_interface =
> +		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> +	if (dev_info->event_interface == NULL) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
>  
> -	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
> -		iio_setup_ev_int(&dev_info->event_interfaces[i]);
> -		if (dev_info->info->event_attrs != NULL)
> -			ret = sysfs_create_group(&dev_info->dev.kobj,
> -						 &dev_info->info
> -						 ->event_attrs[i]);
> -		else
> -			ret = sysfs_create_group(&dev_info->dev.kobj,
> -						 &iio_events_dummy_group);
> -		if (ret) {
> -			dev_err(&dev_info->dev,
> -				"Failed to register sysfs for event attrs");
> -			goto error_free_setup_event_lines;
> -		}
> -		ret = __iio_add_event_config_attrs(dev_info, i);
> +	iio_setup_ev_int(dev_info->event_interface);
> +	if (dev_info->info->event_attrs != NULL)
> +		ret = sysfs_create_group(&dev_info->dev.kobj,
> +					 dev_info->info->event_attrs);
> +	else
> +		ret = sysfs_create_group(&dev_info->dev.kobj,
> +					 &iio_events_dummy_group);
> +	if (ret) {
> +		dev_err(&dev_info->dev,
> +			"Failed to register sysfs for event attrs");
> +		goto error_free_setup_event_lines;
> +	}
> +	if (dev_info->channels) {
> +		ret = __iio_add_event_config_attrs(dev_info);
>  		if (ret) {
>  			if (dev_info->info->event_attrs != NULL)
>  				sysfs_remove_group(&dev_info->dev.kobj,
> -						   &dev_info->info
> -						   ->event_attrs[i]);
> +						   dev_info->info
> +						   ->event_attrs);
>  			else
>  				sysfs_remove_group(&dev_info->dev.kobj,
>  						   &iio_events_dummy_group);
> @@ -1031,16 +1031,14 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
>  	return 0;
>  
>  error_free_setup_event_lines:
> -	for (j = 0; j < i; j++) {
> -		__iio_remove_event_config_attrs(dev_info, j);
> -		if (dev_info->info->event_attrs != NULL) {
> -			sysfs_remove_group(&dev_info->dev.kobj,
> -					   &dev_info->info->event_attrs[j]);
> -			sysfs_remove_group(&dev_info->dev.kobj,
> -					   &iio_events_dummy_group);
> -		}
> -	}
> -	kfree(dev_info->event_interfaces);
> +	__iio_remove_event_config_attrs(dev_info);
> +	if (dev_info->info->event_attrs != NULL)
> +		sysfs_remove_group(&dev_info->dev.kobj,
> +				   dev_info->info->event_attrs);
> +	else
> +		sysfs_remove_group(&dev_info->dev.kobj,
> +				   &iio_events_dummy_group);
> +	kfree(dev_info->event_interface);
>  error_ret:
>  
>  	return ret;
> @@ -1048,20 +1046,16 @@ error_ret:
>  
>  static void iio_device_unregister_eventset(struct iio_dev *dev_info)
>  {
> -	int i;
> -
> -	if (dev_info->info->num_interrupt_lines == 0)
> +	if (dev_info->event_interface == NULL)
>  		return;
> -	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
> -		__iio_remove_event_config_attrs(dev_info, i);
> -		if (dev_info->info->event_attrs != NULL)
> -			sysfs_remove_group(&dev_info->dev.kobj,
> -					   &dev_info->info->event_attrs[i]);
> -		else
> -			sysfs_remove_group(&dev_info->dev.kobj,
> -					   &iio_events_dummy_group);
> -	}
> -	kfree(dev_info->event_interfaces);
> +	__iio_remove_event_config_attrs(dev_info);
> +	if (dev_info->info->event_attrs != NULL)
> +		sysfs_remove_group(&dev_info->dev.kobj,
> +				   dev_info->info->event_attrs);
> +	else
> +		sysfs_remove_group(&dev_info->dev.kobj,
> +				   &iio_events_dummy_group);
> +	kfree(dev_info->event_interface);
>  }
>  
>  static void iio_dev_release(struct device *device)
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
> index 7c4cc9e..10a658d 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -595,7 +595,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
>  	struct iio_dev *dev_info = private;
>  	struct tsl2563_chip *chip = iio_priv(dev_info);
>  
> -	iio_push_event(dev_info, 0,
> +	iio_push_event(dev_info,
>  		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
> @@ -680,7 +680,6 @@ static const struct iio_info tsl2563_info_no_irq = {
>  
>  static const struct iio_info tsl2563_info = {
>  	.driver_module = THIS_MODULE,
> -	.num_interrupt_lines = 1,
>  	.read_raw = &tsl2563_read_raw,
>  	.write_raw = &tsl2563_write_raw,
>  	.read_event_value = &tsl2563_read_thresh,
