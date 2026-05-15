Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745238F925;
	Fri, 15 May 2026 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837397; cv=none; b=UGaklSpnScvuZtkxJEwQC0vzGaIWz46A/HPUZyLjmblppKInmfZPchH5Y2RctE7xXNvKSl+ADe9nBnNdY76KH8Bq8YWlvBMJAsypYhQnyHMgT0Ugxk42pBvGQp60bnCFpQwkns433D+6O3e2W3Z6FANFqiSDlF+JcaXe922ZOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837397; c=relaxed/simple;
	bh=SE75j4Iyud7MMtx0DEKj7/adQYIBvLKMI5frRmXs7Vk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dewn617jU1AkNkAzt36AZMkfvozz+p3G4FSM4ehvKy9QEQv6WQOe9ctAmMOKnSpIUzrdCTqI+GwNC1MgjwVbz4OWyBxoS3tu9gvnd8JKNaoW1BibccESC6NH66HWpP/HpzOl84Y30zjueKGF4Yq23bA98D/GKZ3MTrg8w7aiaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SCahSfDJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SCahSfDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778837396; x=1810373396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SE75j4Iyud7MMtx0DEKj7/adQYIBvLKMI5frRmXs7Vk=;
  b=SCahSfDJMwjB5lNcTUGAzAtD95NoX9utSgH4AA9nNc3A1Ds+LoM76us4
   GCynLTSM+Fytp6p0UYLxAl7Qi5KnuQhMwEbxv4Da4titCRQSlLNUDPHuV
   P6Gh2AO5xkx3VujIxco7NVbD6LcDN+tSLitMIXHX2/5T/f0nORFo7v2xI
   kAHzPu5UwgbEO7AtkbrotVaW/HuI2BEH1A1zo2Qp9zSHrNvGfB2a7lGvi
   YA2G2dazfvVdeo9vmDenrqyMt6Ezb2jefDBzU4BM0xcqSRYsMglSZFrvZ
   d3bNvUcf96XIlc0OlJzK7cRcHC83CIeNlwiCnMLImj8YpLsy5iWpQVT74
   Q==;
X-CSE-ConnectionGUID: Y4NSJCdiR8C+lnvQe5YPyw==
X-CSE-MsgGUID: 9sjv03v2TGWzGI5PqWNpdg==
X-IronPort-AV: E=Sophos;i="6.23,236,1770620400"; 
   d="scan'208";a="57560885"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:29:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 15 May 2026 02:29:54 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 15 May 2026 02:29:51 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v4 0/2] add support for Microchip PAC194X Power Monitor
Date: Fri, 15 May 2026 12:29:44 +0300
Message-ID: <20260515092946.10791-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Add support for Microchip PAC194X and PAC195X series of Power Monitor
with Accumulator chip family. This driver covers the following part
numbers:
 - PAC1941, PAC1941-2, PAC1942, PAC1942-2, PAC1943, PAC1944
 - PAC1951, PAC1951-2, PAC1952, PAC1952-2, PAC1953, PAC1954

The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
32V Full-Scale Range.

There are two versions of the PAC194X/5X: the PAC194X-1/5X-1 devices are
for high-side current sensing and the PAC194X/5X-2 devices are for low-side
current sensing or floating VBUS applications. The PAC194X/5X-1 is named
shortly PAC194X/5X.

Differences related to previous patch:
v4:
  rewrite the driver to keep just basic functionality
- fix review comments for device tree binding:
  change compatible from "microchip,pac194(1/2)2" to "microchip,pac194(1/2)-2"
  rewrite the interrupts and interrupt-names
  add gpio-controller
  add range for input voltage and current sense voltage
  remove the long average mode from hardware accumulator
- fix review comments for the driver:
  remove custom attributes
  fix include files
  remove "non standard" frequency
  add range parsing from the device tree for Vbus and Vsense
  free acpi allocated buffers in case of early exit

v3:
- fix review comments device tree binding:
  rewrite commit message
  change the way full scale for voltage and current is set. Add a
    properties to describe if the input is bipolar or not.
  fix the "dtschema/dtc warnings/errors"
- fix review comments driver:
  simplify the driver to include just the basic functionality. More
    features will be added later.
  fix coding style issues
  change to lower case the "to_pac1944_chip_info()" to be more like
    other container_of
  remove the PAC1944_DEV_ATTR() macro
  drop the __func__ bit from error messages
  remove unneeded casts
  change the logic to reset the accumulator when is enabled
  change from {} to { }
  remove unreachable() from the code
  rewrite the code to keep the error paths out of line
  replace scoped_guard() with guard(), where was possible
  use to_delayed_work() to get from work to delayed work
  remove active_channels[] array
  print info message in case FW disagrees with what is found on the bus

v2:
- fix review comments device tree binding:
    remove underscore from names
    add names to the interrupts and list them
    add a better description for new properties
- fix review comments driver:
    fix coding style issues
    use bitmap for checking the active channels
    keep the "pac1944_get_unaligned_be56" here because the change wasn't acceted
      into the asm-generic.
    document new added attributes
    remove the "scan" part till we support buffered capture
    remove "unlikely" marking
    add masks up in some array of const structures to avoid some case statements
    remove pac1944_mutex_destroy function
    replace some functions with a macro (just for testing)
    replace dev_err with dev_err_probe in functions used in pac1944_probe

v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: add support for PAC1944
  iio: adc: add support for PAC194X

 .../bindings/iio/adc/microchip,pac1944.yaml   |  315 +++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1944.c                     | 2172 +++++++++++++++++
 5 files changed, 2507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
 create mode 100644 drivers/iio/adc/pac1944.c


base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
-- 
2.51.0

