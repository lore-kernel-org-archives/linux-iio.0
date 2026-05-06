Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8E3F0759;
	Wed,  6 May 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086624; cv=none; b=QS2v2sqzz7R9VLs7Pf6rSryvHf6/iDKXG36YM8PVmprHHWZEbUsFArHTz6wEuaioqSENGfIJsQA8Zm7GtOQiwFlfpu/JI0bZwd/+YwMoY8ew2fxGAX/7XNWJlDxFs5biFWPaYfA/oPziyYCuk5seFeXqwqBDDvhk7gKiOSoGcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086624; c=relaxed/simple;
	bh=HroG5E/wUYD3yi/7DjWNflWPgLK7sV22USIbplzUVbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEDVLo37mF958SbS6kaEfMIbdVCqEeV/DQo1A9cap0PxJgTRqriXRNVXwL55+7lcXqHjLpYN7I+VQ3L2z4KPQt+rJgEf4v28tsLo6vmxfIjMJ8AwV92vqkmTfutnw346Yaa7jc+uADiuApZx8poRunV1up5OprfRf+yBQsJu3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzmpkXjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzmpkXjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE400C2BCB0;
	Wed,  6 May 2026 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086624;
	bh=HroG5E/wUYD3yi/7DjWNflWPgLK7sV22USIbplzUVbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fzmpkXjh1pDOqftElDIINNPKHUiWUVYeluE2JL7br0BMmOM7MVS3ClkFtyoe4kH17
	 NZZFMwDi/+WUe9ZZP+zkH4WCR9ahnPayl9TNKF1AISiM8xKozDHJrs+H5VrM2F70l4
	 VkwV0d1YUhP1FX7E4uowSj0u6yV4N+bciI/RriwDeS9YJcdKRaDO5BUYEOZc67Og/T
	 3K3ElRvkrUnIzPHkrI2sX+pZKmBC/9nJBKtDIXU0tU37AKsUHfDtATlWKaZO/RDKVe
	 s+kjAquSNFoKhzUnMcOLhHkBDT77OLiZ49AqLbSIixc6GsEgS5yfXxNxlayhGekDVx
	 oQTui1dDlEOnw==
Date: Wed, 6 May 2026 17:56:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 12/18] iio: magnetometer: ak8975: reduce usage of
 magic lengths of the buffer
Message-ID: <20260506175656.368a4aa4@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-12-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-12-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:08 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reduce usage of magic lengths of the supplied buffer by replacing them
> with the corresponding sizeof():s.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.
