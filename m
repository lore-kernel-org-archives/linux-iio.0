Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F933343C;
	Tue, 21 Apr 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750739; cv=none; b=BxWnwdY5rdfACmL3NFmGZD4o9uFJDcfrQE8KtCpPzglCORJdmzonNXIfyni7sZWCYa9jqd1NW9+BZNWdysZoZpShdaZa98Q+m03JvqilGnPcXBDfEzk69Js8fUc7KvyWb9Lp5GOpwQlqq3p8C0JBkEavnntQt9GLGRj645zPdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750739; c=relaxed/simple;
	bh=+afQkrBjifeMNcUkqruDJ2jou/VRvNSVXVdjTrHlne4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCDwvO1DmsZa2fhfEnwDOBcCoC/p3RayLxLhjN18t0ieEH0ffEiYGxHaW9Dr5MrSF+wcjcvgJ00OmQdiRnKLAJse9E1Wkd8jN+853Mjd0iCmnkN2v+kLLER/ci9tdKI4uN935f0uFmUZMGW1a07t1ziwiePUPEaGOcstl8h3AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qazZTaev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qazZTaev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19919C2BCB5;
	Tue, 21 Apr 2026 05:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776750739;
	bh=+afQkrBjifeMNcUkqruDJ2jou/VRvNSVXVdjTrHlne4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qazZTaevUXHlPyX6x5wci5KaPIQwD8k9gMIC7FSK3fExYrRZiAk5ARSliAFnlE7ac
	 uHyf3o3tal0FAO/5+5B+1Y+sJ9e9/M50hdXUNSYq68zfkqHCmTD8muWUYeguuSWeR6
	 bnWRrs1AXgMvH+pxbOt9Rm5H7opCIssLt9Ka1l/Y=
Date: Tue, 21 Apr 2026 07:52:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sudharshan <sudharsanam346@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7816: fix coding style issues
Message-ID: <2026042105-briskly-juice-13d4@gregkh>
References: <20260421033251.15663-1-sudharsanam346@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421033251.15663-1-sudharsanam346@gmail.com>

On Tue, Apr 21, 2026 at 09:02:51AM +0530, Sudharshan wrote:
> Fix mixed indentation in spi_driver struct and add missing
> newline at end of file.

That's not what this patch did at all :(
