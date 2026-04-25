Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E7242925;
	Sat, 25 Apr 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777130718; cv=none; b=rKaF+4ge8D44XnSkmj4AS+u0kVM41Go4TvuGGyauGvG00SeLHgrxnBCLxL8y8QIdVXpH306RQ1nyMyDgpMKv+uMYInQh2Py3akyNdUvU3hLPs9nOfwKOk1OVZ/QcCLQSU2XwVWDICSmYdkMS2WvXlW6sBBp1kfwvlTZ92lGwcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777130718; c=relaxed/simple;
	bh=np+XqB9KT1l4HbWjrRgeNIWR8QnKBBomtziH7+bI+Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMpF9hCLXETIP1QrIAIQ03onFLYaNLCJAaOYtHTpmByGddXKYjkpN1QskbG+/QKQEXNnIsZDukIdDT9AsJ+PJuU6wGh88OOu9r9L6XcfxZqXBgjuYmib+TNHOMR/BudLxNjS5zabob7iPROQvWtr83lVv/fJVahPlwICMm1SB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h414BExs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h414BExs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7476C2BCB0;
	Sat, 25 Apr 2026 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777130718;
	bh=np+XqB9KT1l4HbWjrRgeNIWR8QnKBBomtziH7+bI+Y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h414BExsmS/HWoZQ8+cjbhdriiEiOr/taD7IpDKd5OFstDl+RNAaRY1pmeTHw2hku
	 t9w7y9NX43rKZqEss5rMHqG6gHgk+7k9MA+T/ufh8OXspGeyaXTiTwXxOTSmLud+G+
	 zTpeaZLve6bOaF0T/6J5HfLAAmfLUpM/IRFa1ybR2CT3quoTl3IN1VXFw06rp713TY
	 Mt5huaYm4kNsnOD64gHgPz23QvUD2XvU/gCDz1VIIpQVJA2bb4voN6DedGthLs2Zk/
	 iNBnVdkmnjexab01muo+hpiA3WhpOM45nkrXjro5WwuP04EmsbXg7N3tMzoaNf+UYR
	 zDKwJbZ3CnvTg==
Date: Sat, 25 Apr 2026 16:25:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Update APDS990x ALS to support device trees
Message-ID: <20260425162508.0b4907ea@jic23-huawei>
In-Reply-To: <20260425125429.65154-1-clamor95@gmail.com>
References: <20260425125429.65154-1-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 15:54:26 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Document Avago APDS9900/9901 ALS/Proximity sensor in schema and add its support
> to tsl2772 driver.
Applied to the testing branch of iio.git. I'll rebase that on rc1 once
available and then push it out as the togreg branch which linux-next picks up.

Thanks,

Jonathan
> 
> ---
> Changes in v3:
> - switched from apds990x to apds9900 in the driver
> - fixed misc-devices/index.rts
> - expanded and adjusted commit descriptions
> 
> Changes in v2:
> - dropped all previous patches
> - apds990x was documented in tsl2772.yaml
> - apds990x support was added to tsl2772.c
> - original apds990x driver removed from misc
> ---
> 
> Svyatoslav Ryhel (3):
>   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
>     sensor
>   iio: tsl2772: Add support for Avago APDS9900/9901 ALS/Proximity sensor
>   misc: Remove old APDS990x driver
> 
>  .../bindings/iio/light/tsl2772.yaml           |    2 +
>  Documentation/misc-devices/apds990x.rst       |  128 --
>  Documentation/misc-devices/index.rst          |    1 -
>  drivers/iio/light/tsl2772.c                   |   16 +
>  drivers/misc/Kconfig                          |   10 -
>  drivers/misc/Makefile                         |    1 -
>  drivers/misc/apds990x.c                       | 1284 -----------------
>  include/linux/platform_data/apds990x.h        |   65 -
>  8 files changed, 18 insertions(+), 1489 deletions(-)
>  delete mode 100644 Documentation/misc-devices/apds990x.rst
>  delete mode 100644 drivers/misc/apds990x.c
>  delete mode 100644 include/linux/platform_data/apds990x.h
> 

