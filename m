Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753547AbdJHOin (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 10:38:43 -0400
Date: Sun, 8 Oct 2017 13:10:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: Documentation: Add IIO Generic Counter
 sysfs documentation
Message-ID: <20171008131002.3498dd91@archlinux>
In-Reply-To: <7390f98f0285ef5172df64367c0946334824db6c.1507220144.git.vilhelm.gray@gmail.com>
References: <cover.1507220144.git.vilhelm.gray@gmail.com>
        <7390f98f0285ef5172df64367c0946334824db6c.1507220144.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  5 Oct 2017 14:13:59 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the userspace sysfs
> atrributes of the IIO Generic Counter Interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

It's a good start - but I think we need to expand on some elements.
I'm also worried that repurposing the - in here form being actual
subtraction in the differential channels is confusing.

> ---
>  .../testing/sysfs-bus-iio-generic-counter-sysfs    | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
> new file mode 100644
> index 000000000000..b2c09254ec5a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
> @@ -0,0 +1,63 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Counter function mode for Value Y of Counter X; counter function
> +		evaluation triggered by conditions specified by the
> +		countX-Y_trigger_signalX-Z attributes.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function_available
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available function modes for the configuration
> +		of the respective Value Y of Counter X are listed in this file.

Docs need to list what they can be.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_name
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Value Y of Counter X.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_raw
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw count data of Value Y of Counter X.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_triggers
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of Signals associated to Value Y of Counter X.

That description doesn't seem to match.  This is triggers rather than signals.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Trigger mode of Value Y for Signal Z. This attribute indicates
> +		the condition of Signal Z that triggers the counter function
> +		evaluation for Value Y. Both Value Y and Signal Z are part of
> +		Counter X.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z_available
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available trigger modes are listed in this file
> +		for the configuration of the respective Trigger associating
> +		Signal Z of Counter X with Value Y of Counter X.

it's another case where I think overloading the - is getting confusing. Not sure
what the right answer is though!

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_name
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Signal Y of Counter X.

What is this name for?  This doesn't feel like a counter specific thing, but
rather a generic IIO addition.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_raw
> +KernelVersion:	4.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw signal data of Signal Y of Counter X.

While it might seem clunky - I'd prefer us to keep the channel direction
prefixes throughout.  So that means most of these would end up as
in_signalX-Y_raw etc.

As I mentioned before I think overloading the meaning of - is probably
a bad idea.  Not sure what the right option would be though.
Err.  Something like in_signalX<Y>_raw?  Or do we need to make it really
obvious and end up with something like.
in_signalX<CounterY>_raw - though that would require another level of
info beyond and index to describe that we are dealing with a counter
rather than a light channel for example.

I wonder if we would be better off not using the naming to reflect
the grouping at all, but rather add something like in_signalX_group

in_counterY_groupmembers which lists the members.  Are we trying
to stretch the interface too far in sticking to doing it in naming?
Not sure...

Jonathan
