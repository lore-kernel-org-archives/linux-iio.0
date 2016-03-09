Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>, Haneen
 Mohammed <hamohammed.sa@gmail.com>, Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>, Darshana Padmadas
	<darshanapadmadas@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>, Octavian
 Purdila <octavian.purdila@intel.com>, Vladimir Barinov
	<vladimir.barinov@cogentembedded.com>, Crt Mori <cmo@melexis.com>, Masanari
 Iida <standby24x7@gmail.com>, Harald Geyer <harald@ccbib.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Michal Simek
	<michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?=
	<soren.brinkmann@xilinx.com>, Kevin Tsai <ktsai@capellamicro.com>, Cristina
 Opriceana <cristina.opriceana@gmail.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, Markus Pargmann <mpa@pengutronix.de>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Bastien Nocera
	<hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, Vlad Dogaru
	<vlad.dogaru@intel.com>, Ana Calinov <ana.calinov@gmail.com>, Adriana Reus
	<adriana.reus@intel.com>, Joachim Eastwood <manabian@gmail.com>, Martin
 Kepplinger <martink@posteo.de>, Christoph Muellner
	<christoph.muellner@theobroma-systems.com>, Roberta Dobrescu
	<roberta.dobrescu@gmail.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Naidu Tellapati
	<naidu.tellapati@imgtec.com>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Marc Titinger <mtitinger@baylibre.com>, Fugang Duan <b38611@freescale.com>,
	Stefan Agner <stefan@agner.ch>, Sanchayan Maity <maitysanchayan@gmail.com>,
	kbuild test robot <fengguang.wu@intel.com>, Bhuvanchandra DV
	<bhuvanchandra.dv@toradex.com>, Lars Svensson
	<lars1.svensson@sonymobile.com>, Vladimirs Ambrosovs
	<rodriguez.twister@gmail.com>, Alan <gnomes@lxorguk.ukuu.org.uk>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Viorel Suman <viorel.suman@gmail.com>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>, Martin Liska
	<marxin.liska@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Markus Elfring
	<elfring@users.sourceforge.net>, Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Andreas Dannenberg <dannenberg@ti.com>, Tiberiu Breana
	<tiberiu.a.breana@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>, Marek Belisko
	<marek@goldelico.com>, Yong Li <sdliyong@gmail.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ioana
 Ciornei <ciorneiioana@gmail.com>, Janani Ravichandran
	<janani.rvchndrn@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Tina Johnson
	<tinajohnson.1234@gmail.com>, Nizam Haider <nizamhaider786@gmail.com>,
	Shivani Bhardwaj <shivanib134@gmail.com>, Gregor Boirie
	<gregor.boirie@parrot.com>
Subject: [PATCH v5 0/2] iio:core: introduce timestamping clock selection
Date: Wed, 9 Mar 2016 19:03:33 +0100
Message-ID: <cover.1457546125.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This version is aimed at all authors/reviewers/<put your title here> of IIO
drivers this patch modifies.
I'm sorry to bother you guys but I just want to ensure that no harmfull disaster
will happen. Please, feel free to ring my bell in case of unforseen/unexpected
behavior.

IIO timestamping clock selection support based on the following principles :
* selected timestamping clock is a per-device attribute which the userspace
  may access through a sysfs file ;
* a single reference clock is used for both buffered samples and events of a
  given device at the same time ;
* userspace may choose amongst the following subset of available POSIX clocks:
  CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
  CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI ;
* sample and event timestamps consistency with respect to clock changes is
  ensured by rejecting the ability to select a new clock as long as an events
  chrdev is opened or a buffered samples channel is enabled for a given device.
* no in-kernel API support since :
  * consumers work synchronously in direct mode, i.e. timestamping may be
    peformed using traditional kernel time keeping ;
  * any given device can only feed a single timestamping channel to all
    consumers.

Changes since v1:
* isolate clock setup from sysfs
* rename timestamping clock sysfs entry to "timestamp_clock"
* make the "timestamp_clock" file content a self-describing string
* merge all 3 patches into a single one
* cosmetics
* rebase onto IIO testing branch

Changes since v2:
* rename timestamping clock sysfs entry to "current_timestamp_clock" to allow a
  futur refinement exposing available clocks through a
  "timestamp_clock_available" sysfs entry
* rename clock ids (remove "CLOCK_" prefix + lower case)
* checkpatch'ed
* rebase onto IIO testing branch

Changes since v3:
* rebase onto IIO testing branch
* leave dht11 driver untouched as timestamping is used for internal purpose
  only

