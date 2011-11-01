Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:33331 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab1KARDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2011 13:03:46 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de, gregkh@suse.de, dtor@mail.ru,
	thomas.petazzoni@free-electrons.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/5] staging:iio: in kernel push interface 
Date: Tue,  1 Nov 2011 17:11:48 +0000
Message-Id: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

This is a more developed (though still far from finished)
version of the set I sent out last week.

The input driver is very basic, but should show how things
fit together.  Clearly we need some more boilerplate code
to avoid every user having to respin the stuff for breaking
up the incoming data stream.

Quick summary.
Mapping to a client is done using the same maps as in the pull
interface, but for push there is only the 'get all' option.
(see that RFC for this side of things).

Push is done by inserting 'buffer' interfaces (basically data
sinks) in and out of a list.  Adding a buffer tears down all
capture and then builds it up again with the new buffer.

Special call back 'buffer' provided that will get a stream of
data aligned and padded as it would be for userspace.
As with userspace this can be interpretted using info in
the availale chan_spec structures

Lots of interface code needed to make it easy for clients to
handle the datastreams without reinventing the wheel in
every client driver.  This will get written as and when
client drivers need it.  A very basic 'input' client is
provided to motivate what we have here with a real user.

There are some questions raised at the end of this cover letter...

In detail...

Lifting most of the text from the previous RFC

The following is primarily an RFC rather than a firm proposal due
to a few things currently not being there.

1) A full interface. This needs quite a few more wrapper functions
if we are to keep the underlying IIO stuff as opaque to clients
as I would like.

2) A lack of any certainty that I haven't broken 90% of more of
the drivers.  Hardware buffers for one (sca3000) are going to
be interesting with this.

3) Locking missing all over the place.  Once I am sure no one
has any issues with the basic approach I'll get this cleaned up.

4) No means of doing in kernel trigger configuration at the moment
so you'll have have to have a trigger set up BEFORE any driver
tries to insert a buffer for it to feed.  For devices doing push
this is probably a data ready signal anyway and so would be the
default trigger.

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

What has changed (from before the first RFC, not since then)

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
    |       --------           |          -------------------
     ----->|Device 2| ->        -------> |In Kernel interface|
            --------                      -------------------

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
4) Bring up buffering (including attaching the pollfunc).

Since the earlier RFC I have added a trivial buffer implementation
buffer_cb that as it names suggests just calls an appropriate
callback function that is called when the buffer store_to method
is called.  It has a simple interface and should handle most
usecases for push interfaces.

Note that the only overhead on a 'normal' driver over what we had
before is a lookup into a list with only one entry + a few pointer
copies. (where normal is without in kernel usage and a scan that
requires no demux).

Now, there are a few issues that need discussion.

1) Right now pull interface (previously proposed and much simpler)
doesn't not play well with the push interface.  For existing
drivers you can sometimes pull the most recent value back from
their IIO buffer (on a read of the sysfs attributes for example)
but for elements that are not in the scan and hence not being
grabbed on the trigger, we return -EBUSY.  The same will hold
true here.  Iff this is a big issue for usecases people have
then we could have a pull channel gets add their own buffer which simply
stores one value and have direct reads retrieve that.
Unfortunately there are still channel combinations that will
fail...

2) Unclear how to handle incompatible scan sets.  If one inkernel
user requests in_voltage1 and another in_voltage1-in_voltage2
we typically can't service both requests in a remotely efficient
manner (using data ready etc).  So the question is, when do
we fail? On first attempt to set the scan mask element or
only when we attempt to insert the buffer?  My personal
feeling is that, when we have pulled the triggered capture
down to add the new buffer, there should be a verification
check of the new buffers requested scan, and if it doesn't
work the buffer add attempt should be dropped, but the
triggered capture restarted for everything else.
Having said that, it also makes sense to verify that a
given buffers own requested set are possible and this can occur
at time of the scan mask being set.  I don't thing verifying
against everything is going to fly as it will get racey.

Anyhow, all comments, particularly on the interface welcomed!

Jonathan Cameron (5):
  staging:iio: scrap scan_count and ensure all drivers use
    active_scan_mask
  staging:iio: make all buffer access pass through the buffer_list
  staging:iio: make update buffers available outside iio.
  staging:iio: add a callback buffer for in kernel push interface
  staging:iio: Proof of concept input driver.

 drivers/staging/iio/Kconfig                     |    7 +
 drivers/staging/iio/Makefile                    |    3 +-
 drivers/staging/iio/accel/adis16201_ring.c      |   26 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   27 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   25 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   20 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   20 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   41 ++-
 drivers/staging/iio/adc/ad7192.c                |   41 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   46 ++-
 drivers/staging/iio/adc/ad7476_ring.c           |   35 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   20 +-
 drivers/staging/iio/adc/ad7793.c                |   43 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   40 ++-
 drivers/staging/iio/adc/ad799x_ring.c           |   47 ++-
 drivers/staging/iio/adc/max1363_ring.c          |   20 +-
 drivers/staging/iio/buffer.h                    |   12 +-
 drivers/staging/iio/buffer_cb.c                 |  115 +++++
 drivers/staging/iio/gyro/adis16260_ring.c       |   23 +-
 drivers/staging/iio/iio.h                       |    2 +
 drivers/staging/iio/iio_input.c                 |  106 +++++
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   26 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   27 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   21 +-
 drivers/staging/iio/industrialio-buffer.c       |  544 ++++++++++++++---------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/inkern.h                    |   35 ++
 drivers/staging/iio/meter/ade7758_ring.c        |   34 +-
 28 files changed, 965 insertions(+), 442 deletions(-)
 create mode 100644 drivers/staging/iio/buffer_cb.c
 create mode 100644 drivers/staging/iio/iio_input.c

-- 
1.7.7

