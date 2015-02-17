Return-Path: <jkosina@suse.cz>
Date: Tue, 17 Feb 2015 13:35:18 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] HID Sensor hub driver fixes
In-Reply-To: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1502171335030.2279@pobox.suse.cz>
References: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 7 Jan 2015, Srinivas Pandruvada wrote:

> Address two bug fixes in the existing code.
> 
> Srinivas Pandruvada (2):
>   HID: hid-sensor-hub: Correct documentation
>   HID: sensor-hub: correct dyn_callback_lock IRQ-safe change
> 
>  drivers/hid/hid-sensor-hub.c   | 8 +++++---
>  include/linux/hid-sensor-hub.h | 5 +++++
>  2 files changed, 10 insertions(+), 3 deletions(-)

Applied to for-3.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
