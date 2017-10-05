Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35342 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdJESN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2017 14:13:26 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, benjamin.gaignard@linaro.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/6] iio: Introduce the generic counter interface
Date: Thu,  5 Oct 2017 14:13:14 -0400
Message-Id: <cover.1507220144.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There have been some significant implementation changes for this version
of the patchset. Here's a brief summary of the updates:

 - Inline comments throughout the industrial-counter.c file; this
   should help clarify some of the code and aid in the review of the
   system architecture

 - Simplification of the driver API; primarily, dynamic updates to the
   Counter Values, Triggers, and Signals lists are no longer allowed --
   all relationships must be defined before the Counter is registered to
   the system

 - Dynamic component registration functions
   (iio_counter_value_register, et al.) have been removed, and now the
   signals, values, and triggers array members serve to register the
   components; signals, values, and triggers were previously named
   init_signals, init_values, and init_triggers respectively -- the
   "init_" prefix was removed now that dynamic registration is no longer
   allowed

 - Requiring static component relationships means linked lists are no
   longer necessary so all the list related code has been removed;
   Signals, Triggers, and Values are now accessed directly from the
   arrays supplied in the iio_counter structure

 - No dynamic additions/substraction of components eliminates the need
   for mutex locks, so those have been removed as well

 - Previously, the entire iio_counter structure was copied and stored as
   the iio_dev private data; now, only a pointer to the supplied
   iio_counter structure is stored

 - devm_iio_counter_register and devm_iio_counter_unregister functions
   were incorporated from Benjamin Gaignard's suggestions

 - Dummy counter driver provided as a reference for a simple counter
   implementation utilizing the Generic Counter interface

In a previous discussion, Benjamin noted some conflicts between the
Generic Counter and the underlying IIO core code: mapping does not
always work out seemlessly and sometimes the IIO core functionality
exposure provided via iio_counter is not quite flexible enough. I intend
to address these shortcomings in the next version of this patchset
hopefully.

In particular, I'm leaning towards separating the Generic Counter
interface from the IIO core dependency entirely. Since the Generic
Counter inteface focuses on a more abstract representation of a counter
device, I don't think it provides a suitable interface to map onto IIO
core, which appears to focus more on a representation of the physical
hardware itself.

Separating Generic Counter from IIO core should allow a driver to use
the IIO core functions (iio_device_register, et al.) to represent the
physical nature of their hardware (voltages, currents, etc.), while also
utilize the Generic Counter interface to represent the abstract
relationships between those Signals and their ultimate counter Values.

In particular, I'm hoping for the Generic Counter system implementation
itself to not require all this hoop-jumping (mapping to IIO core
functions, jumping back to the parent iio_counter, handling non-matching
parameter lists between iio_counter and iio_dev, etc.); that should make
the code simpler to debug, more efficient, and more stable in the
long-run. I will consider these advantages and disadvantages before
committing to a separation however.

Regarding this version of the patchset in particular, I decided to
remove the dynamic component registration functionality since I doubt
that many devices would require such; almost all, if not all, hardware
counters I encountered have static relationships between input lines and
the count value (i.e. specific input lines correlate to specific count
registers).

The requirement that Counter component relationships are
static has opened the possibility of some optimizations in the Generic
Counter interface code:

 - Signals, Triggers, and Values are provided as arrays; these arrays
   could benefit from some amount of sorting based on component IDs

 - Searching for a component can be more efficient in a sorted array;
   currently, the code just walks down the array elements and compare
   the IDs

 - Similar to general searching, the arrays are initially verified to
   gurantee unique IDs; currently, the code walks down the array
   elements and compares the current element ID with all the elements
   before and after -- this could be made more efficient with some
   sorting

There are likely other areas of improvement, so let me know and I'll see
what I can do.

William Breathitt Gray (6):
  iio: Implement counter channel specification and IIO_SIGNAL constant
  iio: Introduce the generic counter interface
  iio: Documentation: Add IIO Generic Counter sysfs documentation
  docs: Add IIO Generic Counter Interface documentation
  iio: Add dummy counter driver
  iio: 104-quad-8: Add IIO generic counter interface support

 .../testing/sysfs-bus-iio-generic-counter-sysfs    |  63 ++
 Documentation/driver-api/iio/generic-counter.txt   | 526 ++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/Kconfig                                |   8 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/counter/104-quad-8.c                   | 294 ++++++-
 drivers/iio/counter/Kconfig                        |  16 +
 drivers/iio/counter/Makefile                       |   1 +
 drivers/iio/counter/dummy-counter.c                | 293 +++++++
 drivers/iio/industrialio-core.c                    |  14 +-
 drivers/iio/industrialio-counter.c                 | 900 +++++++++++++++++++++
 include/linux/iio/counter.h                        | 166 ++++
 include/linux/iio/iio.h                            |   2 +
 include/uapi/linux/iio/types.h                     |   1 +
 14 files changed, 2274 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
 create mode 100644 Documentation/driver-api/iio/generic-counter.txt
 create mode 100644 drivers/iio/counter/dummy-counter.c
 create mode 100644 drivers/iio/industrialio-counter.c
 create mode 100644 include/linux/iio/counter.h

-- 
2.14.1

