Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35840 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcDXLg7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 07:36:59 -0400
Subject: Re: [RFC PATCH 3/3] Documentation: iio: Add IIO software devices docs
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
 <1461167126-23399-4-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a6785c14-c55c-9e6f-00fa-ce83e6604f88@kernel.org>
Date: Sun, 24 Apr 2016 12:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <1461167126-23399-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 16:45, Daniel Baluta wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Other than the deliberate mistake, looks good.

J
> ---
>  Documentation/ABI/testing/configfs-iio | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
> index 2483756..84b6bd1 100644
> --- a/Documentation/ABI/testing/configfs-iio
> +++ b/Documentation/ABI/testing/configfs-iio
> @@ -19,3 +19,16 @@ KernelVersion:	4.4
>  Description:
>  		High resolution timers directory. Creating a directory here
>  		will result in creating a hrtimer trigger in the IIO subsystem.
> +
> +What:		/config/iio/devices
> +Date:		April 2016
> +KernelVersion:	4.7
> +Description:
> +		Industrial IO software devices directory.
> +
> +What:		/config/iio/triggers/dummy
> +Date:		April 2016
> +KernelVersion:	4.7
> +Description:
> +		Dummy IIO devices directory. Creating a directory here will result
> +		in creating a dummy IIO device in the IIO subystem.
> 

