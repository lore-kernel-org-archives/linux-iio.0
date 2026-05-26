Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BA3FF8BA;
	Tue, 26 May 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807134; cv=none; b=s3WEHZ03Om97kLpoc3qwntxYV+danZJvdM9qoKyW0PKsqfhuSbiWA+sqNENFyJEkuse9AuBarY4TTnD9jHBBFoRCmZ0v2njOpPX0WNbLIPFDG4s825Gry3iUcWibs/G0OLtxsQZHRpCxwSq3Vnjov8y4/6kXQNxH2lJavt3WUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807134; c=relaxed/simple;
	bh=v47yB+d/wdMGutyO0sPfBx2tF5oBmMp7BFKXELxnqV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lojuLxz0UOpyamYgy17HDrl9EeeX1ix9uO17/5tvN/GRsDmHum74jqA1bNHfOqnLWxaSRCR/WeX6HzpM/nV7B8hua+Kfmq9TmlJ7Bjq5d/4EygUBnjWWo5M8JXWurzJIbkORek+yNgy4glsmmds6Sa9M/loSxjvuCm2LMEQhTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olJDwkIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olJDwkIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01381F000E9;
	Tue, 26 May 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807132;
	bh=0DBp/8u90S5UO82b4DzM4YDhXCxN1Y2TwAO+LekYXFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=olJDwkIpKExAjb9qgYj5zvP3MyOlk4AX78EZDXF1t32lnIFBtnde5dGzgtsbC2GSB
	 PlUA5O7YPwmHcSvXfFkNS1G+rSeCiPgsrMUFiLrvVUqADwuS9pfAs23yhv62eAseHV
	 b1smpSHtRyQ+AN7CAm/n3lv/uiOpCDTWJ8IayaggcYhMsZRoS/VpftWZ7luRxiM2qI
	 XRseMVB0QIz/P8yYiN4SFF+8XD31LvY+nvE8q1UInE+X7jd9K+ZtSUmYnLmhrapVFv
	 LPWMdy2cengB5DugDrPEMwD6Evr93xtn4hJEn1vXifYEwfeOsXx0mekkwVZq/G/VaP
	 hCyBhntwh0SpA==
Date: Tue, 26 May 2026 15:52:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Heidelberg
 <david@ixit.cz>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND
 DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] iio: light: al3010: read both ALS ADC registers
 again
Message-ID: <20260526155204.43bf2ea3@jic23-huawei>
In-Reply-To: <20260523114505.73601-1-grandmaster@al2klimov.de>
References: <20260523114505.73601-1-grandmaster@al2klimov.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 13:44:57 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> al3010_read_raw() used to read two adjacent registers
> until the driver was modernized using the regmap framework.
> That cleanup accidentally replaced the 16-bit word read
> with a single byte read. I'm reverting latter.
> 
> Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
