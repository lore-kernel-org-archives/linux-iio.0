Return-Path: <SRS0=M7s+=KG=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	fabrice.gasnier@st.com,
	benjamin.gaignard@st.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	akpm@linux-foundation.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 00/11] Introduce the Counter subsystem
Date: Sun, 22 Jul 2018 18:49:49 -0400
Message-Id: <cover.1532298882.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes in v9:
 - Prefix exported symbols with "counter_" to make counter namespace
   explicit and clear
 - Replace scnprintf and snprintf lines with sprintf in 104-quad-8.c
   since we're dealing with sysfs files

This revision is functionally identical to the last; changes in this
version were made to improve code clarity. Andrew Morton suggested
improving the names of the exported symbols to clean up the Counter
subsytem namespace. This revision adds a "counter_" prefix to the
exported symbols to keep the namespace tidy and these symbols as
clearly part of the Counter subsystem.

Andrew Morton also brought up a good point that the Generic Counter
"signal" terminology could conflict with the existing established use of
the term in other areas of the Linux kernel. I've changed the major
exported symbols in counter.h that used the "signal_" naming covention
to now use a "counter_signal_" naming convention in order to help
prevent this confusion; I've made similar changes to symbols in
counter.c as well. If this naming still causes trouble, we can consider
alternative names for this component.

William Breathitt Gray

Benjamin Gaignard (2):
  counter: Add STM32 Timer quadrature encoder
  dt-bindings: counter: Document stm32 quadrature encoder

Fabrice Gasnier (2):
  counter: stm32-lptimer: add counter device
  dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move

William Breathitt Gray (7):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  iio: 104-quad-8: Update license boilerplate
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation
  iio: counter: Add deprecation markings for IIO Counter attributes

 Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
 Documentation/ABI/testing/sysfs-bus-iio       |    8 +
 .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
 .../bindings/counter/stm32-timer-cnt.txt      |   31 +
 .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
 .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
 Documentation/driver-api/generic-counter.rst  |  342 ++++
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |   15 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/{iio => }/counter/104-quad-8.c        |  782 +++++++-
 drivers/counter/Kconfig                       |   51 +
 drivers/{iio => }/counter/Makefile            |    5 +-
 drivers/counter/counter.c                     | 1567 +++++++++++++++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 ++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 include/linux/counter.h                       |  510 ++++++
 include/linux/counter_enum.h                  |   45 +
 24 files changed, 4352 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 rename drivers/{iio => }/counter/104-quad-8.c (44%)
 create mode 100644 drivers/counter/Kconfig
 rename drivers/{iio => }/counter/Makefile (46%)
 create mode 100644 drivers/counter/counter.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 include/linux/counter.h
 create mode 100644 include/linux/counter_enum.h

-- 
2.18.0
