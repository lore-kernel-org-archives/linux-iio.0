Return-Path: <jic23@kernel.org>
Message-ID: <4FD10AEA.80906@kernel.org>
Date: Thu, 07 Jun 2012 21:11:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] staging:iio:adc:ad7298: Use new triggered buffer
 setup helper function
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
> Use the new triggered buffer setup helper function to allocate and register
> buffer and pollfunc.
> 
> Also as part of the conversion drop scan_timestamp being enabled by default,
> since it is a left over of an earlier cleanup.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
