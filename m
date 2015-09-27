Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37247 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbbI0Pqa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 11:46:30 -0400
Subject: Re: [PATCH v6 1/2] iio: resistance: Document that resistance can be
 output
To: Peter Rosin <peda@lysator.liu.se>, linux-iio@vger.kernel.org
References: <1443018383-16578-1-git-send-email-peda@lysator.liu.se>
 <1443018383-16578-2-git-send-email-peda@lysator.liu.se>
Cc: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56080F53.10401@kernel.org>
Date: Sun, 27 Sep 2015 16:46:27 +0100
MIME-Version: 1.0
In-Reply-To: <1443018383-16578-2-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 15:26, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.
Note will probably get rebased shortly once Greg has picked up last pull
request (assuming he does!)

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9398484196c4..2eea468f704d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1475,6 +1475,8 @@ Description:
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
>  KernelVersion:	4.3
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 

