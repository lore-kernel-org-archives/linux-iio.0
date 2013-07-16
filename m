Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: jonathan cameron <jic23@kernel.org>
Date: Tue, 16 Jul 2013 11:26:55 +0200
Subject: iio_trigger_poll_chained stop and trig->use_count always equals to 1
Message-ID: <5206767.5F4z6p4ukz@ctocwl0124>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi all,

I need your help to understanding my strange issue...
The scenario is that:

- I have one I2C device (microcontroller) that expose some sensors.
- I wrote one driver that create one IIO device for each sensor.
- There is only one trigger associated to all IIO devices, and one buffer f=
or=20
each device.

When interrupt appear (DRDY of one or more sensors), the driver reads a mas=
k=20
from micro to understand how many sensors have new data. After that, the=20
driver reads all new data from micro and save all data to one buffer. This =
is=20
done in a threaded irq function.

When iio_trigger_poll_chained is called, all data are saved to one common=20
buffer, each iio_triggered_buffer_setup functions is called and can split a=
nd=20
push their data to iio_buffer.

The issue is that: after some samples (about 50:100) the=20
iio_trigger_poll_chained doesn't call the iio_triggered_buffer_setup functi=
ons=20
and trig->use_count is always equals to 1.

To well understanding:

static irqreturn_t st_drdy_poll(int irq, void *private)
{
	// stuff statements
	// i2c read mask
	// i2c read sensors data
	iio_trigger_poll_chained(trig, 0);
	return IRQ_HANDLED;
}

static irqreturn_t st_trigger_handler(int irq, void *p)
{
	// stuff statements
	// only check operations
	iio_push_to_buffers(sensor_iio_dev, sdata->buffer_data);
	iio_trigger_notify_done(sensor_iio_dev->trig);
	return IRQ_HANDLED;
}

trigger_allocate()
{
err =3D request_threaded_irq(client->irq,
				NULL,
				st_drdy_poll,
				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
				name,
				trig);
}

buffer_allocate()
{
return iio_triggered_buffer_setup(sensor_iio_dev,
						&iio_pollfunc_store_time,
						&st_trigger_handler,
						&st_buffer_setup_ops);
}



If you have any comments...Thanks for your time!

Denis
