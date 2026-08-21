Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DB3A5445;
	Fri, 21 Aug 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297685; cv=none; b=MD4I25CKkMWKrljzSVHDrbG3m9DtZ3mC5ODg4RingeoxfZIuvo2lKWz8342+cP6F69JWyZtFXpD+nlfjW/eiuRhl3oMH91EUTgPoyYjR7OLpQZ895YC4h50/02NoDBucjb5mBOmkR3oAxt96uYvC7dOEdZWEQkubRsx+YrpvcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297685; c=relaxed/simple;
	bh=H6gqWqfB39usN/jVqWAOhWYzGmLyDQ43+6TUxEzLesg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKV2Ps9pK3xUw5T7Ma9De1fqJ4sRsBkN1GE2xm1IbDpHcvuDhbB7MqypSTAffG3UZIcABPOh72dj9jWyXdAT48AIJ+sUJgOm0VWmQcG5w0BKy2nKy4lqVJxY/iZjJhBZZi96LiNMJUtuWFhkZAzRDyCPIVKnvgezn2o/GaPIPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buw97lLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buw97lLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF41F000E9;
	Fri, 21 Aug 2026 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787297674;
	bh=itO7hZz7ukX+qgDBQwlj/x+5JojCzAJhCiknR42HMPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=buw97lLwZ3zwZfLjy3HjpJfZVD0YNAKLizgtY1oZ8e6p7U1YcAqdowr/DpmKU4u4Y
	 2ZZVwBKHv72ecRmnWo2aW12Jdh9dK9qWo7e//wnzp/ZkhF11kBjK7KkTORbcRoEed0
	 3EaqH7pm0CnX9XQ8KyQw0GT88pBlicy7+PFsXYYMUjfrnk/dTU46vmS53kaimgjdQS
	 X9DtQ/79w2R8UyqLkRmaHJpwy9jL316QJlJIm3cWrajqVD+Jqb2g0eSyUn0K2BzLgs
	 DlY4Ds7KuHvdvzXtp1/jXInlZ34Kl0MHAvqg9lrgl+8lxm+Dgq7yCEQGLStCePGx2I
	 qFblVsqnpXwsA==
Date: Fri, 21 Aug 2026 09:34:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] dt-bindings: iio: light: ltr501: Make
 proximity-near-level conditional
Message-ID: <20260821-realistic-sarcastic-labrador-b8a1ce@quoll>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
 <20260817-liteon-ltr329-v5-8-6f71ab2b0588@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-liteon-ltr329-v5-8-6f71ab2b0588@geanix.com>

On Mon, Aug 17, 2026 at 07:08:57PM +0200, Esben Haabendal wrote:
> The proxmity-near-level attribute is only supported by ltr501 and ltr559
> chips.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  .../devicetree/bindings/iio/light/liteon,ltr501.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

