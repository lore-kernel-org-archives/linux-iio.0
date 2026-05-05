Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729533E1CE4
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998143; cv=none; b=pPHYAu0kNUg1ZbY1n0CKdxb8SkyxvhOIx9hIWgt0pTISgqjAhct1FnDDgjIwS3/PLbyAMd+3CKDqykZwfzVoOS2k1v/iEOEAkIFVJ9CDo9suloJWoLgw4o7lbLS9WWTiw6Lynz/Ud8EqyQMQ0HphWj3quuCGgwOKGnfDVlZHslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998143; c=relaxed/simple;
	bh=ZtES+jPtylVCHzmgLomzHkmz5Y60KHexu8mfY/Hnxms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGq9sjU39XluQ9ZaXcQvDVcOv7Zv6atBIbqkQaD4J71marDhR290ovvP8u8OidqD/gKE+wO3zYBlAYuEn6/L0MebtCpw9MlsvEfY/rx6sraS6vAQOJQMzQXGQ8b88KyGfTGEMaAOCZ/N4bg5EY5/SIQsm8O1u52LEbarbm/AieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwVgjXx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwVgjXx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ECCC2BCB4;
	Tue,  5 May 2026 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998143;
	bh=ZtES+jPtylVCHzmgLomzHkmz5Y60KHexu8mfY/Hnxms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwVgjXx6PBZtje+j22jMqUCqgWo1YHd/duJWf6UAqd8N8tD6Nt9hjsNQrS0FDFvve
	 zrZnsj0nmUsWC59TIKaDlNiJTGzKZ/9BRu2lAnJNc5jM7n4rIMDqVOS2xSS3UbNLFf
	 ADyufWjHt2M5Cy2AxPBOy0RW90O83nZEMqU9dLS9BWi6D5lZhczE7E8k0A5HqFTk5F
	 Th2WKL1X7ynVJRVhkezp1hrLWpmpF8WETGss9jQnJ2nOyRe/OMxVKngsKObwuUdaQK
	 Qx8JZI6lrPG2yUoN5LTm0H06NdRQbjk2MrrHAGMIKJBlOE6hFOV9nhsuPTk0vltuLH
	 e648/GQ94CClA==
Date: Tue, 5 May 2026 17:22:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Machado Lage <marcelomlage@usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: mcp3422: apply bit manipulation macros
Message-ID: <20260505172214.6f0025d3@jic23-huawei>
In-Reply-To: <afLyk-kNyZkr_drR@ashevche-desk.local>
References: <20260429224401.11818-1-marcelomlage@usp.br>
	<afLyk-kNyZkr_drR@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 09:11:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 07:43:59PM -0300, Marcelo Machado Lage wrote:
> > This patch set rewrites several open-coded bit manipulation parts of
> > the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
> > macros.  
> 
> Both LGTM now
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Nice.  Applied to the testing branch of iio.git.

FWIW Sashiko had a field day on 'whilst I was here' things in this driver:
https://sashiko.dev/#/patchset/20260429224401.11818-1-marcelomlage%40usp.br

Note that the DMA one is wrong. Some of the others might or might not be correct.
Maybe some stuff to look at if you want to do more work on this driver, though
you'll probably need to work out some way of testing fixes for the more complex
ones.

Thanks,

Jonathan

