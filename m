Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794309401;
	b=BZ4M1bpvcIPIzyhkNpGL6VOCXscihLgv8CiAk0476bDf53uLGxZwPza+oQYzXMxedWtM
	 8uG0O8BN3oqz4aazLnzfdN8A1diQJ3kOCoXfwhjngrlr1uXQgLaQYNucF9pawYBjbRm5J
	 jtT5oeGh8un7NSCPyAynTfu2NdY5r/DOHW29GuEW7JlAJVGe40Fwh7M+Sw8mb/PfwjQEW
	 hXqlexYAx3db6Sbug+/rE1J/Kx6Bcka7tuL4+KdoR+aMYFCecJfcYuwmwV5wMVznclc3K
	 KUARRGnbij6dFnqqZ14Mly8CVCj/xczzYrPkMwQthOXTvKfVdkkO48LkokkTi4D8Qag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vJI7l8oJcBgA4nOmTh9uQAX8T46jiZwSjPoDS12ZPNs=;
	b=nRIN+fbqV1DFYBSPtzUAcZSGE1tNbiMJIDSH/xbZlRS6Y5Jlsi8+Ebju7gk39LLAZowm
	 LIMUWkh5lmr35MuGAUqk3ZCgbmjLUXKL+/kP9oZHFHo8z25NQNUT2UFLWNudOoUADLaWC
	 hjK+Uzsr8go/ckK6waZOZZSR19Iax9d2kMfq3puaAv9QubdtRrzk6q1449AUI3R3sUMMc
	 N/hn+/nSLT5cWPabKytOr86JxFXtHdkP4tGLtSmVA5oKKWTg+ipBV2tOHyeMNasA7OsPD
	 mlmZzHbhcnCq1GCP8VLZcG9dOo0GE2JdqcEqH1tPXuD1SROSPKsHQDs+OkdPwem0tDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TByK/Sxg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D5606A332;
	Tue, 10 Nov 2026 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TByK/Sxg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794309400;
	b=18Bhgz3n9MVuWW6tF+/fdz4PjzrYCkuVdZeal+5BbcDZQdSz+gRLnMuvBaIq9CSH6+gk
	 IBmcnMWW2vHjxm1ZrylDCXGp7saqSuwnwejLnpfku+6Pnd4/UGlSZbBCKE6cUcccBlI19
	 lLRLmO4poYHFDcT1+/k53jJJuX9J2chyrDLWOJNk4Q4IqwK0Ucm8hQgrQ5TH2abvrkR9R
	 BQNw8Wi5+NJaDnA7D1Orcyt1KJLHdS3wKhDattkjxGZbfBTJsfzwYqxhfNqmzmheYm3fa
	 Y26hhHauY7RS07n0Rf/yd8nSpDeb9pAjEA4l2zrCBd5GNhgorg0Qjczq26l8Nnh+OMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794309400;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vJI7l8oJcBgA4nOmTh9uQAX8T46jiZwSjPoDS12ZPNs=;
	b=zeho1zLHdZf1gowG/uai4B0WsPY+uDS7oEUsF4A9akzUysjgOlasg3JMJRd0DreliOfU
	 2rb3+wTWVkPLgjx1ztKTny3FMf6F2AF9i7skM2xVVrdRYm3948UYJ81ROhtuzw2Y1j64A
	 hvOB6ve5zyK18vlkLC546UCkL9fsuDCRXbgRIgdazjCOg934zokBLkpok+HrLh2R3lizA
	 iVzJOR+F/eG2VWhpIQk7quwNuKmbIqajI06ZWK7FZUUUltFMYIFe9vGx0DajEeFzBWz4T
	 eWK7a7S9feKVgARHDINMOaASeSD/2PXu4aHWwTmY9w4R5MKwZjKtnGAdm/Oot1/jpUA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 6FDDC1F008A7;
	Tue, 10 Nov 2026 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309400;
	bh=vJI7l8oJcBgA4nOmTh9uQAX8T46jiZwSjPoDS12ZPNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TByK/SxgKPQi7CXrcp4F3lTWbTkGc/KUBqKYWDRmRwtaPWIS9U259qMM50Umu4qf9
	 qQVOMq1OUmI+W9MmET1BAb5m2SHuPZ5brsD8z8/3Ne7gDSNz9jVuV35vUL11z/mmrO
	 +IScRQxbYdACFG4Tn1wn4NHz+JbqXATKenM+bLCc7JkHMxxwaZYuv6sRPc86r3mVKN
	 eLRFg7xfi/NX5mK8U4eFdo+86zAPRBHelB/Bf3R1cYs78TF1uWme9CTy3L8D352T28
	 uEY5fqKUtUX79pO9Alczn6n1dHPgGatIokcZWRPb4XuceUFGhvUXpqxat/LohNIz9o
	 oUoR8Es/APLvQ==
Date: Tue, 10 Nov 2026 12:15:51 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 03/16] iio: adc: xilinx-xadc: Use kernel integer
 types
Message-ID: <20261110121551.0000528b@kernel.org>
In-Reply-To: <20261110050201.1850399-4-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
	<20261110050201.1850399-4-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue, 10 Nov 2026 10:31:48 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Replace stdint types with kernel types and include linux/types.h
> to explicitly provide the corresponding type definitions.
> 
> No functional changes intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c   | 49 ++++++++++++++--------------
>  drivers/iio/adc/xilinx-xadc-events.c |  3 +-
>  drivers/iio/adc/xilinx-xadc.h        | 19 ++++++-----
>  3 files changed, 37 insertions(+), 34 deletions(-)
> 

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
