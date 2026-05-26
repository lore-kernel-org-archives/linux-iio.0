Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410B2236F7;
	Tue, 26 May 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800333; cv=none; b=anMBbw/VE3QRJi6bCvyocho1qLuAZIfwyuFZYAKPVY3Y0Fpr8x7uuZ03liARb0yyKXntXaxBSxW3uG1DM1PbGLKTLo4d2MvGBkw6FXxJcn/IFZkINPu+1mAaTXNHsW0Y7Sgyxrkk7u1CU+4tdOV7wjTnWKHFLxc+v7VzbDuP93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800333; c=relaxed/simple;
	bh=1Df38oZqqXj9YwM0HsLCEYxP0/3lx16tUR9wSDpkl6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKiBLMCsMDaBAsTs7XlHJ8MyelO1eQVVUB/1OvqS6CGfTgD095+bm6/w8bXfJupt0tA2N6Hf/dN9ai6NERap/DJC2Rc1ppYG0Zo1tfBw477HuPjVTPHc2LOCDPMEfRWKHVjziOTYZimgPkTTOok2lkQx1Cp3FF2aQKS1XYI9QNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwmSHDa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwmSHDa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D21F000E9;
	Tue, 26 May 2026 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800332;
	bh=LpIzCj54S1Mhe6sihKHC8kzUsrSpi/nyKEUQGixWGk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cwmSHDa/UxuiVVD8f7QpTe9+K6iZeHbr76EHnb4h5acbJWhU3yb2ClcGVxGTEj+wD
	 16DbNz2td6Iu68Vm6Dg9inX5qWyg1Ns9MapbILkKNFcm7Md6+mWY+nkfL1puSsHNu+
	 HhLqRWx3gbb+lEr37ItwpPgCE/zNglzXXv8IkgVsz67dNgK9URqJZz4KUCAoJVcj8n
	 z8QIchs9K2J191o2/VjVhvgDOPOfdCoY3BuVSagB392UbCWq7SK2KRGn/+T1YprNl+
	 lcnFuiWWG4vcyP7jdPo3uo8PaWOReeOtFSPiLBSGRYkmq9l/7OIHJifn+DxK9J92T8
	 a5VbwrsHaepqw==
Date: Tue, 26 May 2026 13:58:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 4/8] iio: tcs3472: use ! instead of explicit NULL
 check
Message-ID: <20260526135844.4ce0139c@jic23-huawei>
In-Reply-To: <20260522123420.45495-5-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-5-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:34:15 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in
> tcs3472_probe() to follow the preferred kernel style.
> 
> No functional change.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Applied.
Thanks,
J
