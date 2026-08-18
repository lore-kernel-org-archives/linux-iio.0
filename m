Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1E1C862D;
	Tue, 18 Aug 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018837; cv=none; b=efctVwZvcVwFs5c0FguIQ9iDo23LzTsqy4Q7W//P1iKcpWoU3gKHiMrrgA9FSzyNzucDKBnXNRaTvmRb5b2DVGPv9P4JGKNNYA2kQLJQMwZ2z/4ika1G/RBJWFKf9fsxe0FbvpyIG0AT/mHmU0GTLiLrDuP+Z1MMYyh2MPS7K4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018837; c=relaxed/simple;
	bh=kXubcTmBYtZ/Am9m2cRMO5VecS4Sbxt0HtinmoMAspU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8+0fMOePN0Fzg7c8mG+//4Q8E1QTnBZIc56LTPn8jkrSoBb+2bVVosugMrr9oU7nP3kRrFo0NdilHxBFd9MYvcgUxmEweNMC2WV5/EVaMqQqdxRzbwNbNZmzIMeTrIbuijk7w+hVgtKz4KMV/ZbnxBHGXRgrzBW892HJ0eVac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlzyTsnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlzyTsnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8171F00A3A;
	Tue, 18 Aug 2026 02:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787018836;
	bh=4Twm40/J2sIMyzBqukyBfE0U96J7aDjmNtT9OUOe934=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IlzyTsnMemb2V5tgm9Et/RJz5dU0jGPuTuQj7gTlRMPJcqd8VTHTE95RnNxJmaIsf
	 NIwdbVnPPkLaNwpofTtvtZjn12yioC1OtPQ/wlWhDQLsJReMACM2wI1LaPwHUQ90ff
	 1tvaNHmY9+B//cCU+lcMtj3mSZYiX+T/xbKNRiiEgfpkDWw/7/Zi5p3Vzd/4873w/w
	 s9b2VnVKPJP+lVrXPprEFrFjgstT15LcgQLfRNnF0teLBejOZfENc3ks/F3ySR2is5
	 Kmczu/FnNOo2zqKdpEGj4TFYsFJj7/j/hjn+Z3D3l7Srl1MeLp96yyykN8AIuR1Eu7
	 GD61ikN+7wdHQ==
Date: Tue, 18 Aug 2026 03:07:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Petar Stepanovic
 <pstepanovic@axiado.com>, Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260818030710.146825da@jic23-huawei>
In-Reply-To: <20260817135920.0000461d@gmail.com>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
	<20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
	<anoYDi-bt-t6ZeeD@ashevche-desk.local>
	<20260817034541.053dac28@jic23-huawei>
	<20260817135920.0000461d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 13:59:20 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> With the diff Jonathan sent in mind,
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Added.
