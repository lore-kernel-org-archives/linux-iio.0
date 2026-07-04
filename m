Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E5433E7F;
	Sat,  4 Jul 2026 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209220; cv=none; b=gtyeCS14bATb90mQRcgcdCCiu190RY2Y8Doco0l3yoW2dlOHfyoY7/QMoAGh0oZiDrKpAcG1zycIPiz/njqG7njkmSxuVAK7wceQMGaqyawcROcXuSIicnnHgLH4YMwWURhOQTxswL59K+kLKSAFeuDovWE5CYDzljC88cD5ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209220; c=relaxed/simple;
	bh=0VLtQdyq5UZGHJEbEc0i+jjqir2HYEAMbvgB0pe/RZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I70yQr5Z7bOvdeL8E8KC7oBfSF+teO17I0XydI4dn7tJuQa3R0nN62gcUHrMWT2VII1GT+gSunpRJkyexQpiWZNFPBUdNBUvgXh3ee9kyPDphKS0tZLkiQ/cv0Ujus07GV065lwk+tf08nk5BVH8Tc8oDLTSEbtR1x/10NcMzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoYLpjAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoYLpjAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAAF1F000E9;
	Sat,  4 Jul 2026 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783209219;
	bh=0VLtQdyq5UZGHJEbEc0i+jjqir2HYEAMbvgB0pe/RZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CoYLpjAnixKkqcYDlbBuAuqy4BKBjqxyCU22/MWThaTy670q298LGu0jZCivvzqWa
	 JO3kuFQB7sFNH9Ma934zFbWFqcAQbJZ4VrhfFJTgShpAoX/0PwbCr5z31aTC1UAyD3
	 i7wimOMGU4EW2vahTRo2o0K6O6j7IImfrRjlCYWp8YMZIAp4Gkbddiobes54Zvg9Ho
	 7SuOpc974iXNvthe7eSN/lLp6yha6yZUhTOL8oEqbaPmb5rqWtmHqjS3j1b0YDm2vr
	 we40MW33J3d2nJvcGwZM1oOqZaFy+ut9zqoGiu2Bw191ciS3cAE0ZvIE69u+/fRQOf
	 nttLRXiyg5ZFQ==
Date: Sun, 5 Jul 2026 00:53:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/6] Add support for AD3532R/AD3532
Message-ID: <20260705005332.3d5c5cc4@jic23-huawei>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 18:10:05 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> This series adds support for the AD3532R/AD3532, a 16-channel, 16-bit
> voltage output DAC, to the existing ad3530r driver.
Applied to the testing branch of iio.git.

Thanks,

Jonathan
