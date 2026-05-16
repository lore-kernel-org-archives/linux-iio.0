Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086D1C5F39;
	Sat, 16 May 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929047; cv=none; b=Ge36V9u4huxhHh3VNVgPrydzVrYKcfqbNc174/2meO7NcxKAeswD/h0KsXxMCEF2+CbIVeKYU7xU1l+DAMZgjtaLI1z7y9M7uNWdAX+eyr3Ks8rqq5BV0GpixhTmJUaAayb1VKZLLhajltuIzxU/5dROG6pJmANvC93YjXLmaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929047; c=relaxed/simple;
	bh=w1HDI7qDSJTkeV92krG3LvV/CuMFeiY4XLAxP9rTTiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te1jeCh/SrALbr6Z002KYkgoeFl5OKbMygQwHFNFTa0lxnERK61TOvjaf+iTXbQCsXuidTw+Sowv6o5l54vncs5c51UEGw6BA+h5/q4gPADCZ0kW9RA2Up1LEYKH3B10uVGfqzx3ilZyqwiSug37kBRqC+3Jvkza6ekYC2LNB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQx+wD3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQx+wD3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482CC19425;
	Sat, 16 May 2026 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778929047;
	bh=w1HDI7qDSJTkeV92krG3LvV/CuMFeiY4XLAxP9rTTiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQx+wD3ppTNhg7Xws8Dlxl2QSV4pLZ7RKnw/uRNVq/YUaW3wH6VCnShJuBKZCFcO+
	 klaK8e/+7VvS6hSRfqQ1tV1sUpoA4TWb4PYi8Y38GwoU77vmyOVCcOp1GRBZDSGdzB
	 /V1VUU0yQA0L284LwFp8GV4s6p6qut7Y3fUMSeauNvwPQLakOj2jbHWK357bYRl1us
	 8tAn2KCVnmGfaGvKKtHcvQ/tapZxKh1Xf4oj7GouhXnuULqZYbfUeg/A89CSaJk3zg
	 B716D/qSXj98KWfa2dWAZarXRNAcmXuXqYcspv9NB0s9eQvNA1WmphodoqTHAuvHQ9
	 1sOmr5kFrdaHg==
Date: Sat, 16 May 2026 11:57:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, corbet@lwn.net,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
 linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: iio: fix typo in triggered-buffers
 example
Message-ID: <20260516115719.2a866ecf@jic23-huawei>
In-Reply-To: <agb8enneR8dWE_uL@ashevche-desk.local>
References: <20260514085157.20327-1-sozdayvek@gmail.com>
	<agb8enneR8dWE_uL@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 13:59:06 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, May 14, 2026 at 01:51:57PM +0500, Stepan Ionichev wrote:
> > In the "IIO triggered buffer setup" example, iio_triggered_buffer_setup()
> > is called with "sensor_iio_polfunc" (single 'l') while the function is
> > defined and later referenced as "sensor_iio_pollfunc" (double 'l'). Fix
> > the misspelling so the example is consistent.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.
Thanks,
J
