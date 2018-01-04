Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:06:18 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 0/5] iio: use permission specific variants of DEVICE_ATTR
Message-ID: <cover.1515076155.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Series of clean-up patches which replace all DEVICE_ATTR macros with the
permission specific variants DEVICE_ATTR_{RO/WO/RW}.

Patches were created using coccinelle. The following script is for conversion to
the DEVICE_ATTR_RO macro and the other conversions are similar. The script may
require some manual intervention when multiple attributes share the show or
store function.

@r@
identifier attr, show_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);

@script: python p@
attr_show;
attr << r.attr;
@@

// standardise the show fn name to {attr}_show
coccinelle.attr_show = attr + "_show"

@@
identifier r.attr, r.show_fn;
declarer name DEVICE_ATTR_RO;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);
+ DEVICE_ATTR_RO(attr);

@rr@
identifier r.show_fn, p.attr_show;
@@

// rename the show function
- show_fn
+ attr_show
        (...) {
        ...
  }

@depends on rr@
identifier r.show_fn, p.attr_show;
@@

// rename fn usages
- show_fun
+ attr_show

Aishwarya Pant (5):
  iio: buffer: use permission specific variants of DEVICE_ATTR
  iio: core: use permission specific variants of DEVICE_ATTR
  iio: trigger: use permission specific variants of DEVICE_ATTR
  iio: hrtimer: use permission specific variants of DEVICE_ATTR
  iio: trigger: sysfs: use permisssion specific variants of DEVICE_ATTR

 drivers/iio/industrialio-buffer.c      | 25 +++++++++++--------------
 drivers/iio/industrialio-core.c        | 11 +++++------
 drivers/iio/industrialio-trigger.c     | 18 ++++++++----------
 drivers/iio/trigger/iio-trig-hrtimer.c |  8 +++-----
 drivers/iio/trigger/iio-trig-sysfs.c   |  4 ++--
 5 files changed, 29 insertions(+), 37 deletions(-)

-- 
2.15.1
