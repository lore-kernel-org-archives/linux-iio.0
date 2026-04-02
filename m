Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D23033C9;
	Thu,  2 Apr 2026 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129240; cv=none; b=N9HUqFv4CGm6dy2x9D1EgK0EpRNTdypF/LjMUnb88yQlpj8ovp1telZEJ8t4wFTu2OWYl+a3Ufaplh3ij2Tbr7atqOSi1zdSSMBZ0qX1unPFkNl2AnBm44BtHJF4W4JcVYoZShEjUl3haMBHYIPx34Nx0qS8YT66pTOVY/yZdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129240; c=relaxed/simple;
	bh=RJpXxgdcLRXOQInFIVw4wQyUovOJaFJVivtsWywioAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMxGW0yvVcDZXsOgR+7XfNn5qNt40ZIuVtFrnCMYv/LJ4mEpXLME9zqp6Om/yGHUxdjh8I3tTHTyCx9Ii3fNcbkZXwbdG8G/VLH4cymVt6oEAjb+i4FYOw+LDxTEURxpCHgbpQQc0BUhlXRcBmgST2b8atK5f+CKDhKtgZeDnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQ3BhFpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQ3BhFpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA03C116C6;
	Thu,  2 Apr 2026 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775129239;
	bh=RJpXxgdcLRXOQInFIVw4wQyUovOJaFJVivtsWywioAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQ3BhFpeKe6TR0R7oq3DWWoKHf4d1aPF2J220hMUGsBxe7j8s9R3RSaugHc8zmW93
	 gB2iYKkAFmMc275+okZ3qfPT68BLwE6mxKEKRiTwdW7Q3Oz2LskubffhcgfYXH/GIT
	 Z7abeVaaIDcmpKcytJFlNruKv6GRyPT1CzqFNVbw=
Date: Thu, 2 Apr 2026 13:27:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sheng Kun Chang <nothingchang@mirrorstack.ai>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: iio: adis16203: align MODULE_LICENSE with
 SPDX identifier
Message-ID: <2026040227-wireless-daringly-752d@gregkh>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
 <20260401162458.88110-3-nothingchang@mirrorstack.ai>
 <ac4rpSyxTg2qPy86@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4rpSyxTg2qPy86@ashevche-desk.local>

On Thu, Apr 02, 2026 at 11:41:09AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 01, 2026 at 04:24:56PM +0000, Sheng Kun Chang wrote:
> > The SPDX license identifier is GPL-2.0+ (GPL v2 or later) but
> > MODULE_LICENSE was set to "GPL v2" which indicates GPL v2 only.
> > Change to "GPL" which means GPL v2 or later, matching the SPDX
> > header.
> 
> This description has nothing to do with the macro parameter. GPL is new,
> GPL v2 is just legacy alias.

As Andy says, this is not true at all, please read include/module.h for
the details.  Both MODULE_LICENSE() strings mean the exact same thing,
please do not change it unless you are the original author of the code.

thanks,

greg k-h
