Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>, Daniel Baluta
	<daniel.baluta@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v7 0/1] iio:pressure:ms5611: fix and enhancements
Date: Thu, 17 Mar 2016 12:55:02 +0100
Message-ID: <cover.1458215358.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Changes since v1:
* temperature compensation fix:
    * reword commit message
    * remove useless parenthesis
* power regulator: reword commit message
* add oversampling rate support

Changes since v2:
* remove non printable characters from commit messages

Changes since v3:
* drop first 3 patches since applied onto testing
* fix oops at regulator probing time if regulator support not compiled-in
* complete device-tree support and documentation
* remove continuous sampling support (see Jonathan's "kthread tight loop
  trigger" proposal)
* checkpatch'ed

Changes since v4:
* drop first 2 patches since applied
* amend commit to include "Fixes" tag

Changes since v5:
* reword patch subject line and include "Fixes" tag in commit message

Changes since v6:
* use devm_regulator_get to allow dummy regulator usage
* ensure regulator is properly disabled

Regards,
Gregor.

Gregor Boirie (1):
  iio:pressure:ms5611: fix missing regulator_disable

 drivers/iio/pressure/ms5611.h      |  3 +++
 drivers/iio/pressure/ms5611_core.c | 41 +++++++++++++++++++++++++++++---------
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.1.4
