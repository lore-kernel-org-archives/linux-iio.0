Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeAAMJc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 07:09:32 -0500
Date: Mon, 1 Jan 2018 11:26:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/11] counter: Documentation: Add Generic Counter
 sysfs documentation
Message-ID: <20180101112601.64cf29d9@archlinux>
In-Reply-To: <e1235f0c7151a69f838dfc8eb4f25bd4cb9fe415.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
        <e1235f0c7151a69f838dfc8eb4f25bd4cb9fe415.1513266127.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Dec 2017 15:50:58 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the userspace sysfs
> attributes of the Generic Counter interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-counter-generic-sysfs    | 73 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs b/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
> new file mode 100644
> index 000000000000..3b1c3c4498d1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
> @@ -0,0 +1,73 @@
> +What:		/sys/bus/counter/devices/counterX/countY
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y. Typically, this is an accumulated count
> +		value.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_function
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count function mode of Count Y; count function evaluation is
> +		triggered by conditions specified by the countY_signalZ_action
> +		attributes.

List possible values here or in the available.  This document should fully
define the interface.

> +
> +What:		/sys/bus/counter/devices/counterX/countY_function_available
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available count function modes for the
> +		configuration of the respective Count Y are listed in this file.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_name
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Count Y.

It's specific to both the device and the count so make that clear.
Also give a description of where it comes from.  Who makes this up and how
do they do it?

> +
> +What:		/sys/bus/counter/devices/counterX/countY_signalZ_action
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Action mode of Count Y for Signal Z. This attribute indicates
> +		the condition of Signal Z that triggers the count function
> +		evaluation for Count Y.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_signalZ_action_available
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available action modes are listed in this file
> +		for the configuration of the respective Synapse associating
> +		Signal Z to Count Y.

Again, all options need to be explicitly listed.

> +
> +What:		/sys/bus/counter/devices/counterX/counter_name
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		the Counter.

How is this decided? (actually the IIO docs are weak on this as well I think
- I should fix that as we frequently end up in a mess over this).

> +
> +What:		/sys/bus/counter/devices/counterX/signalY
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Signal data of Signal Y. Typically, this is an input line level
> +		state.

I would avoid 'typically'.  Just expand this text to cover new options when
they occur.

> +
> +What:		/sys/bus/counter/devices/counterX/signalY_name
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Signal Y.

Again, decided how?

> +
> +What:		/sys/bus/counter/devices/counterX/countY_synapses
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of Synapses associating Signals to Count Y. The columns
> +		represent the following in the respective order: Signal ID,
> +		Signal name, and current action mode.

This doesn't really conform to the sysfs golden rule of one attribute one
thing.
An alternative I would look into would be to have countY_synapses
directory containing a number of files to indicate this.
Signal name looks redundant to me though as it can be established easily
from the ID (I think).  So I would have 
countY_synapses/synapse_signalX_action and the action in there.

Not totally sure how this would work out in reality but it would at least
mean software only had to read the one it cared about rather than parse
a table.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07dd7b933bfa..38da1bc615b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3665,6 +3665,7 @@ COUNTER INTERFACE
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter-*
>  F:	drivers/iio/counter/
>  F:	include/linux/iio/counter.h
>  

