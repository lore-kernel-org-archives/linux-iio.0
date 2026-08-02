Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBA2264C7;
	Sun,  2 Aug 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693869; cv=none; b=hbIrZnrU5gidQ1BfvR032Fv5PzLhXWm7p0CXSaf9/cC3g2NATDVLvZhJzv8xWHLG/IES/cWgxQ2eDAfbu9nmAUzwjn/Mz8+GnGXxFIZnn+iauGFKTc4MlSNkc0Ucm7zH3yqv7TVB7L3h+ovNmFu5IJuJIl6kjXtvrNf8WvBsRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693869; c=relaxed/simple;
	bh=zmeFDNgD2J7sJiGEpm404uH+UGsAjIgFL64F50ar1Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0P6+t5i1rYCnCrbHQl3NUZbVMb5vqkFl/PX7g1doS30pvZvsbKivkpvY2KzZbDCFho97Z+MsWwq5EPi6OI9XsDc5Ncj8mFrIxEgHETb1Mq7BcoGfBuSdc+9y5UPrPvoI0F4H1xDmO9MY62qGyFr+UgEhQiKt42qHE1phxTHjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K45mERq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K45mERq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F52C1F000E9;
	Sun,  2 Aug 2026 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693867;
	bh=h+dDAtKfMnCAQZ4l+j52+VXsmQL9O1xV9kYcHsWbKtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K45mERq2ovowhITJmeuhjKttKAlF55qFb9pj6Tg8MpGzhGmFewN+4j/8SgjU5uDBf
	 7mhJ2Qn0Fp+2XxSI8w6oaraLhLwfkwkB1c56FpoHIDQLDyXH3NQRzXMh/LUqEXD/pf
	 5GmbBwZGf+mPY1lY/gEtAu+vFdgYAbsB4vddfbQlmgcO0+eCyGWycj8YdiJD5xFhQX
	 E6bDy340HAwyi2gxP1vjPEkoHT4cxIj0Wj/AvbpuILoa37FCKaFTsznMDX2c9AibAV
	 KIcvtLsQMLotTXU6vnufIwXqaY9Gcg/LZRT8VNNcZtG3hR2B1KS+aMnIVR7A40VnZo
	 QNA0AYIKNtDVQ==
Date: Sun, 2 Aug 2026 19:04:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org (open list), linux-iio@vger.kernel.org (open
 list:IIO SUBSYSTEM AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: Re: [PATCH v2] iio: Update email for Maxwell Doose
Message-ID: <20260802190423.548a98b7@jic23-huawei>
In-Reply-To: <20260731213911.444306-1-maxwell@maxwelld.cc>
References: <20260731213911.444306-1-maxwell@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 16:39:11 -0500
Maxwell Doose <maxwell@maxwelld.cc> wrote:

> I'm transitioning to a new email, add mapping and update MAINTAINERS
> entries to keep email up to date.
> 
> Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
Applied, thanks.

J
