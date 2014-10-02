Return-Path: <iivanov@mm-sol.com>
Message-ID: <1412257785.1027.40.camel@iivanov-dev>
Subject: Re: [PATCH] iio: inkern: Add of_xlate function to struct iio_dev
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Sachin Kamat
 <sachin.kamat@linaro.org>,  Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, John Stultz
 <john.stultz@linaro.org>,  linux-iio@vger.kernel.org, svarbanov@mm-sol.com,
 linux-kernel@vger.kernel.org,  linux-arm-msm@vger.kernel.org
Date: Thu, 02 Oct 2014 16:49:45 +0300
In-Reply-To: <542D5377.90201@metafoo.de>
References: <1412253128-32165-1-git-send-email-iivanov@mm-sol.com>
	 <542D5377.90201@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-10-02 at 15:30 +0200, Lars-Peter Clausen wrote:
> On 10/02/2014 02:32 PM, Ivan T. Ivanov wrote:
> > When #iio-cells is greater than '0', the driver could provide
> > a custom of_xlate function that reads the *args* and returns
> > the appropriate index in registered IIO channels array.
> 
> Do you have an example of a device that doesn't want to use the default 
> mapping? If yes please include it in the commit message, otherwise it is 
> fairly hard to say whether this makes sense or not.

Still not mainlined. You can find more detailed description of the 
issue here[1] and driver here[2].

Regards,
Ivan

[1] https://lkml.org/lkml/2014/10/2/123
[2] http://www.spinics.net/lists/devicetree/msg50717.html
