Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52422 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbbDINPt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 09:15:49 -0400
Message-ID: <55267B84.4040206@kernel.org>
Date: Thu, 09 Apr 2015 14:15:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] tools: iio: Add iio targets in tools Makefile
References: <1427571788-2909-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZC4X5_-uAViGdzt+6JT+cQzQHu1VGggP3b6zhBhjbKBTA@mail.gmail.com>
In-Reply-To: <CAEnQRZC4X5_-uAViGdzt+6JT+cQzQHu1VGggP3b6zhBhjbKBTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/15 15:44, Daniel Baluta wrote:
> On Sat, Mar 28, 2015 at 9:43 PM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> This patch adds targets for building and cleaning iio tools to tools/Makefile.
>> To build iio tools from the toplevel kernel directory one should call:
>>
>> $ make -C tools iio
>>
>> and for cleaning it
>>
>> $ make -C tools iio_clean
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
>> ---
>>  tools/Makefile | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/Makefile b/tools/Makefile
>> index 9a617ad..79463b0 100644
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>> @@ -8,6 +8,7 @@ help:
>>         @echo '  cpupower   - a tool for all things x86 CPU power'
>>         @echo '  firewire   - the userspace part of nosy, an IEEE-1394 traffic sniffer'
>>         @echo '  hv         - tools used when in Hyper-V clients'
>> +       @echo '  iio        - IIO tools'
>>         @echo '  lguest     - a minimal 32-bit x86 hypervisor'
>>         @echo '  perf       - Linux performance measurement and analysis tool'
>>         @echo '  selftests  - various kernel selftests'
>> @@ -41,7 +42,7 @@ acpi: FORCE
>>  cpupower: FORCE
>>         $(call descend,power/$@)
>>
>> -cgroup firewire hv guest usb virtio vm net: FORCE
>> +cgroup firewire hv guest usb virtio vm net iio: FORCE
>>         $(call descend,$@)
>>
>>  liblockdep: FORCE
>> @@ -91,7 +92,7 @@ acpi_clean:
>>  cpupower_clean:
>>         $(call descend,power/cpupower,clean)
>>
>> -cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean:
>> +cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean iio_clean:
>>         $(call descend,$(@:_clean=),clean)
>>
>>  liblockdep_clean:
>> @@ -114,6 +115,6 @@ tmon_clean:
>>
>>  clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
>>                 perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
>> -               vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
>> +               vm_clean net_clean iio_clean x86_energy_perf_policy_clean tmon_clean
>>
>>  .PHONY: FORCE
>> --
>> 1.9.1

