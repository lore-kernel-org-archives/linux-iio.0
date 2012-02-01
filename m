Return-Path: <lars@metafoo.de>
Message-ID: <4F299764.8090605@metafoo.de>
Date: Wed, 01 Feb 2012 20:49:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/6] staging:iio: Event handling updates
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1328121956-29596-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/01/2012 07:45 PM, Lars-Peter Clausen wrote:
> Hi Greg,
> 
> This series is a resend of the same series form early January, with two minor
> issues in patch 4 and 5 being fixed. Also the order of patch 5 and 6 in the
> series has been changed.
> 
> The series starts with fixing some documentation issues for the
> iio_event_interface struct. The second patch moves the IIO event handling code
> from the IIO core file to its own file with the next patches containing some
> cleanups to the event handling code. The last patch implements poll support for
> IIO event handling fds.
> 
> - Lars
> 


Sorry for the noise, greg's old email address is already dead, I'll have to
resend this series.
