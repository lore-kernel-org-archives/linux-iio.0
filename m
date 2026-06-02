Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77C3DA5B1;
	Tue,  2 Jun 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407326; cv=none; b=Y5PkLUCFg/ZSLHV1e2w7iMBNdFlnToLMfWa4mlc+r17PMPv8VLtG4hqQq1A5y/j6cPVh7qC6x7U+iZ+YKnb7m7aG+f+t880UBeb4AkRH99HMR/1rzPQnV6NX2tvVBlB/DvmaQkyY39jIlmOCo5AmTEcVceFXs13hmZ3ie70mc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407326; c=relaxed/simple;
	bh=DyGoMv3BRcTXuwrnNRtYtzBdxVhFpqqEorPIFjphD9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCfMUEt5GTD6NouXraWQ3mZs6/CEbTtNBrsqQJddXPmRdVSGomlJAnNeSEmMJhMMG0YidzkfS5SEK5T8b2honV+oIQdYCZUqOJSlV3XnIBrn1FdWbKEryRTl00khiFsvVf7J0iRz0Zv83qolXRdXRS2FcdE2I1TnTfqFnUPHm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjXf7xKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjXf7xKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EF71F00893;
	Tue,  2 Jun 2026 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407325;
	bh=8hCHP5p7GMnu3GPWczwHLnQrb/wxtqOnhbkrpgwz3FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NjXf7xKFQ5gt8Rm/WXkQKI5a9mrvN6wMWpbq1BG4jf3xTd7BCDlkI+T8mai5haKgx
	 ZGcpccBFEgrdPoL4UA+n/yd9gnjPFSqZLqovqELFOQ8jOhKFGaXmn5rUonhaARrsw1
	 /7EQ3UM60oJ3mERT7iYaFzKSIQ4UBJVnFuAArtbNVFW1GFdRndenm1NZwKjREmEgQA
	 2W2IlEfLV+nby1U9i2/OQEaOvA6nbqNSU6fprLSC5g1H/wO/zNx+YQFwhkC5KME30X
	 HpnOGrXNkSF0lJf3eo/bOCyy4MywUGHeLPXEh0HxlJ8eGtsekq/s2dfzdDf5iJg3N6
	 Mf0035HpJce/w==
Date: Tue, 2 Jun 2026 14:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 0/8] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <20260602143520.273097a6@jic23-huawei>
In-Reply-To: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 11:17:00 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"):
> 
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> This one adds a number of cleanups and fixes, like:
> - Refactor include headers (IWYU);
> - Remove redundant register definition;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix internal voltage reference control for single-channel devices;
> - Acquire lock when doing power down control;
> - Fix powerdown control for dual-channel devices;
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I've just merged v7.1-rc6 into the testing branch which allows me to finally
apply this.  So applied to the testing branch of iio.git and pushed out for
the usual bots to take a look.

Thanks,

Jonathan
