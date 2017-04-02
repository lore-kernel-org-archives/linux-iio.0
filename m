Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60518 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdDBQ1g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Apr 2017 12:27:36 -0400
Message-ID: <1491150454.7991.1.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-hub: Implement batch mode
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org
Cc: linux-iio@vger.kernel.org
Date: Sun, 02 Apr 2017 09:27:34 -0700
In-Reply-To: <3c5824ca-e56b-f1c2-2fda-42f4b4bafa61@kernel.org>
References: <1490738130-54272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <3c5824ca-e56b-f1c2-2fda-42f4b4bafa61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-04-02 at 11:59 +0100, Jonathan Cameron wrote:
> On 28/03/17 22:55, Srinivas Pandruvada wrote:
> > HID sensor hubs using Integrated Senor Hub (ISH) has added
> > capability to
> > support batch mode. This allows host processor to go to sleep for
> > extended
> > duration, while the sensor hub is storing samples in its internal
> > buffers.
> > 

[...]

> > hid_sensor_get_report_latency(iio_trigger_get_drvdata(indio_dev-
> > >trig));
> > +	if (latency < 0)
> > +		return latency;
> > +
> > +	return sprintf(buf, "%d\n", latency / 1000);
> 
> Seems to me that you'll be wanting latencies of sub one second
> sometimes...
> hence I'd make this fixed point.  The core IIO functions should be
> available
> to help with conversion if you want to use them.

Correct. We want latency less than 1 second too, which is granularity
for poll() system call.
So we should be in this case should be able to enter 0.5 for 500
milliseconds using hwfifo_timeout. 

Thanks,
Srinivas
