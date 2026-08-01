Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724148988E;
	Sat,  1 Aug 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548690; cv=none; b=KFPyRKeFOCuLCWCqeeNTISowhiZjX3HnruO91ESoUriErRofgNoHZtYZ/u4Dw/9sOTu6gL4jeIWIXo1Jc1meE9dKc4AeGUCWqqO40HpjAF6rIXIp5tEp1jMBLCbPcXoKR8dRXMhVySzXnd/h+ePLqTf0quHKN7iwQytyZHBL6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548690; c=relaxed/simple;
	bh=OyEJ2FjGrdlUIu6RlXa6ivxOuEw3ctF//W0KbL8i6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHKZtAAIadlEBVZ+zXxZy1UBRehl3B77yFwsgsMHl7bImhcK/c8lj5JxBBClfP3LTLZI4E4afYSHpb3669DlEHj/+BnutHBCI6gC4nBElelksmYAaQcOE+7PuZWvTlCw5O/AZEjlfW4UDFWHTxmFZ4ClOlVJcGMW62thcGy/CR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuvVUmMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuvVUmMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBEF1F00AC4;
	Sat,  1 Aug 2026 01:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548688;
	bh=vcL2MQ0L53z3f4PzFpgfMlNLyAs1xeASuNlN5kmxois=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QuvVUmMVC7qfCurZ7pQA6Kr2AOCRvrRz+AIoNsyBtY+HZBCzD3SF/e0q7CfQ3F2j2
	 /twEJPXNE6eXSkcp3Ooo7+LwAh/+hXf2mDhIQGQZXiQEKt8sy5Wyc3uHAUwhWm1ImF
	 mz8fZquP208z15e2M59odTDJa3UQHhGeef7p/g0YPo/3XVy8ExIYqIO1jvxNyxP7sM
	 U/cjYIM0/c01OK76lKFZDclxla5as3x8/va9NNBj+4TByazK7luLA+lLYVP6+h0DQZ
	 3WC12Fduh2+ZiS/IUKweDa2MRSbHIhCB47DesDsftS69DFW8649DT+s7A0uaWSLWVS
	 H6+X0hqTdhhwg==
Date: Sat, 1 Aug 2026 02:44:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
 <joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/16] iio: adc: at91-sama5d2_adc: adapt the driver
 for sama7d65
Message-ID: <20260801024442.49bfad4e@jic23-huawei>
In-Reply-To: <20260727122633.117435-7-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
	<20260727122633.117435-7-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 17:56:23 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add support for sama7d65 ADC. The differences are highlighted with the
> compatible. The calibration data layout is the main difference.
> 
> Update Kconfig help text to mention SAMA7 SoC family support.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Hi Varshini, 

I looked through the rest of the series and don't have any other comments or
questions.  Thanks,

Jonathan
