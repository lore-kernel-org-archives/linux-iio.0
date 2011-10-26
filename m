Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de,
	gregkh@suse.de,
	thomas.petazzoni@free-electrons.com,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/7] staging:iio:towards an in kernel push interface
Date: Wed, 26 Oct 2011 16:54:11 +0100
Message-Id: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

Before I say anything else: Note that the interfaces here are a
mess and no intended to reflect what would go on on the inkernel
client side.  The current snoop driver is just a hack to test the
push side works.  I'll wrap this up and make it look all pretty
once we have pinned the other elements down.

The following is primarily an RFC rather than a firm proposal due
to a few things currently not being there.

1) A decent interface.  The snoop driver shows it works but requires
some pretty low level knowledge of what is going on.

2) A lack of any certainty that I haven't broken 90% of more of
the drivers.  Hardware buffers for one (sca3000) are going to
be interesting with this.

3) Locking missing all over the place.

4) No means of doing in kernel trigger configuration at the moment
so you'll have have to have a trigger set up BEFORE any driver
tries to insert a buffer for it to feed.

5) Probably want to separate the bits of preenable functions that
deal with setting up scan modes etc from those that run for each
buffer.  This is the case with max1363 which uses the update_scan_mode
callback, but the naming doesn't reflect things well.

6) I've only tested it on the max1363 so far with snoop on in_voltage3_raw
and the main buffer set to read in_voltage0_raw and in_voltage2_raw.
A sysfs trigger was used and hammered from a tight loop whilst the
generic_buffer example was used to read from the iio chrdev.
This setup works.

So basically, this 'works', but might eat babies in its current form.

What has changed:

Principally the dataflow has become a little more complex

Before we had
 -------      --------       ------------        ---------
|Trigger|--->|Device 1| --> |Ring or Fifo|  --> |Userspace|
 -------      --------       ------------        ---------
    |         --------       ------------        ---------
     ------->|Device 2| --> |Ring or Fifo|  --> |Userspace|
              --------       ------------        ---------


Now we have
 -------    --------      ----------      ------      ---------
|Trigger|->|Device 1| -> |BufferList| -> |R/Fifo| -> |Userspace|
 -------    --------      ----------      ------      ---------
    |                          |
    |         ------           |          -------------------
     ----->|Device 2| ->        -------> |In Kernel interface|
              ------                      -------------------

So we have inserted a bufferlist.  If there is nothing in this
list (initial state) then the poll function is not attached
so the trigger will not cause this device to push to the buffers.

All buffer pushing from the driver is done through
iio_push_to_buffers()

Changes to the buffer list are done by calling iio_buffers_update
which takes a buffer to add or one to remove (or neither).

This function does the following:

1) Tear down current buffering (including detaching the poll function).
2) Add or remove buffers from the list.
3) Setup the Demux. As a change to any buffer can result in a change
   to the active scan mask (that may or may not succeed) all demuxes
   into the buffers must be updated if they are still attached.
4) Bring up buffinrg (including attaching the pollfunc).

As you can see form the snoop driver, right now we don't really
have an interface, drivers can add buffers by setting up the magic
and inserting them.  Whether we need to be nicer than that isn't
immediately clear.  Some utility functions would definitely make
things easier to follow though!

Note that the only overhead on a 'normal' driver over what we had
before is a lookup into a list with only one entry + a few pointer
copies. (where normal is without in kernel usage and a scan that
requires no demux).

All comments welcome.  I'll be away from a few hours time until
next Monday though so may take me until then to get back to people!

Just thought I'd best show people where things stand before heading
out.  All in all it was roughly as fiddly to get this working as
I expected.  It's suprising how many decisions turn out to be wrong
when you want to add a diversion for your data...

Jonathan Cameron (7):
  staging:iio:buffer drop bpe field.
  staging:iio; remove userspace access to bytes per datum.
  staging:iio:buffer move setup ops from buffer instance to iio_dev
  staging:iio: scrap scan_count and ensure all drivers use
    active_scan_mask
  staging:iio: make all buffer access pass through the buffer_list
  staging:iio: make update buffers available outside iio.
  staging:iio:snoop example of rawest level of push interface

 drivers/staging/iio/Kconfig                     |    5 +
 drivers/staging/iio/Makefile                    |    1 +
 drivers/staging/iio/accel/adis16201_ring.c      |   29 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   30 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   28 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   23 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   23 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   44 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |   41 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   48 ++-
 drivers/staging/iio/adc/ad7476_ring.c           |   37 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   24 +-
 drivers/staging/iio/adc/ad7793.c                |   45 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   42 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   48 ++-
 drivers/staging/iio/adc/max1363_ring.c          |   22 +-
 drivers/staging/iio/buffer.h                    |   39 +--
 drivers/staging/iio/gyro/adis16260_ring.c       |   26 +-
 drivers/staging/iio/iio.h                       |   18 +
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   29 +-
 drivers/staging/iio/iio_snoop.c                 |   94 ++++
 drivers/staging/iio/impedance-analyzer/ad5933.c |   29 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   24 +-
 drivers/staging/iio/industrialio-buffer.c       |  574 +++++++++++++----------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/kfifo_buf.c                 |    2 -
 drivers/staging/iio/meter/ade7758_ring.c        |   36 +-
 drivers/staging/iio/ring_sw.c                   |    2 -
 29 files changed, 835 insertions(+), 533 deletions(-)
 create mode 100644 drivers/staging/iio/iio_snoop.c

-- 
1.7.7
