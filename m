Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831559;
	b=AxbEjddGGYGZxf4apx0ZlblEMprvZYatlVkZku5AvhjNqP1Di/Zn9g4lGxIO6maJOr4i
	 fSuzKT6Q0NpEF6a1Sc8xT6JN4piFf2qGdB61R+k7/logBUoTBxfW9WI1v9Is/F91yGugz
	 0KUxIx2Q/9eWD5KEfNcqtwytwStqtM/+mCmXwfXQVEOpm61MCAjjc5U/DD6PUS0d8qE8q
	 nlhcq3Oh3a5qWKxozempj0JMiYLqrfcKu85M+aBJnoeYPRhb40ea47yD2O7vMGaf3Oryl
	 4tUH73J43Deyj1DxFdR7qeFIeqXFN/vdeMBaqQZKjnY346zH5GkXs0lgmMwW+x7UhMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831559;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PsHuO+dYPHrDaL7olY6c856oTYxQkKQxCg0cq/BUyYk=;
	b=J0989zX+e6x2gRLdZ8sBQtMOpKLmuA3uVPgpbwKXBoH2GEYWX68lAp9jbrSP+vgPhZwT
	 TvN+mJDNiwHZZi7AJ2HMHaxFGZbcdnLPzYcoM1PnpweDS5ox7NAn4KSCQTpyzhYMlE4Xy
	 PJ5K+IHGpHRbboUOBSCLvotoZ1p0l3ZHXmwpfUxKU1u0yOhB3HaRZJZj5cCeqrMtZk4cE
	 V7oVWPEf0nbtSb8eFgZ/+jW3JyD3mbqwgLn6unrOyLRTlcZfwEIPM9IBACcnxpgXxxNLN
	 nd1gXx6RGMeiRRyNMvv2ZyzcTKv+OT86lYA1RUJnVepDssZwAYz78bHOax+17EQcEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iU2SKOzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FB606A31E;
	Sat, 28 Nov 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iU2SKOzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C91F000C1;
	Sat, 28 Nov 2026 02:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795831559;
	bh=PsHuO+dYPHrDaL7olY6c856oTYxQkKQxCg0cq/BUyYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iU2SKOzJDNDO1HhvVJC8Qi/jVM+1GtK+RTIBFu4NxLfTHmM+P/aph9mcPGGxTk2Lp
	 9ceB2PjKil8j0vBhAO2oTpgzWDpJu/t2gjdRfyZlHtNDAp69RLcU5QoruJz3IaHHuN
	 NfO+5a7OwsrzvFj2EKdFs5c3DmUrAtyB3ln8iMkD0ffKqqJD+M3mHkdeud5N845Bc8
	 BJK/M91A9bwsGBw+Fg13H42P+Vqk1lhwUN14Dc26Ay7KhCzc4AqjphxFkC4wxSaU/z
	 sFfG+H/09U4vyo/DBJ+e2pHDePQbiNB5lq6LUjq9t0GWwq4ceJhUqc92X6pnrFJUrY
	 OtcGi/UsdEIMw==
Date: Sat, 28 Nov 2026 02:05:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
Cc: iasnezhkov@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, Roman Vivchar
 <rva333@protonmail.com>, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: mt6359: fix MT6357 ISENSE/VCDT and MT6358
 VCDT request bits
Message-ID: <20261128020551.17cf4fe3@jic23-hlaptop>
In-Reply-To: <20261127025517.9548-1-iasnezhkov@gmail.com>
References: <20261127025517.9548-1-iasnezhkov@gmail.com>
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

On Fri, 27 Nov 2026 02:55:17 +0000
Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
> 
> mt6357_auxadc_ch_desc[] sets req_bit to 0 for both ISENSE and VCDT, and
> mt6358_auxadc_ch_desc[] sets req_bit to 0 for VCDT. Bit 0 of
> PMIC_AUXADC_RQST0 triggers BATADC (ADC0) rather than ISENSE (ADC1) or
> VCDT (ADC2), so polling the ready bit of ADC1/ADC2 times out unless the
> channel was triggered externally.
> 
> Use the actual hardware request bits in PMIC_AUXADC_RQST0: bit 1 for
> MT6357 ISENSE and bit 2 for MT6357/MT6358 VCDT (matching MT6363 VCDT
> and the MediaTek PMIC AUXADC hardware registers).
> 
> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Reviewed-by: Roman Vivchar <rva333@protonmail.com>
> Tested-by: Roman Vivchar <rva333@protonmail.com> # mt6358
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
Applied like Roman's series to the testing branch of iio.git + marked for stable.
That puts it on course for the merge window rather than rushing it in as a fix
during the rc cycle.

Thanks,

Jonathan
