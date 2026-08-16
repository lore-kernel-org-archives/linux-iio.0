Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F43A961B;
	Sun, 16 Aug 2026 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910947; cv=none; b=rkodD/Bbo28HmShyn8OLmnvBaHcoQXmG754slxDXepXgmgzH2bxnxJWepkIZpjVmApUlZaJeDMWBjcruvyKbNiYa1mqitfBe7FoU4+ejdm4uw3lT3ROAe8Xk1EpE0Tn2RyZgx64PNf2wDdAqvpTsoZXlRt3FYA2IZw9FUOl8nTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910947; c=relaxed/simple;
	bh=1RUqESLfyCLnumX0L0JtUcgmewXJXFBDnmm9hudNrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ba89OsjEDa5M91jRTMCfEBJbzD5wIjnAOOjdLSaw9qwCe+nwwfeYuhUfs09cpQVjFFfLCZrFTmCYAb2IJkk+om3O948bbDUVaYj/SUbDJelbpDyUMq5npVdOQY9izy683kEChwAgtPhAaCLH7bTCoDbrHld8pDnc/I6hLOlZclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBE1SzUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBE1SzUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721161F000E9;
	Sun, 16 Aug 2026 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786910946;
	bh=rncw3Mh1vYWtXSr8o1BuEq34sysukRkoilNd+fF7fOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZBE1SzUray38dMIWAqFmHI+pd9sjMHIgmwI/tFxjiYxC0+TopX/Tdzs+eK4j8uKU/
	 41CnCrBkiBFNst5XwAPyoVgYiN7A0xkreLKb4zLq1W3Td4mnLO/YRsENIDLbcytFvm
	 ZiOCjZZLqSYETH7mmJHbjjIANnqHrXfSTQtPLPsfTD7OwmKVaky9lFHEdHNsCj1w6h
	 68osRf3OvESPAr9/MS1oX2u2eV+LybuH4CwkZo+GDyKRAelzuDITpnX4n6uXsXWqxH
	 WcJUKIeaXHi5ZsyRbIAJP+I8cUz1Y+f6kvZStxVJIPzqZX2z/ux8acGHWiDBA2kuUv
	 EqM7jLRyC1nuQ==
Date: Sun, 16 Aug 2026 21:09:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
 dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 gregkh@linuxfoundation.org, joshua.crofts1@gmail.com,
 skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <20260816210901.55959c11@jic23-huawei>
In-Reply-To: <aneNtcyLLQjMmPA7@ashevche-desk.local>
References: <20260807094704.5371-1-raizudeen.kerneldev@gmail.com>
	<aneNtcyLLQjMmPA7@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Aug 2026 23:12:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 07, 2026 at 03:17:03PM +0530, Mohamad Raizudeen wrote:
> > Previous attempts to change do_div() to div64_ul were rejected because
> > mclk will always fit within 32 fits for this hardware, making do_div()
> > safe to use.
> > 
> > However, Coccinelle continues to flag this as a false positive. To
> > prevent future developers from submitting unnecessary fixes, add a
> > comment explaining why do_div() is intentionally kept.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git.  That will become
togreg and turn up in linux-next after I rebase on rc1 (in a few
weeks time)

Thanks,

Jonathan


