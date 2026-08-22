Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE61A9F8C;
	Sat, 22 Aug 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365350; cv=none; b=Y49ATQSUx/T+SgeBiMvQSr3IUSccAsYkEixbV/HkF1eZ3W+aRGegA/yhmI3sQz/lb8olv9jmm3IaTlMQi/LxTECakmFSbQqiSb8iweyByHEzq7yiHuglRrwvzIOxBoJiuniooPdnVcZ01ClS8kCHwB7FW7QZTkrOTpEaX1QU8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365350; c=relaxed/simple;
	bh=EW5Rvqu61xUHUHtvRaYJZTHx+uRUDtm5MDy5SQuRAhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHRuC+7KFUq84SQwIkZGCLYyhxK1iZwE6HF1PmJPPC+OubLSdTVU7/bLAJCNpuOyGorfJtbaGlhF7pCY0EVm8x6Lop5IZ1oHpqxUpuleTc2AG2qOGtRMaH5bEJccYUkbUOTBSsSJBEyGupOlkFJv2S1qiwWTi4Zp927pe0bE0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBCe+fg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBCe+fg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C451F000E9;
	Sat, 22 Aug 2026 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787365349;
	bh=Xb6rTgt+uFNgFwc4HCFfSYnrbiscVhoaKefqv3sJWXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FBCe+fg7Gqq3Paj6qq9aPuCE4bwPEMIlRpEB5FmSWWjnYjXIVINQomBrJmGgqoyRS
	 I1bwRtyB5H5k+3QnQ0rKnCiYO1zsuzTGUVaPuE7Jz7oGNrDxC9hJUQVW59O1wEzI3/
	 kXkyb9I5Ag1tvWq4oqzgHpygqFCusZm/4eq3a2LjcHacYYzriAbiqXw3wipBPU7/GE
	 PqvMbPwBj/SE8hazqLbr9QWQTVABRB5yUKx9ffscZOh2Nxx6Hd1yZKGpnUQ4FGWuJr
	 3f7bvFj2JHiJsx1RfliEQ+yVkgSB013lukhf91yaHGLuf7ODf7rlyF2KMGWC9G7/oW
	 t9jEqXf7snZkA==
Date: Sat, 22 Aug 2026 03:22:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v10 2/2] iio: ABI: Encourage differential voltage ABI
 usage
Message-ID: <20260822032224.2dbb88b2@jic23-huawei>
In-Reply-To: <5760e0d12184eb0d7cf6fec34ad4b6da2d8669e0.1786662010.git.marcelo.schmitt@analog.com>
References: <cover.1786662010.git.marcelo.schmitt@analog.com>
	<5760e0d12184eb0d7cf6fec34ad4b6da2d8669e0.1786662010.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 20:05:33 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> So far, parts that could only do differential voltage measurements were
> only required to have a consistent labeling of their channels by complying
> either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
> came to the conclusion that the voltageY-voltageZ ABI is better suited for
> differential-only chips as it provides a simple indication to users that
> the channels measure the difference of two inputs.
> 
> Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
> for chips that do only differential voltage measurements.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

I applied earlier version I think. Please send a diff on top.

Too much floating around at the moment so I'm sorry to say
I'm loosing track even with tools to help me!

Jonathan

> ---
> Change log v9 -> v10:
> - Mention the possibility of having same index for diff channels (e.g. voltageX-voltageX)
>   in ABI doc.
> 
> After looking at a few other chips I'm not sure either about having
> voltageX-voltageX in the docs. I worry voltageX-voltageX might not provide a
> clear unambiguous indication of channel properties. Nevertheless, mentioned that
> possibility as a special case.
> 
> For chips that have configurable inputs such that both differential and
> non-differential readings are separately available (current ABI usage),
> voltageX-voltageX can mean both ADC ends connected to the same physical input
> pins (e.g. AIN3 and AIN3, CH3 and CH3, V3 and V3 ...).  That seems to not make
> much sense for most parts. Though, there are corner cases where the same input
> number is used to configure both ADC ends (e.g. to access a temperature sensor
> through an embedded multiplexer).
> 
> For chips that can only do differential measurements, voltageX-voltageX would
> mean the positive and negative inputs of a differential channel to have the same
> index (e.g. IN3+ and IN3-, AI3P and AI3N, AIN3+ and AIN3-, etc). The ABI is the
> same, but the meaning would be different. Even though we have the left-most
> index for the positive end and right-most for the negative end, that's not
> enough to fully tell how a channel works.
> 
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5cc2e82c4997..bb17105650ab 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -162,10 +162,12 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) differential voltage measurement equivalent to
>  		channel Y - channel Z where these channel numbers apply to the
> -		physically equivalent inputs when non differential readings are
> -		separately available. In differential only parts, then all that
> -		is required is a consistent labeling.  Units after application
> -		of scale and offset are millivolts.
> +		physically equivalent inputs when non-differential readings are
> +		separately available. Even though differential-only parts had
> +		been merely required to have consistent channel labeling, this
> +		ABI is preferred over the non-differential one for those chips.
> +		Special configurations may have the same index for both Y and Z.
> +		Units after application of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
>  KernelVersion:	6.18

