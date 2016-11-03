Return-Path: <jikos@kernel.org>
Date: Thu, 3 Nov 2016 12:10:31 -0600 (MDT)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Fix packing of result buffer for feature
 report
In-Reply-To: <1477612160-23621-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1611031210120.5061@cbobk.fhfr.pm>
References: <1477612160-23621-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 27 Oct 2016, Srinivas Pandruvada wrote:

> When report count is more than one and report size is not 4 bytes, then we
> need some packing into result buffer from the caller of function
> sensor_hub_get_feature.
> By default the value extracted from a field is 4 bytes from hid core
> (using hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT)), even
> if report size if less than 4 byte. So when we copy data to user buffer in
> sensor_hub_get_feature, we need to only copy report size bytes even
> when report count is more than 1. This is
> not an issue for most of the sensor hub fields as report count will be 1
> where we already copy only report size bytes, but some string fields
> like description, it is a problem as the report count will be more than 1.
> For example:
>     Field(6)
>       Physical(Sensor.OtherCustom)
>       Application(Sensor.Sensor)
>       Usage(11)
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>         Sensor.0306
>       Report Size(16)
>       Report Count(11)
> 
> Here since the report size is 2 bytes, we will have 2 additional bytes of
> 0s copied into user buffer, if we directly copy to user buffer from
> report->field[]->value
> 
> This change will copy report size bytes into the buffer of caller for each
> usage report->field[]->value. So for example without this change, the
> data displayed for a custom sensor field "sensor-model":
> 
> 76 00 101 00 110 00 111 00 118 00 111
> (truncated to report count of 11)
> 
> With change
> 
> 76 101 110 111 118 111 32 89 111 103 97
> ("Lenovo Yoga" in ASCII )
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied for 4.9-rc. Thanks,

-- 
Jiri Kosina
SUSE Labs
