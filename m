Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <4BDEAF0B4D8F634F8160DC743839C4B505015963@IRSMSX108.ger.corp.intel.com>
References: <1423767897-23964-1-git-send-email-roberta.dobrescu@gmail.com>,<54DF3591.4020803@kernel.org> <4BDEAF0B4D8F634F8160DC743839C4B505015963@IRSMSX108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [RFC PATCH] iio: Move iio dummy modules out of staging
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 16 Feb 2015 21:45:37 +0000
To: "Baluta, Daniel" <daniel.baluta@intel.com>,Jonathan Cameron <jic23@kernel.org>,Roberta Dobrescu <roberta.dobrescu@gmail.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Purdila, Octavian" <octavian.purdila@intel.com>,"knaack.h@gmx.de" <knaack.h@gmx.de>,"lars@metafoo.de" <lars@metafoo.de>,"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Message-ID: <75FFB2BC-0308-479C-991D-4E3BC4516334@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 15 February 2015 20:58:18 GMT+00:00, "Baluta, Daniel" <daniel.baluta@intel.com> wrote:
>
>________________________________________
>From: Jonathan Cameron [jic23@kernel.org]
>Sent: Saturday, February 14, 2015 1:46 PM
>To: Roberta Dobrescu; linux-iio@vger.kernel.org
>Cc: Baluta, Daniel; Purdila, Octavian; knaack.h@gmx.de;
>lars@metafoo.de; pmeerw@pmeerw.net
>Subject: Re: [RFC PATCH] iio: Move iio dummy modules out of staging
>
>On 12/02/15 19:04, Roberta Dobrescu wrote:
>> This patch moves iio dummy modules from drivers/staging/iio/ out of
>> staging, to drivers/iio/dummy/.
>>
>> It also adds Makefile and Kconfig files and removes the entries that
>will
>> no longer be needed from drivers/staging/iio/Kconfig and
>drivers/staging/iio/Makefile.
>>
>> The corresponding config options are removed from IIO Staging Drivers
>menu and
>> added to a new IIO Dummy Modules menu.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>While I can see the advantage in moving this, the issue here was that
>there wase still one large change that would ideally be made to this
>driver
>prior to moving it out of staging.
>
>The way that evgen generates interrupts greatly restricts their use and
>is far from clean.  Something more similar to that done in the sysfs
>trigger would be better.  So change from handle_nested_irq (which will
>only
>ever call the threaded part) to an irq_work_queue.
>
>There is also the outstanding issue on how these devices should be
>created.
>What we have now, with a module parameter controlling how many
>instances
>are created, kind of works, but is rather uggly!
>
>There is a fun question on whether we can break the ABI on creation of
>a 'fake' device or not?
>
>Maybe it is time to move this out and just take the view that it's
>more esoteric (e.g. not IIO ABI) elements may well change to make it
>cleaner and more flexible.
>
>The creation of these fake devices strikes me as a job for configfs
>rather than module parameters and sysfs magic, but that's a bigger
>change..  We need that stuff anyway to deal with the abuse of sysfs
>to create 'devices' we have in the sysfs-trigger and the proposed
>high frequency timer trigger.
>-----
>
>Hi Jonathan
>
>We are working on some IIO cleanups as a part of OPW program [1], [2].
>Our main priority now is to move ISL29018 out of staging.
>
>What do you think about having an IIO dummy project for the
>next round of OPW.
>
>Besides the changes that you already mentioned we could also add
>support for more devices. This could be a nice 3 months project for an
>intern.
Cool. Thoroughly in favour.  Perhaps looking at accompanying docs as an extension would be good..

Just seen your description. Looks good and we can expand on it as needed later.
Will be interesting to see how it works out!
>
>I wonder why your reply didn't reach linux-iio list ?
>
>thanks,
>Daniel.
>
>[1] http://kernelnewbies.org/OPWIntro?action=recall&rev=138
>[2] https://iiobits.wordpress.com/
>[3] http://marc.info/?l=linux-iio&m=142376792210058&w=2
>
>
>
>
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
