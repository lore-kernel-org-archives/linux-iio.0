Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379911;
	b=c9jjO2Z2I00bHUp/Nqcz5dtL5NdWWDa6WgLIoK4JbytkMKR+Ol99wLyNTO/i8s7Su9VB
	 /M/44C93pkB+rWo1SXvvMnmgPwQRmbwvY1nKXWmyTHcn1Bs/eAHitG6jzeaNF48Sg4qqk
	 o1q7txQd+xBP3LbJF9F5prgz/Sf5AInEvNdYM4XNlFG7RTTy86zyuq5ffTDOzYADmkRrr
	 7vO2yEzCHr7vR1cISwJciTPL1C+p5k1TjSv5rdiP8rzvHs/SFREJphYeTOqqYwYnPOYmd
	 Ef0GlrLKncEARxH4A1V4BeCgMXMKYhnlPkP8RqZb5rLq+39ft8eDjPr0Abco8qYVGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379911;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=502iF91XeobRM5bHAgU3cwUNblInjy2fvN2qbJeoKfY=;
	b=PVR1iKAV5wKtly8Q4p6l1/EpLu4f1av7G9iKTZYhQxG5D/GP6D0tTsaah5gVjixoQdrC
	 czwgaxqG9PX9vtg65R0ykDi8Vdi/tcuhlOipKEo1JOf5HKfqQCX0tE8M+eS86qyK5l2Mq
	 E/UqtOVLOMbiQVkEgNs0Zty9fjdPdVB3D6uxKKOxkJmfDBnbTsNcIetXeI6Gjh2VIgbaX
	 itUGXhsoVD651NeWSB/fljgodk11VyoCv6NVveLUiRVaymcXQb8P+Jmt1NULhZC0XdZsj
	 I2IOd7st5YpFyGzcV7TZnh3UaQhdsNb2Y7BkV8L0qNlJr+7aaPN04R9x6wdcdHuSOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aEY3v/TJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF75606A31A;
	Sun, 22 Nov 2026 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEY3v/TJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87C11F000C4;
	Sun, 22 Nov 2026 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379910;
	bh=502iF91XeobRM5bHAgU3cwUNblInjy2fvN2qbJeoKfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aEY3v/TJjyOLFzdPpr+wLUW8lYbAh/3fqMvgWrPRpdStErgo278vyYX/ILRbiA1JR
	 MQ9tjVLgCreC2Pb2cPNy5crJAr85eetxnkLuVIg5ATnnnuJzEGTAAby3WYxzF4st/+
	 KAHkNqmvCP54O/vWPpeBw6nxdyvm2Eo7JT0qBI6GnSQ4k/ZVqRC+jTnNO4FsA360A1
	 LfhUywXgueZRDFK9FAiUOeuVcSVEF2cm8aB539bAePqfrTUUrS+FjL6Yck3RLLHTi/
	 CQeKUVoEDf2sBQacXgidB0Zv5e0e25cYdUTtlvJ7N9V6i5v+7dt1pRSHEf3UnlrgEf
	 QPDvOs3S5W9tA==
Date: Sun, 22 Nov 2026 20:38:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: pressure: dps310: data-ready trigger
Message-ID: <20261122203826.29448f34@jic23-hlaptop>
In-Reply-To: <20261114083828.18059-1-zoone.rupert@gmail.com>
References: <20261114083828.18059-1-zoone.rupert@gmail.com>
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

On Sat, 14 Nov 2026 10:38:26 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> DPS310 can raise an interrupt on SDO for each new result. Document it
> and use it for a data-ready trigger, so triggered captures follow the
> measurements and are stamped with the interrupt time.

Looks good to me so applied to the testing branch of iio.git.

Thanks,

Jonathan
