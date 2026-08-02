Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDECEEC3;
	Sun,  2 Aug 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785629416; cv=none; b=mM7HnzRNP3LH3FO6NJjgpvs3QDG/fa1xkvx22tlcvMVi/En/J9e06I12sVUILunz1TBUhK4D/QTaYXEYa/wBs5RKTK5f0kaqaqX+bU91Q1VNO425F4k1acayFgn8qPG3bDsbb1gWFewMQ93K8sz2TpkoXxR9nqObJuJZatSRPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785629416; c=relaxed/simple;
	bh=xgr4KDAO4BQ4x50JD82oGk50bEjH0+9uvlFjnD8cRz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li6njpqdIOq41Wsa3M3T9MHz2UlNlJwwIrzyCKohNeithgBWHNbR7BTnFz9Z46LkNcgpFRlG3/LU2uR76heZUEEQHwzpqueZPXPcJjpRjwhDbqN3svRl6sWFQ2lpkL0C0clFlPYvT626VJMYcrDyHlJAV+7rpQyvehG8n4HU5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTtpb8Gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTtpb8Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9432D1F00AC4;
	Sun,  2 Aug 2026 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785629414;
	bh=PDAZryFvGbwIdulz1vmeoa6qroav231BWWjGAxSYlc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XTtpb8Gi/Aw5NrYrKdQjnqz1Uz0w1XwE/5cQtXdv0J5oc29iCtUMU/drcGx4MqZCv
	 /2GQWgq5zOgmLedqtosxYiUqvv2t+FMlKaCFDA6nhPhdoehrtMnbjAlUFG24Xm04OC
	 gxhDHvQEETKThj74BSS1Nl6c5eNu5F7Pu/LWVlO8eB3xgC27FwUqzrcwORHU7DCHZ/
	 MVajCS85PWx17ll4MoQz+r9gdR1gGKA7NA3A9YqYzLrvyycPyOWVZIskR8YEaQLajB
	 H+A4EqNv2uulqcuQQy7BzKhtGWAena/i9zBNKD40pszFRw+P4jNzsYbyyS8r1yBXBN
	 GBAiOgim1myNQ==
Date: Sun, 2 Aug 2026 01:09:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 00/17] AD9910 Direct Digital Synthesizer
Message-ID: <20260802010959.25f9f4df@jic23-huawei>
In-Reply-To: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 09:25:27 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices AD9910 DDS.
> 
Series applied with that small Kconfig help tweak and a bit of fuzz
around the new channel type due to the flow sensor I merged earlier today.

Thanks,

Jonathan
