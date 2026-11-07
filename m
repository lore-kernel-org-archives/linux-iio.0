Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090969;
	b=0uJP01Kg1DfB8b1Gi1fBRLgdqopqEV8w9sQWRM1hsRa0LQ8NcivMEKANy2bRiOIpfJlr
	 AHv15I8JeOKHXAIL7TfHYp1NsXzkwBxUWwowXklkQISJFKQh6Pm5nl4fcLB0s5v/mXwdf
	 0C2riRkWQYJqvw3qPoSD6/IeUoJOjxlo62zAkIWfkSX+Y6NrTseb4z7ndTk9djbcOerIW
	 QOgBPVMtfBbe1B3pscyByM7EBycYaA9He2azSXevsL6gP8D9FKquX8HtpvxjUf8qytcy/
	 rpGuK+wC0cxlkjNEQy1cYBAi3tQU029D7ErvTZPjKlyNfnJ86sFSlCq/god3DLiWtlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090969;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DhangAGvmVCIS+hDPEPisbOILnqFpCMxX21ELicINj0=;
	b=W0keAe1XAhREkKbzsd1VWATGCoHBR4SRZ8qcjiAtqvCLyvSEsJaWZV3+a2s/dshik70D
	 AhdxNyMFo7vnMRtSCh9a5ld0cxWz8EHMdC3ewdI3Iw7Zpj8Iuu5bOGcop3AKmit9bVuft
	 vDpJnUmG2nYbqtG74LK/pTQQNtUFh57hif/yFhJ5omoaqoP9Qaogh6K4NlVjKi0tPFheY
	 cdJgnnXtOqG/Mkwq+muH6uUm4wjAQoWtFEBzGKP2ooiKiJdEeUE77E6G7w/g9Z96RgCEn
	 Ubh/ZFFXlqsKX3LvAg+Mi4bAWYGkvvtP/hVPAYPqAmw1DaVQ2uuyS5HRf1An7/PePsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la+2gmFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F5606A326;
	Sat,  7 Nov 2026 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la+2gmFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC051F0089F;
	Sat,  7 Nov 2026 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090969;
	bh=DhangAGvmVCIS+hDPEPisbOILnqFpCMxX21ELicINj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=la+2gmFA4t9FBB/TFLKuyvQnZsilPiL1b50mQTyaCcPN0S/DWmMfIOCs/Io4iBpFt
	 FeivtUJ12eJU9vbmY8VIXaOerwvONSXxq1L8FDkHQLL7rfQjD7MpTnzZ4kio1oN3Hq
	 ScQ29Xpdb0YJtSznyDg0/Nw4ZlkjUNOP8h9EPNXCbgrMbKv3DMXLBd7tVdpVeMh0QC
	 QwL4NaoB2yhx+hgbITUs4+f/oo8hOS5eqb7dmnr2/dLUedURIQubJf+hfQW10YesUE
	 Gyh0Lxxsv//DkUMCpBAeV53rMPtkW1M5Kl9J4Sx2RL42EAthZ1CofuvIkyUbzZwbkX
	 oNqQgnE0bRUBQ==
Date: Sat, 7 Nov 2026 22:36:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply
 support
Message-ID: <20261107223601.0ba9ffc6@jic23-hlaptop>
In-Reply-To: <20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
	<20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com>
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

On Sun, 08 Nov 2026 00:15:03 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> On some boards, the chip shares a power rail with other components. If
> that rail is turned off, the chip can't function.
Not sure how the sharing is relevant.  Even if shared with nothing
else we need to turn it on.  So just mention that on some boards it
isn't always on.

The only reason this would be optional in the binding is if there
was internal routing in some packaging or similar that meant there
was no pin to connect.

Upshot, make this required in the binding. Note that doesn't mean
the driver must require it - we are simply documenting that the
device needs power. 

Thanks,

Jonathan

> 
> Add vdd-supply property to document the chip power supply.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f655a570aac7..114cf87eb54d 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -37,6 +37,8 @@ properties:
>  
>    proximity-near-level: true
>  
> +  vdd-supply: true
> +
>  required:
>    - compatible
>    - reg
> 

