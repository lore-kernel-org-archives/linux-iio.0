Return-Path: <daniel.baluta@intel.com>
From: "Baluta, Daniel" <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Roberta Dobrescu
	<roberta.dobrescu@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Purdila, Octavian" <octavian.purdila@intel.com>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>
Subject: RE: [RFC PATCH] iio: Move iio dummy modules out of staging
Date: Sun, 15 Feb 2015 20:58:18 +0000
Message-ID: <4BDEAF0B4D8F634F8160DC743839C4B505015963@IRSMSX108.ger.corp.intel.com>
References: <1423767897-23964-1-git-send-email-roberta.dobrescu@gmail.com>,<54DF3591.4020803@kernel.org>
In-Reply-To: <54DF3591.4020803@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

=0A=
________________________________________=0A=
From: Jonathan Cameron [jic23@kernel.org]=0A=
Sent: Saturday, February 14, 2015 1:46 PM=0A=
To: Roberta Dobrescu; linux-iio@vger.kernel.org=0A=
Cc: Baluta, Daniel; Purdila, Octavian; knaack.h@gmx.de; lars@metafoo.de; pm=
eerw@pmeerw.net=0A=
Subject: Re: [RFC PATCH] iio: Move iio dummy modules out of staging=0A=
=0A=
On 12/02/15 19:04, Roberta Dobrescu wrote:=0A=
> This patch moves iio dummy modules from drivers/staging/iio/ out of=0A=
> staging, to drivers/iio/dummy/.=0A=
>=0A=
> It also adds Makefile and Kconfig files and removes the entries that will=
=0A=
> no longer be needed from drivers/staging/iio/Kconfig and drivers/staging/=
iio/Makefile.=0A=
>=0A=
> The corresponding config options are removed from IIO Staging Drivers men=
u and=0A=
> added to a new IIO Dummy Modules menu.=0A=
>=0A=
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>=0A=
While I can see the advantage in moving this, the issue here was that=0A=
there wase still one large change that would ideally be made to this driver=
=0A=
prior to moving it out of staging.=0A=
=0A=
The way that evgen generates interrupts greatly restricts their use and=0A=
is far from clean.  Something more similar to that done in the sysfs=0A=
trigger would be better.  So change from handle_nested_irq (which will only=
=0A=
ever call the threaded part) to an irq_work_queue.=0A=
=0A=
There is also the outstanding issue on how these devices should be created.=
=0A=
What we have now, with a module parameter controlling how many instances=0A=
are created, kind of works, but is rather uggly!=0A=
=0A=
There is a fun question on whether we can break the ABI on creation of=0A=
a 'fake' device or not?=0A=
=0A=
Maybe it is time to move this out and just take the view that it's=0A=
more esoteric (e.g. not IIO ABI) elements may well change to make it=0A=
cleaner and more flexible.=0A=
=0A=
The creation of these fake devices strikes me as a job for configfs=0A=
rather than module parameters and sysfs magic, but that's a bigger=0A=
change..  We need that stuff anyway to deal with the abuse of sysfs=0A=
to create 'devices' we have in the sysfs-trigger and the proposed=0A=
high frequency timer trigger.=0A=
-----=0A=
=0A=
Hi Jonathan=0A=
=0A=
We are working on some IIO cleanups as a part of OPW program [1], [2].=0A=
Our main priority now is to move ISL29018 out of staging.=0A=
=0A=
What do you think about having an IIO dummy project for the=0A=
next round of OPW.=0A=
=0A=
Besides the changes that you already mentioned we could also add=0A=
support for more devices. This could be a nice 3 months project for an inte=
rn.=0A=
=0A=
I wonder why your reply didn't reach linux-iio list ?=0A=
=0A=
thanks,=0A=
Daniel.=0A=
=0A=
[1] http://kernelnewbies.org/OPWIntro?action=3Drecall&rev=3D138=0A=
[2] https://iiobits.wordpress.com/=0A=
[3] http://marc.info/?l=3Dlinux-iio&m=3D142376792210058&w=3D2=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
