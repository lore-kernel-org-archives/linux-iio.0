Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1427571788-2909-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1427571788-2909-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Mon, 6 Apr 2015 17:44:03 +0300
Message-ID: <CAEnQRZC4X5_-uAViGdzt+6JT+cQzQHu1VGggP3b6zhBhjbKBTA@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: Add iio targets in tools Makefile
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 28, 2015 at 9:43 PM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch adds targets for building and cleaning iio tools to tools/Makefile.
> To build iio tools from the toplevel kernel directory one should call:
>
> $ make -C tools iio
>
> and for cleaning it
>
> $ make -C tools iio_clean
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  tools/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/Makefile b/tools/Makefile
> index 9a617ad..79463b0 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -8,6 +8,7 @@ help:
>         @echo '  cpupower   - a tool for all things x86 CPU power'
>         @echo '  firewire   - the userspace part of nosy, an IEEE-1394 traffic sniffer'
>         @echo '  hv         - tools used when in Hyper-V clients'
> +       @echo '  iio        - IIO tools'
>         @echo '  lguest     - a minimal 32-bit x86 hypervisor'
>         @echo '  perf       - Linux performance measurement and analysis tool'
>         @echo '  selftests  - various kernel selftests'
> @@ -41,7 +42,7 @@ acpi: FORCE
>  cpupower: FORCE
>         $(call descend,power/$@)
>
> -cgroup firewire hv guest usb virtio vm net: FORCE
> +cgroup firewire hv guest usb virtio vm net iio: FORCE
>         $(call descend,$@)
>
>  liblockdep: FORCE
> @@ -91,7 +92,7 @@ acpi_clean:
>  cpupower_clean:
>         $(call descend,power/cpupower,clean)
>
> -cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean:
> +cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean iio_clean:
>         $(call descend,$(@:_clean=),clean)
>
>  liblockdep_clean:
> @@ -114,6 +115,6 @@ tmon_clean:
>
>  clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
>                 perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
> -               vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
> +               vm_clean net_clean iio_clean x86_energy_perf_policy_clean tmon_clean
>
>  .PHONY: FORCE
> --
> 1.9.1
