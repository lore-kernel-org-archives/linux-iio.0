Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E62F363F;
	Wed, 12 Aug 2026 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499433; cv=none; b=r7+HBY7VHklZ4liGzovoa/yF7d7Bq1hIjCGFjeuB/hP74Y+DlTYvNUq1JbwO4rK/a0cEs5cIyKjKHCtrytiykg0R02SyGsyl82HA+zZqP2NF5eMkrQYg3WkCcpPmEaDJIgQrlchwHxPSAjpSm7tLkE8fxGlfCC8YU+q09WZKZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499433; c=relaxed/simple;
	bh=eYLFteZU+TUhM2X6428s2odKCcEwqXARF28M96jfUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrU33A8TMiZj7QUN20s3gCcSdRHT4eA0wq1dhgsUHtau4gSJjRe40zYpgA9JPsTG2k1xX0D8+QEHWTIdlAi5PjjLF5qttAeHDYEOuAEXm5Hm5+j7SbqnSpLavz6iLW5496NfwWyuUokKVFrp0u+vjC4ku5qpUdMWOLfP6eb+o1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKmaB3k0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKmaB3k0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D221F000E9;
	Wed, 12 Aug 2026 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499432;
	bh=sWsDyXcx+n3+dS1JGT2lIs0EX6Lf7YxYDYxowTniGrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nKmaB3k0G8WY8c5OYsppztyEEIo3YITBHasTQk9KYHVFCKCZ5BKBQ2foSYe1Nfu/q
	 bkomYc70PpwDWN/MPE2nDvLqfhfRpJT0nm8E1+gt34YmTOkYL1AR0iw515IJBj0UUV
	 yV90w8dQLlEx9kvHp+7iIsP37EesV5whzx8nDlurU/Z7cTDJ+E/J8atlBDE9FlmWHt
	 p62ZU4TLi5JFNaEyWo1Y6jqB0YzJnpG3azzKeh6Te6q/2TVOn3xEwG5PJRIeqK0Gtn
	 en51wEzVRkKGNYNbzf5PGwHfrPWDg7aldZSOIbfT/E3AbFqb05G8pt52xHOb3B9Zuw
	 oFkMbiwi27rvQ==
Date: Tue, 11 Aug 2026 20:50:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, linux@analog.com,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to
 title
Message-ID: <178649942462.498073.6096793289071355326.robh@kernel.org>
References: <20260805094135.11762-1-andrei.stancovici@analog.com>
 <20260805094135.11762-2-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805094135.11762-2-andrei.stancovici@analog.com>


On Wed, 05 Aug 2026 12:41:27 +0300, Andrei Stancovici wrote:
> The LTC2499 is already listed in the compatible enum and covered by the
> description, but was missing from the binding title. Add it so the title
> matches the set of devices the schema documents. No schema or property
> change is needed.
> 
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

