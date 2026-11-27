Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822716;
	b=vhMizEil+wn/WEIH0IwEA+D+NlFaMnDqDPhopX990HpP5PXqh8dybfhXMozr5isdG7hV
	 1pWz0e+eAeBudwGWGL082QsUZHXSCKOoRaF7xieCy/6G4Z2XUHAfqgv4gXvsl39AzINpn
	 lUP92i2ha4m8bIstGMQYFrva3S3kDJ9/c/T8GIJefFuU20uSGlYiscQUlwE6cK+DZXJL7
	 UyU7jf8gK5YUbCDyKCl/2OHNfMMYJe/hIFDZiJPeT7JmimMEzRHBQ2L/jiST61sNIBaVk
	 5K/QdWuWQnpeye7Q3WkoXHfBPJxdguTLAM9eQqNC/G5DPuCnY6abUM6w5Sb4C99wlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h/jWoY+6pagE3qJ20cADEGp5YFJH3K3J99NjHZMsL3Y=;
	b=fbXvR7F+DxJnkHR1blctcolHqC+YJqIpP+mCQnZCo2soeVK/2hKrPpDxaWW/RCDc6/2m
	 ZOpSM+DPmxF97De5sRWkN0PDfIWPdchlZlq6xgv2c2wk7HGYWLSJ24RNBLa5CVSQ6CIjJ
	 xlxuV5J1RjO8hcKYTXhsALiE5iiAT6HIdZGWFLzG8c04Q7eP93OIb0jt2gVXlMlFou0aZ
	 PnsTu5Vtzatqjr4u4tsyzP9UCkRgEdzNJ0jq7H8AFJuVQr5WNA4acWbeS61AKe18lUJtF
	 Itu8pqxksQzenox34PqGGSpohrmMgDoQ1vbnzCEH9hysp22TwYDW9BU1w00yVpcWlvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h99WLmzO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3C606A31C;
	Fri, 27 Nov 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h99WLmzO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744C71F00899;
	Fri, 27 Nov 2026 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822715;
	bh=h/jWoY+6pagE3qJ20cADEGp5YFJH3K3J99NjHZMsL3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h99WLmzOdrvV8boDVg/oevMa6MEyoKJF1+EKFs+Obe+jLQTSS5RTPC1zWZ05GUQTQ
	 Ab5es5K9ELBC6rsW8OTxuQQkTLCx/hgd86/BwxJqtI5+V3IjqtvlPZhVVsno1tTRBE
	 UzSUFJsix14OACA1acSyv5Wy0nDKp3foYLQuMrmxrrAGGep+lO7apfL6OJ436SKJRw
	 fRyETSVUM9QLtC3ydP7b24/XhSzZ5xZe3mIgvbP7x2OstPATs2+IOHYKQROdkPw3fM
	 RNNfvlz6pz+oBeziGEsweQl7r81rjp7TkNhUSYRnjxPdYCtiN+9Njd17L+iJm8MuBt
	 rSxVS7qHOMDJQ==
Date: Fri, 27 Nov 2026 23:38:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux@analog.com>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: Add ADA4355
Message-ID: <20261127233828.41fe61b5@jic23-hlaptop>
In-Reply-To: <8813d3f0e71d8917d13db74e4432002bb57548af.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
	<8813d3f0e71d8917d13db74e4432002bb57548af.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 18:52:57 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
> converter with a serial LVDS data interface.
> 
> Document how to describe ADA4355 devices in device tree.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> ADA4356 has a different set of selectable input configurations that leads to a
> different scaling factor to get to milliampere units. A system with ADA4356
> matching/fallingback to a device driver only supporting ADA4355 would get the
> wrong _scale from the IIO device driver. Users would not be able to accurately
> read data in milliampere units. ADA4355 cannot fallback to ADA4356 for the same
> reason.

We'd normally have a short version of this in the commit message as it is useful
to capture for the longer term.  Provides info to those who may want to
add more supported parts.

Otherwise, nothing to add to our friend Sashiko's feedback.

Jonathan

