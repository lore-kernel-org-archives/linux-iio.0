Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59711 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054Ab2EOIkn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 04:40:43 -0400
Message-ID: <4FB2168A.2050206@cam.ac.uk>
Date: Tue, 15 May 2012 09:40:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: IIO include folder hierarchy
References: <4FB21652.9070809@metafoo.de>
In-Reply-To: <4FB21652.9070809@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/15/2012 9:39 AM, Lars-Peter Clausen wrote:
> Hi,
>
> I was just preparing a patch to move the DAC drivers out of staging. And I'm
> wondering if we want to use a flat hierarchy in the IIO include folder, i.e
> put all includes in toplevel folder. Or if we want individual subfolders for
> the different device classes (e.g. include/linux/iio/dac/ in this case). I'd
> opt for the later since I fear that things would get quite messy over time
> in the toplevel folder.
Subfolders sounds sensible to me.
>
> Thanks,
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

