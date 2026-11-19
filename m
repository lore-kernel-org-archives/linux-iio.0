Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058805;
	b=AldIQ7zhzBVPUA/s7t6OhSsjL40NcCQbT+A2SOxAY+V9JnFtN/8aGruem4Kej7XXu1eV
	 GAV6GZsVEw2iOQAqYVAzLGMHjS1JuLMaGD8cWfaeYdy6f+ioJgEnkRhqJm1ZYaTjZElvi
	 3ZWUTht2/fIPziejtmd+Jm+ZQgeDwNjJjN4Pj4B7ArrbRBvDSqNIMy3D/tnZkm3siLV05
	 JiEQklJ1+yUz9z0EP7tHLnMXceeWgeRIKmwB/tPr3iJLmyn4cAO/7PJKf3T4lBh2ShMy9
	 TtSzwjRa05Ts1rq82SC55hMC4QAU+kjPZPuO7YmdRX+A/fIS7NTq7ttNn74VucVAlew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058805;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g4HEOxKXI5p37y75bz5PVrYA/LN3PmOLGZBVBTHSa+c=;
	b=ggHzvXrsgiCJB4c/+3ImAnUnwOSZM/tQTCqbv+CgxG3JdWrYIhM0rF0kChEtOVZ1vJQH
	 lzUxCHrX805y+y7M8NTEuYsZ/I/gJn7VMnHA3IbZjJK289UVHHC6cEOgHuz4nIasDU1kL
	 2M3N7uK3xB963XkjmRpRczSyEuaGFujTsTqenA5FZ3gQHJp5R6/8o6zOM9p5P+osJX9Jq
	 bddekTfbYZ9NsqULv+MWG/jEa5WwW+wqQ4LVAJz3S7xcwGvVvikXF7oEA7tKYG7Bjl9TG
	 qF6RSIq7snPd6ZqYplYJPLXA0xBxt1ZhLw5P7smlCJr0IsyBx4F5+pYpNwwtriZx80A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQyTQwA2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65210606A325;
	Thu, 19 Nov 2026 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQyTQwA2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742DE1F000C5;
	Thu, 19 Nov 2026 03:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058805;
	bh=g4HEOxKXI5p37y75bz5PVrYA/LN3PmOLGZBVBTHSa+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MQyTQwA21loTGGqn5Tpm21Fn2AbASq6KmaZgoffSG0frRv471AKWTlXkj+prE3Bt2
	 duLj8A8ATLJuUFLKgtNzUAZkbuWQqmno0qJx+lrnfRjmcC16JGTB1drQq24sum3Gx8
	 qg5pnyzhEYsziD8hCnoraGMDte61mn4zOHmmt8NACjVxgUB99jpRNXb6fXPtuazWPQ
	 Yvn63gPmDcK/JZ+jr89Pmjai/QkQqgtmBLJkiKGKT4nTWUgP3KuaktN78/T2IMg4xW
	 9k3CcnAsE2HtgOVCJ5TlJ3nhx3m4nj0icq1MUqr+71Jj5Hy8VL3IM8ZsLvyC+xJWrQ
	 CnLoB/uGNy6Gw==
Date: Thu, 19 Nov 2026 03:26:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Robert Budai <robert.budai@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/7] iio: imu: Add support for the ADI ADIS16607
Message-ID: <20261119032638.4ba84193@jic23-hlaptop>
In-Reply-To: <20261118-adis16607-v7-0-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
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

On Wed, 18 Nov 2026 15:17:42 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series adds support for the Analog Devices ADIS16607, a precision
> MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> temperature sensor, communicating over a non-standard SPI Half-Duplex
> protocol.
> 
> This version no longer carries the buffered capture. Following the v6
> review, the FIFO support is split out into a follow-up series, which
> will first update adislib's has_fifo handling (keeping the existing
> trigger/current_trigger interface in place) and the adis16475 FIFO
> variants that use it, and then add the adis16607 FIFO on top. The
> devicetree binding still describes the interrupt pin, as it is part of
> the hardware and is what the follow-up uses.

Given changes from the bits I tried to pick up in v6 are minor
and I only had that one really trivial comment, looks like it
is ready to go to me.

Applied to the testing branch of iio.git.

Thanks

Jonathan
