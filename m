Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EE331EB2;
	Sun, 18 Oct 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365351; cv=none; b=rylIaIenjhhS8BLkz//O1/0W/qLr7Bqf5/ylxwSgEjcOYhy69fPnRxJF3XN+/02o3XTS/EOM7veYQFINO8ivbYGzeiN3jpSrZWT+Tc4EMkaG22xWcBhNb2Ez03W7Xu7h9krkjwLTh+0KFFy5njGLvHAYZATi5J+UNRC0WKepR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365351; c=relaxed/simple;
	bh=+OSrWr50zUCKoU85B1HY61GgrKfHb3iVmSdlhTbbOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYcQvuha/mjIw7e6meiFkzaIr5QrRbR3hFoaYyf8aYu5u/0wL+UogYQnxXs2ZGtCdLuF0UYXUcKxDT0YrnaWRa7iqa7h421tFeFLwFlPwDZQ7h7NqTi/aX6Gc/Zvgzsmt5bpe9CnzSj69pETH93amk55ezIdL3sh7/GZ2o9AmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzdGfbew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzdGfbew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F441F000C4;
	Sun, 18 Oct 2026 23:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792365350;
	bh=4e4WE20O8Rc1VgzdqF32AmLC1BPibXZYUFbzR4tIIrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EzdGfbewnEhIziv1YL/5Gs3Q8qpBioGwiZ3DXYkEaS3CR8wJKqldZ/xq2Do6mY44T
	 0Si/HW8abmJ1QEBnb3nVgK/ck/gplmbh0zDW0T2Dox8iA78R89YwyTpTK/grZtbWJg
	 AyyG8Yb7Wzf22M1f2D8faolUwip/qa+mZU3IqN20xjue+r3v9R7/VLH/RSO+gsydcw
	 7hUY2bb7I0venUazDjkTvv+inyecj92M6hohjk10GLWHWgcCICxgDSJPGjipIIx5SE
	 wa6l0P/VGznMycXw479YqJcrmoEhAE/TNsTst3tR+S+6/I9I4UtVsu9DCOwIEyghc0
	 +cMsv2H9NZpDw==
Date: Mon, 19 Oct 2026 00:15:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 09/15] iio: adc: xilinx-xadc: Drop unused header
 files
Message-ID: <20261019001542.157390c4@jic23-hlaptop>
In-Reply-To: <20261005094205.1045874-10-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-10-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:11:59 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Remove header files that are no longer required after the
> recent code cleanups.
I'd retitle this patch as you are adding includes as well.
Perhaps "Update to include appropriate header files."


> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c   | 7 +++----
>  drivers/iio/adc/xilinx-xadc-events.c | 1 -
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 65fcefa07516..46b95883a250 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -11,27 +11,26 @@
>   *  - AXI XADC interface: Xilinx PG019
>   */
>  
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/cleanup.h>
>  #include <linux/clk.h>
> +#include <linux/container_of.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/overflow.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/types.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index f5b5aad6e313..ea0f06ca2a82 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -8,7 +8,6 @@
>  
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> -#include <linux/kernel.h>
>  #include <linux/types.h>
>  
>  #include "xilinx-xadc.h"

