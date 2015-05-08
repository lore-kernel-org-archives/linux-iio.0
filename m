Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52643 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbbEHSlR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:41:17 -0400
Message-ID: <554D0347.9000903@kernel.org>
Date: Fri, 08 May 2015 14:41:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: lars@metafoo.de, jlbec@evilplan.org, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	octavian.purdila@intel.com, pebolle@tiscali.nl,
	patrick.porlan@intel.com, adriana.reus@intel.com,
	constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: Re: [PATCH v6 0/4] Add initial configfs support for IIO
References: <1431092025-14355-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1431092025-14355-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/05/15 09:33, Daniel Baluta wrote:
> This patchset introduces IIO software triggers, offers a way of configuring
> them via configfs and adds the IIO hrtimer based interrupt source to be used
> with software triggers.
> 
> The arhitecture is now split in 3 parts, to remove all IIO trigger specific
> parts from IIO configfs core:
> 
> (1) IIO software triggers - are independent of configfs.
> (2) IIO configfs - offers a generic way of creating IIO objects. So far we can
> 	create software triggers.
> (3) IIO hrtimer trigger - is the first interrupt source for software triggers
> 	(with syfs to follow). Each trigger type can implement its own set of
> 	attributes.
I'm happy with the whole series, but given Lars' involvement would like to
give him a bit of time for another look / reviewed-by / acked-by or similar.

Obviously comments from anyone else welcome as well.

Now all we need to do is all the other uses for configfs that we've
discussed in earlier threads :) Easy really ;)
> 
> Changes since v5: (after Lars comments)
> 	* the most important change is that we moved sampling_frequency attribute
> 	from configfs to trigger's directory in /sys.
> 	* couple of const added to strings
> 	* documentation to public API in sw_trigger.h
> 	* replace pr_err with WARN_ONCE in trigger_make_group to avoid spamming
> 	kernel log, but without leaving user clueless in case of errors.
> 	* we still need to decide if we get a real gain by adding min/max limits
> 	for sampling frequency in /config dir. Anyhow, this can be done in a later
> 	patch.
> 	* fix race in hrtimer_remove
> 
> Changes since v4:
> 	* patch 1/4
> 		- fixed "new line" nit in industrialio-sw-trigger.c
> 		- added license header in sw_trigger.ho
> 	* patch 2/4
> 		- none
> 	* patch 3/4 
> 		- none
> 	* patch 4/4
> 		- removed "Further work" chapter in iio_configfs.txt
> 		- added configfs-iio file in Documentation/ABI/testing
> 
> Daniel Baluta (4):
>   iio: core: Introduce IIO software triggers
>   iio: core: Introduce IIO configfs support
>   iio: trigger: Introduce IIO hrtimer based trigger
>   iio: Documentation: Add IIO configfs documentation
> 
>  Documentation/ABI/testing/configfs-iio |  20 ++++
>  Documentation/iio/iio_configfs.txt     |  58 ++++++++++
>  drivers/iio/Kconfig                    |  16 +++
>  drivers/iio/Makefile                   |   2 +
>  drivers/iio/industrialio-configfs.c    | 117 ++++++++++++++++++++
>  drivers/iio/industrialio-sw-trigger.c  | 115 +++++++++++++++++++
>  drivers/iio/trigger/Kconfig            |  10 ++
>  drivers/iio/trigger/Makefile           |   2 +
>  drivers/iio/trigger/iio-trig-hrtimer.c | 194 +++++++++++++++++++++++++++++++++
>  include/linux/iio/sw_trigger.h         |  85 +++++++++++++++
>  10 files changed, 619 insertions(+)
>  create mode 100644 Documentation/ABI/testing/configfs-iio
>  create mode 100644 Documentation/iio/iio_configfs.txt
>  create mode 100644 drivers/iio/industrialio-configfs.c
>  create mode 100644 drivers/iio/industrialio-sw-trigger.c
>  create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
>  create mode 100644 include/linux/iio/sw_trigger.h
> 

