Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080631;
	b=tdokeE4b9iibOmNe7RFgHvgYgwr7Eq6QqKjry2ZzNvRt2mOhB+haS2vAwtV+1OUeA9Ze
	 i+8NZIadBZHxaJbdB5HPRD/TqWc1MoygRM7hsHtv69n+uoCz5GArIj2QWLPHhdU6t9vIg
	 gtozFYnlR3mF5DNNFNqdyiMMWej4k8ZSCwnL44hgLjL/9czJXk9pG4gJmcHBWFhUy/4Q7
	 IkcisMvKnk5ptZyIezZMw16ldemCkqT2Mvq+lnoSoIgAJLcA3EbHqhucMRhjRK/U1+w9e
	 wqxdxkpmP4b1fZwOJlLZKP65KvHi5d0+CX6vU3DAZW+oTwN3VZKastPW4oMjnDJBLbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080631;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OZKL/sgPGSno1xBgS6lUfrtiTZf3oM3GGstyW6wEvp8=;
	b=hOqqxXbpxepyeFq6Blq5Q/BmetM68hNui6UwJdii85hXhIhdMTuUAcMR2UVJLWp3H7bH
	 AfIBjGjn2DNpNfVXi3fx/bC3TOU0XYX9/HeqPvy+MyD+y1u9EiZ6q/Y5K6MK4bU2fbhWn
	 DrXJ/7MeEyX25oGbV9q415vubQXNK8KQ0Exa+lbNuvtkhTL2cvPA3yV50WdEOzDRPS/33
	 vQhg6/o8uJYFMI8rA6HMOoisDYLdj/9mBaRdglYvjE8yDNhCMvrjxI4FlxCt8rXjs5YIF
	 +kGcRLddT7E7Msw4d4zbZRGQ5ch+ZuI9LBhXGsq6+/HW1xHcGVMDlmrsutcmQtEyZOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpGnvUfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C711606A32C;
	Thu, 19 Nov 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpGnvUfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FC71F000C4;
	Thu, 19 Nov 2026 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080630;
	bh=OZKL/sgPGSno1xBgS6lUfrtiTZf3oM3GGstyW6wEvp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GpGnvUfC31nNCL2JQ4j9DepV7Ltts/PSsz0XWG6tP+/KcBGSWbyoyM3Wgapt10lDc
	 QtXDYruyP9SeUaIGi8T5ddvFZry9b/xv9haNmk4IYHaFPiBTHsoWUbNFBwO7CEbXtQ
	 kEXMyJjO1P78Qdb6WcUPn1Z5Qohy46Dw2kI5cchbIlYLseN2c0APdH6dAU1ePS/AVn
	 tpQhpG9oFDqc60m/5fjOkmt7c9DLOE+VeVKn/9LHLVNsApHP9EY/jyygh2mpqMZwKW
	 zZRmvXob6hYARlIvVF6Z4s3SLuYNdDJsuKFvisIyJt1uqq+aRW5v7J3jRNu18HjWgY
	 OqvwDlu35tKIA==
Message-ID: <cc270a65-985a-45ad-bfdf-b205cf9ff86b@kernel.org>
Date: Thu, 19 Nov 2026 10:30:28 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi323: check i2c_transfer() return value
To: Siqi Chen <chensiqi@uniontech.com>, jagathjog1996@gmail.com,
 jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119070837.3844364-1-chensiqi@uniontech.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261119070837.3844364-1-chensiqi@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19-Nov-26 8:08, Siqi Chen wrote:
> i2c_transfer() returns the number of messages transferred or a negative
> error code. The BMI323 I2C read path only checks for negative values and
> maps all errors to -EIO.
> 
> If only the register-address message is transferred, the function copies
> data from the receive buffer and reports success even though the read
> message was not completed.
> 
> Require both messages to be transferred, preserve negative error codes,
> and return -EIO for a short transfer.
> 
> OpenCode was used to identify the issue and draft the code and changelog.
> 
> Compile-tested with CONFIG_BMI323_I2C=m using:
> 
>   make O=/tmp/opencode/linux-build-bmi323 W=1 \
>        drivers/iio/imu/bmi323/bmi323_i2c.o
> 
> No hardware or I2C fault-injection testing was performed.

Also the testing info should go under the ---, as it's compile tested only.

-- 
Kind regards,
Joshua Crofts

