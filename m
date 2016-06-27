Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 0/7] iio:st_pressure: improvements
Date: Mon, 27 Jun 2016 12:38:51 +0200
Message-ID: <cover.1467023672.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This follows up on various comments related to the preliminary patch series
found at http://www.spinics.net/lists/linux-iio/msg24239.html

Note ! Note ! First patch reworks the way triggered buffering is done and will
affect other st_sensors. If anyone owning one of these could run some tests, I'd
be glad to get some feedback.

What you'll find here :
* make st_pressure sensors compliant with IIO ABI ;
* fix the way st_sensors samples are stored in memory to comply with IIO
  expected alignment constraints ;
* add support for temperature triggered buffering ;
* enhance LPS22HB support.

Changes since v1 :
* drop first patch since already applied
* comment skipping of timestamping channel at setup time
* remove useless channel initializers

Changes since preliminary series :
* drop patches already applied onto testing branch
* 1st patch is a rebase of Jonathan's fixes-togreg branch d43a411 commit onto
  testing branch
* reorder patches to move fix patches ahead of series
* document sampling gains and datasheets in a separate patch
* rebase of other patches on top of testing branch
* complete LPS22HB support with Linus' open drain mode

Tested with the following Linus' fixes-togreg branch patches applied :
9914760 iio: st_sensors: Disable DRDY at init time
ff05916 iio: st_sensors: Init trigger before irq request
65925b6 iio: st_sensors: switch to a threaded interrupt

Regards,
gregor.

Gregor Boirie (7):
  iio:st_sensors: align on storagebits boundaries
  iio:st_pressure: align storagebits on power of 2
  iio:st_pressure: document sampling gains
  iio:st_pressure: temperature triggered buffering
  iio:st_pressure:lps22hb: open drain support
  iio:st_pressure:lps22hb: temperature support
  iio:st_pressure: clean useless static channel initializers

 drivers/iio/common/st_sensors/st_sensors_buffer.c |  37 +++---
 drivers/iio/common/st_sensors/st_sensors_core.c   |   2 +-
 drivers/iio/pressure/st_pressure_core.c           | 155 ++++++++++++++++++----
 3 files changed, 148 insertions(+), 46 deletions(-)

-- 
2.1.4
