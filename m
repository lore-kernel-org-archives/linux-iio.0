Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754171AbdG3Qaw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Jul 2017 12:30:52 -0400
Date: Sun, 30 Jul 2017 17:30:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v1 2/2] iio: tools: add install section
Message-ID: <20170730173047.6477b836@kernel.org>
In-Reply-To: <20170729003605.73790-2-andriy.shevchenko@linux.intel.com>
References: <20170729003605.73790-1-andriy.shevchenko@linux.intel.com>
        <20170729003605.73790-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 29 Jul 2017 03:36:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Allow user to call install target.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
This also looks good to me.  Anyone else want to take
a look?

Thanks,

Jonathan
> ---
>  tools/Makefile     |  6 +++---
>  tools/iio/Makefile | 10 +++++++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 616e7722b327..f3f5f45b6355 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -93,7 +93,7 @@ kvm_stat: FORCE
>  all: acpi cgroup cpupower gpio hv firewire lguest liblockdep \
>  		perf selftests spi turbostat usb \
>  		virtio vm net x86_energy_perf_policy \
> -		tmon freefall objtool kvm_stat
> +		tmon freefall iio objtool kvm_stat
>  
>  acpi_install:
>  	$(call descend,power/$(@:_install=),install)
> @@ -101,7 +101,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -cgroup_install firewire_install gpio_install hv_install lguest_install perf_install spi_install usb_install virtio_install vm_install net_install objtool_install:
> +cgroup_install firewire_install gpio_install hv_install iio_install lguest_install perf_install spi_install usb_install virtio_install vm_install net_install objtool_install:
>  	$(call descend,$(@:_install=),install)
>  
>  liblockdep_install:
> @@ -123,7 +123,7 @@ kvm_stat_install:
>  	$(call descend,kvm/$(@:_install=),install)
>  
>  install: acpi_install cgroup_install cpupower_install gpio_install \
> -		hv_install firewire_install lguest_install liblockdep_install \
> +		hv_install firewire_install iio_install lguest_install liblockdep_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install vm_install net_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 5581c062421a..d4d956020adf 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,7 @@
>  include ../scripts/Makefile.include
>  
> +bindir ?= /usr/bin
> +
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
> @@ -54,6 +56,12 @@ clean:
>  	rm -rf $(OUTPUT)include/linux/iio
>  	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>  
> +install: $(ALL_PROGRAMS)
> +	install -d -m 755 $(DESTDIR)$(bindir);		\
> +	for program in $(ALL_PROGRAMS); do		\
> +		install $$program $(DESTDIR)$(bindir);	\
> +	done
> +
>  FORCE:
>  
> -.PHONY: all clean FORCE prepare
> +.PHONY: all install clean FORCE prepare

