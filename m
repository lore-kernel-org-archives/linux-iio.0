Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdJHOi2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 10:38:28 -0400
Date: Sun, 8 Oct 2017 15:38:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: Introduce the generic counter interface
Message-ID: <20171008153823.30a0793e@archlinux>
In-Reply-To: <cover.1507220144.git.vilhelm.gray@gmail.com>
References: <cover.1507220144.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  5 Oct 2017 14:13:14 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> There have been some significant implementation changes for this version
> of the patchset. Here's a brief summary of the updates:
> 
>  - Inline comments throughout the industrial-counter.c file; this
>    should help clarify some of the code and aid in the review of the
>    system architecture
> 
>  - Simplification of the driver API; primarily, dynamic updates to the
>    Counter Values, Triggers, and Signals lists are no longer allowed --
>    all relationships must be defined before the Counter is registered to
>    the system
> 
>  - Dynamic component registration functions
>    (iio_counter_value_register, et al.) have been removed, and now the
>    signals, values, and triggers array members serve to register the
>    components; signals, values, and triggers were previously named
>    init_signals, init_values, and init_triggers respectively -- the
>    "init_" prefix was removed now that dynamic registration is no longer
>    allowed
> 
>  - Requiring static component relationships means linked lists are no
>    longer necessary so all the list related code has been removed;
>    Signals, Triggers, and Values are now accessed directly from the
>    arrays supplied in the iio_counter structure
> 
>  - No dynamic additions/substraction of components eliminates the need
>    for mutex locks, so those have been removed as well
> 
>  - Previously, the entire iio_counter structure was copied and stored as
>    the iio_dev private data; now, only a pointer to the supplied
>    iio_counter structure is stored
> 
>  - devm_iio_counter_register and devm_iio_counter_unregister functions
>    were incorporated from Benjamin Gaignard's suggestions
> 
>  - Dummy counter driver provided as a reference for a simple counter
>    implementation utilizing the Generic Counter interface
> 
> In a previous discussion, Benjamin noted some conflicts between the
> Generic Counter and the underlying IIO core code: mapping does not
> always work out seemlessly and sometimes the IIO core functionality
> exposure provided via iio_counter is not quite flexible enough. I intend
> to address these shortcomings in the next version of this patchset
> hopefully.
> 
> In particular, I'm leaning towards separating the Generic Counter
> interface from the IIO core dependency entirely. Since the Generic
> Counter inteface focuses on a more abstract representation of a counter
> device, I don't think it provides a suitable interface to map onto IIO
> core, which appears to focus more on a representation of the physical
> hardware itself.
> 
> Separating Generic Counter from IIO core should allow a driver to use
> the IIO core functions (iio_device_register, et al.) to represent the
> physical nature of their hardware (voltages, currents, etc.), while also
> utilize the Generic Counter interface to represent the abstract
> relationships between those Signals and their ultimate counter Values.
> 
> In particular, I'm hoping for the Generic Counter system implementation
> itself to not require all this hoop-jumping (mapping to IIO core
> functions, jumping back to the parent iio_counter, handling non-matching
> parameter lists between iio_counter and iio_dev, etc.); that should make
> the code simpler to debug, more efficient, and more stable in the
> long-run. I will consider these advantages and disadvantages before
> committing to a separation however.

Key things here:
1) userspace ABI - this bit we need to get right
2) driver ABI - right now we'll irritate a few rather nice and hopefully calm
   people - so it doesn't matter much :)
3) Maintainability.  The key thing is to end up with something that is
   easy to look after.  Particularly when the inevitable happens and you 
   can no longer remember how some corner of your own code works.
> 
> Regarding this version of the patchset in particular, I decided to
> remove the dynamic component registration functionality since I doubt
> that many devices would require such; almost all, if not all, hardware
> counters I encountered have static relationships between input lines and
> the count value (i.e. specific input lines correlate to specific count
> registers).

Where this is not true of the bit we are writing a driver for the
wider system should impose this relationship in most cases.
The only exception would be where the counter resources are more
constrained than the hardware it is interfaced to.  So say we have
2 hardware counters on a system that has 4 encoders but there is
some underlying reason why we don't need to use all the encoders
at the same time...  We can probably figure out how to represent
that though even with the initialization time mappings etc.

Something to fix when we care - not from the outset!

> 
> The requirement that Counter component relationships are
> static has opened the possibility of some optimizations in the Generic
> Counter interface code:
> 
>  - Signals, Triggers, and Values are provided as arrays; these arrays
>    could benefit from some amount of sorting based on component IDs
> 
>  - Searching for a component can be more efficient in a sorted array;
>    currently, the code just walks down the array elements and compare
>    the IDs

I raise the point that mostly (I think) the drivers know exactly where
to look in these arrays from the index.  My inclination is to give
them the ability to provide that knowledge to the core.  I wouldn't
worry too much for now. There are lots of ways of dealing with the
small performance enhancements once the rest is sorted - they don't
effect the ABI so we can try what we like ;)

> 
>  - Similar to general searching, the arrays are initially verified to
>    gurantee unique IDs; currently, the code walks down the array
>    elements and compares the current element ID with all the elements
>    before and after -- this could be made more efficient with some
>    sorting

It's not a fast path - don't bother. You'll add code complexity to little
practical gain - 0.1 seconds on boot up or something less than that...

> 
> There are likely other areas of improvement, so let me know and I'll see
> what I can do.

It comes up in the individual patch reviews but my main takeaways would be:

1) Naming - we need to deal with trigger (and I think also value -> counter)
   to limit confusion.
2) Fuller definitions in documentation.  Good start on the docs, but you need
   to be specifying allowable values for parameters as that's what a userspace 
   interface will need to know.

Anyhow, sorry it took me so long to get to it and looking forward to the next
revision!

Jonathan
> 
> William Breathitt Gray (6):
>   iio: Implement counter channel specification and IIO_SIGNAL constant
>   iio: Introduce the generic counter interface
>   iio: Documentation: Add IIO Generic Counter sysfs documentation
>   docs: Add IIO Generic Counter Interface documentation
>   iio: Add dummy counter driver
>   iio: 104-quad-8: Add IIO generic counter interface support
> 
>  .../testing/sysfs-bus-iio-generic-counter-sysfs    |  63 ++
>  Documentation/driver-api/iio/generic-counter.txt   | 526 ++++++++++++
>  MAINTAINERS                                        |   7 +
>  drivers/iio/Kconfig                                |   8 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/counter/104-quad-8.c                   | 294 ++++++-
>  drivers/iio/counter/Kconfig                        |  16 +
>  drivers/iio/counter/Makefile                       |   1 +
>  drivers/iio/counter/dummy-counter.c                | 293 +++++++
>  drivers/iio/industrialio-core.c                    |  14 +-
>  drivers/iio/industrialio-counter.c                 | 900 +++++++++++++++++++++
>  include/linux/iio/counter.h                        | 166 ++++
>  include/linux/iio/iio.h                            |   2 +
>  include/uapi/linux/iio/types.h                     |   1 +
>  14 files changed, 2274 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
>  create mode 100644 Documentation/driver-api/iio/generic-counter.txt
>  create mode 100644 drivers/iio/counter/dummy-counter.c
>  create mode 100644 drivers/iio/industrialio-counter.c
>  create mode 100644 include/linux/iio/counter.h
> 

