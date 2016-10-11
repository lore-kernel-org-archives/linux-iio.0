Return-Path: <tomas@novotny.cz>
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Yong Li <sdliyong@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/4] iio: dac: mcp4725: use regulator framework, add vref and dt support
Date: Tue, 11 Oct 2016 15:57:39 +0200
Message-Id: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

here is a second version of a series to use regulator framework, add an
option to set external reference and to add devicetree support for
mcp4725/6.

I wasn't using the regulator framework in the previous version. That is the
reason why is the second iteration very different. I took ad7303.c as a
reference.

Changes since v1:
- add the first patch
- use regulator framework
- fix printf argument (%u instead of %d)
- add parenthesis to make expression more clear
- fix typo in documentation (Microchpip)
- move vref configuration from probe function to new mcp4726_set_cfg

Tomas Novotny (4):
  iio: dac: mcp4725: use regulator framework
  iio: dac: mcp4725: support voltage reference selection
  Documentation: dt: iio: add mcp4725/6 dac device binding
  iio: dac: mcp4725: add devicetree support

 .../devicetree/bindings/iio/dac/mcp4725.txt        |  35 ++++
 drivers/iio/dac/mcp4725.c                          | 182 +++++++++++++++++++--
 include/linux/iio/dac/mcp4725.h                    |   3 +-
 3 files changed, 202 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt

-- 
2.1.4
