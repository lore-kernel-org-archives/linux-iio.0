Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945879;
	b=nHE5+lRLyONoPDDtZp8uN7SIkiFfYVa4S0wgS2l9RgsrE5FzoA3EbopnxQMnJHV1yTN4
	 1bjUciCp5COG8fy8HXoQg5+wVTdQOAFuYiuI9gLEH2bwzEJ+AJwnSGOxALw3u0b0eZkNT
	 UCHmJ+DHrwiv6XtwauEenzxwR7DVUjTCn08cB/zBKOJ9T0Tn1ELxDvMDQZN/RmBH7RjOe
	 7TpqGqsHHsQ8HIEovWpi/wdJMQp1bbGzcRVduvIHngJ+QeeNWCMI6+7CtqgREK6NczuOE
	 YwMJl+yOg1AB0XVXsb9+9PH7DxRfN30aw5759qFX/0tcLMnX2FC2sUiXAfJp4DK6XyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945879;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XjiiH9vEp71/nKv/afBhmdp7G4Z4pntmYOkq9YJDSd4=;
	b=hvjRd0FC+wXuDe9mTM1Mt11paCTQRNHY2WUQy+a4bDSkUxoSVyKMDFsQXacTn6+PLRQ8
	 0lqmpLv/vTrJWUYloWsUPxqgrTDHuPEFn9yBmr33/dYzWOtamq0fQONPSWIPybqggmILB
	 0FhWocFWvYQ19qLPrDU9vyi1nPJzBXzX3GBNlv0ehe88zSHYjdFu19Ve67nOOtHtj3al8
	 qoREAMDbEhc8EuRrHyThbDy5D1w5c7uPCcfZov0XQoKCdNSxl0bErYGQ7xXha5yPykrxy
	 UKLQD+8aXj9G82CW/hU9/CY1CxEg6TSY9xZAP5LVBv8OeIzMEs2pSANKGtq15in1hgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D2606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 20:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso87747a91.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 12:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945878; x=1795550678;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XjiiH9vEp71/nKv/afBhmdp7G4Z4pntmYOkq9YJDSd4=;
        b=ryhZQsfuT7+hVqYLfFZrNdGJDcXvv9O4XUmb2MFw5PC4+vHeZLlz6afahWvLZRW1R4
         apAH4wu2Du0toPuD8MWaW2tcFWV2OBJTn9Up+ZW+9n1OF9dxEmpKPaW1749vYhMTMjqr
         u+Fr9VCVj6QBRInFHQNm21BVJll3XBiC6h1QCaHSXynDhPHCgEA5YxrWI9BH3jzwPC2A
         wXj7WmiZNZ4ONWjy/3RztNOe32NSvwczxt96R1h+WPeTsxM5f4vUaoTQ8J53V9OMNhkQ
         fQ6/PrdztciwsnJf98w8zryUqkOVvhZ14+RFy6Eiij/ZAoVOSOnON/02LTP1TFDc2RJn
         gWeQ==
X-Forwarded-Encrypted: i=1; AL+hErHnvsrkq00iVKaZ0tvuxczNXtkvaaxJZcaERbkvIdlbIGb8PcGxXzBnPiCqsjOlCbIrwcCJrJPvIWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NIKFXYtAfAmlTLHVrswCbuqSZ0/pYpe2perQ2hfvDnYkrf+Ul
	h0ftLMyGwunEKtJL/pxTnWs5BsGTOTotNSXRw3DGixbIfWS2N+mqdefaxFPXNJle
X-Gm-Gg: AZFdTZfVdtjR3/4E+k+k4kUvxvXTNfLwJP9llrBIelKqxN4rqNzJsK5FdRQMhHvmwjR
	CT8VCt5rtftqMbyIc1Ls7oEEKhOV5jzNqzkaNGBRJhjLPFn7IImxh1ZD7wBxQc+hvH7vVX0kTJz
	fQ4KHYM+wIN/rg3q/PkjPT19OjylgGWK4DDEcW4eQGpYsZbdysMQfnk7U5nZKGKP8vMRZTBD//8
	Ys/hfkoxy0sLcHisbBQ/XNufrD0T3Qx8mt4+2kcu5KjUFMoo8cNfsi04r+5ofjTeoO0eFCDM1/5
	wVO+h+hxQVPDK36fheOJm4wpbpQ8BfuFe8OOSNTUEklFeZq+3B8UjrWcRVNFIeELV5mIGhkAmZ0
	E8j2XWbmKjhWzBCgRdtNUmkqqJzjX4DJgzFgtht3U3cwqjRwiBeMnHOp/xtHErpORaR4uh6mvKq
	d+//Zrd68Z7701mF+DmoqroBN+VpC4VukBzAUWX85QjTeGuTkWwGpVz6SfUI4hIsbgyE55k234L
	uRh1O7ivkm8jdrTlY0s3A6j8U9IHjmCyn08EVk8jHlDdlJrjhzM6chske4aW0xOjRcfbHfHDsKH
	Pfmt5kw5ZLCJ1gOkqsHNcCHiwnYgKdasDNivRf2JIEvIyARnFhsqWRyZyt9bI03qHtfE3b/MXJE
	x9yjd2JPGooEhZP9M/CrfCB60eoRZOPyOmk4XAavnBoSd
X-Received: by 2002:a17:90b:440d:b0:3b1:83aa:5b53 with SMTP id 98e67ed59e1d1-3b3d07c28d2mr437615a91.58.1794945878034;
        Tue, 17 Nov 2026 12:04:38 -0800 (PST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com. [74.125.82.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac4d98b8sm5315647a91.13.2026.11.17.12.04.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 12:04:37 -0800 (PST)
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso467386eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 12:04:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHMeACoe5ODWJ0v2sfASZnCVF2ilNRTxiBMMqpMQIVLIWy6Q5wVW2W9cx4Fjb5vrRnVUSLKN+T4Kg8=@vger.kernel.org
X-Received: by 2002:a05:7300:7314:b0:381:1580:cb4c with SMTP id
 5a478bee46e88-38281023cfemr582427eec.24.1794945876970; Tue, 17 Nov 2026
 12:04:36 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-3-ef6b7c06d4b0@telaak.dev> <20261117-object-glutton-d948f8e36ae4@spud>
In-Reply-To: <20261117-object-glutton-d948f8e36ae4@spud>
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 17 Nov 2026 15:04:25 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6dAt1YGcd_u6SJW6A_tBUZrZUZyie6W9Pc0Q3NHwXGYg@mail.gmail.com>
X-Gm-Features: Aa3M54qec_C2Pi8qcev_6zb3aM3vk4ZjOhmwBtJpitJBxkWn2QAJ5tNJXdTE9jc
Message-ID: <CAPY4CJ6dAt1YGcd_u6SJW6A_tBUZrZUZyie6W9Pc0Q3NHwXGYg@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: iio: potentiometer: Add Analog Devices AD5246
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026, Conor Dooley wrote:
> Why is there no fallback between devices? Do the different resistance
> values affect the logic? Please note that.

Yes. The versions differ only in end-to-end resistance, which the
driver reports as the channel's scale (R_AB / 128 per step), and the
part can't report it, so none of them can stand in for another. I'll
note that in the v2 commit message.

> Filename matching a compatible please.

Will do, as adi,ad5246-005.yaml.
