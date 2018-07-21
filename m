Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbeGUSzN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 14:55:13 -0400
Date: Sat, 21 Jul 2018 19:01:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH v8 00/11] Introduce the Counter subsystem
Message-ID: <20180721190134.166e50ab@archlinux>
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 15 Jul 2018 16:44:24 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v8:
>  - Add counter_enum.h file
>  - Simplify COUNTER Kconfig option help text
>  - Rename generic-counter.c to the more straightforward counter.c
>  - Update copyright and license boilerplate (use recommended SPDX line)
>  - Replace EXPORT_SYMBOL lines with respective EXPORT_SYMBOL_GPL lines
>  - Replace scnprintf lines with sprintf since we're dealing with sysfs files
>  - Add struct counter_attr_parm to simplify counter_attribute_create parameters
>  - Rename *_comp_t suffixes to *_unit in order to avoid *_t suffix implications
>  - List sysfs attribute values verbatim in sysfs documentation files
>  - Reorganize 104-QUAD-8 driver license boilerplate update to dedicated patch
> 
> This revision is functionally identical to the last; changes in this version
> were made to improve clarity, formatting and whitespace, and organization. I
> also took this opportunity to record some of the new ACKs from the last
> submission.
> 
> The counter_enum.h file was created to hold the Generic Counter enum helper
> functions required by the Generic Counter enum macros (i.e. COUNTER_SIGNAL_ENUM,
> COUNTER_COUNT_ENUM, etc.). These helper functions are not intended to be used
> directly by driver authors, so I thought it best to keep them separated. Now the
> counter.h file contains only macro, functions, and data structures that are
> expected to possibly appear in a counter device driver.
> 
> The counter_attribute_create function parameter list was large so I reorganized
> the parameters into the counter_attr_parm structure, which may be set and passed
> by reference to the counter_attribute_create function. Since the show and store
> function pointers match with the struct device_attribute show and store function
> pointers, I decided to keep them declared as there are here without a typedef --
> however, I can typedef them in a future revision if it will improve clarity to
> do so.
> 
> Heads-up for Jonathan Cameron: you may pick-up the "iio: 104-quad-8: Update
> license boilerplate" patch independent of this series; it's the SPDX license
> boilerplate update for the 104-QUAD-8 IIO driver.
> 
> Sincerely,
> 
> William Breathitt Gray
> 
This crossed with Andrew Morton's good points on this occupying
namespace that is rather too generically named.  Hence I'll assume
we'll see a v9 with a solution to that (and personally ignore v8
to save time ;)

Ah I see you just replied to Andrew. Great!


Jonathan

> Benjamin Gaignard (2):
>   counter: Add STM32 Timer quadrature encoder
>   dt-bindings: counter: Document stm32 quadrature encoder
> 
> Fabrice Gasnier (2):
>   counter: stm32-lptimer: add counter device
>   dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
> 
> William Breathitt Gray (7):
>   counter: Introduce the Generic Counter interface
>   counter: Documentation: Add Generic Counter sysfs documentation
>   docs: Add Generic Counter interface documentation
>   iio: 104-quad-8: Update license boilerplate
>   counter: 104-quad-8: Add Generic Counter interface support
>   counter: 104-quad-8: Documentation: Add Generic Counter sysfs
>     documentation
>   iio: counter: Add deprecation markings for IIO Counter attributes
> 
>  Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
>  Documentation/ABI/testing/sysfs-bus-iio       |    8 +
>  .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
>  .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
>  .../bindings/counter/stm32-timer-cnt.txt      |   31 +
>  .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
>  .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
>  Documentation/driver-api/generic-counter.rst  |  342 ++++
>  Documentation/driver-api/index.rst            |    1 +
>  MAINTAINERS                                   |   15 +-
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    1 +
>  drivers/{iio => }/counter/104-quad-8.c        |  782 ++++++++-
>  drivers/counter/Kconfig                       |   51 +
>  drivers/{iio => }/counter/Makefile            |    5 +-
>  drivers/counter/counter.c                     | 1561 +++++++++++++++++
>  drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
>  drivers/counter/stm32-timer-cnt.c             |  390 ++++
>  drivers/iio/Kconfig                           |    1 -
>  drivers/iio/Makefile                          |    1 -
>  drivers/iio/counter/Kconfig                   |   34 -
>  include/linux/counter.h                       |  505 ++++++
>  include/linux/counter_enum.h                  |   45 +
>  24 files changed, 4341 insertions(+), 86 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  create mode 100644 Documentation/driver-api/generic-counter.rst
>  rename drivers/{iio => }/counter/104-quad-8.c (44%)
>  create mode 100644 drivers/counter/Kconfig
>  rename drivers/{iio => }/counter/Makefile (46%)
>  create mode 100644 drivers/counter/counter.c
>  rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
>  create mode 100644 drivers/counter/stm32-timer-cnt.c
>  delete mode 100644 drivers/iio/counter/Kconfig
>  create mode 100644 include/linux/counter.h
>  create mode 100644 include/linux/counter_enum.h
> 

