Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E701EA84;
	Sat, 14 Feb 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771059086; cv=none; b=i5vCRkurJr3CG/m4ydLodxUgRrk5AFdnmdAt/ReARXUVaOGsW+ROypbYWgXpLfVRvPdJEboFAYBdDof5XdeFWc/tRG7a+XqJ64pCX+aBxIP2poFL7szMP4KFpiDAdmVMf5hh3mjWbJgwNYRVcXlri8xVAgfjizm1R7gBShAgqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771059086; c=relaxed/simple;
	bh=JwTMYnwa5HT7Q8LWerbFcZqOP2iJP+uEcVrglFNP160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiuESah6CliogimHVf6OZ1dgt9qvCHn47D8NpyIFcOjyd7BQ7BGWuWqQAkP2HsA6IDQMt+0XAGcyO1xe/3Y1WD73ASLGsCncWaSlnMRMLzg+1/k9iXYQLS9m3G684/yXqXzXM4HwW1FUTWwDb3Shq6IeeTDy8ILACTIW/UgTbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjQs1VVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjQs1VVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E262C19421;
	Sat, 14 Feb 2026 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771059085;
	bh=JwTMYnwa5HT7Q8LWerbFcZqOP2iJP+uEcVrglFNP160=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjQs1VVlg0ik38L4BICalzHJIj3V24MISICzbxduCjEinWprrwJTT4udajHKc9Sj9
	 ZXrSN3maoU+DXrb5vAXu9X00YXZhYaaQSCJUKJMHWmtZp5XIw/VbSXRBAjfIdVYp+L
	 jW2tSR+hAEqVcdGOeIOjaXyG64w3M/oM9ZbbVyV97nqTDRrws2FKE3bZqT+ufQeXAV
	 1XvJdNvmjuC7QrFF5tEzcemPSqYXn6pu/aSjs2nCznrE8E/KlvB3SjPW3/iaIx3M5y
	 Pe2u4KTbOh9ao3gKygRLa4cSAIcmM9kFIHEpXw54QX/oa0EOshR95BPQ+p0VQFWq9e
	 osvzThvZIotVg==
Date: Sat, 14 Feb 2026 09:51:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4085
Message-ID: <20260214-evasive-green-kingfisher-cc4dfa@quoll>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
 <20260213144629.16001-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260213144629.16001-4-antoniu.miclaus@analog.com>

On Fri, Feb 13, 2026 at 04:46:24PM +0200, Antoniu Miclaus wrote:
> Add device tree binding support for the AD4085 16-bit SAR ADC.
> Add adi,ad4085 to the compatible enum.
> 
> A fallback compatible string to adi,ad4080 is not appropriate as the
> AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
> different driver configuration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> No changes since v1.

So you just ignored entire feedback?

NAK

Best regards,
Krzysztof

