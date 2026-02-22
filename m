Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481292248A8;
	Sun, 22 Feb 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781363; cv=none; b=teCIs1tEfYCJ18HRRQKHmAslEJEcG6tPpsKne5L4nvAYwLwFH+u4jrc2WzlR1ntvw9QfI/cr170oLdJssAX/f8Nn07lFL65dyNt+z/b38kqr/mDSSQBtek7WZXck6oJXFc6t4gvliJtB40UiQl5ZOecdo0wuUOMULG/4zZVxWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781363; c=relaxed/simple;
	bh=83/GT02pEc1lPUaf0sgF/nw3ojRUdqxyEPOXRU89KGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ne+fUC136lLcoLXyxqdluOrbncQXTMlotRKq9DSkRYBFsBdPIJolFdxFbE+PifmmZ9Zqq0OYxhzI7vqkXmjVdObZN62dfr2mTp8swYKPA2ZZZ9CrSTQ7wmQsK3mAv5teoJPn5V6VBC3fGEn0nDjufZy0gLsrFQrbpQjqdmWjkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRlwo4/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRlwo4/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88552C116D0;
	Sun, 22 Feb 2026 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771781362;
	bh=83/GT02pEc1lPUaf0sgF/nw3ojRUdqxyEPOXRU89KGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRlwo4/WvvkKMY+m1h9xLaKFaqyH26UiGUtFznIzUK6AGAD1FVGRAG2k1jGpBc6VO
	 axFzzoiUBv1nCYGPNSRphMnH8JQZkgMdpDJEcBk1tE2Pl4IvXHhGZ37NoYowtAzyii
	 IJ6QJWD8Kfn+gzcYzxOe3lFUkusmtS9lOFDOiIIgClOM31L8jD3S/Z9PSCmqOPx4YF
	 Kqi4x30D+sju4iQUi+33TNKEZcf9QqqaI2qtPYdh9v9KVgqZ9elseEb3csMUwxeKT/
	 hkPUa3eQ5yjAAnla5Yu2dEYZ6gnn8b0C/W4w8vUK7Uvp3e0j7hpeiR+qFXPH3EEphG
	 QkMNk8txKxrkg==
Date: Sun, 22 Feb 2026 17:29:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <20260222172912.60a103c0@jic23-huawei>
In-Reply-To: <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
	<20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 15:02:17 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> to parse numbers from a string.
> A helper function __iio_str_to_fixpoint64() replaces
> __iio_str_to_fixpoint() implementation, extending its usage for
> 64-bit fixed-point parsing.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo.

This looks fine to me, but given earlier discussions I'd ideally like
to wait for a final review from Andy.

Thanks,

Jonathan
