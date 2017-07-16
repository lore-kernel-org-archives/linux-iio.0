Return-Path: <SRS0=gSC8=6T=gmail.com=arek.burdach@kernel.org>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
To: Patrick Pedersen <ctx.xda@gmail.com>, jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, jic23@kernel.org,
 srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20170715122721.6908-1-ctx.xda@gmail.com>
From: Arek Burdach <arek.burdach@gmail.com>
Message-ID: <af21ea47-29df-443d-0a3d-5fc36d8cf119@gmail.com>
Date: Sun, 16 Jul 2017 09:39:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170715122721.6908-1-ctx.xda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Patrick,

On 15.07.2017 14:27, Patrick Pedersen wrote:
> It shall additionally be noted that the i2c-hid 'sleep' bug (present since kernel ver. 4.3)
> still affects the driver. This means that the sensor hub will not report any movement, until
> the device is suspended and resumed.
>
Do you have workaround for that? In my case suspending and resuming 
doesn't help. Sensor reporting is backing to work in unpredictable way. 
What I've tested:

- kernel v4.13-rc1 with your patch applied
- watch -n1 cat /sys/bus/iio/devices/iio\:device*/*_raw <- value not 
changing
- suspend
- resume
- watch -n1 cat /sys/bus/iio/devices/iio\:device*/*_raw <- still not 
changing

If you have some workaround scenario please add it to bug reported be 
me: https://bugzilla.kernel.org/show_bug.cgi?id=195681

Cheers,
Arek
