Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821982;
	b=Y43+mGTZNz3jK42Wwow2FqeF5bEmEVJD8TW3YcMZm4dYPKtSTJtPnmeP0acYTzNRNJZ8
	 zGmGxuVPUAcUtvEGtbupibfKtsqMLtTVTcdecatIqxPEuFbfoqjG5QCP9ZMqw9PKkUVJg
	 OYPLStmbPCE7JZi7tu8IS9dXDxy9R31NjObrcQnksQVzxU7l6rnowRcYZ25zy1/ZGSiD5
	 KB8CQj2+BkK8uJFR3ppEJmIDnEUsUyYnn6qNjEaNutJOtDi8OPrbfWnrvPgf+4NVcAH4o
	 vFmbZcY6mPkQAu0C7NxZY8s4rSk2mBPE27WRuKsPVGWaQCcsBO/zll/UjSXk6g5yQHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hfoRvGqqQqFH6dWXbv1dhwvY8+kLq3Xa2Ym/N8TO6Po=;
	b=3ASTjDrsP2FZCMSskiUrZylNFfzwU9XoUOYx6iipDlcbfWn9TAfIMAOAF4kwMT234od1
	 pFv+5E6k6oekAd18I2DEFTUr4MfJ+HNjkMwQvotdFNEUxb7oZyS5sGfdhgeg4fBglSJo0
	 YqMZjyzgT+ZRKtg7TaTta8dVEmdkoCJdlPkVzPgVTLMG0YXajKkSQsipVUhxo6ppZc4gu
	 3lO6vcpv5P43hkDEOaCf1V088mfFRCF/xiA619+sGPdmiLPc6F86bUXAPoxmIQ+kWVRwJ
	 RbMnkb14ljApKIikWWzgYSlBAw0ErD/ahbH1TB0LO24BR7Pj43iNu1U2KdpOI+4IBbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB8nWWm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D73606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB8nWWm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42291F00893;
	Fri, 27 Nov 2026 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795821982;
	bh=hfoRvGqqQqFH6dWXbv1dhwvY8+kLq3Xa2Ym/N8TO6Po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QB8nWWm5Tf98hAvI9LV6sr5CUzvQ8BXa5ltT9/CqV2LXVPFuz+ldmhjKB+qoZL5qa
	 14UGDzCBpg6F1IZ+0uxylBF3jNl0H5ij99lkXsKSmACf6qOE+lIK8zz1wtPCZYmzmi
	 bY55rpnPDVMPhSFzydsx5WsIRF3ITLEWUr4mscCJpDZcJWjgt35PyEDPu9fVz1SsHT
	 P5zyzSE+gvqOLXnJ6PYMk+GAud3OMDxU2XGGdysO2uXJqicCeL4UTTocshHR1MxiXW
	 zG2g65H+gucpNPPEpeYyCLZ8A1qZosmpFx9NK2AbBBc91HZJLeYQQrq2NBei4SMxht
	 4gM9sGa5F8iIA==
Date: Fri, 27 Nov 2026 23:26:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: ssp_sensors: Use __packed instead
 of __packed__
Message-ID: <20261127232615.72a35573@jic23-hlaptop>
In-Reply-To: <20261127115852.1720736-1-andriy.shevchenko@linux.intel.com>
References: <20261127115852.1720736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 12:58:52 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Sparse can't recognise __packed__ attribute:
> 
>   .../ssp_sensors/ssp_dev.c:30:3: warning: symbol '__packed__' was not declared. Should it be static?
> 
> Use __packed instead of __packed__ to make sparse happy
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
https://sashiko.dev/#/patchset/20261127115852.1720736-1-andriy.shevchenko%40linux.intel.com

I'd been meaning to look into this warning. Seems rather nastier than
simply confusing sparse.

Is sashiko right?

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 40b658d39294..456d59dc53dd 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -27,7 +27,7 @@ struct ssp_instruction {
>  	__le32 a;
>  	__le32 b;
>  	u8 c;
> -} __packed__;
> +} __packed;
>  
>  static const u8 ssp_magnitude_table[] = {110, 85, 171, 71, 203, 195, 0, 67,
>  	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,

