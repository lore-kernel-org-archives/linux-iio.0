Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002723FC41;
	Sat, 22 Aug 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434679; cv=none; b=N4ZWJMv6xv31ZAJ2961qSfCYpJiilKKhGs8zvrmiMxKfhseOQcJotYj1X/8Z7J9xFXKirkj5Z5FOyDkQKkKnRzAF9RkFMcBq929NyEG88hS0tkA1IZIWVnPRdJjH8tfDyp+mZAM+/sDvFAIeW1LDbamOadDZlUZr+CrK8+b5iIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434679; c=relaxed/simple;
	bh=lJvYd/nWI+qbwvwOZrEjZPXdMpzn9aZ+qWTm0GL+3+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwxJQYer07tZ3LmuaIqZiMZreMuaNhVE/x+hN1NP+5IwyPWUXR5+g7H7nuiIMGSwo5IQ6xViQMUxnuttF1HZei7UnnNbjLO4jTLWO9iEI/bIaMwQh8WNMRaZL/IXFMSXqD+bjvuMVXxcujfxjTz54z/2CXrYAQqwyNJ8ae5eTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0vGywoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0vGywoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595181F000E9;
	Sat, 22 Aug 2026 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787434678;
	bh=N5nf3hb4HLKMx/ZcWnduWDJ/0loX4O3zmqSuci6U+qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c0vGywoW1zcU92Bh3PEqL4LCfx8WsHB4tm4j9RDyqwnyKBBIqFqAK5tPVva++g3ZE
	 ZmZdTLwNvgxmMNo0uyZLP8f5MwlGzxQFkzFvkEWvHMhbt+a8ElliXjdwAGpV0kIqoR
	 ds59hvMRptapLPd+kRTZM6HrUgxvup27NNZ9lO6IKTrZaHxCM9mAcm1ZLecF00oWAa
	 Pa0R56GaGqXEz3VXgozd2zPfsiCfTYSzjAczg1fUobbhpslvfWfWE/FR6HeueWu1kn
	 dTF54/UdT7HTvZap7+gdMHEy8vk/lXG9iRHrQQv2SBUtmw3zaXv66PXV5etRLI4Bah
	 iNtZez0LB/PSg==
Date: Sat, 22 Aug 2026 22:37:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arka Mondal <arkamondalofficial@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 venkat.prashanth2498@gmail.com, rohitsarkar5398@gmail.com,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: adis16400: fix unprotected debugfs reads
Message-ID: <20260822223753.21b1b417@jic23-huawei>
In-Reply-To: <aoAmduhNrHoJdmn7@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
	<20260814090728.965922-2-arkamondalofficial@gmail.com>
	<aoAmduhNrHoJdmn7@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 11:42:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 14, 2026 at 06:07:27PM +0900, Arka Mondal wrote:
> > The serial_number file operations are open coded and never call
> > debugfs_file_get(), which debugfs_create_file_unsafe() requires.
> > debugfs_remove_recursive() therefore does not wait for a read in
> > progress, and unbind frees the iio_dev underneath it.
> > 
> > Use debugfs_create_file() instead.  
> 
> Have you read the code? Have you read the commit message of the "culprit"
> commit?
> 
> NAK. Please, revisit all your patches and be careful next time.
> 
FWIW it is curious that the original patch didn't touch the serial number
declaration whilst touching the other two.  Superficially that looks
like an omission we missed in review.

Jonathan

