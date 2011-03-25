Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/3] staging:iio: allow channels to be set up using a table of iio_channel_spec structures.
Date: Fri, 25 Mar 2011 15:37:01 +0100
Cc: linux-iio@vger.kernel.org
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <1300997125-2896-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300997125-2896-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103251537.02030.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 24 March 2011, Jonathan Cameron wrote:
> +	
> +/**
> + * struct iio_chan_spec - specification of a single channel
> + * @type:	what type of measurement is the channel making
> + * @channel:	what number or name do we wish to asign the channel
> + * @channel2:	if there is a second number for a differential
> + *		channel then this is it.
> + * @address:	driver specific identifier.

Better make it "unsigned long" instead of int when it's driver specific.
That way, a driver can store a pointer here if necessary.

> +#define IIO_ST(si, rb, sb, sh)						\
> +	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
> +
> +#define IIO_CHAN(_type, _chan, _inf_mask, _address, _si, _stype)		\
> +	{ .type = _type, .channel = _chan, .info_mask = _inf_mask,	\
> +			.address = _address,				\
> +			.scan_index = _si, .scan_type = _stype }
> +
> +#define IIO_CHAN_EV(_type, _chan, _inf_mask, _address, _si,		\
> +		    _stype, _event_mask, _shared_h)			\
> +	{ .type = _type,						\
> +			.channel = _chan,				\
> +			.info_mask = _inf_mask,				\
> +			.address = _address,				\
> +			.scan_index = _si, .scan_type = _stype,		\
> +			.event_mask = _event_mask,			\
> +			.shared_handler = _shared_h }
> +
> +#define IIO_CHAN_COMPOUND(_type, _chan1, _chan2, _inf_mask,_address, _si, _stype) \
> +	{ .type = _type, .channel = _chan1, .channel2 = _chan2,		\
> +			.info_mask = _inf_mask,				\
> +			.address = _address,				\
> +			.scan_index = _si, .scan_type = _stype }
> +
> +#define IIO_CHAN_COMPOUND_EV(_type, _chan1, _chan2, _inf_mask,		\
> +			     _address, _si, _stype, _event_mask, _shared_h) \
> +	{ .type = _type,						\
> +			.channel = _chan1, .channel2 = _chan2,		\
> +			.info_mask = _inf_mask,				\
> +			.address = _address,				\
> +			.scan_index = _si, .scan_type = _stype,		\
> +			.event_mask = _event_mask,			\
> +			.shared_handler = _shared_h}
> +
> +#define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
> +	{ .type = IIO_TIMESTAMP, .channel = -1,				\
> +			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }

Maybe try to reduce the number of macros here. In many cases, doing the
assignment manually would be more readable than calling the macro with
unspecified arguments, IMHO.

> @@ -116,6 +248,31 @@ struct iio_dev {
>  	u32				*available_scan_masks;
>  	struct iio_trigger		*trig;
>  	struct iio_poll_func		*pollfunc;
> +
> +	struct iio_chan_spec *channels;
> +	int num_channels;
> +	struct list_head channel_attr_list;
> +
> +	char *name; /*device name - IMPLEMENT */
> +	int (*read_raw)(struct iio_dev *indio_dev, 
> +			struct iio_chan_spec *chan,
> +			int *val,
> +			long mask);
> +
> +	int (*read_event_config)(struct iio_dev *indio_dev,
> +				 int event_code);
> +
> +	int (*write_event_config)(struct iio_dev *indio_dev,
> +				  int event_code,
> +				  struct iio_event_handler_list *listel,
> +				  int state);
> +
> +	int (*read_event_value)(struct iio_dev *indio_dev,
> +				int event_code,
> +				int *val);
> +	int (*write_event_value)(struct iio_dev *indio_dev,
> +				 int event_code,
> +				 int val);
>  };

As mentioned in the comment for 2/3, a number of the members here are
constant, so you could split the structure into a per-driver constant
part and a per-device part, like most other subsystems do.

	Arnd
