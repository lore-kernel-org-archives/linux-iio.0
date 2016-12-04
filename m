Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:37037 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbcLDVFi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2016 16:05:38 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Cc: daniel.baluta@intel.com, Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH] docs: IIO documentation conversion from DocBook
Date: Sun,  4 Dec 2016 20:49:05 +0000
Message-Id: <20161204204906.27327-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I had a long train journey today so finished off an initial cut of a
conversion of the existing IIO DocBook over to Sphinx.

There are various issues with the kernel doc in some of our source files
that need cleaning up, but thought I'd get this out for people to be able
to take a first look.

For now I've basically left any editorial work out.  This is just format
conversion (with simple stuff like cross references added as I went along).

I did it by hand because I wanted to get to know the new syntax - that may
well have meant I made different decisions on some of the formatting!

One thing I would love, would be cross referencing to structure members.
A lot of IIO stuff is done by assigning these members of some really quite
large structures.

Note whilst Daniel did a great job on these initial docs, they are far from
complete - so I'd envision adding at least sections on:

1) A structural overview - probably diagrams of how the whole thing fits
together.
2) in kernel interface description
3) Illustrations of 'exceptions' to the standard way of doing things (e.g.
buffers without triggers)
4) DMA buffers etc.
5) Events

Jonathan

Jonathan Cameron (1):
  docs: IIO documentation

 Documentation/driver-api/iio/buffers.rst           | 127 +++++++++++++++
 Documentation/driver-api/iio/core.rst              | 180 +++++++++++++++++++++
 Documentation/driver-api/iio/index.rst             |  15 ++
 Documentation/driver-api/iio/intro.rst             |  23 +++
 Documentation/driver-api/iio/triggered-buffers.rst |  70 ++++++++
 Documentation/driver-api/iio/triggers.rst          |  78 +++++++++
 Documentation/driver-api/index.rst                 |   1 +
 7 files changed, 494 insertions(+)
 create mode 100644 Documentation/driver-api/iio/buffers.rst
 create mode 100644 Documentation/driver-api/iio/core.rst
 create mode 100644 Documentation/driver-api/iio/index.rst
 create mode 100644 Documentation/driver-api/iio/intro.rst
 create mode 100644 Documentation/driver-api/iio/triggered-buffers.rst
 create mode 100644 Documentation/driver-api/iio/triggers.rst

-- 
2.10.2

