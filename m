Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9043372B23;
	Thu,  7 May 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169726; cv=none; b=VKpNkbVTRxS+vGpUvT3ornPh0ApideiUvr0RiuMY3iTfqh2MnmLyHxIgW+taTkp0sTDNYnMwC0q2/WT09kO40tEgkCkgY4mDhMoRYy5PqPMlb+wnAXBAg8uhMvD9553x3vFz/Gyl9ryJOmjPZaIEFjLZzsRD9d8sCYY7SJAuUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169726; c=relaxed/simple;
	bh=f2hzin3nefcffzqxgbzMklPTa6zT29OO6KXHSSBokuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coKDUctbLW9q6TD1EAdf+UmwIgUq54vue/cVRYwRfniz4OudgyuD4AKTQHtZ5oAUjkmW1YbAIRclZ1vi6m74TNcStEo2doq0es3/fTjyeNkYbM4WO3x2N0IPDnwjNKIGtAnVmGRKuLUxwWLYZNkiO1XQuD6Gz1xU/yIbJObDwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdBB9hWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdBB9hWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BBDC2BCB2;
	Thu,  7 May 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169725;
	bh=f2hzin3nefcffzqxgbzMklPTa6zT29OO6KXHSSBokuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HdBB9hWIvACu7K+AY6WnDLX1eE8Ye2nOhklmDg4xcVBobtu2wEXxOP0RHx3E9gcR4
	 3Fvbz23MaLTPPPekFHHPpwWhoWwiWIYC3bHv91DPnd5kln/Sem2H6WdYcBTO/+TVSl
	 Hwo6l6lP6LDX8FmWhhwoJKZJWHxxZzGvgsGIb9j1/tcYf7OpHm4qxCGQXIehcczqtN
	 C5CIIHBghjDK3eVZrS9Uu7iFYmsE7Ez4aNZzv1jJXyENn3m6i1f3L2M/ggoxTOhboo
	 GQHtZcPbCF/hGDecfd2Yru7xNR0sDIOMmKfkNVVctMwM+/3NOIvi3DLW2j4uEVY5YB
	 dpH6r3qvvolhw==
Date: Thu, 7 May 2026 17:01:52 +0100
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
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v11 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <20260507170152.55027f68@jic23-huawei>
In-Reply-To: <20260506-adf41513-iio-driver-v11-5-2b7e99cfe8f2@analog.com>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
	<20260506-adf41513-iio-driver-v11-5-2b7e99cfe8f2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 May 2026 15:08:49 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> defines the representation of fixed decimal point values into a single
> 64-bit number. This new format increases the range of represented values,
> allowing for integer parts greater than 2^32, as bits are not "wasted"
> in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> decimals into integer values used in IIO formatting interfaces, which
> creates consistency and avoid error-prone manual assignments when using
> wordpart macros. When doing the parsing, kstrtodec64() is used with the
> scale defined by the specific decimal format type.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Looks good to me now. I'll probably take one final look before applying
but for now looks like you've still got some Sashiko reported stuff to
sort and I don't have any other feedback.

Thanks,

Jonathan
