Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996206;
	b=GeMYKQc5aWFIC8APksbM6ywQvIPpWLkZc6CPr8zjmAuvGCqEMTpPDCzbR4IRAhWtKrDU
	 nJx78bvotdAnsDjsTnS4YQJGPMaDiL/euhx1HDPAf0VK5CHhq/MVkLPYYKH+xTPXJ8Hv9
	 mjoX87rnCcoq3EVXfM22KiM7Ee7Zj71E+BPKoMOje+ZPEbdtl6kAEW66pLxMDi7O4kP+9
	 A1zpDQbGsu47zihQRN955TF0YWITxKz65MBKCMSN2gHNa76Qr/iCJNTUVcWruA2u+MnrZ
	 1BqpJHrTVbkpY4H6keOL9AqWIO98y75LrVe5IHPRHbGNMOO/SP9ZWQ2Mof0CaQRZpvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qg+3Jru4AhL9lqIWeA0Ptdw+DO4BjaXZQxOSqwuUPTo=;
	b=AWhf1I47zYAZPhe7/9xlEavdn/HA8wpiExixeWRCAJlsflkgwP3KFVy6VqJ2vh+vmZVF
	 HljeUma76d+76oz6jZzsUGBlJoOs1eWb8rxi62H02Rymov+TV1cOP7sdzIUtJ6dQKOHW7
	 6P3DhW5mowEwp3gntxA3bd8vALcpZDeu09IIJ3rTVdPJqOUfmXg0y8vzaT8KFZBp8TnNG
	 C+XzqP6sC9Tmx9ixcC1YaT6WJbXIIxwQExUeVsnIGKalRn9+VXFrcZScvSXNfe3gXi9w0
	 EM+5gncbdICCzQ0loQEDIKJnyPVBn+qJ2qbOWCUi8fYYfVWxbDwWkAcxf8gyfheL2Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgSQGD48;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BA606A31C;
	Wed, 18 Nov 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgSQGD48
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794996206;
	b=bNZ/lhvKHh0YLHvOMb7deZGzcK6vhuy8DGVorJnijJrHfZdREI/BE4IkUcW20aVXysol
	 xgFfGNbyp8rIt8cpOWlAJUh4aq2djY61i+UPEel0NDNz4kTROCc94ZylGl2XMdKz9os4N
	 MK2HRliYy0J2wka05+e0NDXPEU/XswXJbQ5fk0x7b7h1uyK3zY1v/UU+Ha2M4a6wEZFGg
	 HqBPvgAbWxFsRLtN5/kj1Ecz5fsZ2Ezw06N36J87l+ovhN4JGneMUXovDOTKwUB9OwRMo
	 eOS+WK7ZcmOcQAZmatdcMWuY5bs9x7WJmfIAzivBdzIPIkWpD0OMiAOR6Qw/FU6L+bQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794996206;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qg+3Jru4AhL9lqIWeA0Ptdw+DO4BjaXZQxOSqwuUPTo=;
	b=qJ6ctkP9aiSimUxm42T/pvTFWRX8V0Jikk8nSq/+8Sgqdp42CgJZcg91oWYSccq5eESz
	 aP8zVKeNLPQfGjetCRjV4MOqPxUjrXej0zrhlj8B7ELxBAjHh+Rk3JG7ax8KbMrX2FOc5
	 anQN2b8/fk2MSsxGfyksGpI/rhEQMc0m8p3U/mecpkUfh20heUFSBdlzTuToK7DpqcRKb
	 CEYAI3zhUIRgBNLT2wk2Il3Y+Mrt2VKtzcckPFM6B02/cOmGk3PYOqCsxUQk7fS1cLD5o
	 yl0m1wqehTRMb69L+JtvsJtwZXzDbBnz3yig8xnC6xGfN089CgnJvczroRiIdDo6beQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 6750A1F000C4;
	Wed, 18 Nov 2026 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996206;
	bh=Qg+3Jru4AhL9lqIWeA0Ptdw+DO4BjaXZQxOSqwuUPTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KgSQGD48L9H4lgzgeLu1d8ZWJYzgh9dsRC2vaN6oBiZaSZ0X+143NqeVdNT7HQ3Fx
	 DHlVhznSC0PaN3UtfOqdwz8kQbd297M96u7WuS64R2axs5Cm/Hw2euXD75AHHncpAY
	 uf3k29LYghNiKjXbngZWz+35t43JNU/ngevBEvF9YmNP6kuMRETrFh8ZXz7hXP0zf8
	 4oHohEJ3hem/MhgFufpEXIt8GWPVJnBaHwDqn5ga64/VWCUOqaRy5zAj6ql7GI/3Ql
	 +OR85ZMA7JtoKwx0YC5d5xaXyt+OeZ35QMvGPW/u+2NUaA9fHjLi4pKHODQRaTTX9K
	 5z/A/g9kc8HVA==
Date: Wed, 18 Nov 2026 11:03:18 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: stk3310: add stk3337 support
Message-ID: <20261118110318.000003c8@kernel.org>
In-Reply-To: <20261117-6768-stk3337-v2-4-92f4c7be3bc6@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
	<20261117-6768-stk3337-v2-4-92f4c7be3bc6@protonmail.com>
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

On Tue, 17 Nov 2026 20:08:38 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add support for the stk3337 sensor, found in the Xiaomi Redmi Note 9
> phone.
> 
> The stk3337 is a subset of the stk36c61. It provides the stk3310 ambient
> light and proximity channels along with the clear intensity channel from
> the stk36c61, but lacks the red, green, and blue intensity channels.
> 
> Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
