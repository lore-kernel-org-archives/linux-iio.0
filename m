Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38867 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbdIYSIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2017 14:08:10 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: benjamin.gaignard@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/5] iio: Introduce the generic counter interface
Date: Mon, 25 Sep 2017 14:07:43 -0400
Message-Id: <cover.1506353914.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This version 2 submission of this patchset is more of an RFC; I haven't
yet completed all the changes and additional comments/documentation I
would like to make. However, I didn't want to keep pushing back this
submission after so many weeks, so I'm providing this version now in the
hopes that the documentation I have written so far can prove useful to
peruse for the time being.

Very little has changed in terms of the code implementation of the
architecture since version 1 of this patchset. In particular, the
following minor changes were made for v2:

  - Elimination of the "__" prefix for symbols; I had used this naming
    convention to indicate symbols which had static scope to the counter
    system, but decided it was ultimately redundant when the "static"
    keyword already conveys such

  - Removal of the drive_module configuration for iio_info structures; I
    noticed the driver_module member was removed in a recent patch

  - Explicit cast to void * before dereferencing uintptr_t variables;
    this minor coding convention oversight was resolved after the
    heads-up provided in the previous v1 review referencing
    iio_counter_trigger_mode_read

  - Fix sanity-check bugs derived from copy-paste typos;
    iio_counter_value_function_get and iio_counter_value_function_set
    had were checking for trigger_mode_get to be set when they should
    have checked for value_function_get and value_function_set
    respectively

Overall, the major addition to this submission is the addition of some
more in-depth documentation about the IIO Generic Counter Interface.
Architectural and driver API documentation has been added in the
Documentation/driver-api/iio/generic-counter.txt file. I noticed that
the files in this directory are in sphinx format, so I'll convert this
file to such in one of the subsequent versions of this patchset.

The typically sysfs documentation has been added in the
Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs file. This
file provides the documentation for the sysfs attributes exposed by
utilizing the IIO Generic Counter Interface.

Unfortunately, I haven't yet added proper commenting to the
industrial-counter.c file, so bear with me until v3 of this patchset.
There's a good number of changes and updates I would still like to make
before the merge so here's a list of what to expect in the coming
revisions:

  - More thorough explanation of the specific code implementation
    provided in the industrial-counter.c file (this would include the
    missing code comments that should resolve the opacity when trying to
    follow the source code); the documentation provided in this v2
    submission is more of a high-level overview of the architecture and
    theory, while a more low-level specific source code roadmap would be
    beneficial for navigating the implementation.

  - Rationale for certain algorithm and data structure decisions; for
    example, why an entire copy of iio_counter is stored rather than
    just a pointer (immutability concerns), the locking structure
    between Values, Triggers, and Signals interactions (race condition
    concerns, why linked lists are used to store Counter components
    (though a vector implementation is a viable alternative I'm
    investigating), etc. These choices I made are not necessarily
    correct, but hopefully my rationale for these decisions will make
    suggestions of alternatives far easier for reviewers to make.

  - Example implementations to exemplify the driver API; the 104-QUAD-8
    generic counter patch in this patchset is not a very good beginner
    example for learning; I'm developing a simple dummy counter
    driver which should make the API use a lot clearer for driver
    authors; I'm hesitant just yet to add support to actual drivers
    since they will likely use the more appropriate future Simple
    Counter and Quadrature Counter interfaces.

As I mentioned before in previous discussions, the Generic Counter
Interface itself isn't particularly intended for general driver
consumption, but rather to serve as the building blocks for various
classes of counter device interfaces. To this end, I've developed the
generic counter paradigm around the essence and bare requirements
necessary to support the concept of a counter.

As such, the Generic Counter Interface has certain flexibilities and
freedoms ill-suited for general drivers, but beneficial for the
construction of more specific classes of counter interfaces. There are
such classes I intend to submit as their own separate patchsets once the
Generic Counter Interface is merged:

  - The Simple Counter Interface for simple counter devices with a
    single Signal, single Trigger, and single Value; this what I
    anticipate most typical drivers consuming -- an interface that is
    simple, rigid, and terse.

  - The Quadrature Encoder Counter Interface for quadrature encoder
    counter devices; this would be consumed by drivers for devices such
    as the 104-QUAD-8 -- an interface with predefined constants for
    quadrature pairs and succinct declarations.

I'm going to prioritize source code commenting for v3 of this patchset,
and try to prevent the long delay this version had. I'm aiming for a
submission of v3 in the next couple of weeks then as I integrate the
rest of the documentation.

William Breathitt Gray (5):
  iio: Implement counter channel specification and IIO_SIGNAL constant
  iio: Introduce the generic counter interface
  iio: Documentation: Add IIO Generic Counter sysfs documentation
  docs: Add IIO Generic Counter Interface documentation
  iio: 104-quad-8: Add IIO generic counter interface support

 .../testing/sysfs-bus-iio-generic-counter-sysfs    |   63 ++
 Documentation/driver-api/iio/generic-counter.txt   |  555 ++++++++++
 MAINTAINERS                                        |    7 +
 drivers/iio/Kconfig                                |    8 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/counter/104-quad-8.c                   |  306 +++++-
 drivers/iio/counter/Kconfig                        |    1 +
 drivers/iio/industrialio-core.c                    |   14 +-
 drivers/iio/industrialio-counter.c                 | 1151 ++++++++++++++++++++
 include/linux/iio/counter.h                        |  221 ++++
 include/linux/iio/iio.h                            |    2 +
 include/uapi/linux/iio/types.h                     |    1 +
 12 files changed, 2312 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
 create mode 100644 Documentation/driver-api/iio/generic-counter.txt
 create mode 100644 drivers/iio/industrialio-counter.c
 create mode 100644 include/linux/iio/counter.h

-- 
2.14.1

