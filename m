Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1F157487;
	Sat,  5 Sep 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573280; cv=none; b=WTzNueXi+mNyV95uC2aNZineDkeQsUM8DTi217hoiSC2m3dorfDDnRDjvedCrXn9oPToMLOcyFDCr6Eyl1YwetIPeRRYmuVx+YCUP8OC4w/QNNZOBWoBZsHwLrf9aHoUVpPygMREVRAa+dMo9vXsMllS4Fd7G1GxedwH6njLu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573280; c=relaxed/simple;
	bh=/AOLLvTTuyVsVf1WBHMYhqaApTeUERzsKCCeLnyvpKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8oPNO1bsYlRjo/08CTLYeDW0Y35vOQPFU3CrzbA0AiuZ3hLFH0GWnrVaLZwqXagTrrGrRp087Z4oxHmm9mdU7CItEVt4VZPTekzS/JQjOoLXsXrQmvgTXesvUd4dBIL0aaTWZXeETxiT6BMJaDvTuRdFcX1nDQET+nt40VzUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWu+fuaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWu+fuaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168331F00A3D;
	Sat,  5 Sep 2026 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573279;
	bh=4MJcl8W46wmt24cCDnHxwj7bbU8/1Quzf4Ca/V5P5wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dWu+fuaIHQGGxEBbTuXRWfpeCDAUcgwvqZqYLiHWMaZBvY+8gi2BZOiIpXf7DNg8S
	 X5bllaVPZw8GOZe1MvXK4xLu/gqGi8O1lySE5ohZguUlCiFdq4pA+ewQwc0rHzPWro
	 iuaK4y6FmmKVfNXUkSPWEEtu0VYONWPXrd07Piknl2YHDTji8XnJ8fKNDINKokSD+s
	 NARSQdXAOfgdG/3ukIcKuHUM9R7MqXWm61vbjA/B9/mmRZxfUx+bZZUvsCZ3RwPW9I
	 fqHErchyUVBSToz3jtRTH6uNr58lnNOJdyNixdNIl+fishmQVwX/0yFTALBMt+Prwn
	 QQfqErzciSs0w==
Date: Sat, 5 Sep 2026 02:54:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
Message-ID: <20260905025431.1d1e4d1d@jic23-huawei>
In-Reply-To: <20260902172230.5234-1-flaviu.nistor@gmail.com>
References: <20260902172230.5234-1-flaviu.nistor@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 20:22:29 +0300
Flaviu Nistor <flaviu.nistor@gmail.com> wrote:

> Add support for an optional label property per channel similar to other adc
> chips. This allows assigning distinct names for each channel which can
> match the schematic signal name.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
Please always use a cover letter for multipatch series.
Makes it easier to handle them with tooling and also provides a place
for general comments etc.

