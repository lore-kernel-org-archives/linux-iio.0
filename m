Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDB26A0DD;
	Sun, 17 May 2026 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026897; cv=none; b=sHnAFS0cWE7O8jA8EsKu25ihkLI/PQeC2SxntXBp2h+AKEKgMimkmtMVW7GiVZsXbUnzfPQ2aj3unXupdy9B6mXbXqWu7ZpKy+T/CuROR/11DWblUvHZFC7YmEBskG/rgaDvyTg4MUbj/WpzaNo2/GHQQEVuQVLfzSCVwsjffKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026897; c=relaxed/simple;
	bh=8vyB96gHpMb0LzI/y0vdy9+Txj6ZWV1AfwtYIrjOO3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5+SkExSbVetbPgNds5sF9KF+wudeU6Qvo75KXCmvBy+pYt+EWc6sD2yiWSwtghAWd7VbwNCdjKBsUq+MQ7on5kw7xc5sAb+MX9ytk25zSrYGzvNfSMuM8yPS+us9NqvnlBp76cIm1TAeuzyLmZpqmxIIJwn2Y3+WyPllroQP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJhCPFC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJhCPFC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFE3C2BCB0;
	Sun, 17 May 2026 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779026896;
	bh=8vyB96gHpMb0LzI/y0vdy9+Txj6ZWV1AfwtYIrjOO3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oJhCPFC6bB133kLdGX19nHwCpwryq4vKGq2Xl1PHZmLuMGNY8z0jeJwnc0+VP9Q3s
	 bPKTL25QYlqS9395IaRXtn70s4xkx29EMGdYkRfCHpZ+/n2dCkMWsAp2uVb3agrhtM
	 pM6gUlIpFQ8uZ9v4FmE2lLgZ7uCrZq25DzMKgXcFP4jfUzE46JqQfdH4U500eRMuSM
	 EQjtumT7BzO+8ZPUtB9lEbjMHhKS/KWjSwTUSukr5a6SkmHDmbhJkj1cC3Su6z0Wm7
	 AiKrgqslVoLLrnpmDQP2XjVGHe4UkrXgDUeZRRLIc1aQlo+6/604T4xzVjqK1jNGPq
	 5FfvvJWcUskNg==
Date: Sun, 17 May 2026 15:08:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v13 00/12] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <20260517150804.3574e31c@jic23-huawei>
In-Reply-To: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 10:13:55 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Load Enable vs Reference signal syncronization
> 
> The series includes:
> 1. PLL driver implementation
> 2. Device tree bindings documentation
> 3. IIO ABI documentation
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I took a brief look and other than the few things you've called out
already and trivial formatting stuff I'd ideally like tweaked, looks
good to me.  Fingers crossed for v14 once others have had a chance
to look at v13.

Thanks,

Jonathan
