Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbcFJN4H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jun 2016 09:56:07 -0400
Message-ID: <1465566904.10525.11.camel@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	chaya.golan@intel.com, daniel.drubin@intel.com,
	Darren Hart <darren@dvhart.com>
Date: Fri, 10 Jun 2016 06:55:04 -0700
In-Reply-To: <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
	 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-10 at 10:44 +0100, Grant Likely wrote:
[...]
> 
> Yes, I do see the in_*_raw_* files in sysfs, and I'm able to get data
> out of them. Gnome also seems to recognize that the accelerometers
> are
> there because it adds a rotation lock button to the system menu.
> 
> However, the events are getting through yet. It may be that I'm
> missing something in my kernel config. I'm rebuilding the kernel with
> Debian's config for the 4.5.5 kernel as a quick sanity test. I'll
> report back when I've tried.
> 
You need to add in /usr/lib/system/systemd/iio-sensor-*

After=multi-user.target


This service starts too early.

> I'll also take some time and review the patch series later this
> afternoon.

Atri Bhattacharya reported issues with suspend/resume. With my test
patches it is fixed for him

If you want to hold on, I will repost with fixes for susend/resume.

Thanks,
Srinivas

> 

> g.
> 
> > 
> > Thanks,
> > Srinivas
> > 
> > 
> > > Thanks,
> > > g.
> > > 
> > > > 
> > > > 
> > > > This series is tested on:
> > > > - Lenovo Yoga 260 with Skylake processor
> > > > - HP Pavilion x2 detachable with Cherrytrail
> > > > 
> > > > The user mode ABI is still same as external sensor hubs using
> > > > Linux
> > > > IIO. So existing user mode software should still work without
> > > > change.
> > > > This series primarily brings in new HID transport used in ISH.
> > > > 
> > > > This series submitted as a RFC to try on several devices. We
> > > > have
> > > > received request from Linux users who wanted this support. So I
> > > > hope all
> > > > those users try and give feedback.
> > > > 
> > > > Daniel Drubin (3):
> > > >   hid: intel_ish-hid: ISH Transport layer
> > > >   hid: intel-ish-hid: ipc layer
> > > >   hid: intel-ish-hid: ISH HID client driver
> > > > 
> > > > Srinivas Pandruvada (1):
> > > >   Documentation: hid: Intel ISH HID document
> > > > 
> > > >  Documentation/hid/intel-ish-hid.txt          |  375 +++++++++
> > > >  drivers/hid/Kconfig                          |    2 +
> > > >  drivers/hid/Makefile                         |    2 +
> > > >  drivers/hid/intel-ish-hid/Kconfig            |   27 +
> > > >  drivers/hid/intel-ish-hid/Makefile           |   20 +
> > > >  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h  |  220 +++++
> > > >  drivers/hid/intel-ish-hid/ipc/hw-ish.h       |   71 ++
> > > >  drivers/hid/intel-ish-hid/ipc/ipc.c          |  710
> > > > ++++++++++++++++
> > > >  drivers/hid/intel-ish-hid/ipc/pci-ish.c      |  238 ++++++
> > > >  drivers/hid/intel-ish-hid/ipc/utils.h        |   65 ++
> > > >  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  672
> > > > +++++++++++++++
> > > >  drivers/hid/intel-ish-hid/ishtp-hid.c        |  201 +++++
> > > >  drivers/hid/intel-ish-hid/ishtp-hid.h        |  157 ++++
> > > >  drivers/hid/intel-ish-hid/ishtp/bus.c        |  670
> > > > +++++++++++++++
> > > >  drivers/hid/intel-ish-hid/ishtp/bus.h        |   99 +++
> > > >  drivers/hid/intel-ish-hid/ishtp/client.c     | 1131
> > > > ++++++++++++++++++++++++++
> > > >  drivers/hid/intel-ish-hid/ishtp/client.h     |  196 +++++
> > > >  drivers/hid/intel-ish-hid/ishtp/dma-if.c     |  175 ++++
> > > >  drivers/hid/intel-ish-hid/ishtp/hbm.c        |  911
> > > > +++++++++++++++++++++
> > > >  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  319 ++++++++
> > > >  drivers/hid/intel-ish-hid/ishtp/init.c       |   94 +++
> > > >  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  276 +++++++
> > > >  include/trace/events/intel_ish.h             |   30 +
> > > >  23 files changed, 6661 insertions(+)
> > > >  create mode 100644 Documentation/hid/intel-ish-hid.txt
> > > >  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
> > > >  create mode 100644 drivers/hid/intel-ish-hid/Makefile
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-
> > > > client.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
> > > >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
> > > >  create mode 100644 include/trace/events/intel_ish.h
> > > > 
> > > > --
> > > > 1.9.1
> > > > 
