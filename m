Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00747363089;
	Sun, 26 Apr 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211468; cv=none; b=neUAcJdoBmyVXGbtriQLi6tws8UzJNx1/QaWNKjb2Nslp2eloZla5tnu2Dd01ro0CO6cQI/JL2kXuLrvYxLtCTyA7ZJTs1N/5eMTP7PbBBJAf6C7tro325bwTtZ1z2BTOCMfWmb+ulSvBbGCeHgEk7gD/HcmkjZHMK+e8/4MNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211468; c=relaxed/simple;
	bh=pw6EEEKmQQLcfcoL91KYDynYHK94CXzz5Y4qkM3cDj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLvO2sHRpQwIPRsn01xt+ukcpmXTqCP/NOjSohyw8ZMD//JKaqjDGbx36PiE9HpX8PdQoTtfwr9/1qcRo8J2E7Dr4mp2T739VFpcEJ6b9LWtmjrO5HCHWShnJB4m76BXrzqr7RiQUHukd3H7a4HqC5cl8Pk6TmmRp90rlyHzePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHyNoga5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHyNoga5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F099CC2BCB3;
	Sun, 26 Apr 2026 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211467;
	bh=pw6EEEKmQQLcfcoL91KYDynYHK94CXzz5Y4qkM3cDj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oHyNoga5deUdzbWDKnNGXY9wWsMHEu22Ihz2R3K0YMpH3auIfIq9S7xj+nof23Vj3
	 pOvryyUfXWemmTzvJDGWqr0NLIZoklMnJJKWmS5jUHAv44t+UGb1jCYV1yCo21OMUY
	 8iP+GW49ugt67jrpd9LH+Y0C/3lYjvAzV5CF9HkkPL/Cspgkobb7ojuqrpGNjZv9Pq
	 PfxYt929EGLQ08bhu6F06k7oqOak2Mwou/Q6baB4cbbuVBBqx1k0KCvEG7mlYpAP1p
	 eX0d4gpZwdUuAtcKNXuxf/bW7tLX0+8ykJME67qFDlGas3w5xMEzD1oUzQqey+WyRN
	 /LL2K06h4GZrA==
Date: Sun, 26 Apr 2026 14:50:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 10/10] iio: dac: ad5686: create bus ops struct
Message-ID: <20260426145057.6dd00be8@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-10-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-10-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:11 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Create struct with bus operations, which will be used to extend bus
> implementation features. Auxiliary functions ad5686_write() and
> ad5686_read() are created and ad5686_probe() now receives an ops struct
> pointer rather than individual read and write functions.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
LGTM

Jonathan

