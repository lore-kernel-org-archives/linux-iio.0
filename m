Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602B2BE057;
	Mon,  2 Mar 2026 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481860; cv=none; b=Xf7mfKD5EFfhdFraNu30tIxE0mL5A9fT6yi2una1gHXA5F4V9Nk+WRYS/WS3K55KJAOzgo3vKQpLZH25h/hM2RVPyJ0sYP5JMJHi3+shtXZptQ/6kiebogYozCAui7P3739jZGJLecdUzM5diWNn+eALnzEpr9HqjbVxe4+LFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481860; c=relaxed/simple;
	bh=uB8MUUzc9gKCRMfCyu6uNqW2m/tmqd1Cf81XBTWSUDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwlD7pyqsgenay+yNLJujQbHd/I3VrgQcLBEayF0CFdqszQkoa6IUVBRC+2+sve7VbpwbVSA3xOoSBYvXfM9r8PY/qQizbMDNQ23FcYBJAj32Gc3UiBtSsSzGQnZNJXR2BmeOzKKPwIQ3VfW6VOt3VxM6Y+h9SHLpWdwJ2Ds4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFTDo36G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFTDo36G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA5C19423;
	Mon,  2 Mar 2026 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772481860;
	bh=uB8MUUzc9gKCRMfCyu6uNqW2m/tmqd1Cf81XBTWSUDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFTDo36GAWXEVLAKPgJ1zOz9zVvhccmlxHhJsjjyJ1RcBu3N4Hvw97iMyhMW8/OQo
	 nWVI4IZ53vjgZ0+snE4AvTJoO52pXpiDkmQGEVsQCYwwJxHTI/IFSNOr+ThZJW38H3
	 D8QPGgG/PnPtvlUe2EiNmPMpTtFiEn4ou63XnOvYT9BxxpK6GZPoSyCTHo9s+89bTo
	 8xyMalAOQTsz7Ug7tSzwkEVrsJPGp7jW07J8QpTh1DCnTKVzn9rHM735aoMHaWNy1K
	 lnW1+rpnna9tPC2Ffnen6dxL++HuHxYHMlwN17lr3iQYh6PpLTA/+vtdV1OjyEjFSu
	 OfzV5Oc9J1Z7Q==
Date: Mon, 2 Mar 2026 20:04:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: remove unused ADE9000_ST_ERROR
 macro
Message-ID: <20260302200411.6ae331c7@jic23-huawei>
In-Reply-To: <aaVBMRU9wd6s4Nu0@ashevche-desk.local>
References: <20260302055035.36363-2-giorgitchankvetadze1997@gmail.com>
	<aaVBMRU9wd6s4Nu0@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 09:50:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 02, 2026 at 09:50:36AM +0400, Giorgi Tchankvetadze wrote:
> > The ADE9000_ST_ERROR macro references ADE9000_ST1_ERROR0
> > through ADE9000_ST1_ERROR3, but the actual defined symbols
> > use the BIT suffix. Since this macro is currently unused
> > in the driver, remove it entirely rather than fixing the names.
> > It can be reintroduced in a future patch when it is actually needed.
> > 
> > The individual error bit definitions (bits 28-31 of the STATUS1
> > register at 0x403) are retained as they follow the convention of
> > defining all register fields.
> > 
> > Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register
> > (0x403), bits 28-31 define ERROR0 through ERROR3 status flags.  
> 
> > v2:
> >  - Drop the unused macro entirely instead of fixing the references,
> >    as suggested by Andy Shevchenko and Jonathan Cameron.  
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied

Thanks,

J
