Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AC426699;
	Mon, 11 May 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523461; cv=none; b=TtMOlWXyx5THNwhnpC9O/iVXPkk9dAOQJ0XYDC1fTIKn9f+o6l37R7EcHLTpznD8rRuzGYxuFpk/KGvx633epElLifT9firbhiz3vqXF2nocljoIQyDgu9ulyhof2MQ+uuuR/WJlW9AIVrdQKQbPy5DfkVqxMhahD7TvbQ5t/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523461; c=relaxed/simple;
	bh=lbURAKti2CzpwsVQhG3cs4u+CeZLlfqHQLKrPBlxm0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlyoL2z6xpJF8exjv9JMlXbZ7EmU2EHOYe/DQUv2WhHbmUSolqdUpdIpc8B9WG7Be71r8gDgh7TjqYrFV5TTOixgIKFaIBPjz1RGCd6hiT64p/dIyl8033aRMD3Q+v0WYGrbn3n0l9JGz/AYZbWVYp4hS4IEqINzG4QLPBjb78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYoeCKof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYoeCKof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBEC2BCB0;
	Mon, 11 May 2026 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523460;
	bh=lbURAKti2CzpwsVQhG3cs4u+CeZLlfqHQLKrPBlxm0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fYoeCKofqFa1PyhhiAlSmCaF6Ac+bBHg9sH8kfm7lIk6BK0OtQJq0r+EiWfPAkeHr
	 AVtlO/keiy8D+jl0Oa40NQUF2qYMFcK6ahne5MNJeX/2rqYQlBGk2bZ36wZkCjUnpa
	 CPVhKgH3HvM7gzuTbdJNY+D1amMprHPv5MBnBs+poQJEoM1o9DKYe/291RNjJSPEl0
	 xKGTjkf2njxEUMaTIPX3W0tG9UTNoboNj+eCyD74X10hHMktexCoGGU4DRITBTQbrU
	 qU47SgK2fZtMVe/BCnRJalmSL9aQGPzyM2TXF4w9ZCvOtybm6cxPI7OLPWLSxOxTYq
	 vyuOHG4t+i9kg==
Date: Mon, 11 May 2026 19:17:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V5 06/11] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID: <20260511191733.1c53e757@jic23-huawei>
In-Reply-To: <20260509191907.24734-7-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
	<20260509191907.24734-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 14:19:00 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add all FIFO parsing and reading functions to support
> inv_icm42607 hardware.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Sashiko was busy on this one as well.

Not all necessary valid but at least some are.
Given I'm way behind with reviews and it's getting late I'm going to
stop look at this series for now. Please take a close look at:
https://sashiko.dev/#/patchset/20260509191907.24734-1-macroalpha82%40gmail.com

If there are things you disagree with that's  fine but it
has a bunch of things in there that are definitely correct.

Thanks

J
