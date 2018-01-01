Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeAAMg7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 07:36:59 -0500
Date: Mon, 1 Jan 2018 12:36:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] counter: Documentation: Add Simple Counter
 sysfs documentation
Message-ID: <20180101123654.361aa189@archlinux>
In-Reply-To: <91b739431afb52f0f95a4e33d01e636347649d05.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
        <91b739431afb52f0f95a4e33d01e636347649d05.1513266127.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Dec 2017 15:51:43 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the userspace sysfs
> attributes of the Simple Counter interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-counter-simple-sysfs     | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-simple-sysfs
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-simple-sysfs b/Documentation/ABI/testing/sysfs-bus-counter-simple-sysfs
> new file mode 100644
> index 000000000000..e1f32c64c667
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-simple-sysfs
> @@ -0,0 +1,61 @@
> +What:		/sys/bus/counter/devices/counterX/countY
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y. This is a signed integer value that
> +		represents the accumulated count.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_function
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count function mode of Count Y. Count function evaluation is
> +		triggered by conditions specified by the countY_signalZ_action
> +		attributes. Two count function modes are available: increase and
> +		decrease.
> +
> +		Increase:
> +			Accumulated count is incremented.
> +
> +		Decrease:
> +			Accumulated count is decremented.

Ah, so the specifics are in these files.  Fair enough I suppose though in that
case. Perhaps add a note where relevant in the generic file to say this.

> +
> +What:		/sys/bus/counter/devices/counterX/countY_max
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count Y count data maximum value.

What does this mean?  Does it wrap here, or stop here?
Needs defining.

> +
> +What:		/sys/bus/counter/devices/counterX/countY_min
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count Y count data minimum value.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_signalZ_action
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Action mode of Count Y for Signal Z. This attribute indicates
> +		the condition of Signal Z that triggers the count function
> +		evaluation for Count Y. Four action modes are available: none,
> +		rising edge, falling edge, and both edges.

I'd put the values in quotes to make it easy to isolate them.

> +
> +		None:
> +			Signal does not trigger the count function.
> +
> +		Rising Edge:
> +			Low state transitions to High state.
> +
> +		Falling Edge:
> +			High state transitions to Low state.
> +
> +		Both Edges:
> +			Any state transition.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY
> +KernelVersion:	4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Signal data of Signal Y. This is the respective input level
> +		represented by two available states: low and high.

