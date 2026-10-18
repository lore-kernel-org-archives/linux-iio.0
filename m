Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051511E5B70;
	Sun, 18 Oct 2026 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363525; cv=none; b=B2xBCk0l0COQlzCHBQFiviDSkEaer+fKTyR7pCjo4ZnR/yJ7l5PSNBdIk/0wsvJco7sTgQyVW0dG3fTb9rd0wdDq2IjLsrLont9JB5Flg8UjzEBFJ3rM0Yx9MHKBWI/kdY1ozkdji4eLTUDaxmQcIABtGChUrcGdNpJOUKtIHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363525; c=relaxed/simple;
	bh=JkJE08H5QHv35H/b5YQYW5go0usnDvNkJJNi7BvEnl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llWzPea8RYtWZB2o79SQnOLGAmB33h29yeEHYygs9x4Z0F6B+w2NSyDyVusylkjXvliHU042J5hz9MEK64IoHO62jssLHPnUaJugEGzYn1sV0upfDEK/+FP5yZaVGA53D5mhXt2IMueROnRgMhq5pSas+Vn6xHwuQrz9OXSjXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXsNjZrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXsNjZrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA7C1F000C4;
	Sun, 18 Oct 2026 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792363524;
	bh=JkJE08H5QHv35H/b5YQYW5go0usnDvNkJJNi7BvEnl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fXsNjZrv90JxmRZzZJ1h7SWytexdhlTX+UywVuaIOOg0g+obt3lfy6e1YPMZVMurL
	 I9zLfeOoZNc/fKYaulgbGvUGcIHxARfHqx0zl2zYYX58O9qC5LQBLxNy9WYYFbaKtL
	 6sLAJhsrgTroXTHKT3V4lC9J9QOxop/3uhsWNFfWoYuIqGF0yfXOMsifbOXb/iAeZ2
	 1wQ3hikr/Mf3ENdV3rtHMe+vxlZ5MfdKWWgGPyn93d9iKYcNP2DsFGVPRnZLK2vcOO
	 96HjjT3r2VBKDt0pL1MF0ZaQorVzmTrIdu2i9bAXqwQbI0iZRB1rbJ6UpqDMcEZgJ/
	 drtUbHU/QAV/Q==
Date: Sun, 18 Oct 2026 23:45:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Petre Rodan <petre.rodan@subdimension.ro>,
 Matteo Martelli <matteomartelli3@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Kevin Tsai
 <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] iio: use designated initializers for
 acpi_device_id
Message-ID: <20261018234515.29faf002@jic23-hlaptop>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Oct 2026 15:01:56 +0100
Pawel Zalewski <pzalewski@thegoodpenguin.co.uk> wrote:

> This series is converting lists that contain the acpi_device_id struct,
> which is defined in the include/linux/device-id/acpi.h to make use of named
> initializers (which they do not use currently). This work is part of the on
> going effort in the kernel associated with device-ids [1]
Applied with some churn due to code moving around and in one case
the change already having been incorporated in another patch.

Thanks,

Jonathan
