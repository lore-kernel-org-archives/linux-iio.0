Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
Date: Wed, 25 Feb 2015 15:38:59 +0200
Message-ID: <CAEnQRZAwv-=aHWDgN1S+V3O6nzu9801GHvZyXNGMvxMGrKG5bA@mail.gmail.com>
Subject: Linux IIO test framework
From: Daniel Baluta <daniel.baluta@intel.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, bogdan.m.davidoaia@intel.com,
	antonel.g.dobre@intel.com, alin.g.arhip@intel.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello,

We are analyzing the possibility of writing a Linux IIO test framework.

First, we need to know if there is already any work done in this
area. Didn't find anything on the Internet :).

Second, do you think that this would bring any benefit to the Linux kernel
IIO subsystem?

We would like to keep the tests in kernel tree under (tools/testing/selftests)
and I'm not yet sure if we can make use of libiio [1].

Because we are now gathering requirements for this, any feedback would
be more than welcomed.

thanks,
Daniel.

[1] https://github.com/analogdevicesinc/libiio
