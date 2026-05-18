Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A26264FBD;
	Mon, 18 May 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118507; cv=none; b=rfX2i9ZHcGwaPRCJUnyvMOtBfcbuqogBG9ExORKRdzyUkRyX143/atl2CcBE0qGKjdE5peBXzzCxm+IDt56Hdun8VRCLwasXZGNE5JADpEjL8cIIHix76ZKS3LBqGJm2GQWzkbOSSShwO7j8gNL6WHrrwej/NJEWqmOz4dVdZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118507; c=relaxed/simple;
	bh=gc2LKcuItvdOnPrBURn+gKlo4PmxYVrXV4Uu1cfjhSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQNVCvjUp/NPVNRaiiMG27SN9blfeExndQAXS8K8CvwtuRTK49JJcEoaS6+2jSmHNL+7qQfeih1JJFrrqmsqu/cCgt8yEZWEb1BI48BxUTHjCyf2vff1N43/FbuSEzAYbXQCYmzHAseVS8BCoVGz+eXn6Qe15QF1gZ5o5hu8/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAyFDl3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAyFDl3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ECDC2BCB7;
	Mon, 18 May 2026 15:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118506;
	bh=gc2LKcuItvdOnPrBURn+gKlo4PmxYVrXV4Uu1cfjhSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nAyFDl3iM47+JQPVJpambibjwIuwoS54fFTZwGKLwKTy1dfoQEjkMtIRruu2xERle
	 SZM4ndITvSfOI4e+UxcyckzOIwD3eQ2w5gd0u1BNkMhzYP2lUrTwlXAfOYHaFP/PH/
	 YQhMNyxqNVwxO1l6lAGd3vbXeNosld1Y8zOTXIraRFpadf5Q2L8uysbxLrnCdBXqWN
	 MKYpLjaPypk0h4+OW0auSFJ9vIEaWeKZxxRmpUcu1PlT/VDdVwTYPZbUxj8IyX9GTv
	 jxAoctVpanLOLwf3niEvW3FBxmJKI7G18a/sMeBCXDbdmJvohZCKbgq/TjgbKjnVKh
	 i6DHf4JemBtCg==
Date: Mon, 18 May 2026 16:34:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: ssp: remove SSP_CHAN_TIMESTAMP() macro
Message-ID: <20260518163459.38b39dac@jic23-huawei>
In-Reply-To: <agq-4keSvfshINQy@ashevche-desk.local>
References: <20260517-iio-ssp-timestamp-v1-1-228a9ed05c1b@baylibre.com>
	<agq-4keSvfshINQy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 10:25:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, May 17, 2026 at 12:29:35PM -0500, David Lechner wrote:
> > Remove the SSP_CHAN_TIMESTAMP() macro and replace users with the
> > IIO_CHAN_SOFT_TIMESTAMP() macro. The SSP_CHAN_TIMESTAMP() macro is
> > identical to the IIO_CHAN_SOFT_TIMESTAMP() macro, so we don't need
> > a separate macro for it.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.
