Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 00/32] iio-tools out-of-staging cleanup
Date: Sun, 31 May 2015 14:39:40 +0200
Message-Id: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Now that the iio-tools got moved out of staging, it is about time to
improve code quality to common kernel level.

Hartmut Knaack (32):
  tools:iio:generic_buffer: fix order of freeing data
  tools:iio:generic_buffer: free dev_dir_name on exit
  tools:iio:iio_utils: free scan_el_dir on exit
  tools:iio: free channel-array completely
  tools:iio:iio_utils: fix allocation handling
  tools:iio:generic_buffer: add check before free
  tools:iio:lsiio: add closedir before exit
  tools:iio: save errno first
  tools:iio:iio_event_monitor: save right errno
  tools:iio:generic_buffer: fix check of errno
  tools:iio:generic_buffer: pass up right error code
  tools:iio:generic_buffer: sign-extend and shift data
  tools:iio:iio_utils: check amount of matches
  tools:iio:iio_utils: implement digit calculation
  tools:iio:iio_utils: mark private function static
  tools:iio: catch errors in string allocation
  tools:iio:generic_buffer: catch errors for arguments conversion
  tools:iio:generic_buffer: add error handling
  tools:iio:iio_event_monitor: add error handling
  tools:iio:iio_event_monitor: check if event is fully read
  tools:iio:iio_utils: add error handling
  tools:iio:lsiio: add error handling
  tools:iio:iio_utils: add missing documentation
  tools:iio: return values directly
  tools:iio:iio_event_monitor: refactor events output
  tools:iio:iio_utils: refactor assignment of is_signed
  tools:iio:iio_utils: move up reset of sysfsfp
  tools:iio:iio_utils: initialize count during declaration
  tools:iio: rework program parameters
  tools:iio:iio_utils: pass strings as const
  tools:iio: adjust coding style
  tools:iio: rename variables

 tools/iio/generic_buffer.c    | 248 ++++++++++++------
 tools/iio/iio_event_monitor.c |  68 +++--
 tools/iio/iio_utils.c         | 584 ++++++++++++++++++++++++++++++++----------
 tools/iio/iio_utils.h         |  35 +--
 tools/iio/lsiio.c             |  94 ++++---
 5 files changed, 737 insertions(+), 292 deletions(-)

-- 
2.3.6
