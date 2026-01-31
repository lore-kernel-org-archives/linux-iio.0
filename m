Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5B3EBF39;
	Sat, 31 Jan 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885733; cv=none; b=J35pG/8WK3H1MkBTQ+bgNfkKssWxs9SSkqsHk50X2Gyitz+Og25+zuC1MceSghELA02pIwHMXOmzsfL7ehPf/XlGHAybTlZvdMH7Bei7F0gz6W/X/MUPXkgg1YPqgiGgbsnNWR5B5ODQP0hF5cFmFGMG7YZTmMJeYwFpcQrg6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885733; c=relaxed/simple;
	bh=XsOB+D4VKxe6wKg1UVnKfNHKJGjvIaMxbNxnvSpNmAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtKXsXnv2B3Je7dOR64lNwAN4ZVuSJNGBtlCBOInz3yCgEr4nobOg9W8prmpk0XLZV4ugh01nlBtE5n0DAjNHoG/clj3MwYblvUThalLLmcc6lJwlIRCq6RNgTTXePOaK0x7BTQxA2fsadt5LRifm8EtDJqSR6eLkCxXSHJornE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqHE3j3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqHE3j3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F89C4CEF1;
	Sat, 31 Jan 2026 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769885732;
	bh=XsOB+D4VKxe6wKg1UVnKfNHKJGjvIaMxbNxnvSpNmAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aqHE3j3/u43ah7hCm+cns/hxLH7RQtaxyzrL/KWuLG96Lw5jAekw/q53C17TORYeh
	 2EI7aZ5HmOXDmq0fP+Ed6H6PhaPMQ7TUGCvBGvrg8aOMGMXDLBsdSwdN4l+w+rAzMK
	 Sb2uCkzY1KthaPQ6o60shuNWxQRd5MTP9SlfWIfYaHa8RkJwY+PCZKP9syFMKlsTNP
	 SUT9PXqyEe7sCCpcePY3A7wYC9pqgcryMtzVWeBgOTH2HWer0ITVR24Dr7/tKO9slK
	 tIyVLREMIml4ifYLrMZEgiUQewfvqAz048NJu2D+wV8j05IfLHQXXH/ogEeYrOhGeL
	 Fu9K7YBKM51XA==
Date: Sat, 31 Jan 2026 18:55:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com
Subject: Re: [RFC PATCH v1 7/9] iio: Expand IIO event interface for
 real-world unit handling
Message-ID: <20260131185524.1ded8d50@jic23-huawei>
In-Reply-To: <6d9baa8d553d03a41fbd97bca0377a7a4779a93e.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
	<6d9baa8d553d03a41fbd97bca0377a7a4779a93e.1768759292.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 15:21:46 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> The IIO event ABI documentation distinguishes between interfaces that
> handle values in device-specific units (_raw) and event interfaces that
> handle values in real-world units (e.g. meters, Joules, lux, etc).
> However, the IIO event code infrastructure had never really implemented the
> bits to distinguish between those two types of interfaces and had always
> presumed events to handle raw device values.
> 
> For most current use cases, assuming events to handle values in device raw
> units is reasonable because it often matches the type of the associated IIO
> channel. There are a few cases where drivers provide events along side
> channels with both _raw and _input interfaces, though. Also, when
Can you list those cases. I thought we'd been keeping an eye out for that
but seems they slipped through!

> real-world values can be mapped back to device configurations, it enables
> drivers to provide event interfaces that are arguably easier to use.
> 
> Expand the IIO events support, enabling IIO drivers to provide event
> interfaces that handle values in real-world units.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