Changes since v4:
* export get_monotonic_coarse64 symbol

Gregor.

Gregor Boirie (2):
  timekeeping: export get_monotonic_coarse64 symbol
  iio:core: timestamping clock selection support

 Documentation/ABI/testing/sysfs-bus-iio           |   7 +
 Documentation/DocBook/iio.tmpl                    |   2 +-
 drivers/iio/accel/bma180.c                        |   2 +-
 drivers/iio/accel/bmc150-accel-core.c             |   4 +-
 drivers/iio/accel/kxcjk-1013.c                    |   2 +-
 drivers/iio/accel/mma7455_core.c                  |   3 +-
 drivers/iio/accel/mma8452.c                       |   4 +-
 drivers/iio/accel/mma9551.c                       |   2 +-
 drivers/iio/accel/mma9553.c                       |   2 +-
 drivers/iio/adc/ad7291.c                          |   2 +-
 drivers/iio/adc/ad7298.c                          |   2 +-
 drivers/iio/adc/ad7476.c                          |   2 +-
 drivers/iio/adc/ad7887.c                          |   2 +-
 drivers/iio/adc/ad7923.c                          |   2 +-
 drivers/iio/adc/ad799x.c                          |   4 +-
 drivers/iio/adc/cc10001_adc.c                     |   2 +-
 drivers/iio/adc/hi8435.c                          |   2 +-
 drivers/iio/adc/ina2xx-adc.c                      |   6 +-
 drivers/iio/adc/max1363.c                         |   5 +-
 drivers/iio/adc/ti-ads1015.c                      |   3 +-
 drivers/iio/adc/vf610_adc.c                       |   3 +-
 drivers/iio/adc/xilinx-xadc-events.c              |   4 +-
 drivers/iio/chemical/atlas-ph-sensor.c            |   2 +-
 drivers/iio/dac/ad5421.c                          |   6 +-
 drivers/iio/dac/ad5504.c                          |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c       |   3 +-
 drivers/iio/dummy/iio_simple_dummy_events.c       |   2 +-
 drivers/iio/gyro/bmg160_core.c                    |  30 ++--
 drivers/iio/iio_core.h                            |   3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        |   2 +-
 drivers/iio/industrialio-core.c                   | 179 +++++++++++++++++++++-
 drivers/iio/industrialio-event.c                  |  19 ++-
 drivers/iio/industrialio-trigger.c                |   2 +-
 drivers/iio/light/acpi-als.c                      |   2 +-
 drivers/iio/light/adjd_s311.c                     |   2 +-
 drivers/iio/light/apds9300.c                      |   2 +-
 drivers/iio/light/apds9960.c                      |   4 +-
 drivers/iio/light/cm36651.c                       |   2 +-
 drivers/iio/light/gp2ap020a00f.c                  |   8 +-
 drivers/iio/light/isl29125.c                      |   2 +-
 drivers/iio/light/lm3533-als.c                    |   2 +-
 drivers/iio/light/ltr501.c                        |   7 +-
 drivers/iio/light/opt3001.c                       |   4 +-
 drivers/iio/light/stk3310.c                       |   2 +-
 drivers/iio/light/tcs3414.c                       |   2 +-
 drivers/iio/light/tcs3472.c                       |   2 +-
 drivers/iio/light/tsl2563.c                       |   2 +-
 drivers/iio/light/us5182d.c                       |   2 +-
 drivers/iio/magnetometer/hmc5843_core.c           |   2 +-
 drivers/iio/magnetometer/mag3110.c                |   2 +-
 drivers/iio/pressure/mpl3115.c                    |   2 +-
 drivers/iio/pressure/ms5611_core.c                |   3 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |   2 +-
 drivers/iio/proximity/sx9500.c                    |   4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c        |   2 +-
 drivers/staging/iio/accel/sca3000_core.c          |   2 +-
 drivers/staging/iio/adc/ad7280a.c                 |   8 +-
 drivers/staging/iio/adc/ad7606_ring.c             |   3 +-
 drivers/staging/iio/adc/ad7816.c                  |   3 +-
 drivers/staging/iio/addac/adt7316.c               |   4 +-
 drivers/staging/iio/cdc/ad7150.c                  |   2 +-
 drivers/staging/iio/light/tsl2x7x_core.c          |   2 +-
 include/linux/iio/iio.h                           |  22 ++-
 kernel/time/timekeeping.c                         |   1 +
 64 files changed, 318 insertions(+), 108 deletions(-)

-- 
2.1.4
