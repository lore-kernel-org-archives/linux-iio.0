Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59733 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbC1Lys (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:54:48 -0400
Message-ID: <55169686.9060107@kernel.org>
Date: Sat, 28 Mar 2015 11:54:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, lars@metafoo.de, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com
Subject: Re: [PATCH 3/3] iio: Documentation: Add initial documentaton for
 IIO
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com> <1427302832-9336-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1427302832-9336-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/15 17:00, Daniel Baluta wrote:
> This file wants to be a starting point document for anyone wanting
> to use IIO configfs support or adding new IIO configfs functionality.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Looks like a good flexible structure to me.  Thanks!
> ---
>  Documentation/iio/iio_configfs.txt | 74 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/iio/iio_configfs.txt
> 
> diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
> new file mode 100644
> index 0000000..494f4ff
> --- /dev/null
> +++ b/Documentation/iio/iio_configfs.txt
> @@ -0,0 +1,74 @@
> +Industrial IIO configfs support
> +
> +1. Overview
> +
> +Configfs is a filesystem-based manager of kernel objects. IIO uses some
> +objects that could be easily configured using configfs (e.g: devices,
> +triggers).
> +
> +See Documentation/filesystems/configfs/configfs.txt for more information about
> +how configfs works.
> +
> +2. Usage
> +
> +In order to use configfs support in IIO we need to select it at compile time
> +via CONFIG_IIO_CONFIGFS config option.
> +
> +Then, mount the configfs filesystem (usually under /config directory):
> +
> +$ mkdir /config
> +$ mount -t configfs none /config
> +
> +At this point, all default IIO groups will be creatd and can be accessed under
> +/config/iio. Next chapters will describe available IIO configurable objects.
> +
> +2.1. Software triggers creation and destruction
> +
> +One of the IIO default configfs groups is the "triggers" groups. It is
> +automagically accessible when the configfs is mounted and can be found under
> +/config/iio/triggers.
> +
> +2.1.1. Trigger creation
> +
> +As simply as:
> +
> +$ mkdir /config/triggers/my_trigger
> +
> +This will create a directory associated with a trigger. To understand how this
> +works we first need to see "my_triggers"'s attributes:
> +
> +$ ls /config/triggers/my_trigger
> +activate            sampling_frequency  type
> +
> +Available types for triggers are:
> +	* none, this is a default dummy trigger that does nothing.
> +	* hrtimer, this is trigger based on high resolution timer.
> +
> +Order of operations in order to create a "hrtimer" trigger:
> +
> +$ echo hrtimer > /config/triggers/my_trigger/type
> +$ echo 1 > /config/triggers/my_trigger/activate
> +$ echo 100 > /config/triggers/my_trigger/sampling_frequency
> +
> +At this point the trigger can be used by an IIO device.
> +
> +2.1.2 Trigger destruction
> +
> +$ echo 1 > /config/triggers/my_trigger/activate
> +
> +3. Misc
> +
> +In order to add a new trigger type, one need to implement a driver that creates
> +an instance of struct iio_configfs_ops (see iio_configfs_trigger.h header file
> +in include/linux/iio) and then support it in iio_trigger_set_configfs_ops
> +function from industrialiio-configfs.c file.
> +
> +These are the existing drivers implementing new trigger types:
> +	* hrtimer => iio/trigger/iio-trig-hrtimer.c
> +
> +4. Further work
> +
> +* IIO dummy device creation
> +* Mappings to 'soft' in kernel users such as iio_input and iio_hwmon
> +* IIO on IIO drivers
> +
> 

