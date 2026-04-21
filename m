Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E73B6C1C;
	Tue, 21 Apr 2026 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767647; cv=none; b=jxfKys6Rk31U8oqhYWzuyv96DStRi6jiUoOVeuXcz5F2C+bCbx38kGWMs3O2B+fCOFJ8V2ulFVVaOZulmNt7S6pHW4SQWU7Omf7VOPEs2hbblUhIxYaJEMQyvZHEiGaGSCAF0aIP5NSw7iwsfV10W3lVyRptfrNQ6ftyORj2mVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767647; c=relaxed/simple;
	bh=u921sYAdtKO7zcnLD0Om5u/LBYlJn8s96ROnNVMxvkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ob2SiQpk8PqwHAhClyJM5EqkLVhYKo60474hhA+muADuw8w4jOQOZYPP4ZYohaEiKk07NQ8T8UuA25GSE0VhKEWIRl3jY7aGjNLZDxFA38CPe/63nMOC/pDWT3724blizojWVpqchza4QpqVWRn4DXD7Z2L9WmoC+lgtzVeTd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX9rHAPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX9rHAPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFC5C2BCB0;
	Tue, 21 Apr 2026 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767646;
	bh=u921sYAdtKO7zcnLD0Om5u/LBYlJn8s96ROnNVMxvkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bX9rHAPYfXcH5nzK0LrFYuHW8hRIgCOCci0rHG3hF9AUUz6VkxwQptXbGlhgGa82Z
	 H6+hQnme2CbzmPRGKoU4anOo3VdeyBS9zJHjMwPoV1FpnlOXTwW91ZPGRcfRWtYWvi
	 EpJugoPrFky2+WdKI48jFRCft4IeeF9u0rtIjkorrRhRU/su2fD21k8GOe3lWi5sq7
	 D/Df8pO2w95tijo8lIKOZdPbRyswPJ07KWEcDjEhQCVjy2VZHKMMOZaQ4AbMFxdWeS
	 UqQ1fRYF6h9xoArPUqIdNUv4SbFsvrlhmt6vcuOSAaI2pbm1kZAVT7rH4jKcEpgzac
	 hJtsjp+p8kCQw==
Date: Tue, 21 Apr 2026 11:33:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: magnetometer: ak8975: header cleanup
Message-ID: <20260421113357.17098de8@jic23-huawei>
In-Reply-To: <CALoEA-za23QHxtjoW5gjT4c60-vPYb5v0AZV+y_odJ1TQrfafA@mail.gmail.com>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
	<20260420110804.1353-2-joshua.crofts1@gmail.com>
	<aeZf8_NszentI8-M@ashevche-desk.local>
	<CALoEA-za23QHxtjoW5gjT4c60-vPYb5v0AZV+y_odJ1TQrfafA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 08:16:42 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 20 Apr 2026 at 19:18, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Seems this implied sorting as well. As Jonathan says somewhere else
> > he prefers to split sorting and IWYU patches.  
> 
> Okay, I'll return it pre-sort.
> 
What I'd prefer is sort, then changes.

That way it's easy to see what is removed or added rather than moved.

Thanks,

Jonathan


