Return-Path: <jic23@cam.ac.uk>
Message-ID: <4D712D72.2070803@cam.ac.uk>
Date: Fri, 04 Mar 2011 18:20:34 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] RFC Staging:iio: move to threaded interrupts for events.
References: <1299261914-15006-1-git-send-email-jic23@cam.ac.uk> <1299261914-15006-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1299261914-15006-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/04/11 18:05, Jonathan Cameron wrote:
> The lis3l02dq is the most complex driver I know of wrt to interrupt
> handling.  The pin is used for dataready and threshold interrupts
> though only one or the other can occur for a given configuration.
> 
> This patch splits the interrupt handling into two separate
> handlers so as to make changing how they work possible.
> To this end we need the means to disable threshold interrupts on
> the enabling of dataready. This requirement adds two core functions
> used to manipulate the list.
> 
> It is also necessary to make the requesting and freeing of the
> threshold event interrupt occur on demand and to do this we have
> to move where it occurs.  This may have all sorts of fun effects
> on other drivers.
oops. Forgot to say.  This sits on top of both patches in
staging:iio:lis3l02dq cs_change fix and cleanups
set.

> 
> ---
>  drivers/staging/iio/accel/lis3l02dq.h      |    4 +-
>  drivers/staging/iio/accel/lis3l02dq_core.c |   68 ++++++++--------
>  drivers/staging/iio/accel/lis3l02dq_ring.c |   96 +++++++++++++++------
>  drivers/staging/iio/iio.h                  |   22 +++++-
>  drivers/staging/iio/industrialio-core.c    |  124 ++++++++++++++++++++--------
>  5 files changed, 214 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
> index 579b3a2..a3c5229 100644
> --- a/drivers/staging/iio/accel/lis3l02dq.h
> +++ b/drivers/staging/iio/accel/lis3l02dq.h
> @@ -150,7 +150,6 @@ Form of high byte dependant on justification set in ctrl reg */
>   * struct lis3l02dq_state - device instance specific data
>   * @helper:		data and func pointer allowing generic functions
>   * @us:			actual spi_device
> - * @work_thresh:	bh for threshold events
>   * @thresh_timestamp:	timestamp for threshold interrupts.
>   * @inter:		used to check if new interrupt has been triggered
>   * @trig:		data ready trigger registered with iio
> @@ -161,13 +160,14 @@ Form of high byte dependant on justification set in ctrl reg */
>  struct lis3l02dq_state {
>  	struct iio_sw_ring_helper_state	help;
>  	struct spi_device		*us;
> -	struct work_struct		work_thresh;
>  	s64				thresh_timestamp;
>  	bool				inter;
>  	struct iio_trigger		*trig;
>  	u8				*tx;
>  	u8				*rx;
>  	struct mutex			buf_lock;
> +	struct list_head		event_list_cpy;
> +	u8				event_reg_cpy;
>  };
>  
>  #define lis3l02dq_h_to_s(_h)				\
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index bd378bc..c67cb78 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -527,6 +527,11 @@ static ssize_t lis3l02dq_write_interrupt_config(struct device *dev,
>  	val = !(buf[0] == '0');
>  
>  	mutex_lock(&indio_dev->mlock);
> +	if (indio_dev->currentmode != INDIO_DIRECT_MODE) {
> +		ret = -EBUSY;
> +		goto error_mutex_unlock;
> +	}
> +
>  	/* read current value */
>  	ret = lis3l02dq_spi_read_reg_8(dev->parent,
>  				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
> @@ -580,7 +585,7 @@ error_mutex_unlock:
>  }
>  
>  
> -static int lis3l02dq_thresh_handler_th(struct iio_dev *indio_dev,
> +static int lis3l02dq_thresh_handler_bh(struct iio_dev *indio_dev,
>  				       int index,
>  				       s64 timestamp,
>  				       int no_test)
> @@ -588,24 +593,6 @@ static int lis3l02dq_thresh_handler_th(struct iio_dev *indio_dev,
>  	struct iio_sw_ring_helper_state *h
>  		= iio_dev_get_devdata(indio_dev);
>  	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
> -
> -	/* Stash the timestamp somewhere convenient for the bh */
> -	st->thresh_timestamp = timestamp;
> -	schedule_work(&st->work_thresh);
> -
> -	return 0;
> -}
> -
> -
> -/* Unforunately it appears the interrupt won't clear unless you read from the
> - * src register.
> - */
> -static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
> -{
> -       struct lis3l02dq_state *st
> -	       = container_of(work_s,
> -		       struct lis3l02dq_state, work_thresh);
> -
>  	u8 t;
>  
>  	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
> @@ -619,7 +606,7 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_Z,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_RISING),
> -			       st->thresh_timestamp);
> +			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
>  		iio_push_event(st->help.indio_dev, 0,
> @@ -628,7 +615,7 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_Z,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_FALLING),
> -			       st->thresh_timestamp);
> +			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
>  		iio_push_event(st->help.indio_dev, 0,
> @@ -637,7 +624,7 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_Y,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_RISING),
> -			       st->thresh_timestamp);
> +			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
>  		iio_push_event(st->help.indio_dev, 0,
> @@ -646,7 +633,7 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_Y,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_FALLING),
> -			       st->thresh_timestamp);
> +			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
>  		iio_push_event(st->help.indio_dev, 0,
> @@ -655,7 +642,7 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_X,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_RISING),
> -			       st->thresh_timestamp);
> +			       timestamp);
>  
>  	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
>  		iio_push_event(st->help.indio_dev, 0,
> @@ -664,19 +651,18 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
>  						  IIO_EV_MOD_X,
>  						  IIO_EV_TYPE_THRESH,
>  						  IIO_EV_DIR_FALLING),
> -			       st->thresh_timestamp);
> -	/* reenable the irq */
> -	enable_irq(st->us->irq);
> +			       timestamp);
> +
>  	/* Ack and allow for new interrupts */
>  	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
>  				 LIS3L02DQ_REG_WAKE_UP_ACK_ADDR,
>  				 &t);
>  
> -	return;
> +	return IRQ_HANDLED;
>  }
>  
>  /* A shared handler for a number of threshold types */
> -IIO_EVENT_SH(threshold, &lis3l02dq_thresh_handler_th);
> +IIO_EVENT_SH(threshold, &lis3l02dq_thresh_handler_bh);
>  
>  IIO_EVENT_ATTR_SH(accel_x_thresh_rising_en,
>  		  iio_event_threshold,
> @@ -757,12 +743,13 @@ static const struct attribute_group lis3l02dq_attribute_group = {
>  static int __devinit lis3l02dq_probe(struct spi_device *spi)
>  {
>  	int ret, regdone = 0;
> +
>  	struct lis3l02dq_state *st = kzalloc(sizeof *st, GFP_KERNEL);
>  	if (!st) {
>  		ret =  -ENOMEM;
>  		goto error_ret;
>  	}
> -	INIT_WORK(&st->work_thresh, lis3l02dq_thresh_handler_bh_no_check);
> +	INIT_LIST_HEAD(&st->event_list_cpy);
>  	/* this is only used tor removal purposes */
>  	spi_set_drvdata(spi, st);
>  
> @@ -793,6 +780,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
>  	st->help.indio_dev->dev_data = (void *)(&st->help);
>  	st->help.indio_dev->driver_module = THIS_MODULE;
>  	st->help.indio_dev->modes = INDIO_DIRECT_MODE;
> +	st->help.indio_dev->currentmode = INDIO_DIRECT_MODE;
>  
>  	ret = lis3l02dq_configure_ring(st->help.indio_dev);
>  	if (ret)
> @@ -818,7 +806,6 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
>  						  "lis3l02dq");
>  		if (ret)
>  			goto error_uninitialize_ring;
> -
>  		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
>  		if (ret)
>  			goto error_unregister_line;
> @@ -862,9 +849,20 @@ static int lis3l02dq_stop_device(struct iio_dev *indio_dev)
>  	struct iio_sw_ring_helper_state *h
>  		= iio_dev_get_devdata(indio_dev);
>  	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
> -	u8 val = 0;
> +	u8 val;
>  
>  	mutex_lock(&indio_dev->mlock);
> +	/* disable any interrupts to give clean state */
> +	val = LIS3L02DQ_DEFAULT_CTRL2;
> +	ret = lis3l02dq_spi_write_reg_8(&indio_dev->dev,
> +					LIS3L02DQ_REG_CTRL_2_ADDR,
> +					&val);
> +	if (ret) {
> +		dev_err(st->us->dev, "problem disabling interrupt sources");
> +		goto err_ret;
> +	}
> +
> +	val = 0;
>  	ret = lis3l02dq_spi_write_reg_8(&indio_dev->dev,
>  					LIS3L02DQ_REG_CTRL_1_ADDR,
>  					&val);
> @@ -897,8 +895,12 @@ static int lis3l02dq_remove(struct spi_device *spi)
>  	flush_scheduled_work();
>  
>  	lis3l02dq_remove_trigger(indio_dev);
> -	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
> +	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
> +		iio_remove_all_event_from_list(&indio_dev
> +					       ->interrupts[0]->ev_list,
> +					       NULL);
>  		iio_unregister_interrupt_line(indio_dev, 0);
> +	}
>  
>  	iio_ring_buffer_unregister(indio_dev->ring);
>  	lis3l02dq_unconfigure_ring(indio_dev);
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index a9896da..de0355f 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -131,23 +131,14 @@ static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
>  /**
>   * lis3l02dq_data_rdy_trig_poll() the event handler for the data rdy trig
>   **/
> -static int lis3l02dq_data_rdy_trig_poll(struct iio_dev *indio_dev,
> -				       int index,
> -				       s64 timestamp,
> -				       int no_test)
> -{
> -	struct iio_sw_ring_helper_state *h
> -		= iio_dev_get_devdata(indio_dev);
> -	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
> -
> -	iio_trigger_poll(st->trig, timestamp);
>  
> +static irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
> +{
> +	disable_irq_nosync(irq);
> +	iio_trigger_poll(private, iio_get_time_ns());
>  	return IRQ_HANDLED;
>  }
>  
> -/* This is an event as it is a response to a physical interrupt */
> -IIO_EVENT_SH(data_rdy_trig, &lis3l02dq_data_rdy_trig_poll);
> -
>  /**
>   * lis3l02dq_read_accel_from_ring() individual acceleration read from ring
>   **/
> @@ -308,20 +299,22 @@ static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
>  /* Caller responsible for locking as necessary. */
>  static int
>  __lis3l02dq_write_data_ready_config(struct device *dev,
> -				    struct iio_event_handler_list *list,
>  				    bool state)
>  {
>  	int ret;
>  	u8 valold;
>  	bool currentlyset;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct lis3l02dq_state *st = indio_dev->dev_data;
>  
>  /* Get the current event mask register */
>  	ret = lis3l02dq_spi_read_reg_8(dev,
>  				       LIS3L02DQ_REG_CTRL_2_ADDR,
>  				       &valold);
> +
>  	if (ret < 0)
>  		goto error_ret;
> +
>  /* Find out if data ready is already on */
>  	currentlyset
>  		= valold & LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
> @@ -329,8 +322,10 @@ __lis3l02dq_write_data_ready_config(struct device *dev,
>  /* Disable requested */
>  	if (!state && currentlyset) {
>  
> +		/* disable data ready */
>  		valold &= ~LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
> -		/* The double write is to overcome a hardware bug?*/
> +		/* The double write is to overcome a hardware bug?
> +		   REALLY NEED TO CHECK IF THESE NEED TO BE HERE?*/
>  		ret = lis3l02dq_spi_write_reg_8(dev,
>  						LIS3L02DQ_REG_CTRL_2_ADDR,
>  						&valold);
> @@ -342,15 +337,57 @@ __lis3l02dq_write_data_ready_config(struct device *dev,
>  		if (ret)
>  			goto error_ret;
>  
> -		iio_remove_event_from_list(list,
> -					   &indio_dev->interrupts[0]
> -					   ->ev_list);
> +		flush_scheduled_work();
> +
> +		/* now disable the interrupt handling */
> +		free_irq(st->us->irq, st->trig);
>  
> +		/* renable all threshold events */
> +		iio_reenable_all_event_from_list(&indio_dev
> +						 ->interrupts[0]->ev_list,
> +						 &st->event_list_cpy);
> +
> +		lis3l02dq_spi_write_reg_8(dev,
> +					  LIS3L02DQ_REG_CTRL_2_ADDR,
> +					  &st->event_reg_cpy);
>  /* Enable requested */
>  	} else if (state && !currentlyset) {
> +		u8 newval = 0;
> +
> +		/* firstly disable all other interrupt sources */
> +
> +		ret = lis3l02dq_spi_read_reg_8(dev,
> +					       LIS3L02DQ_REG_CTRL_2_ADDR,
> +					       &st->event_reg_cpy);
> +		if (ret < 0)
> +			goto error_ret;
> +		newval = st->event_reg_cpy &
> +			~LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT;
> +		ret = lis3l02dq_spi_write_reg_8(dev,
> +						LIS3L02DQ_REG_CTRL_2_ADDR,
> +						&newval);
> +		if (ret < 0)
> +			goto error_ret;
> +		/* Ensure every previous handler is done */
> +		flush_scheduled_work();
> +
> +		/* Walk the list and disable all of the events */
> +		iio_remove_all_event_from_list(&indio_dev
> +					       ->interrupts[0]->ev_list,
> +					       &st->event_list_cpy);
> +
>  		/* if not set, enable requested */
> +		valold &= ~LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT;
>  		valold |= LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
> -		iio_add_event_to_list(list, &indio_dev->interrupts[0]->ev_list);
> +
> +		/* Enable the interrupt handler */
> +		ret = request_irq(st->us->irq,
> +				  lis3l02dq_data_rdy_trig_poll,
> +				  IRQF_TRIGGER_RISING, "lis3l02dq_datardy",
> +				  st->trig);
> +		if (ret < 0)
> +			goto error_ret;
> +
>  		ret = lis3l02dq_spi_write_reg_8(dev,
>  						LIS3L02DQ_REG_CTRL_2_ADDR,
>  						&valold);
> @@ -358,7 +395,6 @@ __lis3l02dq_write_data_ready_config(struct device *dev,
>  			goto error_ret;
>  	}
>  
> -	return 0;
>  error_ret:
>  	return ret;
>  }
> @@ -374,11 +410,13 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  						bool state)
>  {
>  	struct lis3l02dq_state *st = trig->private_data;
> -	int ret = 0;
> +	int ret;
>  	u8 t;
> -	__lis3l02dq_write_data_ready_config(&st->help.indio_dev->dev,
> -					    &iio_event_data_rdy_trig,
> -					    state);
> +
> +	ret = __lis3l02dq_write_data_ready_config(&st->help.indio_dev->dev,
> +						  state);
> +	if (ret < 0)
> +		goto error_ret;
>  	if (state == false) {
>  		/* possible quirk with handler currently worked around
>  		   by ensuring the work queue is empty */
> @@ -386,10 +424,12 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		/* Clear any outstanding ready events */
>  		ret = lis3l02dq_read_all(st, NULL);
>  	}
> -	lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
> -				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
> -				 &t);
> -	return ret;
> +
> +	ret = lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
> +				       LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
> +				       &t);
> +error_ret:
> +	return (ret < 0) ? ret : 0;
>  }
>  
>  static IIO_TRIGGER_NAME_ATTR;
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 248bdd2..1200020 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -48,7 +48,7 @@ static inline s64 iio_get_time_ns(void)
>   *
>   * Does reference counting to allow shared handlers.
>   **/
> -void iio_add_event_to_list(struct iio_event_handler_list *el,
> +int iio_add_event_to_list(struct iio_event_handler_list *el,
>  			   struct list_head *head);
>  
>  /**
> @@ -61,6 +61,22 @@ void iio_add_event_to_list(struct iio_event_handler_list *el,
>  void iio_remove_event_from_list(struct iio_event_handler_list *el,
>  				struct list_head *head);
>  
> +/**
> + * iio_remove_all_event_from_list() - clear the event list
> + * @head:	associated list head
> + * @copy:	head for copying the list to. Set to NULL if no copy desired.
> + **/
> +void iio_remove_all_event_from_list(struct list_head *head,
> +				    struct list_head *copy);
> +
> +/**
> + * iio_reenable_all_event_from_list() - put a copied event list back in place
> + * @head:	event list head to which we are adding elements
> + * @copy:	head we copied to in iio_remove_all_event_from_list()
> + **/
> +int iio_reenable_all_event_from_list(struct list_head *head,
> +				     struct list_head *copy);
> +
>  /* Device operating modes */
>  #define INDIO_DIRECT_MODE		0x01
>  #define INDIO_RING_TRIGGERED		0x02
> @@ -146,7 +162,9 @@ struct iio_interrupt {
>  	int				id;
>  	int				irq;
>  	struct list_head		ev_list;
> -	spinlock_t			ev_list_lock;
> +	struct mutex			ev_list_lock;
> +	unsigned long			type;
> +	const char			*name;
>  };
>  
>  #define to_iio_interrupt(i) container_of(i, struct iio_interrupt, ev_list)
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index f3bf111..de65cbe 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -116,20 +116,11 @@ static irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
>  	struct iio_dev *dev_info = int_info->dev_info;
>  	struct iio_event_handler_list *p;
>  	s64 time_ns;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&int_info->ev_list_lock, flags);
> -	if (list_empty(&int_info->ev_list)) {
> -		spin_unlock_irqrestore(&int_info->ev_list_lock, flags);
> -		return IRQ_NONE;
> -	}
> -
> +	mutex_lock(&int_info->ev_list_lock);
>  	time_ns = iio_get_time_ns();
> -	list_for_each_entry(p, &int_info->ev_list, list) {
> -		disable_irq_nosync(irq);
> +	list_for_each_entry(p, &int_info->ev_list, list)
>  		p->handler(dev_info, 1, time_ns, !(p->refcount > 1));
> -	}
> -	spin_unlock_irqrestore(&int_info->ev_list_lock, flags);
> +	mutex_unlock(&int_info->ev_list_lock);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -138,7 +129,7 @@ static struct iio_interrupt *iio_allocate_interrupt(void)
>  {
>  	struct iio_interrupt *i = kmalloc(sizeof *i, GFP_KERNEL);
>  	if (i) {
> -		spin_lock_init(&i->ev_list_lock);
> +		mutex_init(&i->ev_list_lock);
>  		INIT_LIST_HEAD(&i->ev_list);
>  	}
>  	return i;
> @@ -151,7 +142,7 @@ int iio_register_interrupt_line(unsigned int irq,
>  				unsigned long type,
>  				const char *name)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	dev_info->interrupts[line_number] = iio_allocate_interrupt();
>  	if (dev_info->interrupts[line_number] == NULL) {
> @@ -161,16 +152,8 @@ int iio_register_interrupt_line(unsigned int irq,
>  	dev_info->interrupts[line_number]->line_number = line_number;
>  	dev_info->interrupts[line_number]->irq = irq;
>  	dev_info->interrupts[line_number]->dev_info = dev_info;
> -
> -	/* Possibly only request on demand?
> -	 * Can see this may complicate the handling of interrupts.
> -	 * However, with this approach we might end up handling lots of
> -	 * events no-one cares about.*/
> -	ret = request_irq(irq,
> -			  &iio_interrupt_handler,
> -			  type,
> -			  name,
> -			  dev_info->interrupts[line_number]);
> +	dev_info->interrupts[line_number]->name = kstrdup(name, GFP_KERNEL);
> +	dev_info->interrupts[line_number]->type = type;
>  
>  error_ret:
>  	return ret;
> @@ -190,51 +173,122 @@ EXPORT_SYMBOL(iio_read_const_attr);
>  void iio_unregister_interrupt_line(struct iio_dev *dev_info, int line_number)
>  {
>  	/* make sure the interrupt handlers are all done */
> -	flush_scheduled_work();
> -	free_irq(dev_info->interrupts[line_number]->irq,
> -		 dev_info->interrupts[line_number]);
>  	kfree(dev_info->interrupts[line_number]);
>  }
>  EXPORT_SYMBOL(iio_unregister_interrupt_line);
>  
>  /* Reference counted add and remove */
> -void iio_add_event_to_list(struct iio_event_handler_list *el,
> +int iio_add_event_to_list(struct iio_event_handler_list *el,
>  			  struct list_head *head)
>  {
> -	unsigned long flags;
>  	struct iio_interrupt *inter = to_iio_interrupt(head);
> +	int ret;
>  
>  	/* take mutex to protect this element */
>  	mutex_lock(&el->exist_lock);
>  	if (el->refcount == 0) {
>  		/* Take the event list spin lock */
> -		spin_lock_irqsave(&inter->ev_list_lock, flags);
> +		mutex_lock(&inter->ev_list_lock);
> +		if (list_empty(&inter->ev_list)) {
> +			ret = request_threaded_irq(inter->irq,
> +						   NULL,
> +						   &iio_interrupt_handler,
> +						   inter->type | IRQF_ONESHOT,
> +						   inter->name,
> +						   inter);
> +			if (ret) {
> +				mutex_unlock(&inter->ev_list_lock);
> +				mutex_unlock(&el->exist_lock);
> +				return ret;
> +			}
> +		}
>  		list_add(&el->list, head);
> -		spin_unlock_irqrestore(&inter->ev_list_lock, flags);
> +		mutex_unlock(&inter->ev_list_lock);
>  	}
>  	el->refcount++;
>  	mutex_unlock(&el->exist_lock);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(iio_add_event_to_list);
>  
> +int iio_reenable_all_event_from_list(struct list_head *head,
> +				     struct list_head *copy)
> +{
> +	struct iio_event_handler_list *el;
> +	struct list_head *iter, *working;
> +	struct iio_interrupt *inter = to_iio_interrupt(head);
> +	int ret;
> +
> +	list_for_each_safe(iter, working, copy) {
> +		el = container_of(iter, struct iio_event_handler_list, list);
> +		mutex_lock(&el->exist_lock);
> +		/* Take the event list spin lock */
> +		mutex_lock(&inter->ev_list_lock);
> +		if (list_empty(&inter->ev_list)) {
> +			ret = request_threaded_irq(inter->irq,
> +					     NULL,
> +					     &iio_interrupt_handler,
> +					     inter->type | IRQF_ONESHOT,
> +					     inter->name,
> +					     inter);
> +			if (ret < 0) {
> +				mutex_lock(&inter->ev_list_lock);
> +				mutex_unlock(&el->exist_lock);
> +				return ret;
> +			}
> +		}
> +		list_move(&el->list, head);
> +		mutex_unlock(&inter->ev_list_lock);
> +		mutex_unlock(&el->exist_lock);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(iio_reenable_all_event_from_list);
> +
>  void iio_remove_event_from_list(struct iio_event_handler_list *el,
>  			       struct list_head *head)
>  {
> -	unsigned long flags;
>  	struct iio_interrupt *inter = to_iio_interrupt(head);
> -
>  	mutex_lock(&el->exist_lock);
>  	el->refcount--;
>  	if (el->refcount == 0) {
>  		/* Take the event list spin lock */
> -		spin_lock_irqsave(&inter->ev_list_lock, flags);
> +		mutex_lock(&inter->ev_list_lock);
>  		list_del_init(&el->list);
> -		spin_unlock_irqrestore(&inter->ev_list_lock, flags);
> +		if (list_empty(&inter->ev_list))
> +			free_irq(inter->irq, inter);
> +		mutex_unlock(&inter->ev_list_lock);
>  	}
>  	mutex_unlock(&el->exist_lock);
>  }
>  EXPORT_SYMBOL(iio_remove_event_from_list);
>  
> +void iio_remove_all_event_from_list(struct list_head *head,
> +				    struct list_head *copy)
> +{
> +	struct iio_event_handler_list *el;
> +	struct list_head *iter, *working;
> +	struct iio_interrupt *inter = to_iio_interrupt(head);
> +
> +	list_for_each_safe(iter, working, head) {
> +		el = container_of(iter, struct iio_event_handler_list, list);
> +		mutex_lock(&el->exist_lock);
> +		mutex_lock(&inter->ev_list_lock);
> +		if (copy)
> +			list_move(iter, copy);
> +		else
> +			list_del_init(iter);
> +		if (list_empty(&inter->ev_list)) {
> +			free_irq(inter->irq, inter);
> +		}
> +		mutex_unlock(&inter->ev_list_lock);
> +		mutex_unlock(&el->exist_lock);
> +	}
> +}
> +EXPORT_SYMBOL(iio_remove_all_event_from_list);
> +
> +
>  static ssize_t iio_event_chrdev_read(struct file *filep,
>  				     char __user *buf,
>  				     size_t count,
