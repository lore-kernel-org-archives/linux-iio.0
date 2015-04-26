Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33343 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbDZTh0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 15:37:26 -0400
MIME-Version: 1.0
In-Reply-To: <553D3CEC.4090906@kernel.org>
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
	<1429538563-23430-5-git-send-email-daniel.baluta@intel.com>
	<553D3CEC.4090906@kernel.org>
Date: Sun, 26 Apr 2015 22:37:24 +0300
Message-ID: <CAEnQRZA4czS0HV7WHTzrHxasi8d360ta+hjj6n7wUnPiZ64B2Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: Documentation: Add IIO configfs documentation
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 26, 2015 at 10:30 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/04/15 15:02, Daniel Baluta wrote:
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Probably need to start Documentation/ABI/testing/configfs-iio (or something like that)
> as well to document the ABI elements fully.

Yes, this is a good idea.
>
> This plain text doc is particularly useful to hopefully get feedback on the interface
> from those who might not dive into the details of the series.  Thanks!
>> ---
>>  Documentation/iio/iio_configfs.txt | 67 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>  create mode 100644 Documentation/iio/iio_configfs.txt
>>
>> diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
>> new file mode 100644
>> index 0000000..1aa66d1
>> --- /dev/null
>> +++ b/Documentation/iio/iio_configfs.txt
>> @@ -0,0 +1,67 @@
>> +Industrial IIO configfs support
>> +
>> +1. Overview
>> +
>> +Configfs is a filesystem-based manager of kernel objects. IIO uses some
>> +objects that could be easily configured using configfs (e.g.: devices,
>> +triggers).
>> +
>> +See Documentation/filesystems/configfs/configfs.txt for more information
>> +about how configfs works.
>> +
>> +2. Usage
>> +
>> +In order to use configfs support in IIO we need to select it at compile
>> +time via CONFIG_IIO_CONFIGFS config option.
>> +
>> +Then, mount the configfs filesystem (usually under /config directory):
>> +
>> +$ mkdir /config
>> +$ mount -t configfs none /config
>> +
>> +At this point, all default IIO groups will be created and can be accessed
>> +under /config/iio. Next chapters will describe available IIO configuration
>> +objects.
>> +
>> +3. Software triggers
>> +
>> +One of the IIO default configfs groups is the "triggers" groups. It is
>> +automagically accessible when the configfs is mounted and can be found
>> +under /config/iio/triggers.
>> +
>> +Software triggers are created under /config/iio/triggers directory. A sofware
>> +trigger name MUST be of the following form:
>> +     * <trigger-type>-<trigger-name>:
>> +Where:
>> +     * <trigger-type>, specifies the interrupt source (e.g: hrtimer)
>> +     * <trigger-name>, spefcifies the IIO device trigger name
>> +
>> +We support now to following interrupt sources (trigger types):
>> +     * hrtimer, uses high resolution timers as interrupt source
>> +
>> +3.1 Software triggers creation and destruction
>> +
>> +As simply as:
>> +
>> +$ mkdir /config/triggers/<trigger-type>-<trigger-name>
>> +$ rmdir /config/triggers/<trigger-type>-<trigger-name>
>> +e.g:
>> +
>> +$ mkdir /config/triggers/hrtimer-instance1
>> +$ rmdir /config/triggers/hrtimer-instance1
>> +
>> +Each trigger can have one or more attributes specific to the trigger type.
>> +
>> +3.2 "hrtimer" trigger types attributes
>> +
>> +"hrtimer" trigger type has only one attribute:
>> +
>> +$ ls /config/triggers/hrtimer-instance1
>> +sampling_frequency
>> +
>> +sampling_frequency - represents the period in Hz between two consecutive
>> +iio_trigger_poll calls. By default it is set to 100Hz.
>> +
>> +4. Further work
> I wouldn't bother with this section here.
>> +
>> +* add "sysfs" trigger type
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
