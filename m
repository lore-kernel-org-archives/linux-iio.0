Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37770 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbC1Tnc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 15:43:32 -0400
Received: by wiaa2 with SMTP id a2so73386538wia.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2015 12:43:30 -0700 (PDT)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, daniel.baluta@intel.com,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] tools: iio: Add iio targets in tools Makefile
Date: Sat, 28 Mar 2015 21:43:08 +0200
Message-Id: <1427571788-2909-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds targets for building and cleaning iio tools to tools/Makefile.
To build iio tools from the toplevel kernel directory one should call:

$ make -C tools iio

and for cleaning it

$ make -C tools iio_clean

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 tools/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 9a617ad..79463b0 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -8,6 +8,7 @@ help:
 	@echo '  cpupower   - a tool for all things x86 CPU power'
 	@echo '  firewire   - the userspace part of nosy, an IEEE-1394 traffic sniffer'
 	@echo '  hv         - tools used when in Hyper-V clients'
+	@echo '  iio        - IIO tools'
 	@echo '  lguest     - a minimal 32-bit x86 hypervisor'
 	@echo '  perf       - Linux performance measurement and analysis tool'
 	@echo '  selftests  - various kernel selftests'
@@ -41,7 +42,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest usb virtio vm net: FORCE
+cgroup firewire hv guest usb virtio vm net iio: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -91,7 +92,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean:
+cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean iio_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -114,6 +115,6 @@ tmon_clean:
 
 clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
 		perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
-		vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
+		vm_clean net_clean iio_clean x86_energy_perf_policy_clean tmon_clean
 
 .PHONY: FORCE
-- 
1.9.1

