Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37340 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbbDHNaa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2015 09:30:30 -0400
MIME-Version: 1.0
In-Reply-To: <1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
Date: Wed, 8 Apr 2015 16:30:27 +0300
Message-ID: <CAEnQRZAijAtRdqke5tP-DFL8ROvnzimBEbHwr1=JxhAaqoCndw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 6, 2015 at 5:18 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> This module is the core of IIO configfs. It creates the "iio" subsystem under
> configfs mount point root, with one default group for "triggers".
>
> It offers basic interface for registering software trigger types. Next patches
> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
> create a new kernel module which implements iio_configfs_trigger.h interface.
>
> See Documentation/iio/iio_configfs.txt for more details on how configfs
> support for IIO works.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Hi all,

I also need your feedback on the following problem.

We would like to be able to create hrtimer triggers from within
a kernel module. There are cases where we don't have an interrupt
pin or the interrupt pin is not connected, and we would like
that applications to run unmodified with these types of sensors too.

We will split the current design into 3 parts:

(1) IIO trigger handling generic part, which offers an API
     to register/unregister/get a reference to a trigger type

(2) IIO configfs part that gets a reference to a trigger type and
handles user requests to create/destroy a trigger.

(3) IIO hrtimer driver that use the API at (1) for registering
/ deregistering a trigger type.

Then, each driver in the case that it doesn't have a "real" trigger,
will get a reference to a "hrtimer" trigger type and create
a new "hrtimer" trigger.

Does this look good to you? This could be easily done from
userspace, but we will need to modify our userspace applications.

Also, handling sampling_frequency/delay would be transparent to
applications if we provide this in kernel API.

Daniel.
