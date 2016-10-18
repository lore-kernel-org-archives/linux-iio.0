Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:50799 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941009AbcJRRtg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2016 13:49:36 -0400
From: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v3 0/5] iio: dac: mcp4725: use regulator framework, add vref and dt support
Date: Tue, 18 Oct 2016 19:43:04 +0200
Message-Id: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Tomas Novotny <tomas@novotny.cz>

Hi all,

here is a third version of a series to use regulator framework, add an
option to set external reference and to add devicetree support for
mcp4725/6.

Third version fixes mainly small bits found in the previous version.

Series is tested on MCP4726 on device tree platform.

Changes since v2:
- whitespace fix of two consecutive lines between patches (it affects
  already applied patch)
- abort probe instead of recovery in case of invalid configuration
- use local variable instead of allocation for platform data
- move unrelated comment fix to the new patch
- add ack from Rob
- fix doubled space in an assignment
- add documentation for the struct mcp4725_platform_data
- move the documentation patch forward because it is referenced in struct
  mcp4725_platform_data now
 
Changes since v1:
- add the first patch
- use regulator framework
- fix printf argument (%u instead of %d)
- add parenthesis to make expression more clear
- fix typo in documentation (Microchpip)
- move vref configuration from probe function to new mcp4726_set_cfg

Tomas Novotny (5):
  iio: dac: mcp4725: use regulator framework
  iio: dac: mcp4725: fix incorrect comment
  Documentation: dt: iio: add mcp4725/6 dac device binding
  iio: dac: mcp4725: support voltage reference selection
  iio: dac: mcp4725: add devicetree support

 .../devicetree/bindings/iio/dac/mcp4725.txt        |  35 ++++
 drivers/iio/dac/mcp4725.c                          | 177 +++++++++++++++++++--
 include/linux/iio/dac/mcp4725.h                    |  12 +-
 3 files changed, 206 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt

-- 
2.1.4

