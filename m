Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592630;
	b=KlavzJL2gT00FmP32JvSLr0X/J0/2VbbLbVxpjoj7kpYO/B7eTfGLW/A5a9Z8Avqi10l
	 IkdPBp8w/v53vUIiOVgYRjUezNK7Z8C9fkcU+2aSCY25gNe3mG+h9J0265of89NJ9XtqW
	 ITh9ztSj0kURE+EhsoM7rfSKpw49evNNZkvQizChUU4/9y1YvrNrFZsTi/SSDZNF1gBPW
	 LeZRXyL47APXn5jY4EUvVYQCe6aYAwVt69DB6bLiBKo9D+t3zLE/tD8YTPEny8VNfL3c4
	 BSzSpjGEg7Jg4qnS1oZF4x7TNdADS//I/Dxp05sYl5HNgQF7l9oIvZye1ZEZkhPfzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592630;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=vUXThiVJ6bMe52lRwX1g6CBsmoON8XesHCjvBEoaDQA=;
	b=JDXW7jk6CycNppwASKKnwiWeP/I5n52yomnGEoFuoTBFYF4jog3vYDlUXNhbWEbCMpFZ
	 kbQphe/yNtQmquQlHAFE/bxObsCafVoln4En+o2+cSczHcEHhJFP804gN0aE0Ld4EN6le
	 6BR03vL5A7b7yLW5QPZhqCTRLniPho7DxnRQfLLZy3ZfsY1rwM1y9Ua4uGe8kaLDV7PyX
	 wHalm01MugopnXVaciE11HnD25VfQu3s1xLc24enDZ/wunX64q5qrmBBKNtpEtN3lMNqI
	 JpfS3h2XSyJ9MhJo9ze6Pldh+6mc0wiAJOYfGhxHEtmI+9jCYB4xAhNovpFsAQ+GVig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+N+Jel0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38780606A31E;
	Wed, 25 Nov 2026 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+N+Jel0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B591F000C0;
	Wed, 25 Nov 2026 07:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592629;
	bh=vUXThiVJ6bMe52lRwX1g6CBsmoON8XesHCjvBEoaDQA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=i+N+Jel04pnI42CpZWHeFN1FoGpya+vih+ogo2zO2HAttQ88xS5X/gkqMOi4hXRg1
	 ih7ySjq+dmIS3ApCkUHFnKhxHP1GywJjCrz0ucrlq2Pp9Gs1bQEE/KdQUlhA2Lm6Cq
	 hI+VrBz9f33wDeiGNkJghRFV3m5AFHL1ibmX8OWnW/C0FOb/hMEfKYk8GpDSU/MT44
	 kBu9dZzEHu3lQaB54n9TN5O5GFrYpfdgUOyvKSBFo1w0Dz5ixndV5AP5sL+YmWettM
	 FiDNoUDv65WHXrhIqr3BayR/wyx2fCN6bHMRQ3Sk1Er1mQ7OXMGEumzg7s3NNFZAXT
	 z4US67F+IOfKQ==
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: add ams OSRAM TCS3430
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Ijtsma <robertijtsma@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261124-iio-tcs3430-v1-1-0f2a38a6a4c1@gmail.com>
References: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
 <20261124-iio-tcs3430-v1-1-0f2a38a6a4c1@gmail.com>
Date: Wed, 25 Nov 2026 08:43:46 +0100
Message-Id: <179559262610.14607.7329551323239028527.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-24 23:46 +0100, Robert Ijtsma wrote:
> Add Devicetree binding schema for the ams OSRAM TCS3430 ambient light
> and CIE 1931 XYZ tristimulus color sensor.
> 
> Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/ams,tcs3430.yaml | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 58 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
