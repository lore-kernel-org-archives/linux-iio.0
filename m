Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838284A35;
	Sat, 14 Feb 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086094; cv=none; b=Yu20Su52WVeXCZfN6c3c6k5ubKWfkTsaNo5FN+7D5KKNSBc2XsTTad9NSyzbJZN6+JRaXJLXWLP99fL/5cE8pxIUrpRgoKjkQD5/l5MYzmaE2TkB1Tg2/cPGdR1rSI+KLXNIQwHamivzIhpzcBz7lRRWp+sYCpdPVg5o2+8RMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086094; c=relaxed/simple;
	bh=5tCH8v41cn5DQP2RhchcGnH3MRx8Xz90M7PpUTlhoCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRY7FrOARmOyZHpRRsFuAOVePbJhK+5LZyYijSA/rXq6qEQFzr/XHtjiZw+z+85W2heu+5nIdtxFwubopic2nJIWMB5qblu3A2TOwjSg8P71EJr7Zav20l0F+941z24c3nuOBDtdl743vQ8JazV772GlzNTv9YAqRlFQTX11WKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5i27zGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5i27zGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCC6C16AAE;
	Sat, 14 Feb 2026 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771086094;
	bh=5tCH8v41cn5DQP2RhchcGnH3MRx8Xz90M7PpUTlhoCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5i27zGFDdusZc6t/3X+qxejzTR9lcWMNoRcDb8+bgAl/M9SwC2H3K8h86FpYSFR1
	 7O/IQRBSgZLWlmFHbmt7OWSOyps441gIhNJ2hzqyrEj/qzYpcCKfK6hW8fPLSA6Pi4
	 uFoNYqR4lM8wCCpu+VsWedJWe76wYUS5joLdueo/Rel94Cc8qOtIz5jW2DefDHQ0YZ
	 7lsRZviShO918YZOFMrBXAyWSIQe81UPyS5L00kcTcXzQoCF9sbxW5Ik4tqCqJbnr8
	 3rQDcH5D89MYFVPYUD+RjgfRbUG/mESHCZfbHI0fZ7mQJxt/60E5iO22V2v80mSy9Y
	 Hzs6R3yOK2poA==
Date: Sat, 14 Feb 2026 16:21:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v8 0/8] Add SPI offload support to AD4030
Message-ID: <20260214162123.5a8772a6@jic23-huawei>
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 15:59:58 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> This set adds high speed data capture with AD4030/AD4630 and similar ADCs. It
> also adds support for ADAQ4216 and ADAQ4224.
> 
> Change log v7 -> v8
> Rebased on top of spi-multi-lane change set [1].
> Requires ("units: Add HZ_PER_GHZ") patch to build [2].
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-multi-lane
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/units.h?h=next-20260204&id=5083dba0fde5446c00ee1a82a3911c8f88a2c72e

Given I'm going to be waiting on these anyway and there are just enough
comments that I'm not overly keen on tweaking whilst applying, please
do a v9 with the last few changes from the discussion with Andy.

FWIW I took a look through and didn't find anything to comment on :)
Looks to be in a good shape to me.

Jonathan
