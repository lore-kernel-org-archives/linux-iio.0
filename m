Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE852380FF8;
	Sun, 20 Sep 2026 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870347; cv=none; b=THIKvEB8S4COU++9NNFkYFu0sYHg9sNjB8i1W9F5FfDuEc7/097y98Fg5FmqCTFJMbR1sY7Df8C81qku2ttkV29EAU9OQvHcYdWabHmA4BKkTMMdWALE4j2LF5eiE4SvZ4InLy0wZFEXD+6ZK2X/xG6Rx6l11MuN2yhOnL1tVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870347; c=relaxed/simple;
	bh=FtG+2vcwo4AUc5FtzB9bQj6p6H93SNJZ0iYiKNMN+k0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxBhGGvtJbfMEw4P8Fe/cOzfiTj/1ZuOtNN2Ny7qXdsn/qb+SVmiwh+ReQuw8dzu+cxLPyC4Je6RXYIJ1PB+jqfPkECF7i+3zoChYIn633uzVyLh7C7XVG1JJmPwiM823oJkQEVxBWlKEnpSNbTu/qB+aPO81vBwmuJT6Ur6o8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw9YTS4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw9YTS4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B735A1F000FF;
	Sun, 20 Sep 2026 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789870346;
	bh=nJA25Z5FjQUT9Ibh+fiawYaCKLt7JSI4gadBjccJPes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jw9YTS4nvW88tlLIU17Sm8ijyUq9cUYg5cjY9cMl1+pPHLslVMCGrD0gq0l/hK+oC
	 zV20vz8uT1b4v2xWRNTySNG12d6S/X3dBg3NU+kQbONKn1SZtksGSU9TC77onGghdc
	 t8+OsHJKSQh5SGO1fd7uPMQR6KZQ69AW+lbBOiUZFtdFDqe73SjrwQYg3ub9V4biaI
	 p6B15x9wCXqwIVMIkV1rkIQCe9YD4XU6ikaWJxYpBIJN69zkNC1EljjYBlVJfpyRyP
	 S+PBfJdumeh1+RcdQURgQvR/1XXZgbD/11emo8VkNpgoKZ9q9inEfF1u7okIuQOtxp
	 vBvksSdpOWIEQ==
Date: Sun, 20 Sep 2026 03:12:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 7/8] iio: osf: add core KUnit tests
Message-ID: <20260920031220.4aed758f@jic23-hlaptop>
In-Reply-To: <6915383a4a73b680e357d1a75106e0cf6e413084.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<6915383a4a73b680e357d1a75106e0cf6e413084.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:45 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the existing core regression cases for frame handling, sample-cache
> admission, supported capability discovery, repeated descriptors and
> session faults. The tests exercise valid, ignored and rejected input
> without changing the production receive or IIO implementation.
> 
> Introduce KUnit configuration and build wiring when the core test source
> is present. IIO-specific tests are added separately in the next patch.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
https://sashiko.dev/#/patchset/cover.1789753020.git.kimjinseob88%40gmail.com
The lock one looks right and needs to be fixed. Not sure on the others
(I didn't really look as running out of time today!)

There is a lot here and that is likely to mean it doesn't all get detailed
review. That isn't necessarily a problem though and they are generally good to
have. Just something to be aware of.

Jonathan

>
