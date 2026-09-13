Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA43246ED;
	Sun, 13 Sep 2026 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336968; cv=none; b=kLKZ6DN5J7S5+6ngK/OrBiFu2oRedvPUe6KNIG+1+QaJ+Vmz6660JAuGXDFMGOUM8jIh9hqDzjlgHCc0n2uVvKq4Zgz1iXXc2HPTlFwtAjNBZsCgJyPgBIvW8vINS8vZ51XiWNVYxLcQTWFBfz2aAsePNWGLax0tuDGRDpWIvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336968; c=relaxed/simple;
	bh=IDDoujbdglVVzb8mN2lWehjHoP289/RPGYVqNWhCjBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMleI2zEWlIMYfGOiN+hymRVpAw+2Af1WCoHHp97GSgoAWBelFb0wDePO3oXWoGgttS8ceCnikw+xGPZRKQQtdYNcp9qgQKvmMHxs9S9PZWrJmJVYXZsSlC4vrPYwdvoKYlhwWUHu3oTuCgpq2gqyLNEQITiNH8FBRGD1LDGXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgWvi4Pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgWvi4Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB251F000FF;
	Sun, 13 Sep 2026 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789336967;
	bh=qjzCQhp+OacUd3SsdDyvjRMquqOhFvkR/p6sOFD4mLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NgWvi4PfeLy9t0UF1bpScU84iyUoZHzmn289t0ChqJeCzebd1TVyNic7VeLdEagiP
	 SuSAvMmCv7InK/YCkuBJigrau6WvquRznA2I61L7DAO2bAQrYpd2zn1kS/BCp3kYJf
	 2XFxLDbJ675xvygEZRKcJ9tyqYXSec+QMQ7R4YomDMcY2XvaYvFUxLzh/+R140e0DF
	 TZ6KKMV6wZn2ojf37BqiCko079V6COp/8EqysBA1wA1Ju3bohvcEB4zeBIqO9lZkwK
	 1rVwCYYz9oavgoqhhP05AbX6iRa5zZpQiM5d5uAXeoToX6qNk8/HB3cdVMMvqmj+yA
	 uUgl8QOs7nGCg==
Date: Sun, 13 Sep 2026 23:02:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <20260913230241.63a1c684@jic23-hlaptop>
In-Reply-To: <20260908192036.8503-1-flaviu.nistor@gmail.com>
References: <20260908192036.8503-1-flaviu.nistor@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 22:20:34 +0300
Flaviu Nistor <flaviu.nistor@gmail.com> wrote:

> This patch series intention is to add support for label sysfs attribute
> similar to other ADC devices for ti-ads1015. The patch series adds label
> property in the dt-binding and the needed functionality in the driver.
> 
> Changes in v4:
> - Added this cover letter
> - Use Uper Case letters for "ADC" instead of "adc" in both commit messages
> and move static label assignment to probe as suggested by Andy Shevchenko.
> - Link to v3: https://lore.kernel.org/all/20260907152304.4992-1-flaviu.nistor@gmail.com/
> Changes in v3:
> - Return datasheet_name of the channel in user space if label is not present in dts. 
> - Link to v2: https://lore.kernel.org/all/20260902172230.5234-2-flaviu.nistor@gmail.com/
> Changes in v2:
> - Implement changes suggested by Andy Shevchenko. 
> - Link to v1: https://lore.kernel.org/all/20260901184302.8127-2-flaviu.nistor@gmail.com/
> 
Applied to the testing branch of iio.git where the bots can have
a first look at it before I push out as a tree I'd rather not rebase!
(that normally happens after a few days to 1 week).

Thanks,

Jonathan

> 
> Flaviu Nistor (2):
>   iio: adc: ti-ads1015: Add support for label
>   dt-bindings: iio: adc: ti,ads1015: Add label property
> 
>  .../bindings/iio/adc/ti,ads1015.yaml          |  6 ++++
>  drivers/iio/adc/ti-ads1015.c                  | 30 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 

