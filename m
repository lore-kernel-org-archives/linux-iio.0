Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74D19A;
	Sun,  6 Oct 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223526; cv=none; b=neaj+i2pzyvzo3l/HRHMkn5w4ioxAIdqhS9hOz11vOc5rLRbnihs7wo5ECajH5Zhccx0DnwsTLkAx19Uatryf4//NG4r6AZB/UFhEM0dItKwl89FcjFViQBXwcByvHtuFZ47QzxddJt8asTNT9dIbMm6glLENA+DH3rMmdigJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223526; c=relaxed/simple;
	bh=9tdjrdqE6c/Pn4VU/tViuHLMKxgPZLZGHyYk+KHYd1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNt6qIXnBm/wROwqjCEHgE1A7oylP5nRFBbwOrfbGztNaiigJQjbpKiS8ajfyP2QOctZ+UOwZe2MHGBMCBLCyPz12wCyhxJdGjkGp2ZxsRNiFUWTzNtXoJS017ng10fn/VR+wMbead4RcHQCflzZPncHJPi/PiJBWoL+BqYjQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjWfuahR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjWfuahR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DC1C4CEC5;
	Sun,  6 Oct 2024 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728223526;
	bh=9tdjrdqE6c/Pn4VU/tViuHLMKxgPZLZGHyYk+KHYd1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjWfuahRqMxnPZZOBgXuXsziDbQOhQ+K1fTiu+a6wal50sJNU54/Ga2AlKYRil9me
	 VVEmvzKa2lRWpyeCXMSQ+WZ66QsU9Z0nVnHs0+PTKjdlxXUkoh1bBt+zahi0tROi1D
	 CgInFFMDTCJa1kLFk8PSPog4d0e4nBTSQ6/YQKF6dD9JA/3K1RSoUbx+BHLTOOxxtw
	 TnzOGo+TCoahEaZkyBe88iLEkVGEDBR2OeN5xtiIpi3VXCUdH4/GXP1w6QN945pRSW
	 w3gXROQXhptQvAB3dFmZ0zCnI01EmBLLM1eCz3xhF7vm47+NsL4n9aM8Q8tDnXKfyu
	 H4lsk+doO2cbg==
Date: Sun, 6 Oct 2024 15:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] pressure: bmp280: Improve pushing of data to
 buffer
Message-ID: <20241006150517.00dada74@jic23-huawei>
In-Reply-To: <20240930202353.38203-1-vassilisamir@gmail.com>
References: <20240930202353.38203-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 22:23:51 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Changes in v3:
> 
> [PATCH v3 1/2]:
> 	- Remove fixes tag
> 
> [PATCH v3 2/2]:
> 	- Use internal s32 *chans variable to better visualize what is
> 	  taking place in the data->sensor_data.
> 	- Use proper size/alignment to the data->sensor_data.
> 
> P.S. After this patchseries is applied, I will rebase this [1] and resend it.
> 
> [1]: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com/
Applied to the togreg branch of iio.git and pushed out as testing for all the normal
boring reasons.

Thanks,
Jonathan

> 
> ---
> v2: https://lore.kernel.org/linux-iio/20240929112511.100292-1-vassilisamir@gmail.com/
> v1: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com/
> 
> Vasileios Amoiridis (2):
>   iio: pressure: bmp280: Use unsigned type for raw values
>   iio: pressure: bmp280: Use char instead of s32 for data buffer
> 
>  drivers/iio/pressure/bmp280-core.c | 69 +++++++++++++++++++-----------
>  drivers/iio/pressure/bmp280.h      |  4 +-
>  2 files changed, 46 insertions(+), 27 deletions(-)
> 

