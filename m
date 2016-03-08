Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>, Daniel Baluta
	<daniel.baluta@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v5 0/1] iio:pressure:ms5611: fix and enhancements
Date: Tue, 8 Mar 2016 19:00:31 +0100
Message-ID: <cover.1457459537.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Gregor Boirie (1):
  Fixes: 3145229f9191 ("iio:pressure:ms5611: power regulator support")

 drivers/iio/pressure/ms5611_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.1.4
