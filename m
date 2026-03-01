Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C6322C99;
	Sun,  1 Mar 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772366734; cv=none; b=GPD+d0l7G4K54pg2qeMHrbb9sV3i0/G3kxK+F9tNfNCW5k48tz5+KYLytkY7VAxziJR0ZMj1Yhr02/pKXnI1W5Dgjx3DR4D62HYVLOB6Lnr5wKbqj8IZ1WTXFKs08Jzxzchw4SZOaIN59KqJTaUV8TwdF56QfwL5xN2x8bozdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772366734; c=relaxed/simple;
	bh=qEc7qeGNVclcQbZr5qkobSg2nqBpVYaw2dYdofFbQ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qR9/yz7OuGS2hlYmCiz/XDzvUJDbE2D2VgAJj+dT/FhPpfxCVaZewEaFcfZFwsM84MSyuJm8G9Q3AKTfvvVFwZolgMFTQHfPqDth0ByJwzbB7PS2G+RZsccunaoVYSeEoRtOJz+SItwSfUynth2WG3fEXqsSs7cK8V5Hy0KtaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ7jW+cO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ7jW+cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1C9C116C6;
	Sun,  1 Mar 2026 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772366733;
	bh=qEc7qeGNVclcQbZr5qkobSg2nqBpVYaw2dYdofFbQ4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qQ7jW+cOA/7TJ1XD3R8Xlf7zJSznJAwSQRbjUr5ub+jCiwRWx81DHNVyehn909Y4n
	 0P/8CYryQGT4Ju2t1Ot26MlTiY0KNakWF4vOee0eaZkgtEt7Hmhs/noZHawqcjpPsd
	 ARfsAy9u0ELNqQFaDcyc4f7Uro8rlbJpjeAhCISWhbwhMVeLZ9bU5/3mxNYHItoK5E
	 hRnaikt5ZelEjv+3MuoiRnQPa2nw8P6vhAi4Hgu21HfvbYbi3mPNascwpKuEH0Lss9
	 4dpLrJRLC3fVpXrimEdtdw0SHl4aFT9ikmKAF/bHRUhfsA3Pe0+SbFsXpEAQ61ZaB0
	 +WJ1H9DykQztQ==
Date: Sun, 1 Mar 2026 12:05:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, linux-iio@vger.kernel.org,
 rdunlap@infradead.org, skhan@linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] iio: accel: adxl345: Implement event scaling and
 ABI compliance
Message-ID: <20260301120524.710676e5@jic23-huawei>
In-Reply-To: <f697a233-2fde-49e8-8c85-dbcf2599eaa9@baylibre.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
	<f697a233-2fde-49e8-8c85-dbcf2599eaa9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 10:27:35 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/26/26 9:11 AM, Taha Ed-Dafili wrote:
> > This series addresses ADXL345 driver non-compliance with the IIO ABI.
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Updated to add your tag.

Thanks,

J
