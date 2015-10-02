Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-198.synserver.de ([212.40.185.198]:1043 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752334AbbJBOpr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 10:45:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Andrey Yurovsky <andrey@snupi.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/7] iio: Add DMA buffer support
Date: Fri,  2 Oct 2015 16:45:00 +0200
Message-Id: <1443797107-13391-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series contains phase 1 of adding DMA buffer support to the IIO
framework. It adds the necessary in-kernel infrastructure to support DMA
buffers, but does not yet modify the userspace ABI.

The traditional approach used in IIO to implement buffered capture requires
the generation of at least one interrupt per sample. In the interrupt
handler the driver reads the sample from the device and copies it to a
software buffer. This approach has a rather large per sample overhead
associated with it. And while it works fine for samplerates in the range of
up to 1000 samples per second it starts to consume a rather large share of
the available CPU processing time once we go beyond that, this is
especially true on an embedded system with limited processing power. The
regular interrupt also causes increased power consumption by not allowing
the hardware into deeper sleep states, which is something that becomes more
and more important on mobile battery powered devices.

And while the recently added watermark support mitigates some of the issues
by allowing the device to generate interrupts at a rate lower than the data
output rate, this still requires a storage buffer inside the device and
even if it exists it is only a few 100 samples deep at most.

DMA support on the other hand allows to capture multiple millions or even
more samples without any CPU interaction. This allows the CPU to either go
to sleep for longer periods or focus on other tasks which increases overall
system performance and power consumption. In addition to that some devices
might not even offer a way to read the data other than using DMA, which
makes DMA mandatory to use for them.

For the DMA buffer support that is introduced in this series sample data is
grouped in so called blocks. A block is the basic unit at which data is
exchanged between the application and the hardware. The application is
responsible for allocating the memory associated with the block and then
passes the block to the hardware. When the hardware has captured the amount
of samples equal to size of a block it will notify the application, which
can then read the data from the block and process it. The block size can be
freely chosen (within the constraints of the hardware). This allows to make
a trade-off between latency and management overhead. The larger the block
size the lower the per sample overhead but the latency between when the
data was captured and when the application will be able to access it
increases, in a similar way smaller block sizes have a larger per sample
management overhead but a lower latency. The ideal block size thus depends
on system and application requirements.

The series starts with some minor modifications to the watermark handling
code, primarily for dealing with fixed watermarks. It then adds support for
enable()/disable() callbacks to the iio_buffer_access_ops. This allows the
DMA buffer support to start and stop the DMA controller when the buffer is
enabled and disabled.

The next patch after that contains the core of this series. It adds a
generic infrastructure for managing DMA buffers and while this is not a
complete buffer implementation on its own it contains support for all the
management work that is necessary to support DMA buffers, i.e. implementing
the IIO buffer callbacks. The only thing not part of this infrastructure
is configuring and setting up the DMA controller hardware itself. This is
left to be implemented by a device driver which wants to support DMA buffer
support and can be hooked up into the generic infrastructure by two simple
callbacks. This minimizes the per driver code that is necessary to
implement a DMA buffer.

On top of that the series adds support for DMA buffers to the IIO dummy
simple driver. This code can be used as a template for implementing new DMA
buffer drivers as well as for testing the generic DMA buffer infrastructure
in absence of hardware with DMA capabilities.

Finally this series introduces a fully functional and completely hardware
independent DMA buffer implementation which binds the previously introduced
generic IIO DMA buffer infrastructure to the DMAengine framework. Which is
used setup the actual hardware transfers. This reduces the amount of driver
specific code for implementing a DMA buffer to two lines. One for
registering the buffer and one for unregistering it. This makes using the
DMAengine based buffer implementation the recommended way of implementing a
DMA buffer for a device.

The DMA buffer support has been successfully used and tested at Analog
Devices for a while now with a wide variety of high speed data acquisition
and processing systems with sample rates going up to multiple giga samples
per second. Andrey Yurovsky has also successfully added DMA buffer support
to the existing AT91 ADC driver allowing faster and more efficient data
capture.

The next step after this series and phase 2 is to extend the DMA buffer
support with some userspace ABI additions, this includes support for giving
userspace a more fine grained control over buffer allocation and management
as well as support for mmap() and splice(). mmap() allows to access the
buffer data from userspace without having to copy it which additionally
reduces the management overhead. While splice() allows to exchange data
with other kernel buffers without having to copy it, this can for example
be used to send the data to a network or storage disk controller.

For more background information on using IIO for high-speed data
acquisition and using the DMA buffer support please also refer to [1] and
[2] as well as [3].

- Lars

[1] http://events.linuxfoundation.org/sites/events/files/slides/iio_high_speed.pdf
[2] https://wiki.analog.com/resources/tools-software/linux-software/libiio_internals#high-speed_mmap_interface
[3] https://wiki.analog.com/resources/tools-software/linux-software/libiio_internals#zerocopy

Lars-Peter Clausen (7):
  iio: Set device watermark based on watermark of all attached buffers
  iio:iio_buffer_init(): Only set watermark if not already set
  iio: Add support for indicating fixed watermarks
  iio: Add buffer enable/disable callbacks
  iio: Add generic DMA buffer infrastructure
  staging:iio:dummy: Add DMA buffer support
  iio: Add a DMAengine framework based buffer

 drivers/iio/buffer/Kconfig                         |  20 +
 drivers/iio/buffer/Makefile                        |   2 +
 drivers/iio/buffer/industrialio-buffer-dma.c       | 683 +++++++++++++++++++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 213 +++++++
 drivers/iio/industrialio-buffer.c                  |  58 +-
 drivers/staging/iio/Kconfig                        |  31 +-
 drivers/staging/iio/Makefile                       |   3 +-
 drivers/staging/iio/iio_simple_dummy.c             |   3 +
 drivers/staging/iio/iio_simple_dummy.h             |   8 +
 drivers/staging/iio/iio_simple_dummy_buffer_dma.c  | 470 ++++++++++++++
 include/linux/iio/buffer-dma.h                     | 150 +++++
 include/linux/iio/buffer-dmaengine.h               |  18 +
 include/linux/iio/buffer.h                         |  16 +
 13 files changed, 1667 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iio/buffer/industrialio-buffer-dma.c
 create mode 100644 drivers/iio/buffer/industrialio-buffer-dmaengine.c
 create mode 100644 drivers/staging/iio/iio_simple_dummy_buffer_dma.c
 create mode 100644 include/linux/iio/buffer-dma.h
 create mode 100644 include/linux/iio/buffer-dmaengine.h

-- 
2.1.4

