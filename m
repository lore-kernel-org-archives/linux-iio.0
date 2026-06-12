Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5633CEA7;
	Fri, 12 Jun 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286460; cv=none; b=CXdupW7vNTIqqCLXVMVkqaEMacEaDnAYJOfZm3DARYX5RtY76MI3c+dVlooaOEzPVxbXV1BobbvdXp0mZNk3/cJKMbj7UDCe2Gub6MS3JjhsFiAlWIq7u3/oFxVPxAX7EmpG6RfEBPW1W7R9bStUawMSo+Lx4STy0eaaNwvj5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286460; c=relaxed/simple;
	bh=8oIhSfDEBAL5PNUzU+kQvWvCMy0RABzWiIVT1xpfcPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGS99nxDwNiBJTPNLeeusA7sjwmqay7pIrwYLkSEWVcCLzbK8EgfEDUioAuqwwAnVooyeoM8+bRnmIspekH+ol+lmvSkHLGLIOZbVKSeatzoe9ZxtkSpzKqajlM+kDDxbbQhHNNSUhTesfsekWWFBSZVVu84PMoKp56CbLPW59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEo822KC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEo822KC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A1F1F000E9;
	Fri, 12 Jun 2026 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286458;
	bh=8u++oG2ZPjZsczXp4b3WPdxtDV26Zx4lTOT+5rxQeFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gEo822KCcn5Z++ECtm/9tP4Gt2nZV7ofls05wm/uwfS5cb8T6SzTQZDfmYNNl8nzU
	 eeATQatsle8Q+qvApmmGP5qPNqsbARlPRiodYBD5OJQR9Jse0f1VYXUdhyDuG0iuiO
	 ToUHuGZH1ozsiHmxsLlv4smYJYO/u/nvCQpq0/gCdoRl0umBZDWaOIvA1ot9h0fGkA
	 H/LNN8FSHtuZKE3RfedJ7vQKxUaoe/anZ9Gl4Dx+93EvRTQwauVU/UGxrdZHer61db
	 UTE9fu4FIM2WT4/AjRzTg5mvwO6DvSc1gaS8VBzeysQB1itWgPagVizfLLeLZ+Rq2p
	 4ifuaBwGClBUA==
Date: Fri, 12 Jun 2026 18:47:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260612184729.795e0e84@jic23-huawei>
In-Reply-To: <e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org>
References: <20260611132700.671322-1-wafgo01@gmail.com>
	<20260611132700.671322-5-wafgo01@gmail.com>
	<e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 16:01:12 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 11/06/2026 15:27, Wadim Mueller wrote:
> > +
> > +static const struct of_device_id slf3s_of_match[] = {
> > +	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
> > +	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
> > +	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },  
> 
> You should have only 1300f here and detect the variants. That was my
> point when I suggested to use the fallback.
> 

I'm lost. How does that work?  They cannot fallback to that part because
it relies on in driver detection of the fact that they are incompatible.

Jonathan


> Best regards,
> Krzysztof

