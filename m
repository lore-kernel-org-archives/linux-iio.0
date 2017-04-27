Return-Path: <SRS0=+NPL=4D=users.sourceforge.net=elfring@kernel.org>
Subject: Re: HID: sensor-hub: Delete error messages for failed memory
 allocations in sensor_hub_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
 Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jikos@kernel.org>,
 Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
 <7f9e0982-90b9-0e74-4732-7e3153813b2b@users.sourceforge.net>
Message-ID: <2dc6d99c-f214-83b8-39ca-897b9fee1cc8@users.sourceforge.net>
Date: Thu, 27 Apr 2017 20:16:32 +0200
MIME-Version: 1.0
In-Reply-To: <7f9e0982-90b9-0e74-4732-7e3153813b2b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

> WARNING: Possible unnecessary 'out of memory' message

I have noticed a moment ago that a similar change is also contained
in the update suggestion “HID: Remove unnecessary OOM messages”
by Joe Perches from 2017-03-01.
https://patchwork.kernel.org/patch/9598997/
https://lkml.kernel.org/r/<0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>

How would you like to continue with source code adjustments there?

Regards,
Markus
