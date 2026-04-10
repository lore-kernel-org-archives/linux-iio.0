Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584030C372;
	Fri, 10 Apr 2026 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798898; cv=none; b=mBYEa6Q3MlmlCzxg83oXRYPwC3bglYa/t0FyNFkDXMNHsWmB6G/UMH80n5hy8rMNBCLbfzhqGZhf3mBiFcZjIuaMDa/e4QYJ+lH86PAx8E2TKdrfW2z6xS3wwO51Jay6vUqcveSaPZhX+3WqtcFsqSjt/7O2+cxl/pd55fSYEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798898; c=relaxed/simple;
	bh=6dnXu8Wi8vAo69F1yUajOZbuGKTHese0VXyuNBbrfcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWG3/VKeBQ6CXU5H0atyN1TrNe+aBTQ99/cnb0UfPY7d59obUDzTNxo3+ICN0J4Lnzp85P0jTXBkCFK9X1h7k/t9r+Y/KqKL7v8HIRM4RDpHCP/31Tb646hKWLpqImIhurxWAEQrZec4gu2HnFy1XDKIDPWpDY7xTIEzOiuCQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l6L9z6vH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l6L9z6vH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF23C19421;
	Fri, 10 Apr 2026 05:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775798898;
	bh=6dnXu8Wi8vAo69F1yUajOZbuGKTHese0VXyuNBbrfcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6L9z6vHS9MLr6AW76tocahWNb3V1EEneFQO9vSnejhclMreNLLLnr7SsZ5pLAQje
	 /piwBTnntg0xDGZn3ayVNqyIhuFkcNLxVC4zXnBFesVd9B4FNW4K+J2wQd628Ud9af
	 onaCzVyfsvrOBA9FD+ooUFYdilTeQAtCqDpkMVrc=
Date: Fri, 10 Apr 2026 07:28:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P
 driver
Message-ID: <2026041027-hatless-swinger-eae1@gregkh>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-4-hardik.phalet@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409210639.3197576-4-hardik.phalet@pm.me>

On Thu, Apr 09, 2026 at 09:07:41PM +0000, Hardik Phalet wrote:
> Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
> magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
> over I2C. There is no existing upstream driver for this device.

Sorry, but no new iio drivers should be added to staging.  Take the time
to do it right and put it into drivers/iio/ from the beginning.
Otherwise this will just take more time and effort to get it into that
location in the end (i.e. doing it right is simpler/faster.)

thanks,

greg k-h
